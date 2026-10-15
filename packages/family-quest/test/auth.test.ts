import { describe, expect, it } from "vitest";
import { secretsReady } from "../src/auth";
import { setupPage } from "../src/view";

describe("Family Quest setup", () => {
  it("does not treat a missing secret as ready", () => {
    expect(secretsReady(undefined, undefined)).toBe(false);
    expect(secretsReady("", "1234567890123456")).toBe(false);
    expect(secretsReady("   ", "   ")).toBe(false);
    expect(secretsReady("no", "1234567890123456")).toBe(false);
    expect(secretsReady("pass", "too-short")).toBe(false);
    expect(secretsReady("pass", "1234567890123456")).toBe(true);
  });

  it("shows a not set up yet page", () => {
    const page = setupPage();
    expect(page).toContain("not set up yet");
    expect(page).toContain("FAMILY_PASSCODE");
    expect(page).toContain("SESSION_SECRET");
  });
});
