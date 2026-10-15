import { clipText } from "./text";

const COOKIE = "fq_session";
const MAX_AGE_SECONDS = 60 * 60 * 24 * 14;

export interface Session {
  csrf: string;
}

interface SessionPayload {
  exp: number;
  csrf: string;
}

export async function passwordsMatch(provided: string, expected: string): Promise<boolean> {
  const encoder = new TextEncoder();
  const [left, right] = await Promise.all([
    crypto.subtle.digest("SHA-256", encoder.encode(provided)),
    crypto.subtle.digest("SHA-256", encoder.encode(expected)),
  ]);
  return crypto.subtle.timingSafeEqual(left, right);
}

export async function createSession(secret: string): Promise<{ cookieValue: string; csrf: string }> {
  const csrf = base64Url(crypto.getRandomValues(new Uint8Array(32)));
  const payload: SessionPayload = { exp: Date.now() + MAX_AGE_SECONDS * 1000, csrf };
  const body = base64Url(new TextEncoder().encode(JSON.stringify(payload)));
  const signature = await sign(secret, body);
  return { cookieValue: `v1.${body}.${signature}`, csrf };
}

export function sessionCookie(value: string, secure: boolean, maxAge = MAX_AGE_SECONDS): string {
  const parts = [
    `${COOKIE}=${value}`,
    "HttpOnly",
    "Path=/",
    "SameSite=Lax",
    `Max-Age=${maxAge}`,
  ];
  if (secure) parts.push("Secure");
  return parts.join("; ");
}

export function clearSessionCookie(secure: boolean): string {
  return sessionCookie("", secure, 0);
}

export async function readSession(request: Request, secret: string): Promise<Session | null> {
  const raw = readCookie(request, COOKIE);
  if (!raw) return null;
  const parts = raw.split(".");
  if (parts.length !== 3 || parts[0] !== "v1" || !parts[1] || !parts[2]) return null;
  const expected = await sign(secret, parts[1]);
  const providedBytes = decodeBase64Url(parts[2]);
  const expectedBytes = decodeBase64Url(expected);
  if (!providedBytes || !expectedBytes || providedBytes.length !== expectedBytes.length) return null;
  if (!crypto.subtle.timingSafeEqual(providedBytes, expectedBytes)) return null;
  try {
    const payload = JSON.parse(new TextDecoder().decode(decodeBase64Url(parts[1]) ?? new Uint8Array())) as SessionPayload;
    if (!payload || typeof payload.exp !== "number" || typeof payload.csrf !== "string") return null;
    if (payload.exp < Date.now()) return null;
    if (payload.csrf.length < 16) return null;
    return { csrf: payload.csrf };
  } catch {
    return null;
  }
}

export async function csrfOk(expected: string, provided: unknown): Promise<boolean> {
  const value = clipText(provided, 200);
  if (!value || !expected) return false;
  return passwordsMatch(value, expected);
}

export function requestIsSecure(request: Request): boolean {
  return new URL(request.url).protocol === "https:";
}

async function sign(secret: string, body: string): Promise<string> {
  const key = await crypto.subtle.importKey(
    "raw",
    new TextEncoder().encode(secret),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const signature = await crypto.subtle.sign("HMAC", key, new TextEncoder().encode(body));
  return base64Url(signature);
}

function readCookie(request: Request, name: string): string | null {
  const header = request.headers.get("cookie");
  if (!header) return null;
  for (const part of header.split(";")) {
    const [key, ...rest] = part.trim().split("=");
    if (key === name) return rest.join("=");
  }
  return null;
}

function base64Url(bytes: ArrayBuffer | Uint8Array): string {
  const view = bytes instanceof Uint8Array ? bytes : new Uint8Array(bytes);
  let binary = "";
  for (const byte of view) binary += String.fromCharCode(byte);
  return btoa(binary).replaceAll("+", "-").replaceAll("/", "_").replaceAll("=", "");
}

function decodeBase64Url(value: string): Uint8Array | null {
  try {
    const padded = value.replaceAll("-", "+").replaceAll("_", "/") + "=".repeat((4 - (value.length % 4)) % 4);
    const binary = atob(padded);
    const bytes = new Uint8Array(binary.length);
    for (let index = 0; index < binary.length; index += 1) bytes[index] = binary.charCodeAt(index);
    return bytes;
  } catch {
    return null;
  }
}
