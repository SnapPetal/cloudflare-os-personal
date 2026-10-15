import { describe, expect, it } from "vitest";
import { jwtVerificationEnabled, readAccessUser, sameOrigin } from "../src/auth";
import { handle } from "../src/app";
import { layout, signedOutPage } from "../src/view";

const TEAM = "https://withered-dream-fb5a.cloudflareaccess.com";
const AUDIENCE = "quest-aud-tag";

describe("header sign-in", () => {
  it("does not require an audience or team domain", () => {
    expect(jwtVerificationEnabled(undefined, undefined)).toBe(false);
    expect(jwtVerificationEnabled(TEAM, undefined)).toBe(false);
    expect(jwtVerificationEnabled(undefined, AUDIENCE)).toBe(false);
    expect(jwtVerificationEnabled(TEAM, " padded ")).toBe(false);
    expect(jwtVerificationEnabled(TEAM, AUDIENCE)).toBe(true);
  });

  it("accepts both Access headers and shows the email", async () => {
    const user = await readAccessUser(requestWith("header.jwt.value", "thon.becker@gmail.com"), {});
    expect(user).toEqual({ email: "thon.becker@gmail.com", logoutUrl: null });
  });

  it("shows a sign-in page when either Access header is missing", async () => {
    expect(await readAccessUser(new Request("https://quest.thonbecker.biz/"), {})).toBeNull();
    expect(await readAccessUser(requestWith("header.jwt.value"), {})).toBeNull();

    const page = signedOutPage();
    expect(page).toContain("Sign in through Cloudflare Access");

    const response = await handle(new Request("https://quest.thonbecker.biz/"), {} as Env);
    expect(response.status).toBe(401);
    const body = await response.text();
    expect(body).toContain("Sign in through Cloudflare Access");
    expect(body).not.toContain("hit a snag");
  });

  it("keeps the health check public", async () => {
    const response = await handle(new Request("https://quest.thonbecker.biz/health"), {} as Env);
    expect(response.status).toBe(200);
    expect(await response.text()).toBe("ok");
  });
});

describe("optional JWT verification", () => {
  it("checks the token only when both vars are set", async () => {
    const { token, fetchCerts } = await signAccessToken({ email: "thon.becker@gmail.com" });
    const headers = requestWith(token, "thon.becker@gmail.com");
    const withoutAudience = await readAccessUser(headers, { ACCESS_TEAM_DOMAIN: TEAM }, { fetchCerts, now: NOW });
    expect(withoutAudience?.email).toBe("thon.becker@gmail.com");
    expect(withoutAudience?.logoutUrl).toBe(`${TEAM}/cdn-cgi/access/logout`);

    const verified = await readAccessUser(headers, {
      ACCESS_TEAM_DOMAIN: TEAM,
      ACCESS_AUD: AUDIENCE,
    }, { fetchCerts, now: NOW });
    expect(verified?.email).toBe("thon.becker@gmail.com");
  });

  it("rejects a bad signature, the wrong audience, and an expired token", async () => {
    const good = await signAccessToken({ email: "thon.becker@gmail.com" });
    const env = { ACCESS_TEAM_DOMAIN: TEAM, ACCESS_AUD: AUDIENCE };
    const flipped = `${good.token.slice(0, -4)}aaaa`;
    expect(await readAccessUser(requestWith(flipped, "thon.becker@gmail.com"), env, { fetchCerts: good.fetchCerts, now: NOW })).toBeNull();
    expect(await readAccessUser(requestWith(good.token, "thon.becker@gmail.com"), {
      ACCESS_TEAM_DOMAIN: TEAM,
      ACCESS_AUD: "other-aud",
    }, { fetchCerts: good.fetchCerts, now: NOW })).toBeNull();

    const expired = await signAccessToken({ email: "thon.becker@gmail.com", exp: NOW - 120 });
    expect(await readAccessUser(requestWith(expired.token, "thon.becker@gmail.com"), env, {
      fetchCerts: expired.fetchCerts,
      now: NOW,
    })).toBeNull();
  });

  it("does not throw when the certs endpoint fails", async () => {
    const { token } = await signAccessToken({ email: "thon.becker@gmail.com" });
    const user = await readAccessUser(requestWith(token, "thon.becker@gmail.com"), {
      ACCESS_TEAM_DOMAIN: TEAM,
      ACCESS_AUD: AUDIENCE,
    }, {
      now: NOW,
      fetchCerts: () => Promise.reject(new Error("certs down")),
    });
    expect(user).toBeNull();
  });
});

describe("same-origin posts", () => {
  it("accepts this site's Origin and rejects a cross-site post", () => {
    const same = new Request("https://quest.thonbecker.biz/quests", {
      method: "POST",
      headers: { origin: "https://quest.thonbecker.biz" },
    });
    const cross = new Request("https://quest.thonbecker.biz/quests", {
      method: "POST",
      headers: { origin: "https://evil.example" },
    });
    const bare = new Request("https://quest.thonbecker.biz/quests", { method: "POST" });
    expect(sameOrigin(same)).toBe(true);
    expect(sameOrigin(cross)).toBe(false);
    expect(sameOrigin(bare)).toBe(false);
  });
});

describe("signed-in chrome", () => {
  it("escapes the email and links Lock only when a team domain is known", () => {
    const page = layout({
      title: "Quests",
      body: "<p>Hi</p>",
      viewer: {
        email: `kid<script>@example.com`,
        logoutUrl: `${TEAM}/cdn-cgi/access/logout`,
      },
    });
    expect(page).toContain("kid&lt;script&gt;@example.com");
    expect(page).toContain(`${TEAM}/cdn-cgi/access/logout`);
    expect(page).not.toContain("kid<script>");

    const plain = layout({
      title: "Quests",
      body: "<p>Hi</p>",
      viewer: { email: "thon.becker@gmail.com", logoutUrl: null },
    });
    expect(plain).toContain("thon.becker@gmail.com");
    expect(plain).not.toContain(">Lock<");
  });
});

const NOW = 1_700_000_000;

function requestWith(token: string, emailHeader?: string): Request {
  const headers = new Headers({ "cf-access-jwt-assertion": token });
  if (emailHeader) headers.set("cf-access-authenticated-user-email", emailHeader);
  return new Request("https://quest.thonbecker.biz/", { headers });
}

async function signAccessToken(claims: { email?: string; exp?: number }): Promise<{
  token: string;
  fetchCerts: () => Promise<Array<JsonWebKey & { kid: string }>>;
}> {
  const pair = await crypto.subtle.generateKey(
    { name: "RSASSA-PKCS1-v1_5", modulusLength: 2048, publicExponent: new Uint8Array([1, 0, 1]), hash: "SHA-256" },
    true,
    ["sign", "verify"],
  ) as CryptoKeyPair;
  const jwk = await crypto.subtle.exportKey("jwk", pair.publicKey) as JsonWebKey & { kid: string };
  jwk.kid = "test-key";
  jwk.alg = "RS256";
  jwk.use = "sig";
  const header = base64Url(JSON.stringify({ alg: "RS256", kid: "test-key", typ: "JWT" }));
  const payload = base64Url(JSON.stringify({
    iss: TEAM,
    aud: AUDIENCE,
    exp: claims.exp ?? NOW + 3600,
    email: claims.email,
  }));
  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    pair.privateKey,
    new TextEncoder().encode(`${header}.${payload}`),
  );
  return {
    token: `${header}.${payload}.${base64UrlBytes(new Uint8Array(signature))}`,
    fetchCerts: () => Promise.resolve([jwk]),
  };
}

function base64Url(value: string): string {
  return base64UrlBytes(new TextEncoder().encode(value));
}

function base64UrlBytes(bytes: Uint8Array): string {
  let binary = "";
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary).replaceAll("+", "-").replaceAll("/", "_").replaceAll("=", "");
}
