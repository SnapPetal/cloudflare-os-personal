import { spawnSync } from "node:child_process";
import { readFile } from "node:fs/promises";
import { fileURLToPath, pathToFileURL } from "node:url";
import { dirname, join, resolve } from "node:path";
import { pnpmCommand } from "../cloudflare-os/scripts/pnpm-command.ts";

/**
 * Move the `cloudflare-os` pin forward, in the order that keeps the failure loud.
 *
 * The pin is a commit, not a branch, and this script exists so keeping it current is a command
 * rather than a project. It never pushes the fork, never touches the parent's gitlink, and never
 * deploys: those are three separate decisions, and the last one is production.
 *
 *   node scripts/sync-upstream.ts            fetch, report, and check the mirrored catalog
 *   node scripts/sync-upstream.ts --merge    also merge upstream/main into the fork branch
 *   node scripts/sync-upstream.ts --verify   also install, lint, dry-run, and run the suites
 *   node scripts/sync-upstream.ts --merge --verify    all of it, locally
 *
 * Exit codes: 0 in sync, 1 something failed, 2 the mirrored catalog has drifted, 3 the fork is
 * behind upstream/main and `--merge` was not passed. 3 is not an error -- it is how a caller tells
 * "nothing to do" from "work to do".
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

/** One mirrored key whose two copies disagree. `null` on a side means the key is absent there. */
export interface CatalogDrift {
  section: MirroredSection;
  key: string;
  starter: string | null;
  submodule: string | null;
}

export interface Divergence {
  /** Commits in the upstream ref that the fork branch does not have. */
  behind: number;
  /** Commits on the fork branch that the upstream ref does not have: this repository's own work. */
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

export interface ForkState {
  branch: string;
  upstreamRef: string;
  divergence: Divergence;
  /** The fork branch tip. */
  forkTip: string;
  /** The commit this repository's gitlink records. */
  pinned: string;
  /** Whether the pinned commit is on the fork branch's history at all. */
  pinOnBranch: boolean;
  /** Whether the fork branch has commits `origin` has not seen. */
  unpushed: number;
}

function hasRemote(name: string): boolean {
  return git(["remote"], submoduleDir).stdout.split("\n").map((line) => line.trim())
    .includes(name);
}

export function readForkState(branch?: string): ForkState {
  const head = gitOutput(["rev-parse", "--abbrev-ref", "HEAD"], submoduleDir);
  const resolved = branch ?? head;
  if (head === "HEAD") {
    throw new Error(
      "The submodule is on a detached HEAD, so there is no branch to merge into. Check out the " +
      "fork branch first, or pass --branch <name>.");
  }
  if (!hasRemote("upstream")) {
    throw new Error(
      "The submodule has no `upstream` remote, so there is nothing to compare against. Add it: " +
      "git -C cloudflare-os remote add upstream https://github.com/cloudflare/cloudflare-os.git");
  }
  // `upstream/HEAD` is the upstream default branch, whatever it is called this month.
  const upstreamRef = gitOutput(["symbolic-ref", "--short", "refs/remotes/upstream/HEAD"], submoduleDir);
  const [behind, ahead] = gitOutput(
    ["rev-list", "--left-right", "--count", `${upstreamRef}...${resolved}`], submoduleDir,
  ).split(/\s+/);
  const pinMatch = /^160000 commit ([0-9a-f]{40})\tcloudflare-os$/m.exec(
    gitOutput(["ls-tree", "HEAD", "cloudflare-os"]),
  );
  return {
    branch: resolved,
    upstreamRef,
    divergence: parseDivergence(`${behind} ${ahead}`),
    forkTip: gitOutput(["rev-parse", resolved], submoduleDir),
    pinned: pinMatch?.[1] ?? "unknown",
    pinOnBranch: git(["merge-base", "--is-ancestor", pinMatch?.[1] ?? "", resolved], submoduleDir)
      .status === 0,
    unpushed: Number(gitOutput(
      ["rev-list", "--count", `origin/${resolved}..${resolved}`], submoduleDir,
    )),
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
 * Install both workspaces, then run everything that has to pass before a pin is worth committing.
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
  step("pnpm install (this workspace)", ["install"]);
  step("pnpm install (submodule)", ["--dir", "cloudflare-os", "install"]);
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

/**
 * What a human merge of `upstream/main` has to preserve. Upstream and this fork both edit
 * `server.ts`, the router, and the admin page, so these are the conflicts that matter -- a merge
 * that drops one of them still builds, and still passes the suites, and quietly removes a feature.
 */
const preserveAfterMerge = [
  "grep -rn 'handleVectorStoreRequest\\|handleBookingAdminRequest\\|isSamePublicOrigin' cloudflare-os/packages/workshop-backend/src",
  "grep -n 'vector-store' cloudflare-os/packages/router/wrangler.jsonc cloudflare-os/packages/router/src/index.ts",
  "grep -rn 'VectorStoreAdminPanel\\|BookingAdminPanel' cloudflare-os/packages/workshop-frontend/src",
];

function mergeUpstream(state: ForkState): boolean {
  console.log(`\n=== git -C cloudflare-os merge ${state.upstreamRef}`);
  const result = git(["merge", "--no-edit", state.upstreamRef], submoduleDir);
  if (result.status === 0) {
    console.log(result.stdout.trim());
    console.log("\nConfirm this repository's own work survived the merge:");
    for (const command of preserveAfterMerge) console.log(`  ${command}`);
    return true;
  }
  console.error(
    `\nMerge stopped on conflicts. Resolve them inside cloudflare-os/ -- keeping both sides -- then:\n` +
    `  git -C cloudflare-os add -A && git -C cloudflare-os commit\n` +
    `Or start over with:\n  git -C cloudflare-os merge --abort\n\n` +
    `What the merge must not lose:\n` +
    preserveAfterMerge.map((command) => `  ${command}`).join("\n"),
  );
  return false;
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
  const known = new Set(["--merge", "--verify", "--branch"]);
  const unknown = argv.filter((arg, index) =>
    !known.has(arg) && !(arg.startsWith("--branch=") || (known.has("--branch") && index > 0 &&
      !argv[index - 1].startsWith("-"))));
  if (unknown.length) {
    throw new Error(`Unknown argument(s): ${unknown.join(" ")}. See the header of this file.`);
  }
  const branchIndex = argv.indexOf("--branch");
  const branch = branchIndex === -1
    ? argv.find((arg) => arg.startsWith("--branch="))?.slice("--branch=".length)
    : argv[branchIndex + 1];
  const merge = argv.includes("--merge");
  const verifyToo = argv.includes("--verify");

  console.log("=== fetching upstream and origin");
  for (const remote of ["upstream", "origin"]) {
    if (hasRemote(remote)) {
      const result = git(["fetch", "--quiet", remote], submoduleDir);
      if (result.status !== 0) throw new Error(`git fetch ${remote} failed: ${result.stderr.trim()}`);
    }
  }

  const state = readForkState(branch);
  const { behind, ahead } = state.divergence;
  console.log(`\nfork branch:  ${state.branch} @ ${state.forkTip.slice(0, 9)}`);
  console.log(`upstream:     ${state.upstreamRef}`);
  console.log(`divergence:   ${behind} behind, ${ahead} ahead (the ahead commits are this fork's own)`);
  console.log(`parent pin:   ${state.pinned.slice(0, 9)}${state.pinOnBranch ? "" : "  NOT on the branch"}`);
  console.log(`unpushed:     ${state.unpushed} commit(s) on ${state.branch}`);

  const driftCode = await reportCatalogDrift();
  if (driftCode !== 0) return driftCode;

  if (merge && behind > 0) {
    if (!mergeUpstream(state)) return 1;
  } else if (behind > 0) {
    console.log(`\n${behind} upstream commit(s) to merge. Re-run with --merge to do it locally.`);
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
    `\nNext steps, in order -- each is a separate decision:\n` +
    `  1. commit the pin, if it moved:  git add cloudflare-os pnpm-workspace.yaml pnpm-lock.yaml\n` +
    `  2. push this repository:         git push origin main\n` +
    `  3. push the fork, if it moved:   git -C cloudflare-os push origin ${state.branch}\n` +
    `  4. deploy:                       pnpm deploy   (production; Router deploys last)`,
  );
  return behind > 0 && !merge ? 3 : 0;
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
