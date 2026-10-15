import { abilityModifier } from "./dice";
import { clipText } from "./text";

export type Ability = "strength" | "dexterity" | "constitution" | "intelligence" | "wisdom" | "charisma";

export interface ClassDef {
  id: string;
  name: string;
  blurb: string;
  primary: Ability;
  order: Ability[];
  hp: number;
  ac: number;
  hitDie: number;
  damage: string;
  heal: string | null;
  inventory: string;
  portrait: string;
}

export interface DraftCharacter {
  name: string;
  classId: string;
  className: string;
  ancestry: string;
  level: number;
  hp: number;
  maxHp: number;
  ac: number;
  strength: number;
  dexterity: number;
  constitution: number;
  intelligence: number;
  wisdom: number;
  charisma: number;
  inventory: string;
  portrait: string;
  hitDie: number;
  damage: string;
  heal: string | null;
}

export interface PartyResult {
  ok: true;
  party: DraftCharacter[];
}

export interface PartyError {
  ok: false;
  error: string;
}

export const ANCESTRIES = ["Human", "Elf", "Dwarf", "Halfling", "Gnome", "Dragonkin", "Catfolk", "Owlfolk"] as const;

export const CLASSES: ClassDef[] = [
  {
    id: "knight",
    name: "Brave Knight",
    blurb: "A kind protector with a wooden shield and a practice sword.",
    primary: "strength",
    order: ["strength", "constitution", "wisdom", "charisma", "dexterity", "intelligence"],
    hp: 12,
    ac: 16,
    hitDie: 10,
    damage: "1d8",
    heal: null,
    inventory: "Practice sword, star shield, snack tin, bandage roll",
    portrait: "stands tall in a bright cloak with a shield painted like a star",
  },
  {
    id: "ranger",
    name: "Forest Ranger",
    blurb: "A careful explorer who talks to trails, birds, and weather.",
    primary: "dexterity",
    order: ["dexterity", "wisdom", "constitution", "strength", "intelligence", "charisma"],
    hp: 10,
    ac: 14,
    hitDie: 8,
    damage: "1d8",
    heal: null,
    inventory: "Short bow, leaf cloak, trail map, jar of honey",
    portrait: "wears a leaf-green hood and carries a bow carved with vines",
  },
  {
    id: "healer",
    name: "Kind Healer",
    blurb: "A gentle mender whose magic looks like warm light.",
    primary: "wisdom",
    order: ["wisdom", "charisma", "constitution", "intelligence", "dexterity", "strength"],
    hp: 8,
    ac: 12,
    hitDie: 8,
    damage: "1d6",
    heal: "1d8",
    inventory: "Soft staff, herb pouch, blanket, bell on a ribbon",
    portrait: "has a calm smile, a bell on a ribbon, and pockets full of herbs",
  },
  {
    id: "wizard",
    name: "Spark Wizard",
    blurb: "A student of glittery, harmless magic and good questions.",
    primary: "intelligence",
    order: ["intelligence", "wisdom", "constitution", "charisma", "dexterity", "strength"],
    hp: 8,
    ac: 12,
    hitDie: 6,
    damage: "1d8",
    heal: null,
    inventory: "Spark wand, tiny spellbook, chalk, lucky pebble",
    portrait: "wears a starry hat a size too big and a wand that sneezes sparks",
  },
  {
    id: "scout",
    name: "Sneaky Scout",
    blurb: "A quiet friend who notices footprints, whispers, and loose floorboards.",
    primary: "dexterity",
    order: ["dexterity", "charisma", "wisdom", "intelligence", "constitution", "strength"],
    hp: 9,
    ac: 13,
    hitDie: 8,
    damage: "1d6",
    heal: null,
    inventory: "Soft boots, loop of string, pocket mirror, cinnamon stick",
    portrait: "moves quietly in soft boots with a pocket mirror on a cord",
  },
  {
    id: "bard",
    name: "Story Bard",
    blurb: "A singer of brave songs who can talk almost anyone into a smile.",
    primary: "charisma",
    order: ["charisma", "dexterity", "wisdom", "intelligence", "constitution", "strength"],
    hp: 9,
    ac: 13,
    hitDie: 8,
    damage: "1d6",
    heal: null,
    inventory: "Travel lute, songbook, ribbon, spare string",
    portrait: "carries a small lute and a ribbon tied around one wrist",
  },
  {
    id: "friend",
    name: "Animal Friend",
    blurb: "A patient neighbor to foxes, owls, and any creature having a bad day.",
    primary: "wisdom",
    order: ["wisdom", "charisma", "dexterity", "constitution", "intelligence", "strength"],
    hp: 10,
    ac: 13,
    hitDie: 8,
    damage: "1d6",
    heal: "1d6",
    inventory: "Seed pouch, wool scarf, wooden whistle, apple",
    portrait: "wears a wool scarf that several birds seem to approve of",
  },
  {
    id: "inventor",
    name: "Gadget Inventor",
    blurb: "A builder of kind contraptions: nets, lights, and very polite springs.",
    primary: "intelligence",
    order: ["intelligence", "dexterity", "constitution", "wisdom", "charisma", "strength"],
    hp: 9,
    ac: 13,
    hitDie: 8,
    damage: "1d6",
    heal: null,
    inventory: "Spring launcher, glow jar, tape, spare gear",
    portrait: "has goggles on their forehead and a glow jar clipped to a belt",
  },
];

const STANDARD_ARRAY = [15, 14, 13, 12, 10, 8] as const;

export const PREMISES = [
  {
    id: "picnic",
    title: "The Lost Picnic",
    text: "A friendly fox borrowed the family's picnic basket and trotted into the Whispering Woods. The fox is not mean, just proud of a very good sandwich plan. The woods are sunny, full of talking birds, and a little turned around.",
  },
  {
    id: "dragon",
    title: "The Birthday Dragon",
    text: "A small dragon is planning a birthday surprise for the village and has accidentally stacked the presents, the cake, and three laundry lines into one wobbly tower. The dragon wants help, applause, and absolutely no popping balloons near the cake.",
  },
  {
    id: "library",
    title: "The Library of Living Books",
    text: "At the town library, picture-book characters climbed out of their pages to stretch their legs. They are polite and lost. The librarian asked the party to guide each story home before bedtime, without tearing a single page.",
  },
  {
    id: "bridge",
    title: "Rainbow Bridge Repair",
    text: "The colors slipped off the Rainbow Bridge and wandered into the meadow as shy, giggling ribbons. The animal villagers can still cross on the gray stones, but they miss the colors. The ribbons will come back if someone plays, listens, and asks nicely.",
  },
] as const;

export function classById(id: string): ClassDef {
  return CLASSES.find((entry) => entry.id === id) ?? CLASSES[0]!;
}

export function attackBonusFor(level: number, primaryScore: number): number {
  const proficiency = level >= 5 ? 3 : 2;
  return proficiency + Math.max(0, abilityModifier(primaryScore));
}

export function damageFor(base: string, primaryScore: number): string {
  const modifier = Math.max(0, abilityModifier(primaryScore));
  return modifier === 0 ? base : `${base}+${modifier}`;
}

export function healFor(base: string | null, wisdom: number): string | null {
  if (!base) return null;
  const modifier = Math.max(0, abilityModifier(wisdom));
  return modifier === 0 ? base : `${base}+${modifier}`;
}

export function levelUpReady(level: number, xp: number): boolean {
  return level < 5 && xp >= level * 100;
}

export function leveledSheet(
  level: number,
  hp: number,
  maxHp: number,
  hitDie: number,
): { level: number; hp: number; maxHp: number } {
  return { level: level + 1, maxHp: maxHp + hitDie, hp: hp + hitDie };
}

export function buildQuickParty(rawNames: string[]): PartyResult | PartyError {
  const names = rawNames.map((name) => clipText(name, 24)).filter(Boolean);
  if (names.length < 1) return { ok: false, error: "Add at least one name." };
  if (names.length > 4) return { ok: false, error: "A party can have up to four heroes." };
  const party = names.map((name, index) => draftFrom(name, CLASSES[index % CLASSES.length]!.id, ANCESTRIES[index % ANCESTRIES.length]!));
  return { ok: true, party };
}

export function buildCustomParty(
  rows: { name: string; classId: string; ancestry: string }[],
): PartyResult | PartyError {
  const party: DraftCharacter[] = [];
  for (const row of rows) {
    const name = clipText(row.name, 24);
    if (!name) continue;
    const ancestry = ANCESTRIES.includes(row.ancestry as (typeof ANCESTRIES)[number]) ? row.ancestry : "Human";
    party.push(draftFrom(name, row.classId, ancestry));
  }
  if (party.length < 1) return { ok: false, error: "Add at least one hero." };
  if (party.length > 4) return { ok: false, error: "A party can have up to four heroes." };
  return { ok: true, party };
}

function draftFrom(name: string, classId: string, ancestry: string): DraftCharacter {
  const heroClass = classById(classId);
  const scores = assignScores(heroClass.order);
  const primary = scores[heroClass.primary];
  return {
    name,
    classId: heroClass.id,
    className: heroClass.name,
    ancestry,
    level: 1,
    hp: heroClass.hp,
    maxHp: heroClass.hp,
    ac: heroClass.ac,
    strength: scores.strength,
    dexterity: scores.dexterity,
    constitution: scores.constitution,
    intelligence: scores.intelligence,
    wisdom: scores.wisdom,
    charisma: scores.charisma,
    inventory: heroClass.inventory,
    portrait: `${name} is a ${ancestry.toLowerCase()} ${heroClass.name} who ${heroClass.portrait}.`,
    hitDie: heroClass.hitDie,
    damage: damageFor(heroClass.damage, primary),
    heal: healFor(heroClass.heal, scores.wisdom),
  };
}

function assignScores(order: Ability[]): Record<Ability, number> {
  const scores = {
    strength: 10,
    dexterity: 10,
    constitution: 10,
    intelligence: 10,
    wisdom: 10,
    charisma: 10,
  };
  order.forEach((ability, index) => {
    scores[ability] = STANDARD_ARRAY[index] ?? 10;
  });
  return scores;
}
