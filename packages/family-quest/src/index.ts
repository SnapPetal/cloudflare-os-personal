import { handle } from "./app";

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    try {
      return await handle(request, env);
    } catch (error) {
      const message = error instanceof Error ? error.message : "unknown";
      console.error(JSON.stringify({ event: "request_failed", path: new URL(request.url).pathname, error: message }));
      return new Response("Family Quest hit a snag. Try again in a moment.", {
        status: 500,
        headers: { "content-type": "text/plain; charset=utf-8", "cache-control": "no-store" },
      });
    }
  },
} satisfies ExportedHandler<Env>;
