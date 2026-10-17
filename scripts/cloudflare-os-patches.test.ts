import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { dirname, join, resolve } from "node:path";
import test from "node:test";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");

async function source(path: string): Promise<string> {
  return readFile(join(root, path), "utf8");
}

test("personal Cloudflare OS patches are applied before build and deploy", async () => {
  const server = await source("cloudflare-os/packages/workshop-backend/src/server.ts");
  assert.match(server, /handleVectorStoreRequest/);
  assert.match(server, /handleBookingAdminRequest/);
  assert.match(server, /isSamePublicOrigin/);

  const router = await source("cloudflare-os/packages/router/src/index.ts");
  assert.match(router, /\/vector-store/);

  const admin = await source("cloudflare-os/packages/workshop-frontend/src/AdminPage.tsx");
  assert.match(admin, /VectorStoreAdminPanel/);
  assert.match(admin, /BookingAdminPanel/);

  const golden = await source("cloudflare-os/scripts/release/testdata/golden-manifest.json");
  assert.match(golden, /\/vector-store\/\*/);
});
