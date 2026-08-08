interface Env {
  OPENAI_API_KEY?: string;
  OPENAI_MODEL?: string;
}

const ALLOWED_ORIGINS = new Set([
  "https://thonbecker.biz",
  "https://www.thonbecker.biz",
  "https://booking.thonbecker.biz",
]);
const MAX_MESSAGE_LENGTH = 1_000;
const WINDOW_MS = 10 * 60 * 1_000;
const MAX_REQUESTS_PER_WINDOW = 10;
const requestWindows = new Map<string, { count: number; resetAt: number }>();

const SYSTEM_PROMPT = [
  "You are the public assistant for Thon Becker's personal website.",
  "Answer briefly and helpfully about the website, Cloudflare OS learning project, and general software engineering.",
  "You cannot book meetings, inspect private data, access accounts, or perform actions.",
  "Never claim to have taken an action or accessed a private system.",
].join(" ");

function corsHeaders(origin: string | null): HeadersInit {
  const allowedOrigin = origin && ALLOWED_ORIGINS.has(origin) ? origin : "https://thonbecker.biz";
  return {
    "Access-Control-Allow-Headers": "content-type",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Origin": allowedOrigin,
    "Content-Type": "application/json; charset=utf-8",
    "Vary": "Origin",
  };
}

function json(body: unknown, status: number, origin: string | null): Response {
  return new Response(JSON.stringify(body), { status, headers: corsHeaders(origin) });
}

function allowedOrigin(origin: string | null): boolean {
  return origin === null || ALLOWED_ORIGINS.has(origin);
}

function rateLimited(ip: string): boolean {
  const now = Date.now();
  const current = requestWindows.get(ip);
  if (!current || current.resetAt <= now) {
    requestWindows.set(ip, { count: 1, resetAt: now + WINDOW_MS });
    return false;
  }
  current.count += 1;
  return current.count > MAX_REQUESTS_PER_WINDOW;
}

function outputText(data: any): string | undefined {
  for (const item of data?.output ?? []) {
    for (const content of item.content ?? []) {
      if (content.type === "output_text" && typeof content.text === "string") return content.text;
    }
  }
  return undefined;
}

async function answer(message: string, env: Env): Promise<string> {
  if (!env.OPENAI_API_KEY) throw new Error("OPENAI_API_KEY is not configured");

  const response = await fetch("https://api.openai.com/v1/responses", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: env.OPENAI_MODEL || "gpt-5.6-terra",
      input: [{
        role: "user",
        content: [{ type: "input_text", text: `${SYSTEM_PROMPT}\n\nVisitor message: ${message}` }],
      }],
      max_output_tokens: 500,
    }),
  });

  if (!response.ok) throw new Error(`OpenAI request failed with status ${response.status}`);
  const data = await response.json();
  const text = outputText(data);
  if (!text) throw new Error("OpenAI response did not contain text");
  return text;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const origin = request.headers.get("Origin");
    if (!allowedOrigin(origin)) return json({ error: "Origin not allowed" }, 403, origin);
    if (request.method === "OPTIONS") return new Response(null, { headers: corsHeaders(origin) });
    if (new URL(request.url).pathname !== "/chat" || request.method !== "POST") {
      return json({ error: "Not found" }, 404, origin);
    }

    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    if (rateLimited(ip)) return json({ error: "Please try again later" }, 429, origin);

    let body: unknown;
    try {
      body = await request.json();
    } catch {
      return json({ error: "Request body must be JSON" }, 400, origin);
    }
    const message = (body as { message?: unknown })?.message;
    if (typeof message !== "string" || !message.trim() || message.length > MAX_MESSAGE_LENGTH) {
      return json({ error: `message is required and must be at most ${MAX_MESSAGE_LENGTH} characters` }, 400, origin);
    }

    console.log(JSON.stringify({ event: "public_chat_request", messageLength: message.length }));
    try {
      return json({ message: await answer(message.trim(), env) }, 200, origin);
    } catch (error) {
      console.error(JSON.stringify({ event: "public_chat_error", reason: error instanceof Error ? error.message : "unknown" }));
      return json({ error: "The chat is temporarily unavailable" }, 503, origin);
    }
  },
};
