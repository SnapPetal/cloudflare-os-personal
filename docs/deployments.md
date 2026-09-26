# Deployments

Newest first, timestamps UTC, appended by `pnpm deploy` itself so it cannot drift from what actually
shipped. Each entry's version IDs are the rollback targets for the entry below it; see
`pnpm exec wrangler rollback <version-id> --name <worker>`.

## 2026-09-26 23:35 UTC

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

### Previous versions, superseded 23:35 UTC

Rollback targets for the deployment this replaced, read from `wrangler versions list` before it ran.
Cloudflare still lists them, but nothing else in the repository remembers them.

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

Two deployments preceded this one, at 22:46 and 23:00 UTC, from outside this session and of unknown
content. `c053759a` and `b4733304` are the state this deploy replaced, not the state before 22:46.
