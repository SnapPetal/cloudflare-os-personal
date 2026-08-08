# Troubleshooting

This repository deploys Cloudflare OS as several Workers plus KV, R2, Browser Rendering, and Worker Loader resources. It is not a single static Worker.

## Deployment method

Use the repository deployment script:

```sh
pnpm check
pnpm deploy
```

The Cloudflare dashboard's **Workers & Pages → Create → Connect GitHub** flow is for deploying one generic Worker or Pages project. It does not run this repository's `scripts/deploy.mjs`, does not deploy the dependent Gatekeeper and Error Reporter Workers in the required order, and does not apply the generated service bindings. Do not connect this repository through that generic flow.

For repeatable deployments, run the same commands from a local checkout or from GitHub Actions after authenticating Wrangler. The repository's deploy script is the source of truth.

## R2 is not enabled

Error:

```text
Please enable R2 through the Cloudflare Dashboard. [code: 10042]
```

Fix:

1. Open the Cloudflare dashboard for the correct account.
2. Go to **Storage & databases → R2 → Overview**.
3. Enable or subscribe to R2.
4. Confirm the activation flow shows no unexpected charge.
5. Run `pnpm deploy` again.

R2 must be enabled before Wrangler can create the blueprint-content bucket. Do not create an AWS S3 or ECR resource for this error.

## Dynamic Workers require a paid Workers plan

Error:

```text
In order to use Dynamic Workers, you must switch to a paid plan. [code: 10195]
```

Cloudflare OS uses Dynamic Workers and a Worker Loader to run sandboxed gadgets. Dynamic Workers are not available on the Workers Free plan.

Fix:

1. Open **Workers & Pages → Plans** in the Cloudflare dashboard.
2. Switch this account to the **Workers Paid** plan.
3. Confirm the subscription.
4. Rerun the GitHub Actions deployment.

The Workers Paid plan is separate from the Cloudflare domain plan, Zero Trust plan, and R2 subscription. Cloudflare currently documents a $5/month minimum Workers Paid subscription, with additional usage-based charges beyond the included usage. If the paid plan is not acceptable, Cloudflare OS can be run locally for evaluation, but the production deployment in this repository cannot use the Workers Free plan.

## KV namespace already exists

Error:

```text
a namespace with this account ID and title already exists [code: 10014]
```

This usually means a previous deployment created one or more KV namespaces and then failed before completing. Do not delete them automatically.

List existing namespaces:

```sh
pnpm exec wrangler kv namespace list
```

Map the namespace IDs to these configuration fields in `deployment.jsonc`:

| Namespace purpose | Configuration field |
| --- | --- |
| Blueprints | `resources.blueprintsKvNamespaceId` |
| Avatars | `resources.avatarsKvNamespaceId` |
| Context collections | `context.kvNamespaceId` |

Set the matching IDs explicitly, commit the configuration, and rerun `pnpm check` followed by `pnpm deploy`. This adopts the existing resources and preserves any data already written to them.

List R2 buckets separately:

```sh
pnpm exec wrangler r2 bucket list
```

If the R2 bucket does not exist, leave `resources.blueprintContentBucket` as `null`; the next successful deployment will provision it. If it already exists, set that field to the exact bucket name.

## `os.example.com` or `os.thonbecker.biz` cannot be found

Symptoms include Firefox reporting **Server Not Found** or DNS returning no result.

Check DNS:

```sh
dig +short os.thonbecker.biz
```

Then open **Workers & Pages → `thonbecker-personal-os` → Settings → Domains & Routes** and confirm that `os.thonbecker.biz` is listed as a custom domain.

- If the custom domain is absent, the Workshop deployment did not complete. Run `pnpm deploy` and inspect the final error.
- If the custom domain is present but DNS is still empty, verify that `thonbecker.biz` is an active zone in the same Cloudflare account and wait briefly for DNS/TLS provisioning.
- Do not add an arbitrary A record and do not change the Lightsail nginx configuration. This hostname is served by the Worker.

## Access login does not work

Confirm that `deployment.jsonc` contains:

- `access.issuer`: the Zero Trust team domain, including `https://` and no path;
- `access.audience`: the Access application's long AUD tag;
- `access.admins`: the email address allowed to administer Cloudflare OS.

The Access application must protect the same hostname configured under `workers.workshop.route.customDomain`. The Access policy controls who may sign in; the `admins` list controls who may change Cloudflare OS runtime policy.

## Inspect deployment state

Useful read-only commands:

```sh
pnpm exec wrangler whoami
pnpm exec wrangler kv namespace list
pnpm exec wrangler r2 bucket list
git status --short --branch
```

Do not paste API tokens, OAuth secrets, AWS credentials, or private keys into issues or chat. Account IDs, Worker names, KV IDs, bucket names, hostnames, and Access AUD tags are identifiers rather than credentials.
