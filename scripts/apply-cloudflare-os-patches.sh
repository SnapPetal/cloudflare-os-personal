#!/usr/bin/env bash
# Apply personal Cloudflare OS patches onto the pinned upstream submodule.
#
# The gitlink stays an upstream commit. This script only edits the working tree.
# A clean checkout is patched. A checkout that already has every patch is left
# alone. Anything else — a conflict, a partial apply, a missing submodule — exits
# non-zero and says which patch failed.
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
submodule="$root/cloudflare-os"
patch_dir="$root/patches/cloudflare-os"

if [[ ! -e "$submodule/.git" ]]; then
  echo "cloudflare-os submodule is not initialized. Run: git submodule update --init" >&2
  exit 1
fi

shopt -s nullglob
patches=("$patch_dir"/*.patch)
if [[ ${#patches[@]} -eq 0 ]]; then
  echo "No patches in $patch_dir" >&2
  exit 1
fi

for patch in "${patches[@]}"; do
  name=$(basename "$patch")
  if git -C "$submodule" apply --reverse --check "$patch" >/dev/null 2>&1; then
    echo "Already applied: $name"
    continue
  fi
  if ! git -C "$submodule" apply --check "$patch"; then
    echo "Patch does not apply: $name" >&2
    echo "The pinned upstream commit and this patch have diverged. Refresh patches/cloudflare-os (see README, Bump the upstream pin)." >&2
    exit 1
  fi
  git -C "$submodule" apply "$patch"
  echo "Applied: $name"
done
