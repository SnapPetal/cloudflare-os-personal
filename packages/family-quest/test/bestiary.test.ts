import { describe, expect, it } from "vitest";
import { challengeCap, draftHomebrew, materializeEncounter, partyLevel, suitableMonsters, type MonsterStat } from "../src/bestiary";
import { scriptedSource } from "../src/dice";
import { applyEnemyChoice, startEncounter } from "../src/encounter";

function monster(overrides: Partial<MonsterStat> = {}): MonsterStat {
  return {
    id: "goblin",
    name: "Goblin",
    nameKey: "goblin",
    source: "srd",
    crLabel: "1/4",
    crValue: 0.25,
    xp: 50,
    size: "Small",
    type: "humanoid",
    ac: 15,
    hp: 7,
    hitDice: "2d6",
    dexterity: 14,
    attacks: [
      { name: "Scimitar", bonus: 4, damage: ["1d6+2"] },
      { name: "Shortbow", bonus: 4, damage: ["1d6+2"] },
    ],
    multiattack: [],
    packTactics: false,
    note: "",
    ...overrides,
  };
}

describe("bestiary encounters", () => {
  const catalog = [
    monster(),
    monster({
      id: "owlbear",
      name: "Owlbear",
      nameKey: "owlbear",
      crLabel: "3",
      crValue: 3,
      xp: 700,
      ac: 13,
      hp: 59,
      dexterity: 12,
      attacks: [
        { name: "Beak", bonus: 7, damage: ["1d10+5"] },
        { name: "Claws", bonus: 7, damage: ["2d8+5"] },
      ],
      multiattack: ["Beak", "Claws"],
    }),
    monster({
      id: "wolf",
      name: "Wolf",
      nameKey: "wolf",
      xp: 50,
      ac: 13,
      hp: 11,
      attacks: [{ name: "Bite", bonus: 4, damage: ["2d4+2"] }],
      packTactics: true,
    }),
    monster({ id: "ancient-red-dragon", name: "Ancient Red Dragon", nameKey: "ancient red dragon", crLabel: "24", crValue: 24, xp: 62000, hp: 546, ac: 22 }),
  ];

  it("uses the stat block instead of numbers the model invented", () => {
    const built = materializeEncounter(
      { title: "Picnic raid", picks: [{ name: "Goblin", count: 2 }], loot: ["a button"] },
      catalog,
      challengeCap(1, true),
    );
    expect("error" in built).toBe(false);
    if ("error" in built) return;
    expect(built.enemies.map((enemy) => enemy.hp)).toEqual([7, 7]);
    expect(built.enemies[0]?.ac).toBe(15);
    expect(built.enemies[0]?.attacks?.[0]?.damage).toEqual(["1d6+2"]);
    expect(built.xp).toBe(100);
    expect(built.enemies[0]?.initiativeBonus).toBe(2);
  });

  it("refuses a monster above the party's challenge cap", () => {
    const built = materializeEncounter(
      { title: "Too big", picks: [{ name: "Ancient Red Dragon", count: 1 }], loot: [] },
      catalog,
      challengeCap(partyLevel([1, 1]), true),
    );
    expect(built).toEqual({ error: expect.stringContaining("Ancient Red Dragon") });
  });

  it("suggests homebrew first and keeps high CR out", () => {
    const home = monster({ id: "h-1", name: "Picnic Fox", nameKey: "picnic fox", source: "homebrew", crValue: 0.25 });
    const picks = suitableMonsters([catalog[3]!, home, catalog[0]!], 0.25, 10);
    expect(picks.map((entry) => entry.name)).toEqual(["Picnic Fox", "Goblin"]);
  });

  it("rolls the owlbear's real multiattack and the wolf's pack tactics", () => {
    const owlbear = materializeEncounter({ title: "Beak", picks: [{ name: "Owlbear", count: 1 }], loot: [] }, catalog, 3);
    if ("error" in owlbear) throw new Error(owlbear.error);
    const started = startEncounter({
      title: owlbear.title,
      party: [{ id: "maya", name: "Maya", hp: 30, maxHp: 30, ac: 10, dexterity: 10, attackBonus: 2, damage: "1d6", heal: null }],
      enemies: owlbear.enemies,
      loot: [],
      xp: owlbear.xp,
      random: scriptedSource([0, 10]),
    });
    const beaten = applyEnemyChoice(started, { action: "attack", targetId: "maya", flavor: "It snuffles." }, scriptedSource([15, 4, 15, 6]));
    const hits = beaten.state.log.filter((entry) => entry.text.includes("Hit."));
    expect(hits.some((entry) => entry.text.includes("Beak"))).toBe(true);
    expect(hits.some((entry) => entry.text.includes("Claws"))).toBe(true);
    expect(beaten.state.combatants.find((combatant) => combatant.id === "maya")?.hp).toBeLessThan(30);

    const wolves = materializeEncounter({ title: "Woods", picks: [{ name: "Wolf", count: 2 }], loot: [] }, catalog, 1);
    if ("error" in wolves) throw new Error(wolves.error);
    const pack = startEncounter({
      title: "Woods",
      party: [{ id: "maya", name: "Maya", hp: 20, maxHp: 20, ac: 18, dexterity: 10, attackBonus: 2, damage: "1d6", heal: null }],
      enemies: wolves.enemies,
      loot: [],
      xp: wolves.xp,
      random: scriptedSource([0, 1, 2]),
    });
    const swing = applyEnemyChoice(pack, { action: "attack", targetId: "maya", flavor: "" }, scriptedSource([19, 1]));
    expect(swing.state.log.some((entry) => entry.text.includes("1d20+4 adv"))).toBe(true);
  });

  it("builds a family critter from the form", () => {
    const form = new FormData();
    form.set("name", "Picnic Fox");
    form.set("cr", "1/4");
    form.set("ac", "13");
    form.set("hp", "9");
    form.set("dexterity", "16");
    form.set("attack_name_1", "Nip");
    form.set("attack_bonus_1", "4");
    form.set("attack_damage_1", "1d4+2");
    form.set("multiattack", "1");
    form.set("note", "Steals sandwiches, never bites hard.");
    const drafted = draftHomebrew(form, "h-1");
    expect(drafted.ok).toBe(true);
    if (!drafted.ok) return;
    expect(drafted.monster.hp).toBe(9);
    expect(drafted.monster.attacks[0]?.damage).toEqual(["1d4+2"]);
    expect(drafted.monster.xp).toBe(50);
  });
});
