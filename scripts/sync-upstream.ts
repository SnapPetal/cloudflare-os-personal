import { spawnSync } from "node:child_process";
import { readFile } from "node:fs/promises";
import { fileURLToPath, pathToFileURL } from "node:url";
import { dirname, join, resolve } from "node:path";
import { pnpmCommand } from "../cloudflare-os/scripts/pnpm-command.ts";

/**
 * Report how the pinned `cloudflare-os` commit compares to upstream main.
 *
 * The pin is an upstream commit. Personal changes are patches under `patches/cloudflare-os/`,
 * applied by `pnpm apply:patches`. This script never commits inside the submodule, never pushes,
 * and never deploys.
 *
 *   node scripts/sync-upstream.ts            fetch, report, and check the mirrored catalog
 *   node scripts/sync-upstream.ts --verify   also apply patches, install, lint, dry-run, and test
 *
 * Exit codes: 0 the pin is upstream/main and the catalog matches, 1 a step failed or the pin is
 * not an upstream commit, 2 the mirrored catalog has drifted, 3 the pin is behind upstream/main.
 * 3 is not an error -- it is how a caller tells "nothing to do" from "work to do".
 */

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const submoduleDir = join(root, "cloudflare-os");

/**
 * The two blocks this repository mirrors from the submodule's `pnpm-workspace.yaml`, and only these
 * two. `packages`, `allowBuilds` and `minimumReleaseAge*` are deliberately not mirrored: the first
 * is this repository's own layout, the second is a build-permission policy, and the third is the
 * submodule's supply-chain gate, which has no meaning here. Diffing whole files reports all three
 * as differences and trains you to ignore the output.
 */
const mirroredSections = ["catalog", "overrides"] as const;
type MirroredSection = (typeof mirroredSections)[number];

/**
 * Override keys this repository adds and the submodule does not.
 *
 * `sharp` is the security pin for miniflare 5.20261001.0-alpha, which depends on 0.35.4 exactly.
 * The fixed release is 0.35.5, and Dependabot security updates cannot move that pin. It is not a
 * catalog entry and not part of the capnweb dedupe contract, so its absence upstream is not drift.
 * A value the submodule *does* declare still has to match.
 */
const parentOnlyOverrideKeys = new Set(["sharp"]);

/** One mirrored key whose two copies disagree. `null` on a side means the key is absent there. */
export interface CatalogDrift {
  section: MirroredSection;
  key: string;
  starter: string | null;
  submodule: string | null;
}

export interface Divergence {
  /** Commits on upstream that the checked-out pin does not have. */
  behind: number;
  /** Commits on the pin that upstream does not have. This stays 0 for an unmodified upstream pin. */
  ahead: number;
}

/** `git rev-list --left-right --count A...B` prints two tab-separated counts. */
export function parseDivergence(output: string): Divergence {
  const match = /^(\d+)\s+(\d+)\s*$/.exec(output.trim());
  if (!match) throw new Error(`Unrecognized rev-list output: ${JSON.stringify(output)}`);
  return { behind: Number(match[1]), ahead: Number(match[2]) };
}

/**
 * Drop a trailing `# comment`, honouring quotes so a value like `"catalog:"` survives intact.
 * Comments carry the reasoning behind most of these pins, so they are stripped rather than
 * compared: rewording a comment upstream is not drift.
 */
function stripComment(line: string): string {
  let quote: string | null = null;
  for (let index = 0; index < line.length; index++) {
    const char = line[index];
    if (quote) {
      if (char === quote) quote = null;
    } else if (char === '"' || char === "'") {
      quote = char;
    } else if (char === "#" && (index === 0 || /\s/.test(line[index - 1]))) {
      return line.slice(0, index);
    }
  }
  return line;
}

function unquote(value: string): string {
  return value.length >= 2 &&
    ((value.startsWith('"') && value.endsWith('"')) ||
     (value.startsWith("'") && value.endsWith("'")))
    ? value.slice(1, -1)
    : value;
}

/**
 * The mirrored keys of a `pnpm-workspace.yaml`, as section -> key -> value.
 *
 * A line-oriented read rather than a YAML parse: the two files are the same document upstream and
 * a fork, and the only question is whether the mirrored entries still say the same thing. A real
 * parse would also have to understand that the submodule's file carries sections this one has no
 * business copying.
 */
export function parseMirroredEntries(
  text: string,
): Map<MirroredSection, Map<string, string>> {
  const sections = new Map<MirroredSection, Map<string, string>>(
    mirroredSections.map((section) => [section, new Map<string, string>()]),
  );
  let current: MirroredSection | null = null;
  for (const line of text.split(/\r?\n/)) {
    const topLevel = /^([A-Za-z][A-Za-z0-9_-]*):/.exec(line);
    if (topLevel) {
      const name = topLevel[1] as MirroredSection;
      current = mirroredSections.find((section) => section === name) ?? null;
      continue;
    }
    if (!current) continue;
    const entry = /^\s+(.+?):\s*(.*)$/.exec(stripComment(line));
    // List items (`  - workerd`) and blank lines are not entries.
    if (entry) sections.get(current)!.set(unquote(entry[1].trim()), unquote(entry[2].trim()));
  }
  return sections;
}

/**
 * Every mirrored key whose two copies disagree, in a stable order.
 *
 * A *missing* entry fails `pnpm install` loudly. A *stale* one installs a second copy of capnweb
 * and every RPC call then fails at runtime with `Cannot serialize value: [object RpcStub]` -- from
 * a deploy that changed nothing anyone reviewed. That asymmetry is the whole reason this check
 * exists, and the reason it runs even in the read-only default.
 */
export function catalogDrift(starterText: string, submoduleText: string): CatalogDrift[] {
  const starter = parseMirroredEntries(starterText);
  const submodule = parseMirroredEntries(submoduleText);
  const drift: CatalogDrift[] = [];
  for (const section of mirroredSections) {
    const mine = starter.get(section)!;
    const theirs = submodule.get(section)!;
    for (const key of [...new Set([...mine.keys(), ...theirs.keys()])].toSorted()) {
      const left = mine.get(key) ?? null;
      const right = theirs.get(key) ?? null;
      if (section === "overrides" && parentOnlyOverrideKeys.has(key) && right === null) continue;
      if (left !== right) drift.push({ section, key, starter: left, submodule: right });
    }
  }
  return drift;
}

function git(args: string[], cwd = root): { status: number; stdout: string; stderr: string } {
  const result = spawnSync("git", args, { cwd, encoding: "utf8" });
  return {
    status: result.status ?? 1,
    stdout: result.stdout ?? "",
    stderr: result.stderr ?? result.error?.message ?? "",
  };
}

function gitOutput(args: string[], cwd = root): string {
  const result = git(args, cwd);
  if (result.status !== 0) {
    throw new Error(`git ${args.join(" ")} failed: ${result.stderr.trim() || result.stdout.trim()}`);
  }
  return result.stdout.trim();
}

export interface PinState {
  /** `upstream` when that remote exists, otherwise `origin`. */
  remote: string;
  upstreamRef: string;
  upstreamTip: string;
  /** The commit checked out in cloudflare-os. Patches do not move it. */
  checkedOut: string;
  /** The commit this repository's gitlink records at parent HEAD. */
  pinned: string;
  divergence: Divergence;
}

function hasRemote(name: string): boolean {
  return git(["remote"], submoduleDir).stdout.split("\n").map((line) => line.trim())
    .includes(name);
}

function upstreamRemote(): string {
  if (hasRemote("upstream")) return "upstream";
  if (hasRemote("origin")) return "origin";
  throw new Error(
    "cloudflare-os has no upstream or origin remote. The submodule URL should be " +
    "https://github.com/cloudflare/cloudflare-os.git.");
}

function fetchUpstream(remote: string): void {
  const result = git(["fetch", "--quiet", remote, "main"], submoduleDir);
  if (result.status !== 0) {
    throw new Error(`git fetch ${remote} main failed: ${result.stderr.trim() || result.stdout.trim()}`);
  }
}

export function readPinState(): PinState {
  const remote = upstreamRemote();
  const upstreamRef = `${remote}/main`;
  const checkedOut = gitOutput(["rev-parse", "HEAD"], submoduleDir);
  const pinMatch = /^160000 commit ([0-9a-f]{40})\tcloudflare-os$/m.exec(
    gitOutput(["ls-tree", "HEAD", "cloudflare-os"]),
  );
  const [behind, ahead] = gitOutput(
    ["rev-list", "--left-right", "--count", `${upstreamRef}...${checkedOut}`], submoduleDir,
  ).split(/\s+/);
  return {
    remote,
    upstreamRef,
    upstreamTip: gitOutput(["rev-parse", upstreamRef], submoduleDir),
    checkedOut,
    pinned: pinMatch?.[1] ?? "unknown",
    divergence: parseDivergence(`${behind} ${ahead}`),
  };
}

/** The upstream packages this deployment actually ships, most expensive first. */
const verifyPackages = [
  "@gadgets/workshop-backend",
  "@gadgets/workshop-frontend",
  "@gadgets/gatekeeper-scheduler",
  "@gadgets/gatekeeper-context",
  "@gadgets/router",
] as const;

function runPnpm(args: string[], label: string, capture = false): number {
  const [command, argv] = pnpmCommand(args, process.env);
  const result = spawnSync(command, argv, {
    cwd: root,
    env: process.env,
    stdio: capture ? ["ignore", "pipe", "pipe"] : "inherit",
    encoding: "utf8",
  });
  if (capture) {
    process.stdout.write(result.stdout ?? "");
    process.stderr.write(result.stderr ?? "");
  }
  const status = result.status ?? 1;
  if (status !== 0) console.error(`\n[failed] ${label}`);
  return status;
}

/**
 * Apply the personal patches, install both workspaces, then run everything that has to pass
 * before a new pin is worth committing.
 *
 * The per-package suites pipe their output so a package with no `test` task can be told apart from a
 * package whose tests failed: `Task "test" not found` is a fact about the package, not a broken
 * checkout, and treating it as a failure trains you to skip the whole loop.
 */
function verify(): string[] {
  const failures: string[] = [];
  const step = (label: string, args: string[]): void => {
    console.log(`\n=== ${label}`);
    if (runPnpm(args, label) !== 0) failures.push(label);
  };
  console.log("\n=== apply patches");
  const apply = spawnSync("bash", ["scripts/apply-cloudflare-os-patches.sh"], {
    cwd: root, env: process.env, stdio: "inherit",
  });
  if ((apply.status ?? 1) !== 0) failures.push("apply patches");
  step("pnpm install (this workspace)", ["install"]);
  step("pnpm install (submodule)", ["--dir", "cloudflare-os", "install"]);
  step("generated worker configs", ["--dir", "cloudflare-os", "configs:check"]);
  console.log("\n=== golden release manifest");
  const golden = spawnSync(process.execPath, ["--test", "scripts/release/manifest-lib.test.ts"], {
    cwd: submoduleDir, env: process.env, stdio: "inherit",
  });
  if ((golden.status ?? 1) !== 0) {
    console.error("\n[failed] golden release manifest");
    failures.push("golden release manifest");
  }
  step("pnpm lint", ["lint"]);
  step("pnpm check", ["check"]);
  for (const pkg of verifyPackages) {
    console.log(`\n=== ${pkg} tests`);
    const args = ["--dir", "cloudflare-os", "exec", "vp", "run", "-F", pkg, "--no-cache", "test"];
    const [command, argv] = pnpmCommand(args, process.env);
    const result = spawnSync(command, argv, {
      cwd: root, env: process.env, stdio: ["ignore", "pipe", "pipe"], encoding: "utf8",
    });
    const output = `${result.stdout ?? ""}${result.stderr ?? ""}`;
    process.stdout.write(result.stdout ?? "");
    process.stderr.write(result.stderr ?? "");
    if (result.status === 0) continue;
    if (/Task "test" not found/.test(output)) {
      console.log(`[skipped] ${pkg} has no test task`);
      continue;
    }
    console.error(`\n[failed] ${pkg} tests`);
    failures.push(`${pkg} tests`);
  }
  return failures;
}

async function reportCatalogDrift(): Promise<number> {
  const drift = catalogDrift(
    await readFile(join(root, "pnpm-workspace.yaml"), "utf8"),
    await readFile(join(submoduleDir, "pnpm-workspace.yaml"), "utf8"),
  );
  if (!drift.length) {
    console.log("\ncatalog: in sync with the submodule");
    return 0;
  }
  console.error("\ncatalog: DRIFTED from the submodule");
  for (const entry of drift) {
    const mine = entry.starter ?? "(absent)";
    const theirs = entry.submodule ?? "(absent)";
    console.error(`  ${entry.section}.${entry.key}: here ${mine}, submodule ${theirs}`);
  }
  console.error(
    "\nReconcile pnpm-workspace.yaml before installing. A missing entry fails the install; a stale\n" +
    "one resolves a second copy of capnweb, and every RPC call then fails at runtime with\n" +
    '"Cannot serialize value: [object RpcStub]".',
  );
  return 2;
}

async function main(): Promise<number> {
  const argv = process.argv.slice(2);
  if (argv.some((arg) => arg === "--merge" || arg === "--branch" || arg.startsWith("--branch="))) {
    throw new Error(
      "--merge and --branch are gone. Personal changes are patches in patches/cloudflare-os/, " +
      "not commits on SnapPetal/cloudflare-os. See README, \"Bump the upstream pin\".");
  }
  const unknown = argv.filter((arg) => arg !== "--verify");
  if (unknown.length) {
    throw new Error(`Unknown argument(s): ${unknown.join(" ")}. See the header of this file.`);
  }
  const verifyToo = argv.includes("--verify");

  const remote = upstreamRemote();
  console.log(`=== fetching ${remote} main`);
  fetchUpstream(remote);

  const state = readPinState();
  const { behind, ahead } = state.divergence;
  console.log(`\nsubmodule HEAD: ${state.checkedOut}`);
  console.log(`parent gitlink: ${state.pinned}`);
  console.log(`upstream:       ${state.upstreamTip} (${state.upstreamRef})`);
  console.log(`divergence:     ${behind} behind, ${ahead} ahead`);
  if (state.pinned !== "unknown" && state.checkedOut !== state.pinned) {
    console.log(
      "\nThe checked-out commit and the parent HEAD gitlink differ. Commit the gitlink if this " +
      "move is intentional. Patches do not change the gitlink.");
  }
  if (ahead > 0) {
    console.error(
      "\nThe pin contains commits that are not on upstream/main. This deployment tracks " +
      "unmodified upstream. Move the gitlink back onto upstream/main and keep personal work in " +
      "patches/cloudflare-os/.");
    return 1;
  }

  const driftCode = await reportCatalogDrift();
  if (driftCode !== 0) return driftCode;

  if (behind > 0) {
    console.log(
      `\n${behind} upstream commit(s) since the pin. See README, "Bump the upstream pin". ` +
      "This command does not move the pin.");
  } else {
    console.log("\npin is upstream/main.");
  }

  if (verifyToo) {
    const failures = verify();
    if (failures.length) {
      console.error(`\nVerification failed: ${failures.join(", ")}`);
      return 1;
    }
    console.log("\nVerification passed.");
  }

  console.log(
    "\nNext steps, in order -- each is a separate decision:\n" +
    "  1. if the pin should move, follow README \"Bump the upstream pin\"\n" +
    "  2. commit the gitlink and any refreshed patch in this repository\n" +
    "  3. deploy: pnpm deploy   (production; Router deploys last)",
  );
  return behind > 0 ? 3 : 0;
}

if (process.argv[1] && import.meta.url === pathToFileURL(resolve(process.argv[1])).href) {
  try {
    process.exitCode = await main();
  } catch (error) {
    // One line, no stack, like scripts/deploy.ts: every failure here is git or argument shape.
    console.error(`\nSync failed. ${(error as Error).message}`);
    process.exitCode = 1;
  }
}
