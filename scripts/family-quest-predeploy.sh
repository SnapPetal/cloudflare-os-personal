#!/usr/bin/env bash
# Apply Family Quest's D1 migrations, including the SRD seed, then set its Worker
# secrets. The Deploy workflow runs this after the other Workers and before the
# Family Quest upload. An empty GitHub secret is skipped with a warning.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ -z "${CLOUDFLARE_ACCOUNT_ID:-}" ]]; then
  CLOUDFLARE_ACCOUNT_ID="$(node --input-type=module -e '
    import { readFileSync } from "node:fs";
    import { parse } from "jsonc-parser";
    const config = parse(readFileSync("deployment.jsonc", "utf8"));
    if (typeof config.accountId !== "string" || config.accountId.length === 0) {
      process.exit(1);
    }
    process.stdout.write(config.accountId);
  ')"
fi
export CLOUDFLARE_ACCOUNT_ID

wrangler() {
  if [[ -n "${WRANGLER_BIN:-}" ]]; then
    "$WRANGLER_BIN" "$@"
  else
    pnpm --dir packages/family-quest exec wrangler "$@"
  fi
}

echo "Applying Family Quest D1 migrations (schema and SRD seed)."
wrangler d1 migrations apply thonbecker-family-quest --remote

put_secret() {
  local worker_secret="$1"
  local github_secret="$2"
  local value="${3-}"
  if [[ -z "${value//[[:space:]]/}" ]]; then
    echo "::warning::Skipping wrangler secret put ${worker_secret} because GitHub secret ${github_secret} is empty."
    echo "warning: Skipping wrangler secret put ${worker_secret} because GitHub secret ${github_secret} is empty." >&2
    return 0
  fi
  printf '%s' "$value" | wrangler secret put "$worker_secret" --name thonbecker-family-quest
}

put_secret FAMILY_PASSCODE FAMILY_QUEST_PASSCODE "${FAMILY_QUEST_PASSCODE-}"
put_secret SESSION_SECRET FAMILY_QUEST_SESSION_SECRET "${FAMILY_QUEST_SESSION_SECRET-}"
