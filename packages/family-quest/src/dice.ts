export const DICE = [4, 6, 8, 10, 12, 20] as const;
export type Die = (typeof DICE)[number];
export type RollMode = "normal" | "advantage" | "disadvantage";

export interface RandomSource {
  uint32(): number;
}

export interface DiceRollRequest {
  count: number;
  sides: number;
  modifier: number;
  mode: RollMode;
}

export interface DiceRoll {
  notation: string;
  rolls: number[];
  kept: number[];
  dropped: number[];
  modifier: number;
  total: number;
  mode: RollMode;
  natural: number | null;
  critical: boolean;
  fumble: boolean;
}

export interface ParsedDice {
  count: number;
  sides: Die;
  modifier: number;
}

const COUNT_MAX = 20;
const MOD_MAX = 30;

export function cryptoRandomSource(): RandomSource {
  return {
    uint32(): number {
      const buffer = new Uint32Array(1);
      crypto.getRandomValues(buffer);
      return buffer[0] ?? 0;
    },
  };
}

export function scriptedSource(values: readonly number[]): RandomSource {
  let index = 0;
  return {
    uint32(): number {
      const value = values[index] ?? 0;
      index += 1;
      return value >>> 0;
    },
  };
}

/** Inclusive 1..sides, with rejection sampling so the result is unbiased. */
export function rollDie(sides: number, random: RandomSource): number {
  if (!Number.isInteger(sides) || sides < 2 || sides > 1_000) {
    throw new Error(`Unsupported die: d${sides}`);
  }
  const span = 0x1_0000_0000;
  const limit = Math.floor(span / sides) * sides;
  let value = random.uint32() >>> 0;
  while (value >= limit) {
    value = random.uint32() >>> 0;
  }
  return (value % sides) + 1;
}

export function rollDice(request: DiceRollRequest, random: RandomSource): DiceRoll {
  const { count, sides, modifier, mode } = request;
  if (!Number.isInteger(count) || count < 1 || count > COUNT_MAX) {
    throw new Error("Dice count must be from 1 to 20.");
  }
  if (!Number.isInteger(sides) || !isDie(sides)) {
    throw new Error("Use a d4, d6, d8, d10, d12, or d20.");
  }
  if (!Number.isInteger(modifier) || modifier < -MOD_MAX || modifier > MOD_MAX) {
    throw new Error("Modifier must be from -30 to 30.");
  }
  if (mode !== "normal" && mode !== "advantage" && mode !== "disadvantage") {
    throw new Error("Unknown roll mode.");
  }
  if (mode !== "normal" && !(count === 1 && sides === 20)) {
    throw new Error("Advantage and disadvantage are only for a single d20.");
  }

  const draws = mode === "normal" ? count : 2;
  const rolls: number[] = [];
  for (let index = 0; index < draws; index += 1) {
    rolls.push(rollDie(sides, random));
  }

  let kept: number[];
  let dropped: number[];
  if (mode === "advantage") {
    const high = Math.max(...rolls);
    const low = Math.min(...rolls);
    kept = [high];
    dropped = high === low ? [] : [low];
  } else if (mode === "disadvantage") {
    const low = Math.min(...rolls);
    const high = Math.max(...rolls);
    kept = [low];
    dropped = high === low ? [] : [high];
  } else {
    kept = [...rolls];
    dropped = [];
  }

  const subtotal = kept.reduce((sum, face) => sum + face, 0);
  const natural = count === 1 && sides === 20 ? (kept[0] ?? null) : null;
  return {
    notation: formatNotation(count, sides, modifier, mode),
    rolls,
    kept,
    dropped,
    modifier,
    total: subtotal + modifier,
    mode,
    natural,
    critical: natural === 20,
    fumble: natural === 1,
  };
}

export function parseDice(expression: string): ParsedDice {
  const compact = expression.trim().replace(/\s+/g, "");
  const match = /^(\d*)d(\d+)([+-]\d+)?$/i.exec(compact);
  if (!match) {
    throw new Error(`Could not read dice expression "${expression}".`);
  }
  const count = match[1] ? Number(match[1]) : 1;
  const sides = Number(match[2]);
  const modifier = match[3] ? Number(match[3]) : 0;
  if (!Number.isInteger(count) || count < 1 || count > COUNT_MAX) {
    throw new Error("Dice count must be from 1 to 20.");
  }
  if (!isDie(sides)) {
    throw new Error("Use a d4, d6, d8, d10, d12, or d20.");
  }
  if (!Number.isInteger(modifier) || modifier < -MOD_MAX || modifier > MOD_MAX) {
    throw new Error("Modifier must be from -30 to 30.");
  }
  return { count, sides, modifier };
}

export function rollExpression(expression: string, random: RandomSource, mode: RollMode = "normal"): DiceRoll {
  const parsed = parseDice(expression);
  return rollDice({ ...parsed, mode }, random);
}

export function critExpression(expression: string): string {
  const parsed = parseDice(expression);
  return formatNotation(parsed.count * 2, parsed.sides, parsed.modifier, "normal");
}

export function rollDamage(
  parts: readonly string[],
  random: RandomSource,
  critical: boolean,
): { total: number; text: string } {
  let total = 0;
  const notes: string[] = [];
  for (const part of parts) {
    if (/^\d+$/.test(part)) {
      const flat = Number(part);
      total += flat;
      notes.push(String(flat));
      continue;
    }
    const expression = critical ? critExpression(part) : part;
    const roll = rollExpression(expression, random);
    total += roll.total;
    notes.push(describeRoll(roll));
  }
  return { total, text: notes.join(" + ") };
}

export function formatNotation(count: number, sides: number, modifier: number, mode: RollMode): string {
  const base = `${count}d${sides}`;
  const mod = modifier === 0 ? "" : modifier > 0 ? `+${modifier}` : `${modifier}`;
  const flag = mode === "advantage" ? " adv" : mode === "disadvantage" ? " dis" : "";
  return `${base}${mod}${flag}`;
}

export function describeRoll(roll: DiceRoll): string {
  const faces = roll.rolls.join(", ");
  const kept = roll.dropped.length > 0 ? ` Keeps ${roll.kept.join(", ")}.` : "";
  return `${roll.notation}: [${faces}].${kept} Total ${roll.total}.`;
}

export function abilityModifier(score: number): number {
  if (!Number.isInteger(score)) {
    throw new Error("Ability score must be a whole number.");
  }
  return Math.floor((score - 10) / 2);
}

function isDie(sides: number): sides is Die {
  return DICE.some((die) => die === sides);
}
