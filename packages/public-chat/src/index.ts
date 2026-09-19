interface Env {
  AI?: Ai;
  AI_MODEL?: string;
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
const DEFAULT_MODEL = "@cf/meta/llama-3.3-70b-instruct-fp8-fast";
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

function extractJsonText(raw: string): string {
  const trimmed = raw.trim();
  const codeBlockMatch = trimmed.match(/```(?:json)?\s*([\s\S]*?)\s*```/i);
  if (codeBlockMatch) {
    return codeBlockMatch[1].trim();
  }
  const braceMatch = trimmed.match(/\{[\s\S]*\}/);
  if (braceMatch) {
    return braceMatch[0].trim();
  }
  return trimmed;
}

function parseChatAnswer(data: unknown): ChatAnswer {
  let value: Record<string, unknown> | null = null;
  if (typeof data === "string") {
    try {
      const parsed = JSON.parse(extractJsonText(data));
      if (parsed && typeof parsed === "object") {
        value = parsed as Record<string, unknown>;
      }
    } catch {
      const msgMatch = data.match(/"message"\s*:\s*"((?:[^"\\]|\\.)*)"/);
      if (msgMatch) {
        try {
          return {
            message: JSON.parse(`"${msgMatch[1]}"`),
            action: "show_availability",
            availableSlots: [],
          };
        } catch {
          return {
            message: msgMatch[1],
            action: "show_availability",
            availableSlots: [],
          };
        }
      }
      return {
        message: data.trim(),
        action: "show_availability",
        availableSlots: [],
      };
    }
  } else if (data && typeof data === "object") {
    const obj = data as Record<string, unknown>;
    if (obj.response && typeof obj.response === "object") {
      value = obj.response as Record<string, unknown>;
    } else if (typeof obj.response === "string") {
      return parseChatAnswer(obj.response);
    } else {
      value = obj;
    }
  }

  if (!value) {
    return {
      message: typeof data === "string" ? data.trim() : "Here are the available times.",
      action: "show_availability",
      availableSlots: [],
    };
  }

  let message = typeof value.message === "string" ? value.message.trim() : "Here are the available times.";
  if (message.endsWith(":")) {
    message = message.slice(0, -1).trim();
  }

  const rawSlots = Array.isArray(value.availableSlots) ? value.availableSlots : [];
  const validSlots: AvailabilitySlot[] = [];
  for (const slot of rawSlots) {
    if (slot && typeof slot === "object") {
      const item = slot as Record<string, unknown>;
      if (
        typeof item.start === "string" &&
        typeof item.end === "string" &&
        typeof item.timezone === "string"
      ) {
        validSlots.push({
          start: item.start,
          end: item.end,
          timezone: item.timezone,
        });
      }
    }
  }

  const action: ChatAction =
    value.action === "show_availability" || value.action === "clarify" || value.action === "unsupported"
      ? value.action
      : "show_availability";

  return {
    message,
    action,
    availableSlots: validSlots,
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

interface RawSlot {
  start: string;
  end: string;
  bookingTypeId?: number;
  bookingTypeName?: string;
  durationMinutes?: number;
}

interface RawAvailabilityResponse {
  slots?: RawSlot[];
  timezone?: string;
}

interface FormattedSchedule {
  scheduleText: string;
  uniqueSlots: AvailabilitySlot[];
}

function formatAvailabilitySchedule(jsonText: string, timezone: string): FormattedSchedule {
  let raw: RawAvailabilityResponse;
  try {
    raw = JSON.parse(jsonText);
  } catch {
    return { scheduleText: "No availability data found.", uniqueSlots: [] };
  }

  const slots = Array.isArray(raw.slots) ? raw.slots : [];
  const seenStarts = new Set<string>();
  const uniqueSlots: AvailabilitySlot[] = [];

  for (const slot of slots) {
    if (slot && typeof slot.start === "string" && typeof slot.end === "string") {
      if (!seenStarts.has(slot.start)) {
        seenStarts.add(slot.start);
        uniqueSlots.push({
          start: slot.start,
          end: slot.end,
          timezone,
        });
      }
    }
  }

  if (uniqueSlots.length === 0) {
    return { scheduleText: "No available openings found for the next 14 days.", uniqueSlots: [] };
  }

  const timeFormatter = new Intl.DateTimeFormat("en-US", {
    timeZone: timezone,
    hour: "numeric",
    minute: "2-digit",
  });
  const dateFormatter = new Intl.DateTimeFormat("en-US", {
    timeZone: timezone,
    weekday: "long",
    month: "short",
    day: "numeric",
  });

  const days = new Map<string, { label: string; items: Array<{ time: string; start: string; end: string }> }>();

  for (const slot of uniqueSlots) {
    const d = new Date(slot.start);
    const dateKey = slot.start.slice(0, 10);
    if (!days.has(dateKey)) {
      days.set(dateKey, { label: dateFormatter.format(d), items: [] });
    }
    days.get(dateKey)!.items.push({
      time: timeFormatter.format(d),
      start: slot.start,
      end: slot.end,
    });
  }

  let scheduleText = `Available Openings Schedule (in ${timezone}):\n`;
  for (const [dateKey, day] of days.entries()) {
    scheduleText += `${day.label} (${dateKey}):\n`;
    for (const item of day.items) {
      scheduleText += `  - ${item.time} [start: "${item.start}", end: "${item.end}"]\n`;
    }
  }

  return { scheduleText, uniqueSlots };
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
  if (!env.AI) throw new Error("Workers AI binding (AI) is not configured");
  const rawAvailability = await loadAvailability(timezone, env);
  const { scheduleText } = formatAvailabilitySchedule(rawAvailability, timezone);

  const systemInstructions = `${SYSTEM_PROMPT}

You MUST respond with ONLY a valid JSON object matching this schema:
{
  "message": "Complete, conversational answer to the visitor mentioning specific dates and times.",
  "action": "show_availability" | "clarify" | "unsupported",
  "availableSlots": [
    { "start": "YYYY-MM-DDTHH:MM:SS+ZZ:ZZ", "end": "YYYY-MM-DDTHH:MM:SS+ZZ:ZZ", "timezone": "${timezone}" }
  ]
}

CRITICAL RULES:
1. "message": Write a complete, friendly sentence or paragraph. Always state the specific days and times clearly (e.g. "I have openings on Monday, Sep 21 at 11:00 AM and 6:00 PM CDT."). NEVER end your message with a trailing colon, empty phrase, or cut off sentence like "Here are some options:".
2. If the visitor asks for a date, time, or day of the week that has no openings (such as weekends, outside business hours, or fully booked days), explicitly explain in "message" that there are no openings for that requested time, and offer the closest upcoming openings from the schedule.
3. In "availableSlots", include at most 4-6 matching slot objects directly from the schedule using the exact start, end, and timezone. If answering generally, pick 4-6 convenient upcoming openings. If the visitor is asking off-topic questions or no slots are relevant, use an empty array [].
4. Only suggest openings that exist in the schedule below. NEVER invent or hallucinate dates, times, or slots.
5. Do not wrap your response in markdown code blocks or add any text outside the JSON object.`;

  const userPrompt = `Visitor timezone: ${timezone}
Current visitor date: ${currentDate(timezone)}

${scheduleText}

Visitor message: ${message}`;

  const model = env.AI_MODEL || DEFAULT_MODEL;
  const result = await env.AI.run(model as any, {
    messages: [
      { role: "system", content: systemInstructions },
      { role: "user", content: userPrompt },
    ],
    max_tokens: 1024,
    temperature: 0.2,
  });

  return parseChatAnswer(result);
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
