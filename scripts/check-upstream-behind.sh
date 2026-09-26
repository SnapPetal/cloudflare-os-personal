#!/usr/bin/env bash
# Report when the cloudflare-os fork is behind upstream. Prints nothing when it is level, which bb
# records as a skipped tick, so a quiet week costs nothing.
#
# Both repositories are public, so this needs no clone, no credentials and no working tree -- which
# is what lets it run on the bb server. It only answers one question: is upstream/main an ancestor
# of the fork branch? `pnpm sync:upstream` in cloudflare-os-personal is what acts on the answer.
set -euo pipefail

FORK_OWNER="SnapPetal"
FORK_REPO="cloudflare-os"
FORK_BRANCH="personal/admin-ui"
UPSTREAM_REPO="cloudflare/cloudflare-os"
UPSTREAM_BRANCH="main"
# The head side of a cross-repository compare is `owner:branch`, never `owner/repo:branch`.
FORK_HEAD="${FORK_OWNER}:${FORK_BRANCH}"

# Payloads go through files rather than argv: a compare response carrying 250 commits is larger
# than the argument limit, and a weekly check that dies on its own report is worse than none.
workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

api() {
  curl -sS --max-time 30 -H 'Accept: application/vnd.github+json' \
    "https://api.github.com/repos/$1/compare/$2" 2>/dev/null || true
}

# A real compare response carries one of these four statuses. An error response carries `"status":
# "404"` instead, which is why membership is the test and not mere presence.
classify() {
  python3 -c '
import json, sys
try:
    with open(sys.argv[1]) as handle:
        status = json.load(handle).get("status")
except Exception:
    status = None
print(status if status in ("ahead", "behind", "identical", "diverged") else "unknown")
' "$1"
}

report() {
  python3 - "$1" "$2" "$FORK_BRANCH" "$UPSTREAM_REPO" "$UPSTREAM_BRANCH" <<'PY'
import json, sys

status_path, details_path, branch, upstream_repo, upstream_branch = sys.argv[1:6]


def decoded(path):
    try:
        with open(path) as handle:
            return json.load(handle)
    except (OSError, json.JSONDecodeError):
        return {}


data = decoded(status_path)
# 'ahead' means the fork carries commits upstream does not: this repository's own work, which is
# the normal state. Only 'behind' and 'diverged' are work waiting to be done.
if data.get("status") in ("identical", "ahead"):
    raise SystemExit(0)
if data.get("status") not in ("behind", "diverged"):
    # A rate limit or an outage is not drift. Say so once and stay quiet rather than reporting a
    # green repository as broken.
    print("upstream check could not read the GitHub compare API; treating this week as no change.")
    raise SystemExit(0)

listed = decoded(details_path).get("commits", [])
print(f"{branch} is {data['behind_by']} commit(s) behind {upstream_repo} {upstream_branch} "
      f"({data['status']}).")
for commit in listed[:15]:
    print(f"  {commit['sha'][:9]} {commit['commit']['message'].splitlines()[0]}")
if len(listed) > 15:
    print(f"  ... and {len(listed) - 15} more")
print("Then, in cloudflare-os-personal:  pnpm sync:upstream --merge --verify")
PY
}

# base=upstream, head=fork answers the question. That payload does not list the commits only the
# base has, so when it finds drift the second call asks for them -- base=fork, head=upstream --
# and runs only then.
api "$UPSTREAM_REPO" "$UPSTREAM_BRANCH...$FORK_HEAD" > "$workdir/status.json"
: > "$workdir/details.json"
case "$(classify "$workdir/status.json")" in
  behind|diverged)
    api "$UPSTREAM_REPO" "$FORK_HEAD...$UPSTREAM_BRANCH" > "$workdir/details.json"
    ;;
esac
report "$workdir/status.json" "$workdir/details.json"
