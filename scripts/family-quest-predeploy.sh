#!/usr/bin/env bash
# Apply Family Quest's D1 migrations, including the SRD seed. The Deploy workflow runs
# this after the other Workers and before the Family Quest upload. Sign-in is Cloudflare
# Access, configured as plain vars, so this step does not set Worker secrets.
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
