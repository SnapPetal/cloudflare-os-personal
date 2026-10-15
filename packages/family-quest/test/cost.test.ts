import { describe, expect, it } from "vitest";
import { MemoryUsageStore, capMessage, consumeCount, parseCap, tryConsumeAiCall, utcDay } from "../src/cost";

describe("cost cap", () => {
  it("allows a call under the cap and counts it", () => {
    const result = consumeCount(0, 40, "2026-10-14", () => undefined);
    expect(result).toMatchObject({ allowed: true, used: 1, remaining: 39, cap: 40 });
  });

  it("denies a call once the cap is reached and does not commit", () => {
    let committed = false;
    const result = consumeCount(40, 40, "2026-10-14", () => {
      committed = true;
    });
    expect(result.allowed).toBe(false);
    expect(result.remaining).toBe(0);
    expect(committed).toBe(false);
  });

  it("treats a cap of zero as closed", () => {
    expect(consumeCount(0, 0, "2026-10-14", () => undefined).allowed).toBe(false);
  });

  it("rejects invalid counts and caps", () => {
    expect(() => consumeCount(-1, 10, "2026-10-14", () => undefined)).toThrow(/Usage/);
    expect(() => consumeCount(0, -1, "2026-10-14", () => undefined)).toThrow(/Cap/);
    expect(() => consumeCount(1.5, 10, "2026-10-14", () => undefined)).toThrow(/Usage/);
  });

  it("tracks each UTC day on its own", async () => {
    const store = new MemoryUsageStore();
    const first = await tryConsumeAiCall(store, 1, new Date("2026-10-14T23:30:00Z"));
    const blocked = await tryConsumeAiCall(store, 1, new Date("2026-10-14T23:59:00Z"));
    const nextDay = await tryConsumeAiCall(store, 1, new Date("2026-10-15T00:00:00Z"));
    expect(utcDay(new Date("2026-10-14T23:30:00Z"))).toBe("2026-10-14");
    expect(first.allowed).toBe(true);
    expect(blocked.allowed).toBe(false);
    expect(nextDay.allowed).toBe(true);
    expect(nextDay.day).toBe("2026-10-15");
    expect(store.counts.get("2026-10-14")).toBe(1);
    expect(store.counts.get("2026-10-15")).toBe(1);
  });

  it("stops a memory store at the cap", async () => {
    const store = new MemoryUsageStore();
    const now = new Date("2026-10-14T12:00:00Z");
    expect((await tryConsumeAiCall(store, 2, now)).allowed).toBe(true);
    expect((await tryConsumeAiCall(store, 2, now)).remaining).toBe(0);
    expect((await tryConsumeAiCall(store, 2, now)).allowed).toBe(false);
  });

  it("parses the configured cap and explains a full day", () => {
    expect(parseCap(undefined)).toBe(40);
    expect(parseCap("10")).toBe(10);
    expect(() => parseCap("nope")).toThrow(/AI_DAILY_CAP/);
    expect(capMessage(40)).toContain("40");
    expect(capMessage(40)).toContain("Dice");
  });
});
