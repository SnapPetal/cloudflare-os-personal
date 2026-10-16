import { afterEach, describe, expect, it, vi } from "vitest";
import { handle } from "../src/app";
import worker from "../src/index";
import { openTable, readBytes, readText } from "./local-d1.mjs";

interface SqlRow {
  [column: string]: string | number | null;
}

interface LocalDatabase {
  prepare(sql: string): {
    get(...params: unknown[]): SqlRow | undefined;
    all(...params: unknown[]): SqlRow[];
  };
}

function questTable(): { env: Env; raw: LocalDatabase; close: () => void } {
  return openTable() as unknown as { env: Env; raw: LocalDatabase; close: () => void };
}

const ORIGIN = "https://quest.thonbecker.biz";
const STUB_LINE = "A stub Dungeon Master sets a sunny scene";

describe("home and unknown routes", () => {
  it("renders an empty quest list and answers HEAD /", async () => {
    const { env, close } = questTable();
    try {
      const home = await handle(visit("/"), env);
      expect(home.status).toBe(200);
      expect(await home.text()).toContain("No quests yet");

      const head = await handle(visit("/", "HEAD"), env);
      expect(head.status).toBe(200);
    } finally {
      close();
    }
  });

  it("returns 404 for unknown paths instead of the snag page", async () => {
    const { env, close } = questTable();
    try {
      for (const path of ["/login", "/favicon.ico", "/robots.txt"]) {
        const response = await handle(visit(path), env);
        expect(response.status).toBe(404);
        expect(await response.text()).toContain("wandered off");
      }
    } finally {
      close();
    }
  });
});

describe("quest table", () => {
  it("rejects an empty party and a cross-site post before writing", async () => {
    const { env, raw, close } = questTable();
    try {
      const empty = await handle(post("/quests", "mode=quick&names=&premise=picnic"), env);
      expect(empty.status).toBe(400);
      expect(await empty.text()).toContain("Add at least one name");

      const cross = await handle(post("/quests", "mode=quick&names=Maya&premise=picnic", {
        origin: "null",
        "sec-fetch-site": "cross-site",
      }), env);
      expect(cross.status).toBe(403);
      expect(count(raw, "campaigns")).toBe(0);
      expect(count(raw, "ai_usage")).toBe(0);
    } finally {
      close();
    }
  });

  it("saves a quest, a hero, and a stub Dungeon Master reply when AI is unbound", async () => {
    const { env, raw, close } = questTable();
    try {
      const created = await handle(post("/quests", new URLSearchParams({
        mode: "custom",
        name_1: "Maya",
        class_1: "knight",
        ancestry_1: "Human",
        premise: "picnic",
      }).toString()), env);
      expect(created.status).toBe(303);
      const location = created.headers.get("location") ?? "";
      expect(location).toMatch(/^\/quests\/[0-9a-f-]{36}$/);
      expect(count(raw, "campaigns")).toBe(1);
      expect(count(raw, "ai_usage")).toBe(1);

      const hero = raw.prepare("SELECT id, name, class_name, inventory FROM characters").get() as {
        id: string;
        name: string;
        class_name: string;
        inventory: string;
      };
      expect(hero.name).toBe("Maya");
      expect(hero.class_name).toBe("Brave Knight");

      const sheet = await handle(post(`${location}/characters/${hero.id}`, new URLSearchParams({
        hp: "12",
        inventory: "glow jar",
        portrait: "Maya wears a bright cloak",
      }).toString()), env);
      expect(sheet.status).toBe(303);
      const saved = raw.prepare("SELECT inventory FROM characters WHERE id = ?").get(hero.id) as { inventory: string };
      expect(saved.inventory).toBe("glow jar");

      const home = await handle(visit("/"), env);
      expect(home.status).toBe(200);
      const homeBody = await home.text();
      expect(homeBody).toContain("The Lost Picnic");
      expect(homeBody).toContain("Maya");

      const acted = await handle(post(`${location}/act`, new URLSearchParams({
        speaker: "Maya",
        action: "Look for the picnic basket",
      }).toString()), env);
      expect(acted.status).toBe(200);
      const page = await acted.text();
      expect(page).toContain(STUB_LINE);
      expect(page).toContain("Look for the picnic basket");
      expect(page).toContain("Pip");
      expect(count(raw, "ai_usage")).toBe(1);

      const usage = raw.prepare(`SELECT "count" AS used FROM ai_usage`).get() as { used: number };
      expect(usage.used).toBe(2);
      const roles = raw.prepare("SELECT role, content FROM messages ORDER BY created_at, rowid").all();
      expect(roles.filter((row) => row.role === "dm").map((row) => String(row.content))).toEqual([
        expect.stringContaining(STUB_LINE),
        expect.stringContaining(STUB_LINE),
      ]);
      expect(roles.some((row) => row.role === "player" && String(row.content).includes("Look for the picnic basket"))).toBe(true);
      expect(roles.some((row) => row.role === "npc" && String(row.content).includes("picnic basket"))).toBe(true);
    } finally {
      close();
    }
  });
});

describe("snag page", () => {
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("prints the cf-ray and logs the message and stack", async () => {
    const spy = vi.spyOn(console, "error").mockImplementation(() => undefined);
    const env = {
      DB: {
        prepare() {
          throw new Error("d1 down");
        },
      },
    } as unknown as Env;
    const response = await worker.fetch(new Request(`${ORIGIN}/`, {
      headers: {
        "cf-access-jwt-assertion": "test-token",
        "cf-access-authenticated-user-email": "thon.becker@gmail.com",
        "cf-ray": "8f3c0a76example-ORD",
      },
    }), env);
    expect(response.status).toBe(500);
    expect(await response.text()).toContain("cf-ray: 8f3c0a76example-ORD");
    const logged = spy.mock.calls.map((call) => String(call[0])).find((line) => line.includes("request_failed"));
    expect(logged).toBeTruthy();
    const record = JSON.parse(logged ?? "{}") as { error?: string; stack?: string; ray?: string };
    expect(record.error).toBe("d1 down");
    expect(record.stack).toContain("d1 down");
    expect(record.ray).toBe("8f3c0a76example-ORD");
  });
});

describe("static files", () => {
  it("includes a favicon and a robots file that asks crawlers to stay out", () => {
    const icon = readBytes("public/favicon.ico");
    expect([...icon.subarray(0, 4)]).toEqual([0, 0, 1, 0]);
    expect(readText("public/robots.txt")).toContain("Disallow: /");
  });
});

function visit(path: string, method = "GET"): Request {
  return new Request(`${ORIGIN}${path}`, {
    method,
    headers: {
      "cf-access-jwt-assertion": "test-token",
      "cf-access-authenticated-user-email": "thon.becker@gmail.com",
    },
  });
}

function post(path: string, body: string, headers: Record<string, string> = {}): Request {
  return new Request(`${ORIGIN}${path}`, {
    method: "POST",
    headers: {
      "content-type": "application/x-www-form-urlencoded",
      origin: "null",
      "sec-fetch-site": "same-origin",
      "cf-access-jwt-assertion": "test-token",
      "cf-access-authenticated-user-email": "thon.becker@gmail.com",
      ...headers,
    },
    body,
  });
}

function count(raw: LocalDatabase, tableName: string): number {
  const row = raw.prepare(`SELECT COUNT(*) AS n FROM ${tableName}`).get();
  return Number(row?.n ?? 0);
}
