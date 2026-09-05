# Upstream sync workflow

This repository has two related Git histories:

- The parent repository is a fork of `cloudflare-os-starter`.
- `cloudflare-os/` is a separate fork of `cloudflare-os` used as a pinned submodule.

Keep those updates separate. A parent merge must never replace the submodule gitlink with an
unreviewed upstream branch, and a submodule update must never be treated as a complete parent
upgrade until the wrapper and shared dependency catalog have been checked.

## Prepare an upgrade branch

Start with a clean `main` worktree:

```sh
git switch main
git pull --ff-only origin main
git fetch upstream
git switch -c upgrade/upstream-<date>
```

The parent `upstream` remote points to `cloudflare-os-starter`. The nested repository has its own
`upstream` remote pointing to `cloudflare-os`.

## Update the nested fork

Choose an exact full commit before changing the gitlink:

```sh
git -C cloudflare-os fetch upstream
git -C cloudflare-os log --oneline --decorate upstream/main
git -C cloudflare-os diff --stat HEAD.. <approved-full-sha>
```

Create a branch in the nested fork, merge or cherry-pick the selected upstream commit, preserve
approved personal changes, and run the nested repository’s tests and lint. Push that commit to
`SnapPetal/cloudflare-os`, then check it out in the parent:

```sh
git -C cloudflare-os switch --detach <personal-fork-full-sha>
git add cloudflare-os
```

Never use `git submodule update --remote`; the parent must record a reviewed full SHA.

## Reconcile the parent wrapper

Review the parent starter changes against the current fork:

```sh
git diff --stat main..upstream/main
git diff main..upstream/main -- deployment.jsonc package.json pnpm-workspace.yaml scripts docs
```

If upstream changes the deployment architecture, deploy scripts, Worker identities, routes, storage,
authentication, or RPC contracts, replay the personal commits onto an upstream-first branch rather
than merging directly into `main`. Preserve wrapper-owned Workers and production resource IDs.

After the replay:

```sh
pnpm install
pnpm --dir cloudflare-os install
pnpm lint
pnpm check
```

The parent workspace catalog must match the nested fork’s catalog for shared packages such as
`capnweb` and `capnweb-validate`. A mismatch can create duplicate RPC type implementations even
when installation succeeds.

## Merge and deploy

Open a pull request from the upgrade branch. Merge it into `main` only after the full check passes
and the generated Wrangler dry-runs show every expected Worker and binding. Production deployment
is a separate approval step: record the old gitlink, Worker version IDs, routes, resource identities,
secrets, and rollback limits before running `pnpm deploy`.

For this fork, the expected parent deployment includes the router, Workshop, Context, Scheduler,
Custom Gatekeeper, Error Reporter, public chat, and S3 Vector Explorer.
