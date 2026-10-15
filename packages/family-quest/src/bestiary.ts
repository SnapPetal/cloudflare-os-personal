import { abilityModifier, parseDice } from "./dice";
import type { AttackOption, EnemyBlueprint } from "./encounter";
import { parseEncounterPicks, type EncounterPick } from "./encounter";
import { clipText } from "./text";

export interface AttackStat {
  name: string;
  bonus: number;
  damage: string[];
}

export interface MonsterStat {
  id: string;
  name: string;
  nameKey: string;
  source: "srd" | "homebrew";
  crLabel: string;
  crValue: number;
  xp: number;
  size: string;
  type: string;
  ac: number;
  hp: number;
  hitDice: string;
  dexterity: number;
  attacks: AttackStat[];
  multiattack: string[];
  packTactics: boolean;
  note: string;
}

export interface HomebrewDraft {
  name: string;
  crLabel: string;
  ac: number;
  hp: number;
  dexterity: number;
  attacks: { name: string; bonus: string; damage: string }[];
  multiattack: number;
  note: string;
}

const CR_VALUES: Record<string, number> = {
  "0": 0,
  "1/8": 0.125,
  "1/4": 0.25,
  "1/2": 0.5,
  "1": 1,
  "2": 2,
  "3": 3,
  "4": 4,
  "5": 5,
};

const CR_XP: Record<string, number> = {
  "0": 10,
  "1/8": 25,
  "1/4": 50,
  "1/2": 100,
  "1": 200,
  "2": 450,
  "3": 700,
  "4": 1100,
  "5": 1800,
};

export function challengeCap(level: number, gentle: boolean): number {
  const safe = Math.min(5, Math.max(1, Math.round(level)));
  const gentleCaps = [0, 0.25, 0.5, 1, 2, 2];
  const normalCaps = [0, 0.5, 1, 2, 3, 4];
  return (gentle ? gentleCaps : normalCaps)[safe] ?? 0.25;
}

export function partyLevel(levels: readonly number[]): number {
  if (levels.length === 0) return 1;
  const average = levels.reduce((sum, level) => sum + level, 0) / levels.length;
  return Math.min(5, Math.max(1, Math.round(average)));
}

export function suitableMonsters(catalog: readonly MonsterStat[], maxCr: number, limit = 24): MonsterStat[] {
  const allowed = catalog.filter((monster) => monster.crValue <= maxCr + 0.001);
  const homebrew = allowed.filter((monster) => monster.source === "homebrew");
  const srd = allowed
    .filter((monster) => monster.source === "srd")
    .toSorted((left, right) => right.crValue - left.crValue || left.name.localeCompare(right.name));
  return [...homebrew, ...srd].slice(0, limit);
}

export function materializeEncounter(
  pick: EncounterPick,
  catalog: readonly MonsterStat[],
  maxCr: number,
): { title: string; enemies: EnemyBlueprint[]; loot: string[]; xp: number } | { error: string } {
  const enemies: EnemyBlueprint[] = [];
  let xp = 0;
  const skipped: string[] = [];
  for (const choice of pick.picks) {
    const monster = findMonster(catalog, choice.name);
    if (!monster) {
      skipped.push(choice.name);
      continue;
    }
    if (monster.crValue > maxCr + 0.001) {
      skipped.push(monster.name);
      continue;
    }
    for (let index = 0; index < choice.count; index += 1) {
      if (enemies.length >= 6) break;
      enemies.push(toBlueprint(monster, index));
      xp += monster.xp;
    }
  }
  if (enemies.length === 0) {
    const why = skipped.length > 0 ? ` Not used: ${skipped.join(", ")}.` : "";
    return { error: `Pick a critter from the bestiary that fits this party's level.${why}` };
  }
  return { title: pick.title, enemies, loot: pick.loot, xp: Math.max(1, xp) };
}

export function findMonster(catalog: readonly MonsterStat[], name: string): MonsterStat | null {
  const key = name.trim().toLowerCase().replace(/\s+/g, " ");
  return catalog.find((monster) => monster.nameKey === key || monster.id === key) ?? null;
}

export function toBlueprint(monster: MonsterStat, copy: number): EnemyBlueprint {
  const attacks: AttackOption[] =
    monster.attacks.length > 0
      ? monster.attacks.map((attack) => ({ name: attack.name, bonus: attack.bonus, damage: attack.damage }))
      : [{ name: "Presence", bonus: 0, damage: [] }];
  const first = attacks[0];
  return {
    name: copy === 0 ? monster.name : `${monster.name} ${copy + 1}`,
    hp: monster.hp,
    ac: monster.ac,
    attackBonus: first?.bonus ?? 0,
    damage: first?.damage.join("+") || "0",
    initiativeBonus: abilityModifier(monster.dexterity),
    attacks,
    multiattack: monster.multiattack,
    packTactics: monster.packTactics,
  };
}

export function attackSummary(monster: MonsterStat): string {
  if (monster.attacks.length === 0) return "no weapon attack";
  return monster.attacks
    .map((attack) => `${attack.name} +${attack.bonus} (${attack.damage.join("+") || "no HP damage"})`)
    .join("; ");
}

export function bestiaryPrompt(monsters: readonly MonsterStat[]): string {
  if (monsters.length === 0) return "No critters are available at this party's level.";
  return monsters
    .map((monster) => `${monster.name} | CR ${monster.crLabel} | AC ${monster.ac} | HP ${monster.hp} | ${attackSummary(monster)}`)
    .join("\n");
}

export function readEncounterChoice(raw: unknown): EncounterPick | null {
  return parseEncounterPicks(raw);
}

export function draftHomebrew(form: FormData, id: string): { ok: true; monster: MonsterStat } | { ok: false; error: string } {
  const name = clipText(form.get("name"), 40);
  const crLabel = String(form.get("cr") ?? "1/4");
  if (!name) return { ok: false, error: "Give the critter a name." };
  if (!(crLabel in CR_VALUES)) return { ok: false, error: "Choose a challenge rating from the list." };
  const ac = whole(form.get("ac"), 8, 22);
  const hp = whole(form.get("hp"), 1, 200);
  const dexterity = whole(form.get("dexterity"), 1, 20);
  if (ac === null || hp === null || dexterity === null) {
    return { ok: false, error: "Armor class, hit points, and Dexterity need to be whole numbers in range." };
  }
  const attacks: AttackStat[] = [];
  for (let slot = 1; slot <= 3; slot += 1) {
    const attackName = clipText(form.get(`attack_name_${slot}`), 40);
    const bonusRaw = String(form.get(`attack_bonus_${slot}`) ?? "").trim();
    const damageRaw = String(form.get(`attack_damage_${slot}`) ?? "").trim();
    if (!attackName && !bonusRaw && !damageRaw) continue;
    if (!attackName) return { ok: false, error: "Each attack needs a name." };
    const bonus = Number(bonusRaw);
    if (!Number.isInteger(bonus) || bonus < -2 || bonus > 12) {
      return { ok: false, error: "Attack bonus must be a whole number from -2 to 12." };
    }
    const damage = normalizeDamage(damageRaw);
    if (!damage) return { ok: false, error: `Could not read the damage dice for ${attackName}. Use 1d6+2, or a plain number.` };
    attacks.push({ name: attackName, bonus, damage: damage === "0" ? [] : [damage] });
  }
  if (attacks.length === 0) return { ok: false, error: "Add at least one attack." };
  const swings = whole(form.get("multiattack"), 1, 3) ?? 1;
  const multiattack: string[] = [];
  if (swings > 1) {
    for (let index = 0; index < swings; index += 1) {
      const attack = attacks[index % attacks.length];
      if (attack) multiattack.push(attack.name);
    }
  }
  return {
    ok: true,
    monster: {
      id,
      name,
      nameKey: name.toLowerCase().replace(/\s+/g, " "),
      source: "homebrew",
      crLabel,
      crValue: CR_VALUES[crLabel] ?? 0.25,
      xp: CR_XP[crLabel] ?? 50,
      size: "Medium",
      type: "homebrew",
      ac,
      hp,
      hitDice: "",
      dexterity,
      attacks,
      multiattack,
      packTactics: form.get("pack_tactics") === "yes",
      note: clipText(form.get("note"), 240),
    },
  };
}

export function crOptions(): { label: string; value: string }[] {
  return Object.keys(CR_VALUES).map((label) => ({ label, value: label }));
}

function normalizeDamage(raw: string): string | null {
  const compact = raw.replace(/\s+/g, "");
  if (!compact) return null;
  if (/^\d+$/.test(compact)) {
    const flat = Number(compact);
    return flat >= 0 && flat <= 30 ? String(flat) : null;
  }
  try {
    const parsed = parseDice(compact);
    const modifier = parsed.modifier === 0 ? "" : parsed.modifier > 0 ? `+${parsed.modifier}` : `${parsed.modifier}`;
    return `${parsed.count}d${parsed.sides}${modifier}`;
  } catch {
    return null;
  }
}

function whole(value: unknown, min: number, max: number): number | null {
  const number = typeof value === "string" || typeof value === "number" ? Number(value) : Number.NaN;
  if (!Number.isInteger(number) || number < min || number > max) return null;
  return number;
}
