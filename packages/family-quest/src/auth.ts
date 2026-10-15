/** A person Cloudflare Access has already authenticated. */
export interface Viewer {
  /** `Cf-Access-Authenticated-User-Email`. */
  email: string;
  /** Team logout URL. Present only when `ACCESS_TEAM_DOMAIN` is set. */
  logoutUrl: string | null;
}

interface JwtHeader {
  alg?: string;
  kid?: string;
}

interface JwtClaims {
  iss?: string;
  aud?: string | string[];
  exp?: number;
  nbf?: number;
  email?: string;
}

interface AccessJwk extends JsonWebKey {
  kid?: string;
}

interface CertCache {
  keys: AccessJwk[];
  expires: number;
}

export interface AccessVerifyOptions {
  /** Unix seconds. Tests pin this instead of the wall clock. */
  now?: number;
  /** Replaces the certs fetch. Production omits it and uses the team certs URL. */
  fetchCerts?: (url: string) => Promise<AccessJwk[]>;
}

const CERT_TTL_MS = 10 * 60 * 1000;
const certs = new Map<string, CertCache>();

/** True when both optional plain vars are set, so the JWT should be checked. */
export function jwtVerificationEnabled(teamDomain: unknown, audience: unknown): boolean {
  return normalizeIssuer(teamDomain) !== null
    && typeof audience === "string"
    && audience.length > 0
    && audience === audience.trim();
}

/**
 * A visit counts as signed in when Cloudflare Access set both headers.
 * `ACCESS_TEAM_DOMAIN` and `ACCESS_AUD` are optional. When both are set, the JWT
 * is checked against that team's certs. A failed check is a sign-in page, not a 500.
 */
export async function readAccessUser(
  request: Request,
  env: { ACCESS_AUD?: string; ACCESS_TEAM_DOMAIN?: string },
  options: AccessVerifyOptions = {},
): Promise<Viewer | null> {
  const token = request.headers.get("cf-access-jwt-assertion")?.trim() ?? "";
  const email = request.headers.get("cf-access-authenticated-user-email")?.trim() ?? "";
  if (!token || !email) return null;

  const team = normalizeIssuer(env.ACCESS_TEAM_DOMAIN);
  if (jwtVerificationEnabled(env.ACCESS_TEAM_DOMAIN, env.ACCESS_AUD)) {
    try {
      const verified = await verifyAccessJwt(token, team ?? "", env.ACCESS_AUD ?? "", options);
      if (verified === null) return null;
    } catch (error) {
      console.error(JSON.stringify({
        event: "access_verify_failed",
        error: error instanceof Error ? error.message : "unknown",
      }));
      return null;
    }
  }

  return {
    email,
    logoutUrl: team ? `${team}/cdn-cgi/access/logout` : null,
  };
}

/**
 * State-changing requests must come from this page. Access cookies are sent on
 * cross-site posts, and this app no longer has a session token to pair with a form.
 */
export function sameOrigin(request: Request): boolean {
  const expected = new URL(request.url).origin;
  const origin = request.headers.get("origin");
  if (!origin) return false;
  try {
    return new URL(origin).origin === expected;
  } catch {
    return false;
  }
}

async function verifyAccessJwt(
  token: string,
  issuer: string,
  audience: string,
  options: AccessVerifyOptions,
): Promise<string | null> {
  if (token.length > 16_000) return null;
  const parts = token.split(".");
  if (parts.length !== 3 || !parts[0] || !parts[1] || !parts[2]) return null;
  const header = parseJson<JwtHeader>(parts[0]);
  const claims = parseJson<JwtClaims>(parts[1]);
  if (!header || !claims || header.alg !== "RS256") return null;
  if (!claimsFresh(claims, options.now ?? Math.floor(Date.now() / 1000))) return null;
  if (claims.iss !== issuer) return null;
  const audiences = Array.isArray(claims.aud) ? claims.aud : [claims.aud];
  if (!audiences.includes(audience)) return null;

  const signed = new TextEncoder().encode(`${parts[0]}.${parts[1]}`);
  const signature = decodeBase64Url(parts[2]);
  if (!signature) return null;
  const keys = await loadCerts(issuer, options.fetchCerts, false);
  if (await signatureMatches(header.kid, keys, signature, signed)) {
    return emailClaim(claims);
  }
  if (options.fetchCerts) return null;
  const fresh = await loadCerts(issuer, undefined, true);
  if (await signatureMatches(header.kid, fresh, signature, signed)) return emailClaim(claims);
  return null;
}

function emailClaim(claims: JwtClaims): string {
  return typeof claims.email === "string" ? claims.email.trim() : "";
}

function claimsFresh(claims: JwtClaims, now: number): boolean {
  if (typeof claims.exp !== "number" || claims.exp + 60 < now) return false;
  if (typeof claims.nbf === "number" && claims.nbf - 60 > now) return false;
  return true;
}

async function signatureMatches(
  kid: string | undefined,
  keys: AccessJwk[],
  signature: Uint8Array,
  signed: Uint8Array,
): Promise<boolean> {
  const candidates = keys.filter((key) => {
    if (key.kty !== "RSA") return false;
    if (key.alg && key.alg !== "RS256") return false;
    if (kid) return key.kid === kid;
    return true;
  });
  for (const key of candidates) {
    try {
      const cryptoKey = await crypto.subtle.importKey(
        "jwk",
        key,
        { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
        false,
        ["verify"],
      );
      if (await crypto.subtle.verify("RSASSA-PKCS1-v1_5", cryptoKey, signature, signed)) return true;
    } catch {
      // A malformed JWK is not a reason to fail the whole request.
    }
  }
  return false;
}

async function loadCerts(
  issuer: string,
  fetchCerts: AccessVerifyOptions["fetchCerts"],
  force: boolean,
): Promise<AccessJwk[]> {
  if (fetchCerts) return fetchCerts(`${issuer}/cdn-cgi/access/certs`);
  const cached = certs.get(issuer);
  if (!force && cached && cached.expires > Date.now()) return cached.keys;
  const keys = await fetchJwks(`${issuer}/cdn-cgi/access/certs`);
  certs.set(issuer, { keys, expires: Date.now() + CERT_TTL_MS });
  return keys;
}

async function fetchJwks(url: string): Promise<AccessJwk[]> {
  const response = await fetch(url, { headers: { accept: "application/json" } });
  if (!response.ok) throw new Error(`Access certs returned ${response.status}`);
  const body = await response.json() as { keys?: unknown };
  if (!body || !Array.isArray(body.keys)) throw new Error("Access certs omitted keys");
  return body.keys.filter(isAccessJwk);
}

function isAccessJwk(value: unknown): value is AccessJwk {
  if (!value || typeof value !== "object") return false;
  const key = value as AccessJwk;
  return key.kty === "RSA" && typeof key.n === "string" && typeof key.e === "string";
}

function normalizeIssuer(value: unknown): string | null {
  if (typeof value !== "string" || value.length === 0) return null;
  try {
    const url = new URL(value);
    if (url.protocol !== "https:" || url.username || url.password) return null;
    if (url.pathname !== "/" || url.search || url.hash) return null;
    return url.origin;
  } catch {
    return null;
  }
}

function parseJson<T>(segment: string): T | null {
  try {
    const bytes = decodeBase64Url(segment);
    if (!bytes) return null;
    return JSON.parse(new TextDecoder().decode(bytes)) as T;
  } catch {
    return null;
  }
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
