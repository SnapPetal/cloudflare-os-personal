# Upstream sync

`cloudflare-os/` is a pinned commit of [cloudflare/cloudflare-os](https://github.com/cloudflare/cloudflare-os), not a fork with local commits. Personal behavior that upstream does not expose as configuration lives in [`patches/cloudflare-os`](../patches/cloudflare-os) and is applied with `pnpm apply:patches` before install. Pull request and deploy workflows run that same script and fail if a patch does not apply.

`SnapPetal/cloudflare-os` is not on the build path. After this repository's pin and patches are what deploys, that fork can be reset to upstream without changing a deploy: CI checks the submodule out from `https://github.com/cloudflare/cloudflare-os` at the gitlink, then applies the patches stored here.

## Check before starting

`pnpm sync:upstream` reports the divergence without moving the pin, which is the first thing to run and safe to run at any time:

```sh
pnpm sync:upstream
```

It fetches upstream, reports how far the checked-out commit is behind `main`, confirms that commit is contained in upstream, and verifies this repository's catalog still matches the submodule's. Nothing else moves. Exit code 3 means the pin is behind. Exit code 2 means the catalog drifted. Exit code 1 means the pin is not an upstream commit, or a command failed.

## Move the pin

Follow [Bump the upstream pin](../README.md#bump-the-upstream-pin) in the README. In short: check out an upstream SHA, reapply the patches, refresh any patch that conflicts, re-sync the catalog, then commit the gitlink and the patch files in this repository.

Never use `git submodule update --remote`. Never commit the patched working tree inside `cloudflare-os`. `git apply` does not move `HEAD`, so `git add cloudflare-os` still records the upstream SHA.

Merging to `main` deploys. `.github/workflows/deploy.yml` applies the patches, runs `pnpm check`, then runs `pnpm deploy` on every push to `main`.
