# Skatetricks Knowledge

This is the private data-plane Worker for the native Cloudflare OS `/admin` vector panel. It keeps the same core workflow—list the configured index, inspect vectors and metadata, run nearest-neighbor queries, and delete a vector—while keeping AWS credentials in the Worker. The admin UI lives in the `cloudflare-os` Workshop; this Worker exposes only its server-side API.

The data plane remains Amazon S3 Vectors. Cloudflare R2 is not a vector-index replacement.

## Local setup

```sh
pnpm install
pnpm --filter s3v-explorer types:check
pnpm exec wrangler dev packages/s3v-explorer/wrangler.jsonc
```

Set local secrets with Wrangler; never put them in tracked configuration:

```sh
pnpm exec wrangler secret put AWS_ACCESS_KEY_ID --config packages/s3v-explorer/wrangler.jsonc
pnpm exec wrangler secret put AWS_SECRET_ACCESS_KEY --config packages/s3v-explorer/wrangler.jsonc
```

The Worker is pinned to `thonbecker-vectors` and uses only `s3vectors:GetVectorBucket`, `ListIndexes`, `ListVectors`, `GetVectors`, `QueryVectors`, and `DeleteVectors`. It intentionally does not request account-wide bucket listing or any index/vector creation permission.

Rotate the AWS access key by creating a replacement key, updating the two Cloudflare Worker secrets, verifying the UI, and then deactivating and deleting the old key. Never print the secret JSON or commit it to either repository.

Before any hosted deployment, keep the Worker off public routes and use a dedicated Worker identity. In the personal deployment it is reached only through the private Cloudflare OS `/vector-store` service binding. The Workshop validates the Access identity and administrator allowlist before forwarding requests; AWS credentials remain Worker secrets.

The Worker has no user-facing HTML page. Its API is intentionally limited to listing the configured
bucket and indexes, reading vectors and metadata, querying nearest neighbors, and deleting individual
vectors. Index creation, recreation, bucket management, and credential management remain outside the
Worker API.
