import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import worker from "./index.js";

const availabilityUrl = "https://availability.test/slots";
const originalFetch = globalThis.fetch;

beforeEach(() => {
  vi.useFakeTimers();
  vi.setSystemTime(new Date("2026-09-24T12:00:00Z"));
});

afterEach(() => {
  globalThis.fetch = originalFetch;
  vi.useRealTimers();
  vi.restoreAllMocks();
});

describe("public booking chat", () => {
  it("returns only slots supplied by the mocked availability service", async () => {
    const availability = {
      slots: [
        { start: "2026-10-05T15:00:00-05:00", end: "2026-10-05T15:30:00-05:00" },
        { start: "2026-10-05T16:00:00-05:00", end: "2026-10-05T16:30:00-05:00" },
      ],
    };
    globalThis.fetch = vi.fn().mockResolvedValue(new Response(JSON.stringify(availability)));
    const ai = {
      run: vi.fn().mockResolvedValue(
        JSON.stringify({
          message: "I have an opening Monday at 3:00 PM.",
          action: "show_availability",
          availableSlots: [
            {
              start: "2026-10-05T15:00:00-05:00",
              end: "2026-10-05T15:30:00-05:00",
              timezone: "America/Chicago",
            },
          ],
        }),
      ),
    };

    const response = await worker.fetch(
      new Request("https://chat.thonbecker.biz/chat", {
        method: "POST",
        headers: { Origin: "https://booking.thonbecker.biz", "CF-Connecting-IP": "test-availability" },
        body: JSON.stringify({ message: "What is available Monday?", timezone: "America/Chicago" }),
      }),
      { AI: ai, BOOKING_AVAILABILITY_URL: availabilityUrl },
    );

    expect(response.status).toBe(200);
    await expect(response.json()).resolves.toEqual({
      message: "I have an opening Monday at 3:00 PM.",
      action: "show_availability",
      availableSlots: [
        {
          start: "2026-10-05T15:00:00-05:00",
          end: "2026-10-05T15:30:00-05:00",
          timezone: "America/Chicago",
        },
      ],
    });
    expect(globalThis.fetch).toHaveBeenCalledWith(
      expect.objectContaining({
        hostname: "availability.test",
        search: "?from=2026-09-24&to=2026-10-07&timezone=America%2FChicago",
      }),
      { headers: { Accept: "application/json" } },
    );
  });

  it("rejects requests from origins other than the public booking sites", async () => {
    globalThis.fetch = vi.fn();

    const response = await worker.fetch(
      new Request("https://chat.thonbecker.biz/chat", {
        method: "POST",
        headers: { Origin: "https://attacker.example", "CF-Connecting-IP": "test-origin" },
        body: JSON.stringify({ message: "What is available?" }),
      }),
      { BOOKING_AVAILABILITY_URL: availabilityUrl },
    );

    expect(response.status).toBe(403);
    await expect(response.json()).resolves.toEqual({ error: "Origin not allowed" });
    expect(globalThis.fetch).not.toHaveBeenCalled();
  });

  it("does not expose malformed slots returned by the AI response", async () => {
    globalThis.fetch = vi
      .fn()
      .mockResolvedValue(
        new Response(JSON.stringify({ slots: [{ start: "2026-10-05T15:00:00-05:00", end: "2026-10-05T15:30:00-05:00" }] })),
      );
    const ai = {
      run: vi.fn().mockResolvedValue({
        response: {
          message: "Here are the times:",
          action: "show_availability",
          availableSlots: [{ start: "not-a-date" }, { start: "2026-10-05T15:00:00-05:00", end: 123 }],
        },
      }),
    };

    const response = await worker.fetch(
      new Request("https://chat.thonbecker.biz/chat", {
        method: "POST",
        headers: { "CF-Connecting-IP": "test-malformed-slots" },
        body: JSON.stringify({ message: "What is available?" }),
      }),
      { AI: ai, BOOKING_AVAILABILITY_URL: availabilityUrl },
    );

    await expect(response.json()).resolves.toEqual({
      message: "Here are the times",
      action: "show_availability",
      availableSlots: [],
    });
  });
});
