# Deployments

Newest first, timestamps UTC. Each entry's version IDs are the rollback targets for the entry below
it; see `pnpm exec wrangler rollback <version-id> --name <worker>`.

Local `pnpm deploy` runs append their own entry, from the version IDs wrangler reports. **CI
deploys do not** — `.github/workflows/deploy.yml` runs `pnpm deploy` on every push to `main`, and the
runner cannot commit the file back (it holds `contents: read`), so a CI-deployed entry has to be
added by hand from the run log:

```sh
gh run view -R SnapPetal/cloudflare-os-personal <run-id> --log \
  | grep -oE "Uploaded (\S+) \([0-9.]+ sec\)|Current Version ID: [0-9a-f-]{36}"
```

Every deployment lands here eventually, from either path. A gap in this file means a deploy is not
yet written down, not that it did not happen — `gh run list --workflow=deploy.yml` is the other
source of truth.

## 2026-09-26 23:35 UTC — local

Root `25dd0ed`, submodule `270ca7c5`.

| Worker | Version ID |
| --- | --- |
| `thonbecker-personal-os-errors` | `56d6c5b3-65f5-4791-a1f2-5b8056c87325` |
| `thonbecker-public-chat` | `10958329-7592-48ee-82a1-6c4697ef4496` |
| `s3v-explorer` | `dcae391b-dc83-4ca0-8552-9171a173d1d5` |
| `thonbecker-personal-os-context` | `0af7710a-8581-485c-8401-137a9df36685` |
| `thonbecker-personal-os-scheduler` | `821773d7-5083-47e3-a7fe-c4dab8a701a5` |
| `thonbecker-personal-os-gatekeeper` | `0c91a292-5735-4383-9001-de08fe60a8aa` |
| `thonbecker-personal-os` | `12ad70b1-0c54-4fa5-832a-3f9f9c8cf1ba` |
| `thonbecker-personal-os-router` | `831bad85-f539-4e94-a53c-76d00b064b14` |

## 2026-09-26 23:00 UTC — CI run 36277795113

Root `25dd0ed`, submodule `270ca7c5`. Push-triggered; deployed before the local run above.

| Worker | Version ID |
| --- | --- |
| `thonbecker-personal-os-errors` | `8cd79ed2-d489-43ef-b91f-ff00c4dd9118` |
| `thonbecker-public-chat` | `c81b10b0-33b6-4781-94de-c99c938d10c2` |
| `s3v-explorer` | `d02bb194-ecbb-4021-8a6a-606b3a64d441` |
| `thonbecker-personal-os-context` | `bad133a3-b050-4e15-b554-3441503f2ab8` |
| `thonbecker-personal-os-scheduler` | `9b726fe8-7aee-4698-990b-3208f478365c` |
| `thonbecker-personal-os-gatekeeper` | `38d945c0-370c-46e2-b570-766d66a0ff11` |
| `thonbecker-personal-os` | `c053759a-680a-4f7d-a50b-813bf50b69e3` |
| `thonbecker-personal-os-router` | `b4733304-7ce0-42a3-92ea-6898b5189734` |

## 2026-09-26 22:46 UTC — CI run 36277079117

Root `5fc5b3a`, submodule `270ca7c5`. First deploy of the new submodule pin.

| Worker | Version ID |
| --- | --- |
| `thonbecker-personal-os-errors` | `8837fa0d-5dc6-4cac-8e83-a1c5bdf7484c` |
| `thonbecker-public-chat` | `02d4df30-f612-4adb-8062-fc70021cd8ca` |
| `s3v-explorer` | `e67bc3e6-ae68-41a5-b5d2-978ef37436d4` |
| `thonbecker-personal-os-context` | `1c5b95ff-6066-4fde-b547-40ad00a5ff66` |
| `thonbecker-personal-os-scheduler` | `49f339c4-dcf9-4dce-8c7b-76b2a9fc6179` |
| `thonbecker-personal-os-gatekeeper` | `e385a6d0-b9e8-458e-ac8a-52a4d40a715c` |
| `thonbecker-personal-os` | `46a85590-772d-49b4-bcb4-fb7ad820e3c9` |
| `thonbecker-personal-os-router` | `0e6d050f-469f-4ca2-9be5-e1e810b15f62` |

## 2026-09-26 01:02 UTC — CI run 36207050829

Earlier deploy of the same session, before the version IDs above were recorded here.

## 2026-09-25 10:55 UTC — CI run 36126583125

Manual `workflow_dispatch`, last known-good before this session's work.

## Rollback boundaries

`wrangler rollback` restores code for one Worker. It does not restore Access policies, DNS, service
bindings, secrets, or Durable Object data. That is sufficient for a code-only deploy, which is all
of the above; a change to bindings or a Durable Object schema means restoring the whole known-good
wrapper configuration and redeploying instead.

**The Workshop and the router are a pair.** Rolling back only the router is safe — the previous
frontend comes back. Rolling back only the Workshop, while the new frontend is live, breaks `/admin`
and the commit-email control, because the new frontend calls `setOwnCommitEmail` and the previous
Workshop does not have it. If both must go, Workshop first, then router.

**Neither is deployed on a doc-only change by hand** — see the CI note at the top of this file.
Every push to `main` deploys, so a documentation commit reaches production like any other. That is
why the version IDs for a CI deploy have to be recovered from the run log rather than trusted to be
written down at the time.
