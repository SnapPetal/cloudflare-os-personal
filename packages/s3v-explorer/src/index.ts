import {
  DeleteVectorsCommand,
  GetVectorsCommand,
  ListIndexesCommand,
  ListVectorsCommand,
  QueryVectorsCommand,
  S3VectorsClient,
} from "@aws-sdk/client-s3vectors";

interface Env {
  AWS_ACCESS_KEY_ID: string;
  AWS_SECRET_ACCESS_KEY: string;
  AWS_SESSION_TOKEN?: string;
  AWS_REGION: string;
  VECTOR_BUCKET_NAME: string;
}

interface VectorRecord {
  key?: string;
  data: number[];
  metadata: unknown;
}

const MAX_TOP_K = 100;
const MAX_VECTORS = 2_000;
const MAX_VECTORS_PAGE = 1_000;

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "content-type": "application/json; charset=utf-8", "cache-control": "no-store" },
  });
}

function assertBucket(bucket: string | null, env: Env): asserts bucket is string {
  if (!bucket || !/^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$/.test(bucket)) throw new Error("Invalid vector bucket");
  if (bucket !== env.VECTOR_BUCKET_NAME) throw new Error("Vector bucket is not allowed");
}

function client(env: Env): S3VectorsClient {
  return new S3VectorsClient({
    region: env.AWS_REGION,
    credentials: {
      accessKeyId: env.AWS_ACCESS_KEY_ID,
      secretAccessKey: env.AWS_SECRET_ACCESS_KEY,
      ...(env.AWS_SESSION_TOKEN ? { sessionToken: env.AWS_SESSION_TOKEN } : {}),
    },
  });
}

async function allVectors(bucket: string, index: string, env: Env): Promise<VectorRecord[]> {
  const sdk = client(env);
  const vectors: VectorRecord[] = [];
  let nextToken: string | undefined;
  do {
    const listed = await sdk.send(new ListVectorsCommand({
      vectorBucketName: bucket,
      indexName: index,
      returnData: true,
      returnMetadata: true,
      maxResults: Math.min(MAX_VECTORS_PAGE, MAX_VECTORS - vectors.length),
      ...(nextToken ? { nextToken } : {}),
    }));
    vectors.push(...(listed.vectors ?? []).map((vector) => ({
      key: vector.key,
      data: vector.data?.float32 ?? [],
      metadata: vector.metadata ?? {},
    })));
    nextToken = listed.nextToken;
  } while (nextToken && vectors.length < MAX_VECTORS);
  return vectors.slice(0, MAX_VECTORS);
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    try {
      const sdk = client(env);
      if (request.method === "GET" && url.pathname === "/api/buckets") return json([env.VECTOR_BUCKET_NAME]);
      const bucket = url.searchParams.get("bucket");
      assertBucket(bucket, env);
      const index = url.searchParams.get("index");
      if (url.pathname === "/api/indexes" && request.method === "GET") {
        const result = await sdk.send(new ListIndexesCommand({ vectorBucketName: bucket }));
        return json((result.indexes ?? []).map((item) => item.indexName).filter(Boolean));
      }
      if (!index || !/^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$/.test(index)) throw new Error("Invalid vector index");
      if (url.pathname === "/api/vectors" && request.method === "GET") return json(await allVectors(bucket, index, env));
      if (url.pathname === "/api/vectors" && request.method === "DELETE") {
        const body = await request.json<{ key?: string }>();
        if (!body.key || body.key.length > 1_024) throw new Error("Invalid vector key");
        await sdk.send(new DeleteVectorsCommand({ vectorBucketName: bucket, indexName: index, keys: [body.key] }));
        return json({ ok: true });
      }
      if (url.pathname === "/api/query" && request.method === "POST") {
        const body = await request.json<{ key?: string; topK?: number }>();
        if (!body.key || body.key.length > 1_024) throw new Error("Invalid query key");
        const source = await sdk.send(new GetVectorsCommand({ vectorBucketName: bucket, indexName: index, keys: [body.key], returnData: true }));
        const vector = source.vectors?.[0]?.data?.float32;
        if (!vector?.length) throw new Error("Query vector was not found");
        const result = await sdk.send(new QueryVectorsCommand({ vectorBucketName: bucket, indexName: index, queryVector: { float32: vector }, topK: Math.min(Math.max(body.topK ?? 10, 1), MAX_TOP_K), returnMetadata: true }));
        return json((result.vectors ?? []).map((item) => ({ key: item.key, distance: item.distance, metadata: item.metadata ?? {} })));
      }
      return json({ error: "Not found" }, 404);
    } catch (error) {
      console.error(JSON.stringify({ event: "s3v_explorer_error", reason: error instanceof Error ? error.message : "unknown" }));
      return json({ error: error instanceof Error ? error.message : "Request failed" }, 400);
    }
  },
};
