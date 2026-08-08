# S3V Explorer

This is the web companion for the former `SnapPetal/s3v-explorer` desktop app. It keeps the same core workflow—list vector buckets and indexes, inspect vectors and metadata, run nearest-neighbor queries, and delete a vector—while moving AWS credentials to a server-side Cloudflare Worker.

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

Before any hosted deployment, put the Worker behind a private Cloudflare Access application and use a dedicated Worker identity. The starter's existing Access application protects only its configured Workshop hostname.
