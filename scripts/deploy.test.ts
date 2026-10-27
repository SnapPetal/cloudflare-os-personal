import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";
import { parse, type ParseError } from "jsonc-parser";
import {
  activeWorkerNames,
  aiGatewayPlan,
  assertRetirementAllowlist,
  buildCommands,
  cloudflareResultKind,
  COMPATIBILITY_DATE,
  deploymentLogEntry,
  deployWorkersThenRetire,
  familyQuestDeployMode,
  generateConfigs,
  nextWorkerDomainPage,
  retireWorkers,
  RETIRED_WORKERS,
  validateConfig,
  workerDomainsFromList,
} from "./deploy.ts";
import type { RetirementClient, WorkerDomain } from "./deploy.ts";
import type {
  BaseConfigs,
  DeploymentConfig,
  GeneratedConfigs,
  ProdWranglerConfig,
} from "./deployment-config.ts";

const validConfig: DeploymentConfig = {
  accountId: "0123456789abcdef0123456789abcdef",
  publicBaseUrl: null,
  workers: {
    router: { name: "acme-cloudflare-os", route: { customDomain: "os.example.com" } },
    workshop: { name: "acme-cloudflare-os-backend" },
    s3vExplorer: { name: "acme-cloudflare-os-vectors", route: { workersDev: false } },
    familyQuest: { name: "acme-cloudflare-os-quest", route: { customDomain: "quest.example.com" } },
    context: { name: "acme-cloudflare-os-context" },
    scheduler: { name: "acme-cloudflare-os-scheduler" },
    customGatekeeper: { name: "acme-cloudflare-os-custom" },
    errorReporter: { name: "acme-cloudflare-os-errors" },
  },
  access: {
    issuer: "https://acme.cloudflareaccess.com",
    audience: "access-audience",
    admins: ["admin@example.com"],
  },
  aiGateway: {
    enabled: true,
    name: "cloudflare-os",
    accountId: null,
    providers: ["anthropic", "cloudflare"],
  },
  context: {
    sharingDomain: null,
    kvNamespaceId: "context-kv-id",
    artifacts: { enabled: true, namespace: "acme-context-collections" },
  },
  s3vExplorer: { region: "us-east-1", vectorBucketName: "acme-vectors" },
  personalWeb: {
    baseUrl: "https://app.example.com",
  },
  customGatekeeper: { name: "Acme", message: "Use the company handbook." },
  errorReporting: { enabled: true, environment: "production", release: "abc123" },
  resources: {
    blueprintsKvNamespaceId: "blueprints-kv-id",
    avatarsKvNamespaceId: "avatars-kv-id",
    blueprintContentBucket: "cloudflare-os-blueprints",
  },
  observability: {
    enabled: true,
    headSamplingRate: 0.5,
    logs: { invocationLogs: false },
    traces: { enabled: true, headSamplingRate: 0.25 },
  },
};

/**
 * A copy of {@link validConfig} with `mutate` applied, typed loosely on purpose.
 *
 * Most of these variants assign something `DeploymentConfig` forbids, which is exactly what
 * `validateConfig` exists to catch: `deployment.jsonc` is hand-edited JSONC with no schema behind
 * it, so the type describes the valid shape rather than guaranteeing what is on disk.
 */
function variant(mutate: (config: Record<string, any>) => void): DeploymentConfig {
  const config = structuredClone(validConfig) as Record<string, any>;
  mutate(config);
  return config as DeploymentConfig;
}

// Read from disk rather than inlined, including the Error Reporter's: deploy.ts derives every
// generated config from these files, so a copy here could drift from what actually ships.
async function baseConfigs(): Promise<BaseConfigs> {
  return {
    router: await baseConfig("../cloudflare-os/packages/router/wrangler.jsonc"),
    workshop: await baseConfig("../cloudflare-os/packages/workshop-backend/wrangler.jsonc"),
    s3vExplorer: await baseConfig("../packages/s3v-explorer/wrangler.jsonc"),
    familyQuest: await baseConfig("../packages/family-quest/wrangler.jsonc"),
    context: await baseConfig("../cloudflare-os/packages/gatekeeper-context/wrangler.jsonc"),
    scheduler: await baseConfig("../cloudflare-os/packages/gatekeeper-scheduler/wrangler.jsonc"),
    customGatekeeper: await baseConfig("../packages/custom-gatekeeper/wrangler.jsonc"),
    errorReporter: await baseConfig("../packages/error-reporter/wrangler.jsonc"),
  };
}

// Parsed the way `deploy.ts` parses it, errors included. Swallowing them would let a base config
// that the deploy cannot read still pass these tests on a best-effort parse -- which is how the
// Scheduler's trailing commas hid: nine parse errors, and a config object that still looked usable.
async function baseConfig(path: string): Promise<ProdWranglerConfig> {
  const errors: ParseError[] = [];
  const result = parse(
    await readFile(new URL(path, import.meta.url), "utf8"),
    errors,
    { allowTrailingComma: true },
  ) as ProdWranglerConfig;
  assert.deepEqual(errors, [], `${path} did not parse cleanly`);
  return result;
}

/** The Context data-isolation boundary carried by the Workshop's Gatekeeper binding. */
function sharingDomain(generated: GeneratedConfigs): unknown {
  return generated.workshop.services!
    .find((service) => service.binding === "GATEKEEPER_CONTEXT")!.props!.sharingDomain;
}

test("rejects deployment placeholders", () => {
  assert.throws(
    () => validateConfig(variant((c) => { c.accountId = "<CLOUDFLARE_ACCOUNT_ID>"; })),
    /placeholder/i);
});

test("rejects destructive or malformed deployment values", () => {
  const duplicateWorkers = structuredClone(validConfig);
  duplicateWorkers.workers.context.name = duplicateWorkers.workers.workshop.name;
  assert.throws(() => validateConfig(duplicateWorkers), /unique/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.observability.enabled = "true"; })), /boolean/i);

  assert.throws(
    () => validateConfig(variant((c) => {
      c.workers.router.route.customDomain = "os.example.com/path";
    })), /hostname/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.context.sharingDomain = ""; })),
    /sharingDomain must be null or a non-empty string/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.access.issuer += "/team"; })), /issuer.*origin/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.access.audience = "   "; })), /audience/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.access.audience = " access-audience "; })), /audience/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.access.admins = ["bad-address"]; })), /email/i);

  assert.throws(
    () => validateConfig(variant((c) => {
      c.observability.traces.headSamplingRate = 2;
    })), /sampling/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.context.artifacts.enabled = "true"; })),
    /Artifacts enabled.*boolean/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.context.artifacts = null; })),
    /Artifacts configuration.*object/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.context.artifacts = []; })),
    /Artifacts configuration.*object/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.context.artifacts.namespace = null; })),
    /namespace must be omitted/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.context.artifacts.namespace = "context/collections"; })),
    /namespace must be omitted/i);
});

test("rejects AI Gateway keys that no longer do anything", () => {
  // A silently-ignored workersAi block is how a deploy succeeds with an empty model picker.
  assert.throws(
    () => validateConfig(variant((c) => { c.aiGateway.workersAi = { mode: "gateway" }; })),
    /aiGateway\.workersAi does nothing/i);
  // Even with AI off: the key means the operator believes it still does something.
  assert.throws(
    () => validateConfig(variant((c) => {
      c.aiGateway = { enabled: false, workersAi: { mode: "direct" } };
    })),
    /aiGateway\.workersAi does nothing/i);
});

test("rejects malformed AI Gateway providers and account", () => {
  assert.throws(
    () => validateConfig(variant((c) => { c.aiGateway.providers = []; })),
    /Missing required deployment value: aiGateway.providers/);

  assert.throws(
    () => validateConfig(variant((c) => { c.aiGateway.providers = ["anthropic", "mistral"]; })),
    /providers must be a non-empty subset/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.aiGateway.accountId = "not-an-account"; })),
    /aiGateway.accountId must be null or 32 hexadecimal/i);
});

test("generates Access-mode Workshop, Context, and custom Gatekeeper configs", async () => {
  const generated = generateConfigs(validConfig, await baseConfigs());
  const vars = generated.workshop.vars!;

  assert.equal(generated.workshop.name, "acme-cloudflare-os-backend");
  assert.deepEqual(vars.ADMINS, ["admin@example.com"]);
  assert.equal(vars.CF_ACCESS_ISS, validConfig.access.issuer);
  assert.equal(vars.CF_ACCESS_AUD, validConfig.access.audience);
  assert.equal(vars.PUBLIC_BASE_URL, "https://os.example.com");
  assert.equal(vars.BOOKING_ADMIN_BASE_URL, validConfig.personalWeb.baseUrl);
  assert.equal(vars.CF_AI_GATEWAY, "cloudflare-os");
  assert.equal(vars.CF_AI_GATEWAY_PROVIDERS, "anthropic,cloudflare");
  assert.deepEqual(generated.workshop.ai, { binding: "WORKERS_AI" });
  assert.deepEqual(generated.workshop.services, [
    {
      binding: "ERROR_REPORTER",
      service: "acme-cloudflare-os-errors",
      entrypoint: "ErrorReporter",
      props: {
        service: "acme-cloudflare-os-backend",
        environment: "production",
        release: "abc123",
      },
    },
    {
      binding: "GATEKEEPER_CONTEXT",
      service: "acme-cloudflare-os-context",
      entrypoint: "GatekeeperVendor",
      props: { sharingDomain: "https://os.example.com" },
    },
    {
      binding: "GATEKEEPER_SCHEDULER",
      service: "acme-cloudflare-os-scheduler",
      entrypoint: "GatekeeperVendor",
    },
    {
      binding: "S3V_EXPLORER",
      service: "acme-cloudflare-os-vectors",
    },
    {
      binding: "GATEKEEPER_CUSTOM",
      service: "acme-cloudflare-os-custom",
      entrypoint: "GatekeeperVendor",
    },
  ]);
  assert.deepEqual(generated.workshop.kv_namespaces, [
    { binding: "BLUEPRINTS", id: "blueprints-kv-id" },
    { binding: "AVATARS", id: "avatars-kv-id" },
  ]);
  assert.equal(generated.workshop.r2_buckets![0].bucket_name, "cloudflare-os-blueprints");
  assert.equal(generated.context.name, "acme-cloudflare-os-context");
  assert.equal(generated.context.kv_namespaces![0].id, "context-kv-id");
  assert.deepEqual(generated.context.artifacts, [{
    binding: "ARTIFACTS",
    namespace: "acme-context-collections",
  }]);
  assert.equal(generated.customGatekeeper.name, "acme-cloudflare-os-custom");
  assert.deepEqual(generated.customGatekeeper.vars, {
    CUSTOM_NAME: "Acme",
    CUSTOM_MESSAGE: "Use the company handbook.",
  });
  assert.equal(generated.errorReporter!.name, "acme-cloudflare-os-errors");
  assert.deepEqual(generated.workshop.observability!.logs, {
    invocation_logs: false,
  });
  assert.deepEqual(generated.workshop.observability!.traces, {
    enabled: true,
    head_sampling_rate: 0.25,
  });
  assert.equal(generated.workshop.services!.some(
    (service) => service.binding === "FRONTEND_ERROR_REPORTER"), false);
});

test("gives the router the public route, the frontend, and every service binding", async () => {
  const bases = await baseConfigs();
  const generated = generateConfigs(validConfig, bases);

  assert.equal(generated.router.name, "acme-cloudflare-os");
  assert.equal(generated.router.workers_dev, false);
  assert.deepEqual(generated.router.routes, [{ pattern: "os.example.com", custom_domain: true }]);
  // No entrypoint on any of the three: the router forwards whole HTTP requests rather than making
  // vendor RPC calls, and the binding name is what selects the /gatekeeper/<name> path.
  assert.deepEqual(generated.router.services, [
    { binding: "WORKSHOP_BACKEND", service: "acme-cloudflare-os-backend" },
    { binding: "GATEKEEPER_CONTEXT", service: "acme-cloudflare-os-context" },
    { binding: "GATEKEEPER_SCHEDULER", service: "acme-cloudflare-os-scheduler" },
    { binding: "GATEKEEPER_CUSTOM", service: "acme-cloudflare-os-custom" },
  ]);
  // The base config carries the ASSETS binding, SPA fallback, and /gatekeeper/* prefix an OAuth
  // Gatekeeper redirect needs. The deployment adds the private vector admin routes.
  assert.deepEqual(generated.router.assets!.run_worker_first, [
    ...new Set([
      ...(bases.router.assets!.run_worker_first ?? []),
      "/vector-store",
      "/vector-store/*",
    ]),
  ]);
  assert.equal(generated.router.assets!.binding, "ASSETS");
  assert.equal(generated.router.assets!.directory, "../workshop-frontend/dist");
  assert.ok(generated.router.assets!.run_worker_first!.includes("/gatekeeper/*"),
    JSON.stringify(generated.router.assets));
  assert.ok(generated.router.assets!.run_worker_first!.includes("/vector-store"),
    JSON.stringify(generated.router.assets));
  assert.ok(generated.router.assets!.run_worker_first!.includes("/vector-store/*"),
    JSON.stringify(generated.router.assets));
});

/**
 * The hosted deploy preinstalls this one on every fresh instance (`PREINSTALL` in
 * cloudflare-os/scripts/release/manifest-lib.ts), so a starter that skipped it would not be the same
 * topology: a migrated instance would show none of its existing schedules, and the
 * Durable Objects holding them would be orphaned behind a Worker nothing is bound to.
 */
test("deploys the ambient Scheduler Gatekeeper the hosted flow preinstalls", async () => {
  const bases = await baseConfigs();
  const generated = generateConfigs(validConfig, bases);

  assert.equal(generated.scheduler.name, "acme-cloudflare-os-scheduler");
  // Reached by both, for the two different things a Gatekeeper does: vendor RPC from the backend,
  // and whole HTTP requests under /gatekeeper/scheduler from the router.
  assert.deepEqual(
    generated.workshop.services!.find((service) => service.binding === "GATEKEEPER_SCHEDULER"),
    {
      binding: "GATEKEEPER_SCHEDULER",
      service: "acme-cloudflare-os-scheduler",
      entrypoint: "GatekeeperVendor",
    });
  assert.deepEqual(
    generated.router.services!.find((service) => service.binding === "GATEKEEPER_SCHEDULER"),
    { binding: "GATEKEEPER_SCHEDULER", service: "acme-cloudflare-os-scheduler" });

  // Its Durable Object history has to arrive verbatim: those classes are where the schedules live.
  assert.deepEqual(generated.scheduler.migrations, bases.scheduler.migrations);
  assert.ok(generated.scheduler.migrations!.length > 0, "scheduler lost its DO migrations");
  // No configuration surface of its own -- which is what makes it installable with no user input
  // upstream, and deployable here from nothing but a Worker name.
  assert.equal(generated.scheduler.vars, undefined);
  assert.equal(generated.scheduler.kv_namespaces, undefined);
  assert.equal(generated.scheduler.secrets, undefined);

  const builds = buildCommands(validConfig)
    .map(({ args }) => args)
    .filter((args) => args.includes("@gadgets/gatekeeper-scheduler"));
  assert.deepEqual(builds.map((args) => args.at(-1)), ["build:app", "build"]);
});

test("keeps every Worker behind the router off the public internet", async () => {
  const generated = generateConfigs(validConfig, await baseConfigs());
  const workers = Object.entries(generated) as [string, ProdWranglerConfig][];

  for (const [name, worker] of workers) {
    if (name !== "router" && name !== "familyQuest") {
      assert.equal(worker.workers_dev, false, `${name} answers on workers.dev`);
      assert.equal(worker.routes, undefined, `${name} carries a public route`);
    }
    // A preview URL is an unauthenticated path around the Access-protected origin.
    assert.equal(worker.preview_urls, false, `${name} leaves preview URLs enabled`);
  }
  // The router serves the frontend, so the backend uploads no assets of its own.
  assert.equal(generated.workshop.assets, undefined);
});

test("scopes PUBLIC_BASE_URL and Context sharing to the public origin", async () => {
  const onWorkersDev = variant((c) => {
    c.workers.router.route = { workersDev: true };
    c.publicBaseUrl = "https://acme-cloudflare-os.acme.workers.dev";
  });

  const derived = generateConfigs(validConfig, await baseConfigs());
  const explicit = generateConfigs(onWorkersDev, await baseConfigs());

  assert.equal(derived.workshop.vars!.PUBLIC_BASE_URL, "https://os.example.com");
  assert.equal(
    explicit.workshop.vars!.PUBLIC_BASE_URL, "https://acme-cloudflare-os.acme.workers.dev");
  assert.equal(explicit.router.workers_dev, true);
  assert.equal(explicit.router.routes, undefined);

  // sharingDomain: null follows the public origin, which is what the hosted deploy sets it to.
  assert.equal(sharingDomain(derived), "https://os.example.com");
  assert.equal(sharingDomain(explicit), "https://acme-cloudflare-os.acme.workers.dev");

  // A pinned literal keeps the boundary stable across a hostname change, so it wins.
  const pinned = generateConfigs(
    variant((c) => { c.context.sharingDomain = "production"; }), await baseConfigs());
  assert.equal(sharingDomain(pinned), "production");
  assert.equal(pinned.workshop.vars!.PUBLIC_BASE_URL, "https://os.example.com");
});

test("rejects a public origin it cannot derive or cannot trust", async () => {
  // Nothing in deployment.jsonc names the account's workers.dev subdomain, and PUBLIC_BASE_URL and
  // the Context sharing boundary both need an origin, so this cannot be left to a fallback.
  assert.throws(
    () => validateConfig(variant((c) => { c.workers.router.route = { workersDev: true }; })),
    /publicBaseUrl is required on a workersDev route/i);

  // Scoping Context data to a hostname the deployment does not answer on hides its collections.
  assert.throws(
    () => validateConfig(variant((c) => { c.publicBaseUrl = "https://other.example.com"; })),
    /does not match workers.router.route.customDomain/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.publicBaseUrl = "https://os.example.com/"; })),
    /HTTPS origin only/i);

  assert.throws(
    () => validateConfig(variant((c) => { c.publicBaseUrl = "http://os.example.com"; })),
    /HTTPS origin only/i);

  assert.throws(
    () => validateConfig(variant((c) => { delete c.publicBaseUrl; })),
    /publicBaseUrl must be present/i);
});

test("rejects a workersDev origin that is not the router's own", async () => {
  const onWorkersDev = (publicBaseUrl: string) => variant((c) => {
    c.workers.router.route = { workersDev: true };
    c.publicBaseUrl = publicBaseUrl;
  });

  // The account's workers.dev subdomain is unknowable here, but the rest of the hostname is not: a
  // typo in the Worker label, or an unrelated host, would silently become both PUBLIC_BASE_URL and
  // the Context isolation boundary.
  assert.throws(
    () => validateConfig(onWorkersDev("https://acme-cloudflare-o.acme.workers.dev")),
    /names Worker "acme-cloudflare-o", but the router is "acme-cloudflare-os"/);

  assert.throws(
    () => validateConfig(onWorkersDev("https://os.example.com")),
    /not a workers.dev origin/i);

  // A deeper name is a preview URL or an unrelated host, not the route wrangler serves.
  assert.throws(
    () => validateConfig(onWorkersDev("https://staging.acme-cloudflare-os.acme.workers.dev")),
    /not a workers.dev origin/i);

  // The shape wrangler actually serves stays valid, whatever the account subdomain is.
  const generated = generateConfigs(
    onWorkersDev("https://acme-cloudflare-os.some-account.workers.dev"), await baseConfigs());
  assert.equal(
    generated.workshop.vars!.PUBLIC_BASE_URL, "https://acme-cloudflare-os.some-account.workers.dev");

  // The rule is scoped to the workersDev route. A custom domain has its own hostname, unrelated to
  // any Worker name, and is checked against `customDomain` instead -- both spellings stay valid.
  assert.equal(
    validateConfig(variant((c) => { c.publicBaseUrl = "https://os.example.com"; })).publicBaseUrl,
    "https://os.example.com");
  assert.equal(validateConfig(validConfig).publicBaseUrl, null);
});

test("routes AI Gateway over the Workers AI binding without an API token", async () => {
  const generated = generateConfigs(validConfig, await baseConfigs());
  const vars = generated.workshop.vars!;

  assert.equal(vars.CF_AI_GATEWAY_ACCOUNT_ID, validConfig.accountId);
  // Absent, not "true": the backend takes the binding whenever it is bound, and the binding is
  // pre-authenticated inside the deployment's own account.
  assert.equal(vars.CF_AI_GATEWAY_USE_BINDING, undefined);
  assert.equal(generated.workshop.secrets, undefined);
  assert.deepEqual(aiGatewayPlan(validConfig), {
    gatewayAccountId: validConfig.accountId,
    crossAccount: false,
    needsToken: false,
    tokenReasons: [],
  });
});

test("requires a token for a gateway in another account", async () => {
  const config = variant((c) => { c.aiGateway.accountId = "fedcba9876543210fedcba9876543210"; });
  const generated = generateConfigs(config, await baseConfigs());
  const vars = generated.workshop.vars!;

  assert.equal(vars.CF_AI_GATEWAY_ACCOUNT_ID, "fedcba9876543210fedcba9876543210");
  assert.equal(vars.CF_AI_GATEWAY_USE_BINDING, "false");
  assert.deepEqual(generated.workshop.secrets, { required: ["CF_AI_GATEWAY_API_TOKEN"] });
  // The Workers AI binding stays bound: webFetch's toMarkdown() runs on it too.
  assert.deepEqual(generated.workshop.ai, { binding: "WORKERS_AI" });
  assert.equal(aiGatewayPlan(config)!.tokenReasons.length, 1);
});

test("treats a differently-cased account ID as the same account", async () => {
  const config = variant((c) => { c.aiGateway.accountId = c.accountId.toUpperCase(); });
  const generated = generateConfigs(config, await baseConfigs());

  // Same account written two ways, which the hex pattern accepts: the binding reaches this gateway,
  // so no CF_AI_GATEWAY_USE_BINDING opt-out and no token.
  assert.equal(generated.workshop.vars!.CF_AI_GATEWAY_ACCOUNT_ID, validConfig.accountId);
  assert.equal(generated.workshop.vars!.CF_AI_GATEWAY_USE_BINDING, undefined);
  assert.equal(generated.workshop.secrets, undefined);
  assert.equal(aiGatewayPlan(config)!.crossAccount, false);
  assert.deepEqual(aiGatewayPlan(config)!.tokenReasons, []);
});

test("requires a token for the google provider", async () => {
  const config = variant((c) => { c.aiGateway.providers = ["cloudflare", "google"]; });
  const generated = generateConfigs(config, await baseConfigs());

  assert.deepEqual(generated.workshop.secrets, { required: ["CF_AI_GATEWAY_API_TOKEN"] });
  // Same account, so the binding still carries every other provider.
  assert.equal(generated.workshop.vars!.CF_AI_GATEWAY_USE_BINDING, undefined);
  assert.match(aiGatewayPlan(config)!.tokenReasons[0], /google/i);
});

test("omits disabled backend error reporting", async () => {
  const config = variant((c) => {
    c.errorReporting = { enabled: false, environment: "<ENVIRONMENT>", release: "<RELEASE>" };
  });

  const generated = generateConfigs(config, await baseConfigs());

  assert.equal(generated.errorReporter, undefined);
  assert.equal(generated.workshop.services!.some(
    (service) => service.binding === "ERROR_REPORTER"), false);
});

test("omits dormant AI Gateway configuration", async () => {
  const config = variant((c) => {
    c.aiGateway = {
      enabled: false,
      name: "<AI_GATEWAY_NAME>",
      accountId: "<AI_GATEWAY_ACCOUNT_ID>",
      providers: [],
    };
  });

  const generated = generateConfigs(config, await baseConfigs());
  const vars = generated.workshop.vars!;

  assert.equal(vars.CF_AI_GATEWAY, undefined);
  assert.equal(vars.CF_AI_GATEWAY_ACCOUNT_ID, undefined);
  assert.equal(vars.CF_AI_GATEWAY_PROVIDERS, undefined);
  assert.equal(generated.workshop.secrets, undefined);
  // Still bound: it is what webFetch's toMarkdown() runs on, independent of the model catalog.
  assert.deepEqual(generated.workshop.ai, { binding: "WORKERS_AI" });
  assert.equal(aiGatewayPlan(config), null);
});

test("uses the default Context Artifacts namespace when omitted", async () => {
  const config = variant((c) => { delete c.context.artifacts.namespace; });

  const generated = generateConfigs(config, await baseConfigs());

  assert.deepEqual(generated.context.artifacts, [{
    binding: "ARTIFACTS",
    namespace: "gatekeeper-context-collections",
  }]);
});

test("omits disabled Context Artifacts configuration", async () => {
  const config = variant((c) => { c.context.artifacts = {}; });
  const bases = await baseConfigs();
  bases.context.artifacts = [{ binding: "ARTIFACTS", namespace: "upstream-default" }];

  const generated = generateConfigs(config, bases);

  assert.equal(generated.context.artifacts, undefined);
});

test("defaults Context Artifacts to disabled when configuration is omitted", async () => {
  const config = variant((c) => { delete c.context.artifacts; });

  const generated = generateConfigs(config, await baseConfigs());

  assert.equal(generated.context.artifacts, undefined);
});

test("generates binding-only storage for automatic provisioning", async () => {
  const config = variant((c) => {
    c.context.kvNamespaceId = null;
    c.resources = {
      blueprintsKvNamespaceId: null,
      avatarsKvNamespaceId: null,
      blueprintContentBucket: null,
    };
  });

  const generated = generateConfigs(config, await baseConfigs());

  assert.deepEqual(generated.workshop.kv_namespaces, [
    { binding: "BLUEPRINTS" },
    { binding: "AVATARS" },
  ]);
  assert.deepEqual(generated.workshop.r2_buckets, [{ binding: "BLUEPRINT_CONTENT" }]);
  assert.deepEqual(generated.context.kv_namespaces, [{ binding: "CONTEXT_COLLECTIONS" }]);
});

/**
 * The equivalent, for this repository, of upstream's `deploy-scripts.test.ts`. That one
 * auto-discovers per-package `deploy` scripts; here deploying is centralised in `deploy.ts`, so the
 * same invariant has to be asserted against the commands it spawns.
 *
 * Both halves are silent failures: a replayed cache hit and a dropped build-time flag each exit
 * zero and each still deploy.
 */
test("never lets a deploy replay a cached build artifact", () => {
  const commands = buildCommands(validConfig);
  assert.ok(commands.length > 0, "expected at least one build command");
  for (const { args } of commands) {
    const command = args.join(" ");
    // `pnpm --filter <pkg> build` cannot see a Vite+ task, and two of the three submodule targets
    // are now tasks rather than scripts. `vp run` runs both.
    assert.ok(command.includes("vp run"),
      `build step does not go through vp run: ${command}`);
    assert.ok(command.includes("--no-cache"),
      `build step runs a vp task while deploying without --no-cache: ${command}\n` +
      "Deploys must not replay a cached artifact -- add --no-cache.");
    // Everything after the task specifier is forwarded to the task's own command, so a trailing
    // flag reaches `tsc` as an unknown option instead of reaching vp.
    assert.ok(args.indexOf("--no-cache") < args.indexOf("run") + 4,
      `--no-cache must precede the task name, not follow it: ${command}`);
  }
});

test("rebuilds the Context configurator app rather than replaying it", () => {
  // `gatekeeper-context`'s `build` script spawns `vp run --cache build:app` of its own, which the
  // outer --no-cache does not reach. Without this step a deploy ships whatever app.txt the cache
  // last archived.
  const context = buildCommands(validConfig)
    .map(({ args }) => args)
    .filter((args) => args.includes("@gadgets/gatekeeper-context"));
  assert.deepEqual(context.map((args) => args.at(-1)), ["build:app", "build"]);
  assert.ok(context.every((args) => args.at(-2) === "--no-cache"), context.join("\n"));
});

test("passes VITE_CF_ACCESS_MODE explicitly rather than inheriting it", () => {
  const withAccessMode = buildCommands(validConfig).filter(({ env }) => env);
  assert.deepEqual(withAccessMode.map(({ env }) => env), [{ VITE_CF_ACCESS_MODE: "true" }]);
  // It has to reach the frontend, which inlines it into the bundle, and nothing else.
  assert.match(withAccessMode[0].args.join(" "), /@gadgets\/workshop-frontend/);
});

test("builds the frontend before the router", () => {
  const order = buildCommands(validConfig).map(({ args }) => args.join(" "));
  const frontend = order.findIndex((command) => command.includes("workshop-frontend"));
  const router = order.findIndex((command) => command.includes("@gadgets/router"));
  // The router deploy picks up ../workshop-frontend/dist as its assets.
  assert.ok(frontend >= 0 && router >= 0 && frontend < router, order.join("\n"));
});

test("skips the Error Reporter build when error reporting is disabled", () => {
  const config = variant((c) => {
    c.errorReporting = { enabled: false, environment: "<ENVIRONMENT>", release: null };
  });
  const commands = buildCommands(config).map(({ args }) => args.join(" "));
  assert.equal(commands.some((command) => command.includes("thonbecker-personal-os-errors")), false);
});

test("records each deployed Worker and version, and the commits behind them", () => {
  const entry = deploymentLogEntry({
    timestamp: "2026-09-26 23:47",
    rootCommit: "25dd0ed12345",
    submoduleCommit: "270ca7c5badf",
    versions: [
      ["acme-os-errors", "aaaaaaaa-1111-2222-3333-444444444444"],
      ["acme-os-router", "bbbbbbbb-1111-2222-3333-444444444444"],
    ],
  });
  // The rollback targets, one row per Worker, in the order they were deployed.
  assert.match(entry, /\| `acme-os-errors` \| `aaaaaaaa-1111-2222-3333-444444444444` \|/);
  assert.match(entry, /\| `acme-os-router` \| `bbbbbbbb-1111-2222-3333-444444444444` \|/);
  // Which cloudflare-os produced this code is not recoverable from the gitlink after the fact.
  assert.match(entry, /Root `25dd0ed12345`, submodule `270ca7c5badf`/);
  // Stamped UTC, so the entry means one thing to every reader.
  assert.match(entry, /^## 2026-09-26 23:47 UTC$/m);
  // Appended whole, so the next entry starts on its own line.
  assert.ok(entry.endsWith("\n\n"));
});

test("deployment.jsonc owns workers_dev, invocation logs, traces, and the compatibility date", async () => {
  const errors: ParseError[] = [];
  const deployment = validateConfig(parse(
    await readFile(new URL("../deployment.jsonc", import.meta.url), "utf8"),
    errors,
    { allowTrailingComma: true },
  ) as DeploymentConfig);
  assert.deepEqual(errors, []);
  assert.equal(deployment.observability.logs.invocationLogs, true);
  assert.equal(deployment.observability.traces.enabled, true);
  assert.equal(deployment.observability.traces.headSamplingRate, 0.1);
  assert.equal(deployment.workers.s3vExplorer.name, "thonbecker-s3v-explorer");

  const bases = await baseConfigs();
  const generated = generateConfigs(deployment, bases);
  const owned = [
    ["packages/s3v-explorer", "s3vExplorer", bases.s3vExplorer, generated.s3vExplorer],
    ["packages/family-quest", "familyQuest", bases.familyQuest, generated.familyQuest],
    ["packages/custom-gatekeeper", "customGatekeeper", bases.customGatekeeper, generated.customGatekeeper],
    ["packages/error-reporter", "errorReporter", bases.errorReporter, generated.errorReporter!],
  ] as const;

  for (const [dir, key, base, out] of owned) {
    const deployedName = deployment.workers[key]!.name;
    const pkg = JSON.parse(await readFile(new URL(`../${dir}/package.json`, import.meta.url), "utf8")) as { name: string };
    assert.equal(pkg.name, deployedName, `${dir} package name`);
    assert.equal(base.name, deployedName, `${dir} wrangler name`);
    assert.equal(base.workers_dev, out.workers_dev, `${dir} workers_dev drifted from deployment.jsonc`);
    assert.equal(base.observability?.logs?.invocation_logs, deployment.observability.logs.invocationLogs,
      `${dir} invocation_logs drifted from deployment.jsonc`);
    assert.equal(base.compatibility_date, COMPATIBILITY_DATE, dir);
    assert.deepEqual(base.observability?.traces, {
      enabled: true,
      head_sampling_rate: 0.1,
    }, dir);
  }

  for (const [name, worker] of Object.entries(generated)) {
    assert.equal(worker.compatibility_date, COMPATIBILITY_DATE, name);
    assert.equal(worker.observability?.logs?.invocation_logs, true, name);
    assert.deepEqual(worker.observability?.traces, {
      enabled: true,
      head_sampling_rate: 0.1,
    }, name);
  }

  assert.equal(
    generated.workshop.services!.find((service) => service.binding === "S3V_EXPLORER")!.service,
    "thonbecker-s3v-explorer",
  );
  assert.equal(generated.familyQuest.workers_dev, false);
  assert.deepEqual(generated.familyQuest.routes, [
    { pattern: "quest.thonbecker.biz", custom_domain: true },
  ]);
  assert.equal(generated.familyQuest.vars?.AI_MODEL, "@cf/meta/llama-3.3-70b-instruct-fp8-fast");
  assert.equal(generated.familyQuest.vars?.ACCESS_AUD, undefined);
  assert.equal(generated.familyQuest.vars?.ACCESS_TEAM_DOMAIN, undefined);
  assert.equal(generated.workshop.vars?.CF_ACCESS_AUD, deployment.access.audience);
  assert.equal(deployment.workers.familyQuest.name, "thonbecker-family-quest");

  const commands = buildCommands(deployment).map(({ args }) => args.join(" "));
  for (const name of [
    deployment.workers.s3vExplorer.name,
    deployment.workers.familyQuest.name,
    deployment.workers.customGatekeeper.name,
    deployment.workers.errorReporter!.name,
  ]) {
    assert.ok(commands.some((command) => command.includes(`-F ${name}`)), name);
  }
});

test("Family Quest flags do not change a full check or mix the two modes", () => {
  assert.equal(familyQuestDeployMode(["--check"]), "with-family-quest");
  assert.equal(familyQuestDeployMode(["--skip-family-quest"]), "skip-family-quest");
  assert.equal(familyQuestDeployMode(["--only-family-quest"]), "only-family-quest");
  assert.throws(() => familyQuestDeployMode(["--skip-family-quest", "--only-family-quest"]), /only one/);
  assert.throws(() => familyQuestDeployMode(["--check", "--skip-family-quest"]), /dry-runs every Worker/);
});

test("Deploy workflow applies Family Quest migrations before that Worker deploys", async () => {
  const workflow = await readFile(new URL("../.github/workflows/deploy.yml", import.meta.url), "utf8");
  const script = await readFile(new URL("./family-quest-predeploy.sh", import.meta.url), "utf8");
  const skip = workflow.indexOf("pnpm deploy -- --skip-family-quest");
  const prepare = workflow.indexOf("bash scripts/family-quest-predeploy.sh");
  const only = workflow.indexOf("pnpm deploy -- --only-family-quest");
  assert.ok(skip !== -1 && prepare !== -1 && only !== -1);
  assert.ok(skip < prepare && prepare < only);
  assert.equal(workflow.includes("FAMILY_QUEST_PASSCODE"), false);
  assert.equal(workflow.includes("FAMILY_QUEST_SESSION_SECRET"), false);
  assert.equal(workflow.includes("secret put"), false);
  assert.match(script, /wrangler d1 migrations apply thonbecker-family-quest --remote/);
  assert.equal(script.includes("secret put"), false);
});

function retirementAccount(seed: {
  workers: readonly string[];
  domains: readonly WorkerDomain[];
}): {
  client: RetirementClient;
  calls: string[];
  workers: Set<string>;
  domains: WorkerDomain[];
} {
  const workers = new Set(seed.workers);
  const domains = seed.domains.map((domain) => ({ ...domain }));
  const calls: string[] = [];
  const client: RetirementClient = {
    async getWorker(name) {
      calls.push(`get ${name}`);
      return workers.has(name);
    },
    async listDomains(name) {
      calls.push(`list ${name}`);
      return domains.filter((domain) => domain.service === name);
    },
    async detachDomain(domain) {
      calls.push(`detach ${domain.service} ${domain.hostname}`);
      const index = domains.findIndex((item) => item.id === domain.id);
      if (index >= 0) domains.splice(index, 1);
    },
    async deleteWorker(name) {
      calls.push(`delete ${name}`);
      workers.delete(name);
    },
  };
  return { client, calls, workers, domains };
}

const keptWorkers = [
  "thonbecker-personal-os",
  "thonbecker-personal-os-router",
  "thonbecker-family-quest",
];

test("deletes only the retired Worker, and detaches its custom domain first", async () => {
  assert.deepEqual(RETIRED_WORKERS, ["thonbecker-public-chat"]);
  const account = retirementAccount({
    workers: ["thonbecker-public-chat", ...keptWorkers],
    domains: [
      { id: "a".repeat(32), hostname: "chat.thonbecker.biz", service: "thonbecker-public-chat" },
      { id: "b".repeat(32), hostname: "os.thonbecker.biz", service: "thonbecker-personal-os" },
      { id: "c".repeat(32), hostname: "quest.thonbecker.biz", service: "thonbecker-family-quest" },
    ],
  });

  const results = await retireWorkers({
    retired: RETIRED_WORKERS,
    active: keptWorkers,
    client: account.client,
  });

  assert.deepEqual(results, [{
    name: "thonbecker-public-chat",
    outcome: "deleted",
    detachedHostnames: ["chat.thonbecker.biz"],
  }]);
  assert.deepEqual(account.calls, [
    "get thonbecker-public-chat",
    "list thonbecker-public-chat",
    "detach thonbecker-public-chat chat.thonbecker.biz",
    "delete thonbecker-public-chat",
  ]);
  assert.equal(account.workers.has("thonbecker-public-chat"), false);
  for (const name of keptWorkers) assert.equal(account.workers.has(name), true, name);
  assert.deepEqual(account.domains.map((domain) => domain.hostname), [
    "os.thonbecker.biz",
    "quest.thonbecker.biz",
  ]);
});

test("a retired Worker that is already gone makes no detach or delete request", async () => {
  const account = retirementAccount({
    workers: keptWorkers,
    domains: [
      { id: "b".repeat(32), hostname: "os.thonbecker.biz", service: "thonbecker-personal-os" },
    ],
  });

  const first = await retireWorkers({
    retired: RETIRED_WORKERS,
    active: keptWorkers,
    client: account.client,
  });
  assert.deepEqual(first, [{
    name: "thonbecker-public-chat",
    outcome: "absent",
    detachedHostnames: [],
  }]);
  assert.deepEqual(account.calls, ["get thonbecker-public-chat"]);
  assert.deepEqual(account.domains.map((domain) => domain.hostname), ["os.thonbecker.biz"]);

  const present = retirementAccount({
    workers: ["thonbecker-public-chat", ...keptWorkers],
    domains: [
      { id: "a".repeat(32), hostname: "chat.thonbecker.biz", service: "thonbecker-public-chat" },
    ],
  });
  await retireWorkers({
    retired: RETIRED_WORKERS,
    active: keptWorkers,
    client: present.client,
  });
  present.calls.length = 0;
  const second = await retireWorkers({
    retired: RETIRED_WORKERS,
    active: keptWorkers,
    client: present.client,
  });
  assert.equal(second[0]?.outcome, "absent");
  assert.deepEqual(present.calls, ["get thonbecker-public-chat"]);
});

test("refuses to delete a Worker that is not on the allowlist or is still configured", async () => {
  const account = retirementAccount({
    workers: ["thonbecker-personal-os", "thonbecker-public-chat"],
    domains: [],
  });

  await assert.rejects(
    () => retireWorkers({
      retired: ["thonbecker-personal-os"],
      active: [],
      client: account.client,
    }),
    /not on the retired Worker allowlist/,
  );
  await assert.rejects(
    () => retireWorkers({
      retired: ["thonbecker-public-chat"],
      active: ["thonbecker-public-chat"],
      client: account.client,
    }),
    /still an active Worker/,
  );
  assert.deepEqual(account.calls, []);
  assert.equal(account.workers.has("thonbecker-personal-os"), true);
  assert.equal(account.workers.has("thonbecker-public-chat"), true);

  assert.throws(
    () => assertRetirementAllowlist(["thonbecker-public-chat", "thonbecker-public-chat"], []),
    /more than once/,
  );
});

test("does not detach a domain that belongs to another Worker", async () => {
  const calls: string[] = [];
  const client: RetirementClient = {
    async getWorker() {
      return true;
    },
    async listDomains() {
      return [
        { id: "a".repeat(32), hostname: "chat.thonbecker.biz", service: "thonbecker-public-chat" },
        { id: "b".repeat(32), hostname: "os.thonbecker.biz", service: "thonbecker-personal-os" },
      ];
    },
    async detachDomain(domain) {
      calls.push(`detach ${domain.hostname}`);
    },
    async deleteWorker(name) {
      calls.push(`delete ${name}`);
    },
  };

  await assert.rejects(
    () => retireWorkers({ retired: RETIRED_WORKERS, active: [], client }),
    /belongs to thonbecker-personal-os/,
  );
  assert.deepEqual(calls, []);
});

test("parses a Workers Domains list response and keeps only the retired service", () => {
  // Shape of GET /accounts/{account_id}/workers/domains?service=...
  // https://developers.cloudflare.com/api/resources/workers/subresources/domains/methods/list/
  const page = {
    success: true,
    errors: [],
    messages: [],
    result: [
      {
        id: "dbe10b4bc17c295377eabd600e1787fd",
        cert_id: "9fdf92c8-64c2-4a3d-b1af-e15304961145",
        enabled: true,
        environment: "production",
        hostname: "chat.thonbecker.biz",
        previews_enabled: false,
        service: "thonbecker-public-chat",
        zone_id: "593c9c94de529bbbfaac7c53ced0447d",
        zone_name: "thonbecker.biz",
      },
      {
        id: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        cert_id: "11111111-1111-4111-8111-111111111111",
        enabled: true,
        environment: "production",
        hostname: "os.thonbecker.biz",
        previews_enabled: false,
        service: "thonbecker-personal-os",
        zone_id: "593c9c94de529bbbfaac7c53ced0447d",
        zone_name: "thonbecker.biz",
      },
    ],
    result_info: { count: 2, page: 1, per_page: 20, total_count: 2, total_pages: 1 },
  };

  assert.deepEqual(workerDomainsFromList("thonbecker-public-chat", page), [{
    id: "dbe10b4bc17c295377eabd600e1787fd",
    hostname: "chat.thonbecker.biz",
    service: "thonbecker-public-chat",
  }]);
  assert.equal(nextWorkerDomainPage(1, page), undefined);

  const continued = {
    result: page.result,
    result_info: { total_pages: 2 },
  };
  assert.equal(nextWorkerDomainPage(1, continued), 2);
  assert.equal(nextWorkerDomainPage(2, continued), undefined);
});

test("a Workers Domains item for the retired service names the fields it failed to parse", () => {
  assert.throws(
    () => workerDomainsFromList("thonbecker-public-chat", {
      result: [{
        id: "not-a-domain-id",
        service: "thonbecker-public-chat",
        zone_name: "thonbecker.biz",
        cert_id: "9fdf92c8-64c2-4a3d-b1af-e15304961145",
      }],
    }),
    /could not be parsed \(id is not a 32-character hex domain id; hostname is missing\)\. Result fields: cert_id, id, service, zone_name\./,
  );
});

test("a retired-worker failure still deploys the other Workers, then reports the cleanup error", async () => {
  const order: string[] = [];
  await assert.rejects(
    () => deployWorkersThenRetire({
      check: false,
      deploy: async () => {
        order.push("deploy");
      },
      retire: async () => {
        order.push("retire");
        throw new Error("Custom domain for thonbecker-public-chat could not be parsed (hostname is missing).");
      },
    }),
    /The other Workers were deployed\. Retired Worker cleanup failed: Custom domain for thonbecker-public-chat could not be parsed \(hostname is missing\)\./,
  );
  assert.deepEqual(order, ["deploy", "retire"]);

  await assert.rejects(
    () => deployWorkersThenRetire({
      check: false,
      deploy: async () => {
        throw new Error("wrangler failed");
      },
      retire: async () => {
        order.push("retire-after-failed-deploy");
      },
    }),
    /wrangler failed/,
  );
  assert.deepEqual(order, ["deploy", "retire"]);

  const checkOrder: string[] = [];
  await deployWorkersThenRetire({
    check: true,
    deploy: async () => {
      checkOrder.push("deploy");
    },
    retire: async () => {
      checkOrder.push("retire");
    },
  });
  assert.deepEqual(checkOrder, ["deploy"]);
});

test("treats a missing Worker as success and any other API failure as an error", () => {
  assert.equal(cloudflareResultKind(200, { success: true }), "ok");
  assert.equal(cloudflareResultKind(404, { success: false, errors: [{ code: 10007 }] }), "missing");
  assert.equal(cloudflareResultKind(400, { success: false, errors: [{ code: 10090 }] }), "missing");
  assert.equal(cloudflareResultKind(400, {
    success: false,
    errors: [{ code: 100109, message: "script_reference" }],
  }), "error");
  assert.equal(cloudflareResultKind(500, { success: false, errors: [] }), "error");
});

test("deployment.jsonc does not configure a Worker the deploy is allowed to delete", async () => {
  const errors: ParseError[] = [];
  const deployment = validateConfig(parse(
    await readFile(new URL("../deployment.jsonc", import.meta.url), "utf8"),
    errors,
    { allowTrailingComma: true },
  ) as DeploymentConfig);
  assert.deepEqual(errors, []);
  const active = activeWorkerNames(deployment.workers);
  assertRetirementAllowlist(RETIRED_WORKERS, active);
  for (const name of RETIRED_WORKERS) assert.equal(active.includes(name), false, name);
});

test("records a partial deployment rather than dropping what did ship", () => {
  const entry = deploymentLogEntry({
    timestamp: "2026-09-26 18:47",
    rootCommit: "25dd0ed",
    submoduleCommit: "270ca7c5",
    versions: [["acme-os-errors", "aaaaaaaa-1111-2222-3333-444444444444"]],
  });
  assert.equal(entry.includes("acme-os-router"), false);
});
