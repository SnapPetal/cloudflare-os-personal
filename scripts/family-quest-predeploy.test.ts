import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { chmodSync, mkdtempSync, readFileSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("..", import.meta.url));

function runPredeploy(env: Record<string, string | undefined> = {}) {
  const dir = mkdtempSync(join(tmpdir(), "fq-wrangler-"));
  const bin = join(dir, "wrangler");
  const log = join(dir, "args");
  writeFileSync(bin, `#!/usr/bin/env bash
printf '%s\\n' "$*" >> ${JSON.stringify(log)}
`);
  chmodSync(bin, 0o755);
  writeFileSync(log, "");
  const result = spawnSync("bash", ["scripts/family-quest-predeploy.sh"], {
    cwd: root,
    env: {
      ...process.env,
      WRANGLER_BIN: bin,
      CLOUDFLARE_ACCOUNT_ID: "0123456789abcdef0123456789abcdef",
      ...env,
    },
    encoding: "utf8",
  });
  return {
    status: result.status,
    stdout: result.stdout,
    stderr: result.stderr,
    args: readFileSync(log, "utf8"),
  };
}

test("applies remote D1 migrations and does not put Worker secrets", () => {
  const ran = runPredeploy({
    FAMILY_QUEST_PASSCODE: "should-not-be-installed",
    FAMILY_QUEST_SESSION_SECRET: "should-not-be-installed",
  });
  assert.equal(ran.status, 0, ran.stderr);
  assert.match(ran.args, /^d1 migrations apply thonbecker-family-quest --remote\n$/);
  assert.equal(ran.args.includes("secret"), false);
  assert.equal(ran.stdout.includes("should-not-be-installed"), false);
  assert.equal(ran.stderr.includes("should-not-be-installed"), false);
});
