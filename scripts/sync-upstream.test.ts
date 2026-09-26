import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { dirname, join, resolve } from "node:path";
import test from "node:test";
import { catalogDrift, parseDivergence, parseMirroredEntries } from "./sync-upstream.ts";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");

const starter = `packages:
  - cloudflare-os/packages/workshop-shared

catalog:
  capnweb: ^0.12.0
  # Exact: pinned in lockstep with capnweb (declared as a >=0.7.0 peer)
  capnweb-validate: 0.3.0
  typescript6: npm:typescript@6.0.3
  wrangler: ^4.138.0

overrides:
  vite: "catalog:"
  '@cloudflare/vitest-pool-workers>miniflare': "catalog:"
  '@types/node': 26.1.0

allowBuilds:
  workerd: true
`;

const submodule = `packages:
  - packages/workshop-shared

catalog:
  capnweb: ^0.12.0
  # Exact: pinned in lockstep with capnweb (declared as a >=0.7.0 peer)
  capnweb-validate: 0.3.0
  typescript6: npm:typescript@6.0.3
  wrangler: ^4.138.0

overrides:
  vite: "catalog:"
  '@cloudflare/vitest-pool-workers>miniflare': "catalog:"
  '@types/node': 26.1.0

# The submodule's supply-chain gate. This repository does not mirror it, and must not.
minimumReleaseAge: 1440

minimumReleaseAgeExclude:
  - capnweb
  - workerd

allowBuilds:
  workerd: true
`;

test("reads the mirrored blocks and leaves the rest of the document alone", () => {
  const sections = parseMirroredEntries(submodule);
  assert.deepEqual(sections.get("catalog"), new Map([
    ["capnweb", "^0.12.0"],
    ["capnweb-validate", "0.3.0"],
    ["typescript6", "npm:typescript@6.0.3"],
    ["wrangler", "^4.138.0"],
  ]));
  assert.equal(sections.get("overrides")!.get("vite"), "catalog:");
  // minimumReleaseAge* and allowBuilds are policy, not mirror targets.
  assert.equal(sections.get("overrides")!.has("workerd"), false);
});

test("keeps a quoted value that contains a colon intact", () => {
  const sections = parseMirroredEntries(submodule);
  assert.equal(sections.get("overrides")!.get("@cloudflare/vitest-pool-workers>miniflare"),
    "catalog:");
});

test("ignores comments, so rewording one upstream is not drift", () => {
  assert.deepEqual(catalogDrift(starter, submodule.replace(
    "  # Exact: pinned in lockstep with capnweb (declared as a >=0.7.0 peer)",
    "  # Exact: pinned in lockstep with capnweb",
  )), []);
});

test("ignores the sections this repository does not mirror", () => {
  // The submodule's minimumReleaseAge block is absent from the starter file; that is by design.
  assert.deepEqual(catalogDrift(starter, submodule), []);
});

test("a stale entry is drift, and reports both values", () => {
  const drift = catalogDrift(starter.replace("capnweb: ^0.12.0", "capnweb: ^0.11.0"), submodule);
  assert.deepEqual(drift, [{
    section: "catalog", key: "capnweb", starter: "^0.11.0", submodule: "^0.12.0",
  }]);
});

test("an entry the submodule added and this file lacks is drift", () => {
  const upgraded = submodule.replace("  wrangler: ^4.138.0", "  wrangler: ^4.138.0\n  zod: ^4.5.4");
  assert.deepEqual(catalogDrift(starter, upgraded), [
    { section: "catalog", key: "zod", starter: null, submodule: "^4.5.4" },
  ]);
});

test("an override this file carries and the submodule dropped is drift too", () => {
  const extra = starter.replace("  '@types/node': 26.1.0", "  '@types/node': 26.1.0\n  '@lezer/markdown': 1.6.4");
  assert.deepEqual(catalogDrift(extra, submodule), [
    { section: "overrides", key: "@lezer/markdown", starter: "1.6.4", submodule: null },
  ]);
});

test("the real workspace files are in sync", async () => {
  // The regression this whole script exists for: a submodule bump that adds a catalog entry
  // without the matching edit here installs a second capnweb and breaks every RPC call at runtime,
  // with a green install and a deploy that changed nothing.
  assert.deepEqual(
    catalogDrift(
      await readFile(join(root, "pnpm-workspace.yaml"), "utf8"),
      await readFile(join(root, "cloudflare-os", "pnpm-workspace.yaml"), "utf8"),
    ),
    [],
  );
});

test("reads git's two-column divergence count", () => {
  assert.deepEqual(parseDivergence("0\t10\n"), { behind: 0, ahead: 10 });
  assert.deepEqual(parseDivergence(" 37\t10 "), { behind: 37, ahead: 10 });
  assert.throws(() => parseDivergence(""), /Unrecognized rev-list output/);
  assert.throws(() => parseDivergence("ahead 3"), /Unrecognized rev-list output/);
});
