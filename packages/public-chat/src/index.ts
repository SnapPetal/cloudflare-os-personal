interface Env {
  OPENAI_API_KEY?: string;
  OPENAI_MODEL?: string;
  BOOKING_AVAILABILITY_URL?: string;
  CHAT_RATE_LIMITER?: RateLimit;
}

type ChatAction = "show_availability" | "clarify" | "unsupported";

interface AvailabilitySlot {
  start: string;
  end: string;
  timezone: string;
}

interface ChatAnswer {
  message: string;
  action: ChatAction;
  availableSlots: AvailabilitySlot[];
}

const ALLOWED_ORIGINS = new Set([
  "https://thonbecker.biz",
  "https://www.thonbecker.biz",
  "https://booking.thonbecker.biz",
]);
const DEFAULT_TIMEZONE = "America/Chicago";
const MAX_MESSAGE_LENGTH = 1_000;
const MAX_TIMEZONE_LENGTH = 100;
const WINDOW_MS = 60 * 1_000;
const MAX_REQUESTS_PER_WINDOW = 10;
const requestWindows = new Map<string, { count: number; resetAt: number }>();

const SYSTEM_PROMPT = [
  "You are a concise booking availability assistant for Thon Becker.",
  "Answer only questions about available meeting times using the supplied availability data.",
  "You cannot create, cancel, or modify bookings, and you cannot access attendee records or accounts.",
  "Do not discuss implementation details, providers, infrastructure, or internal technology.",
  "If a visitor asks about anything else, politely say you can only help find available meeting times.",
  "Never claim to have taken an action or accessed private information.",
].join(" ");

function corsHeaders(origin: string | null): HeadersInit {
  const corsOrigin = origin && ALLOWED_ORIGINS.has(origin) ? origin : "https://thonbecker.biz";
  return {
    "Access-Control-Allow-Headers": "content-type",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Origin": corsOrigin,
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

function locallyRateLimited(ip: string): boolean {
  const now = Date.now();
  const current = requestWindows.get(ip);
  if (!current || current.resetAt <= now) {
    requestWindows.set(ip, { count: 1, resetAt: now + WINDOW_MS });
    return false;
  }
  current.count += 1;
  return current.count > MAX_REQUESTS_PER_WINDOW;
}

async function rateLimited(ip: string, env: Env): Promise<boolean> {
  if (env.CHAT_RATE_LIMITER) {
    const result = await env.CHAT_RATE_LIMITER.limit({ key: `public-chat:${ip}` });
    return !result.success;
  }
  return locallyRateLimited(ip);
}

function outputText(data: any): string | undefined {
  for (const item of data?.output ?? []) {
    for (const content of item.content ?? []) {
      if (content.type === "output_text" && typeof content.text === "string") return content.text;
    }
  }
  return undefined;
}

function parseChatAnswer(data: any): ChatAnswer {
  const text = outputText(data);
  if (!text) throw new Error("OpenAI response did not contain text");

  let answer: unknown;
  try {
    answer = JSON.parse(text);
  } catch {
    throw new Error("OpenAI response was not valid JSON");
  }

  if (!answer || typeof answer !== "object") throw new Error("OpenAI response was not an object");
  const value = answer as Record<string, unknown>;
  const slots = value.availableSlots;
  if (typeof value.message !== "string" ||
      !["show_availability", "clarify", "unsupported"].includes(String(value.action)) ||
      !Array.isArray(slots)) {
    throw new Error("OpenAI response did not match the chat schema");
  }
  if (!slots.every((slot) => {
    if (!slot || typeof slot !== "object") return false;
    const item = slot as Record<string, unknown>;
    return typeof item.start === "string" && typeof item.end === "string" &&
      typeof item.timezone === "string";
  })) throw new Error("OpenAI response contained an invalid availability slot");

  return {
    message: value.message,
    action: value.action as ChatAction,
    availableSlots: slots as AvailabilitySlot[],
  };
}

function validTimezone(timezone: string): boolean {
  try {
    new Intl.DateTimeFormat("en-US", { timeZone: timezone }).format();
    return true;
  } catch {
    return false;
  }
}

function currentDate(timezone: string): string {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: timezone,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());
  const values = Object.fromEntries(parts.map((part) => [part.type, part.value]));
  return `${values.year}-${values.month}-${values.day}`;
}

function addDays(date: string, days: number): string {
  const value = new Date(`${date}T00:00:00Z`);
  value.setUTCDate(value.getUTCDate() + days);
  return value.toISOString().slice(0, 10);
}

async function loadAvailability(timezone: string, env: Env): Promise<string> {
  if (!env.BOOKING_AVAILABILITY_URL) throw new Error("BOOKING_AVAILABILITY_URL is not configured");
  const from = currentDate(timezone);
  const url = new URL(env.BOOKING_AVAILABILITY_URL);
  url.searchParams.set("from", from);
  url.searchParams.set("to", addDays(from, 13));
  url.searchParams.set("timezone", timezone);

  const response = await fetch(url, { headers: { Accept: "application/json" } });
  if (!response.ok) throw new Error(`Availability request failed with status ${response.status}`);
  const body = await response.text();
  if (body.length > 100_000) throw new Error("Availability response is too large");
  return body;
}

async function answer(message: string, timezone: string, env: Env): Promise<ChatAnswer> {
  if (!env.OPENAI_API_KEY) throw new Error("OPENAI_API_KEY is not configured");
  const availability = await loadAvailability(timezone, env);

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
        content: [{
          type: "input_text",
          text: `${SYSTEM_PROMPT}\n\nVisitor timezone: ${timezone}\nCurrent visitor date: ${currentDate(timezone)}\n\nRead-only availability JSON for the next 14 days:\n${availability}\n\nVisitor message: ${message}`,
        }],
      }],
      text: {
        format: {
          type: "json_schema",
          name: "booking_chat_answer",
          strict: true,
          schema: {
            type: "object",
            additionalProperties: false,
            properties: {
              message: { type: "string" },
              action: { type: "string", enum: ["show_availability", "clarify", "unsupported"] },
              availableSlots: {
                type: "array",
                items: {
                  type: "object",
                  additionalProperties: false,
                  properties: {
                    start: { type: "string" },
                    end: { type: "string" },
                    timezone: { type: "string" },
                  },
                  required: ["start", "end", "timezone"],
                },
              },
            },
            required: ["message", "action", "availableSlots"],
          },
        },
      },
      max_output_tokens: 500,
    }),
  });

  if (!response.ok) throw new Error(`OpenAI request failed with status ${response.status}`);
  const data = await response.json();
  return parseChatAnswer(data);
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
    if (await rateLimited(ip, env)) return json({ error: "Please try again later" }, 429, origin);

    let body: unknown;
    try {
      body = await request.json();
    } catch {
      return json({ error: "Request body must be JSON" }, 400, origin);
    }
    const message = (body as { message?: unknown })?.message;
    const requestedTimezone = (body as { timezone?: unknown })?.timezone;
    const timezone = typeof requestedTimezone === "undefined" ? DEFAULT_TIMEZONE : requestedTimezone;
    if (typeof message !== "string" || !message.trim() || message.length > MAX_MESSAGE_LENGTH) {
      return json({ error: `message is required and must be at most ${MAX_MESSAGE_LENGTH} characters` }, 400, origin);
    }
    if (typeof timezone !== "string" || timezone.length > MAX_TIMEZONE_LENGTH || !validTimezone(timezone)) {
      return json({ error: "timezone must be a valid IANA timezone" }, 400, origin);
    }

    console.log(JSON.stringify({ event: "public_chat_request", messageLength: message.length }));
    try {
      return json(await answer(message.trim(), timezone, env), 200, origin);
    } catch (error) {
      console.error(JSON.stringify({ event: "public_chat_error", reason: error instanceof Error ? error.message : "unknown" }));
      return json({ error: "The chat is temporarily unavailable" }, 503, origin);
    }
  },
};
