import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { chmodSync, mkdtempSync, readFileSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("..", import.meta.url));

function runPredeploy(env: Record<string, string | undefined>) {
  const dir = mkdtempSync(join(tmpdir(), "fq-wrangler-"));
  const bin = join(dir, "wrangler");
  const log = join(dir, "args");
  const stdinLog = join(dir, "stdin");
  writeFileSync(bin, `#!/usr/bin/env bash
printf '%s\\n' "$*" >> ${JSON.stringify(log)}
if [[ "$1" == "secret" ]]; then
  cat >> ${JSON.stringify(stdinLog)}
  printf '\\n' >> ${JSON.stringify(stdinLog)}
fi
`);
  chmodSync(bin, 0o755);
  writeFileSync(log, "");
  writeFileSync(stdinLog, "");
  const result = spawnSync("bash", ["scripts/family-quest-predeploy.sh"], {
    cwd: root,
    env: {
      ...process.env,
      WRANGLER_BIN: bin,
      CLOUDFLARE_ACCOUNT_ID: "0123456789abcdef0123456789abcdef",
      FAMILY_QUEST_PASSCODE: "",
      FAMILY_QUEST_SESSION_SECRET: "",
      ...env,
    },
    encoding: "utf8",
  });
  return {
    status: result.status,
    stdout: result.stdout,
    stderr: result.stderr,
    args: readFileSync(log, "utf8"),
    stdin: readFileSync(stdinLog, "utf8"),
  };
}

test("applies remote D1 migrations and skips empty Family Quest secrets", () => {
  const ran = runPredeploy({});
  assert.equal(ran.status, 0, ran.stderr);
  assert.match(ran.args, /^d1 migrations apply thonbecker-family-quest --remote\n$/);
  assert.match(ran.stderr, /Skipping wrangler secret put FAMILY_PASSCODE because GitHub secret FAMILY_QUEST_PASSCODE is empty/);
  assert.match(ran.stderr, /Skipping wrangler secret put SESSION_SECRET because GitHub secret FAMILY_QUEST_SESSION_SECRET is empty/);
  assert.equal(ran.stdin, "");
});

test("puts each non-empty Family Quest secret without printing it", () => {
  const passcode = "family-passcode-value";
  const session = "session-secret-value-0123456789";
  const ran = runPredeploy({
    FAMILY_QUEST_PASSCODE: passcode,
    FAMILY_QUEST_SESSION_SECRET: session,
  });
  assert.equal(ran.status, 0, ran.stderr);
  assert.match(ran.args, /d1 migrations apply thonbecker-family-quest --remote/);
  assert.match(ran.args, /secret put FAMILY_PASSCODE --name thonbecker-family-quest/);
  assert.match(ran.args, /secret put SESSION_SECRET --name thonbecker-family-quest/);
  assert.equal(ran.stdin, `${passcode}\n${session}\n`);
  assert.equal(ran.stdout.includes(passcode), false);
  assert.equal(ran.stdout.includes(session), false);
  assert.equal(ran.stderr.includes(passcode), false);
  assert.equal(ran.stderr.includes(session), false);
});

test("skips a whitespace-only secret and still puts the other one", () => {
  const session = "session-secret-value-0123456789";
  const ran = runPredeploy({
    FAMILY_QUEST_PASSCODE: "   ",
    FAMILY_QUEST_SESSION_SECRET: session,
  });
  assert.equal(ran.status, 0, ran.stderr);
  assert.match(ran.stderr, /Skipping wrangler secret put FAMILY_PASSCODE/);
  assert.equal(ran.args.includes("secret put FAMILY_PASSCODE"), false);
  assert.match(ran.args, /secret put SESSION_SECRET --name thonbecker-family-quest/);
  assert.equal(ran.stdin, `${session}\n`);
});
