export const DEFAULT_DAILY_CAP = 40;

export interface CapResult {
  day: string;
  cap: number;
  used: number;
  remaining: number;
  allowed: boolean;
}

export interface UsageStore {
  consume(day: string, cap: number): Promise<CapResult>;
}

export function utcDay(now: Date): string {
  return now.toISOString().slice(0, 10);
}

export function readCap(raw: string | undefined): number {
  try {
    return parseCap(raw);
  } catch (error) {
    const message = error instanceof Error ? error.message : "bad cap";
    console.error(JSON.stringify({ event: "bad_cap", error: message }));
    return DEFAULT_DAILY_CAP;
  }
}

export function parseCap(raw: string | undefined, fallback = DEFAULT_DAILY_CAP): number {
  if (raw === undefined || raw.trim() === "") return fallback;
  const cap = Number(raw);
  if (!Number.isInteger(cap) || cap < 0 || cap > 10_000) {
    throw new Error("AI_DAILY_CAP must be a whole number from 0 to 10000.");
  }
  return cap;
}

/**
 * One step of the daily cap. A call is allowed only when `used < cap`.
 * The commit callback runs only for an allowed call.
 */
export function consumeCount(
  used: number,
  cap: number,
  day: string,
  commit: (next: number) => void,
): CapResult {
  if (!Number.isInteger(used) || used < 0) {
    throw new Error("Usage count is invalid.");
  }
  if (!Number.isInteger(cap) || cap < 0) {
    throw new Error("Cap is invalid.");
  }
  if (used >= cap) {
    return { day, cap, used, remaining: 0, allowed: false };
  }
  const next = used + 1;
  commit(next);
  return { day, cap, used: next, remaining: Math.max(0, cap - next), allowed: true };
}

export class MemoryUsageStore implements UsageStore {
  readonly counts = new Map<string, number>();

  async consume(day: string, cap: number): Promise<CapResult> {
    return consumeCount(this.counts.get(day) ?? 0, cap, day, (next) => {
      this.counts.set(day, next);
    });
  }
}

export async function tryConsumeAiCall(store: UsageStore, cap: number, now: Date): Promise<CapResult> {
  return store.consume(utcDay(now), cap);
}

export function capMessage(cap: number): string {
  return `The storybook is resting for today. Family Quest has used all ${cap} free Dungeon Master turns. Dice, character sheets, and saved chapters still work. New chapters open again after midnight UTC.`;
}
