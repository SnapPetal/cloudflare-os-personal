import { describe, expect, it } from "vitest";
import { attackBonusFor, buildQuickParty, damageFor, levelUpReady, leveledSheet } from "../src/classes";
import { scriptedSource } from "../src/dice";
import {
  applyEnemyChoice,
  applyPlayerAction,
  currentCombatant,
  dismissEncounter,
  parseEnemyChoice,
  parseEncounterPicks,
  shareXp,
  startEncounter,
  type EnemyBlueprint,
  type PartyFighter,
} from "../src/encounter";

function hero(overrides: Partial<PartyFighter> = {}): PartyFighter {
  return {
    id: "maya",
    name: "Maya",
    hp: 10,
    maxHp: 10,
    ac: 12,
    dexterity: 10,
    attackBonus: 2,
    damage: "1d6+1",
    heal: null,
    ...overrides,
  };
}

function sprite(overrides: Partial<EnemyBlueprint> = {}): EnemyBlueprint {
  return {
    name: "Sprite",
    hp: 8,
    ac: 10,
    attackBonus: 2,
    damage: "1d4",
    initiativeBonus: 0,
    ...overrides,
  };
}

describe("encounter engine", () => {
  it("orders initiative and logs the dice", () => {
    const state = startEncounter({
      title: "Garden",
      party: [hero(), hero({ id: "leo", name: "Leo" })],
      enemies: [sprite()],
      loot: [],
      xp: 20,
      random: scriptedSource([18, 4, 9]),
    });
    expect(state.order).toEqual(["maya", "enemy-1", "leo"]);
    expect(state.log[0]?.text).toContain("d20 (19)");
    expect(currentCombatant(state)?.name).toBe("Maya");
  });

  it("breaks initiative ties by bonus, then name", () => {
    const state = startEncounter({
      title: "Tie",
      party: [hero({ name: "Zoe", dexterity: 14 }), hero({ id: "acorn", name: "Acorn", dexterity: 14 })],
      enemies: [sprite()],
      loot: [],
      xp: 10,
      random: scriptedSource([8, 8, 0]),
    });
    expect(state.order.slice(0, 2)).toEqual(["acorn", "maya"]);
  });

  it("hits, misses, and refuses a natural 1", () => {
    const hit = applyPlayerAction(
      startEncounter({
        title: "Hit",
        party: [hero()],
        enemies: [sprite()],
        loot: [],
        xp: 10,
        random: scriptedSource([9, 0]),
      }),
      { type: "attack", actorId: "maya", targetId: "enemy-1" },
      scriptedSource([9, 2]),
    );
    expect(hit.error).toBeNull();
    expect(hit.state.combatants.find((combatant) => combatant.id === "enemy-1")?.hp).toBe(4);
    expect(hit.state.log.some((entry) => entry.text.includes("Hit."))).toBe(true);

    const miss = applyPlayerAction(
      startEncounter({
        title: "Miss",
        party: [hero()],
        enemies: [sprite({ ac: 18 })],
        loot: [],
        xp: 10,
        random: scriptedSource([9, 0]),
      }),
      { type: "attack", actorId: "maya", targetId: "enemy-1" },
      scriptedSource([9]),
    );
    expect(miss.state.log.some((entry) => entry.text.includes("Miss."))).toBe(true);
    expect(miss.state.combatants.find((combatant) => combatant.id === "enemy-1")?.hp).toBe(8);

    const fumble = applyPlayerAction(
      startEncounter({
        title: "Fumble",
        party: [hero({ attackBonus: 10 })],
        enemies: [sprite({ ac: 5 })],
        loot: [],
        xp: 10,
        random: scriptedSource([15, 0]),
      }),
      { type: "attack", actorId: "maya", targetId: "enemy-1" },
      scriptedSource([0]),
    );
    expect(fumble.state.log.some((entry) => entry.text.includes("Miss."))).toBe(true);
  });

  it("doubles the damage dice on a critical hit and never drops HP below zero", () => {
    const state = applyPlayerAction(
      startEncounter({
        title: "Crit",
        party: [hero()],
        enemies: [sprite({ hp: 3 })],
        loot: ["ribbon"],
        xp: 25,
        random: scriptedSource([19, 0]),
      }),
      { type: "attack", actorId: "maya", targetId: "enemy-1" },
      scriptedSource([19, 3, 1]),
    ).state;
    expect(state.log.some((entry) => entry.text.includes("2d6+1"))).toBe(true);
    expect(state.log.some((entry) => entry.text.includes("Critical hit"))).toBe(true);
    expect(state.combatants.find((combatant) => combatant.id === "enemy-1")?.hp).toBe(0);
    expect(state.status).toBe("victory");
    expect(state.xpAwarded).toBe(25);
    expect(state.log.some((entry) => entry.text.includes("ribbon"))).toBe(true);
  });

  it("gives disadvantage after dodge and advantage after help", () => {
    const dodged = applyPlayerAction(
      startEncounter({
        title: "Dodge",
        party: [hero({ ac: 12 })],
        enemies: [sprite({ attackBonus: 2, damage: "1d4" })],
        loot: [],
        xp: 10,
        random: scriptedSource([18, 0]),
      }),
      { type: "dodge", actorId: "maya" },
      scriptedSource([]),
    ).state;
    const enemyTurn = applyEnemyChoice(dodged, { action: "attack", targetId: "maya", flavor: "" }, scriptedSource([19, 1]));
    expect(enemyTurn.state.log.some((entry) => entry.text.includes("1d20+2 dis"))).toBe(true);
    expect(enemyTurn.state.combatants.find((combatant) => combatant.id === "maya")?.hp).toBe(10);

    const started = startEncounter({
      title: "Help",
      party: [hero({ id: "a", name: "Ada" }), hero({ id: "b", name: "Bo", damage: "1d6+1" })],
      enemies: [sprite({ hp: 20 })],
      loot: [],
      xp: 10,
      random: scriptedSource([17, 14, 0]),
    });
    const helped = applyPlayerAction(started, { type: "help", actorId: "a", targetId: "b" }, scriptedSource([])).state;
    const attack = applyPlayerAction(helped, { type: "attack", actorId: "b", targetId: "enemy-1" }, scriptedSource([10, 4, 2]));
    expect(attack.state.log.some((entry) => entry.text.includes("1d20+2 adv"))).toBe(true);
    expect(attack.state.combatants.find((combatant) => combatant.id === "b")?.conditions).not.toContain("helped");
  });

  it("skips knocked-out critters and ends in victory, defeat, or flight", () => {
    const started = startEncounter({
      title: "Skip",
      party: [hero({ attackBonus: 5 })],
      enemies: [sprite({ name: "One", hp: 1 }), sprite({ name: "Two", hp: 6 })],
      loot: [],
      xp: 20,
      random: scriptedSource([17, 9, 4]),
    });
    const next = applyPlayerAction(started, { type: "attack", actorId: "maya", targetId: "enemy-1" }, scriptedSource([9, 0])).state;
    expect(next.status).toBe("active");
    expect(currentCombatant(next)?.id).toBe("enemy-2");

    const fled = applyEnemyChoice(
      startEncounter({
        title: "Half",
        party: [hero()],
        enemies: [sprite()],
        loot: ["pebble"],
        xp: 25,
        random: scriptedSource([0, 10]),
      }),
      { action: "flee", targetId: "", flavor: "The sprite waves and leaves." },
      scriptedSource([]),
    ).state;
    expect(fled.status).toBe("victory");
    expect(fled.xpAwarded).toBe(12);

    const defeat = applyEnemyChoice(
      startEncounter({
        title: "Nap",
        party: [hero({ hp: 4, ac: 10 })],
        enemies: [sprite({ attackBonus: 4, damage: "1d6+1" })],
        loot: [],
        xp: 10,
        random: scriptedSource([0, 19]),
      }),
      { action: "attack", targetId: "maya", flavor: "" },
      scriptedSource([10, 5]),
    ).state;
    expect(defeat.status).toBe("defeat");
    expect(defeat.combatants.find((combatant) => combatant.id === "maya")?.hp).toBe(1);
    expect(defeat.note).toContain("safe");

    const escape = applyPlayerAction(
      startEncounter({
        title: "Leave",
        party: [hero()],
        enemies: [sprite()],
        loot: [],
        xp: 10,
        random: scriptedSource([18, 0]),
      }),
      { type: "flee", actorId: "maya" },
      scriptedSource([14]),
    ).state;
    expect(escape.status).toBe("fled");
    expect(escape.xpAwarded).toBe(0);
  });

  it("uses the critter's stored math when the model picks a target", () => {
    const started = startEncounter({
      title: "Math",
      party: [hero({ ac: 18 })],
      enemies: [sprite({ attackBonus: 0 })],
      loot: [],
      xp: 10,
      random: scriptedSource([0, 12]),
    });
    const choice = parseEnemyChoice({ action: "bonk", targetId: "nope", flavor: "A gentle bump." });
    expect(choice.action).toBe("attack");
    const result = applyEnemyChoice(started, choice, scriptedSource([5]));
    expect(result.state.log.some((entry) => entry.text.includes("Miss."))).toBe(true);
    expect(result.state.combatants.find((combatant) => combatant.id === "maya")?.hp).toBe(10);
  });

  it("reads monster names from a proposal and ignores invented stats", () => {
    const proposal = parseEncounterPicks({
      title: "Too many",
      xp: 5000,
      monsters: [
        { name: "Goblin", count: 2, hp: 999, ac: 3, damage: "9d20+99" },
        { name: "Wolf", count: 9 },
        { name: "Boar" },
        { name: "Owl" },
      ],
      loot: ["a", "b", "c", "d", "e"],
    });
    expect(proposal?.picks.map((pick) => `${pick.name}:${pick.count}`)).toEqual(["Goblin:2", "Wolf:4"]);
    expect(proposal?.loot).toHaveLength(4);
    expect(proposal?.picks.some((pick) => "hp" in pick)).toBe(false);
    expect(parseEncounterPicks({ enemies: [] })).toBeNull();
    expect(parseEncounterPicks({ enemies: [{ name: "Goblin", hp: 4 }] })?.picks[0]?.name).toBe("Goblin");
  });

  it("shares XP, levels a hero, and can dismiss a finished scene", () => {
    expect(shareXp(3, 10)).toEqual([4, 3, 3]);
    expect(shareXp(0, 10)).toEqual([]);
    expect(levelUpReady(1, 100)).toBe(true);
    expect(levelUpReady(1, 99)).toBe(false);
    expect(levelUpReady(5, 1000)).toBe(false);
    expect(leveledSheet(1, 8, 8, 6)).toEqual({ level: 2, hp: 14, maxHp: 14 });
    expect(attackBonusFor(1, 15)).toBe(4);
    expect(damageFor("1d8", 15)).toBe("1d8+2");
    const party = buildQuickParty(["Maya", "Leo", "Sam"]);
    expect(party.ok).toBe(true);
    if (party.ok) expect(new Set(party.party.map((member) => member.classId)).size).toBe(3);
    const state = dismissEncounter(
      startEncounter({
        title: "Done",
        party: [hero()],
        enemies: [sprite()],
        loot: [],
        xp: 10,
        random: scriptedSource([1, 0]),
      }),
    );
    expect(state.dismissed).toBe(true);
  });

  it("rejects a turn taken out of order", () => {
    const started = startEncounter({
      title: "Order",
      party: [hero(), hero({ id: "leo", name: "Leo" })],
      enemies: [sprite()],
      loot: [],
      xp: 10,
      random: scriptedSource([18, 1, 0]),
    });
    const result = applyPlayerAction(started, { type: "dodge", actorId: "leo" }, scriptedSource([]));
    expect(result.error).toMatch(/not that hero/);
    expect(result.state.log).toEqual(started.log);
  });
});
