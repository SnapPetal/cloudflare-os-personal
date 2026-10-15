import { abilityModifier, describeRoll, rollDamage, rollDie, rollExpression, type RandomSource } from "./dice";
import { clipText } from "./text";

export type Side = "party" | "enemy";
export type EncounterStatus = "active" | "victory" | "defeat" | "fled";
export type Condition = "dodging" | "helped" | "frightened";

export interface AttackOption {
  name: string;
  bonus: number;
  damage: string[];
}

export interface Combatant {
  id: string;
  name: string;
  side: Side;
  hp: number;
  maxHp: number;
  ac: number;
  initiative: number;
  initiativeBonus: number;
  attackBonus: number;
  damage: string;
  attacks: AttackOption[];
  multiattack: string[];
  packTactics: boolean;
  heal: string | null;
  conditions: Condition[];
  out: "none" | "down" | "fled";
  dexMod: number;
  characterId?: string;
}

export interface LogEntry {
  text: string;
}

export interface EncounterState {
  title: string;
  round: number;
  turnIndex: number;
  order: string[];
  combatants: Combatant[];
  log: LogEntry[];
  status: EncounterStatus;
  loot: string[];
  xp: number;
  xpAwarded: number;
  note: string;
  dismissed: boolean;
}

export interface PartyFighter {
  id: string;
  name: string;
  hp: number;
  maxHp: number;
  ac: number;
  dexterity: number;
  attackBonus: number;
  damage: string;
  heal: string | null;
}

export interface EnemyBlueprint {
  name: string;
  hp: number;
  ac: number;
  attackBonus: number;
  damage: string;
  initiativeBonus: number;
  attacks?: AttackOption[];
  multiattack?: string[];
  packTactics?: boolean;
}

export type PlayerAction =
  | { type: "attack"; actorId: string; targetId: string }
  | { type: "dodge"; actorId: string }
  | { type: "help"; actorId: string; targetId: string }
  | { type: "heal"; actorId: string; targetId: string }
  | { type: "flee"; actorId: string };

export interface ActionResult {
  state: EncounterState;
  error: string | null;
}

export interface EnemyChoice {
  action: "attack" | "dodge" | "help" | "flee";
  targetId: string;
  flavor: string;
}

export function startEncounter(input: {
  title: string;
  party: PartyFighter[];
  enemies: EnemyBlueprint[];
  loot: string[];
  xp: number;
  random: RandomSource;
}): EncounterState {
  if (input.party.length < 1) throw new Error("A quest needs at least one hero.");
  if (input.enemies.length < 1) throw new Error("A challenge needs at least one critter.");

  const seen = new Set<string>();
  const combatants: Combatant[] = [];
  for (const hero of input.party) {
    if (seen.has(hero.id)) throw new Error("Duplicate hero id.");
    seen.add(hero.id);
    const bonus = abilityModifier(hero.dexterity);
    const face = rollDie(20, input.random);
    combatants.push({
      id: hero.id,
      name: hero.name,
      side: "party",
      hp: Math.max(0, hero.hp),
      maxHp: Math.max(1, hero.maxHp),
      ac: hero.ac,
      initiative: face + bonus,
      initiativeBonus: bonus,
      attackBonus: hero.attackBonus,
      damage: hero.damage,
      attacks: [{ name: "Attack", bonus: hero.attackBonus, damage: [hero.damage] }],
      multiattack: [],
      packTactics: false,
      heal: hero.heal,
      conditions: [],
      out: hero.hp > 0 ? "none" : "down",
      dexMod: bonus,
      characterId: hero.id,
    });
  }

  input.enemies.forEach((enemy, index) => {
    const face = rollDie(20, input.random);
    const attacks =
      enemy.attacks && enemy.attacks.length > 0
        ? enemy.attacks
        : [{ name: "Attack", bonus: enemy.attackBonus, damage: [enemy.damage] }];
    const first = attacks[0];
    combatants.push({
      id: `enemy-${index + 1}`,
      name: enemy.name,
      side: "enemy",
      hp: enemy.hp,
      maxHp: enemy.hp,
      ac: enemy.ac,
      initiative: face + enemy.initiativeBonus,
      initiativeBonus: enemy.initiativeBonus,
      attackBonus: first?.bonus ?? enemy.attackBonus,
      damage: first?.damage.join("+") || enemy.damage,
      attacks,
      multiattack: enemy.multiattack ?? [],
      packTactics: Boolean(enemy.packTactics),
      heal: null,
      conditions: [],
      out: "none",
      dexMod: enemy.initiativeBonus,
    });
  });

  const order = combatants
    .toSorted(
      (left, right) =>
        right.initiative - left.initiative ||
        right.initiativeBonus - left.initiativeBonus ||
        left.name.localeCompare(right.name),
    )
    .map((combatant) => combatant.id);

  const state: EncounterState = {
    title: input.title,
    round: 1,
    turnIndex: 0,
    order,
    combatants,
    log: [],
    status: "active",
    loot: input.loot,
    xp: input.xp,
    xpAwarded: 0,
    note: "",
    dismissed: false,
  };

  for (const combatant of combatants) {
    const face = combatant.initiative - combatant.initiativeBonus;
    pushLog(
      state,
      `${combatant.name} rolls initiative: d20 (${face}) ${formatModifier(combatant.initiativeBonus)} = ${combatant.initiative}.`,
    );
  }

  const firstUp = order.findIndex((id) => byId(state, id)?.out === "none");
  if (firstUp === -1) {
    finishIfOver(state);
    return state;
  }
  state.turnIndex = firstUp;
  const starter = byId(state, order[firstUp] ?? "");
  pushLog(state, `Round 1 begins with ${starter?.name ?? "the party"}.`);
  return state;
}

export function currentCombatant(state: EncounterState): Combatant | null {
  if (state.status !== "active") return null;
  const id = state.order[state.turnIndex];
  const combatant = id ? byId(state, id) : undefined;
  return combatant && combatant.out === "none" ? combatant : null;
}

export function applyPlayerAction(
  state: EncounterState,
  action: PlayerAction,
  random: RandomSource,
): ActionResult {
  if (state.status !== "active") return { state, error: "This scene is already over." };
  const actor = currentCombatant(state);
  if (!actor || actor.id !== action.actorId || actor.side !== "party") {
    return { state, error: "It is not that hero's turn." };
  }

  const next = cloneState(state);
  const current = currentCombatant(next);
  if (!current) return { state, error: "It is not that hero's turn." };

  if (action.type === "dodge") {
    addCondition(current, "dodging");
    pushLog(next, `${current.name} takes a careful stance. Attacks against them have disadvantage until their next turn.`);
    afterAction(next);
    return { state: next, error: null };
  }

  if (action.type === "flee") {
    const roll = rollExpression(`1d20${signed(current.dexMod)}`, random);
    if (roll.total >= 10) {
      pushLog(next, `${current.name} looks for a way out: ${describeRoll(roll)} vs DC 10. The whole party slips away safely.`);
      next.status = "fled";
      next.xpAwarded = 0;
      next.note = "The party leaves the scene safely. There is no reward this time, and nobody is hurt.";
      pushLog(next, next.note);
      return { state: next, error: null };
    }
    pushLog(next, `${current.name} looks for a way out: ${describeRoll(roll)} vs DC 10. The path is still blocked.`);
    afterAction(next);
    return { state: next, error: null };
  }

  if (action.type === "help") {
    const ally = byId(next, action.targetId);
    if (!ally || ally.side !== "party" || ally.id === current.id || ally.out !== "none") {
      return { state, error: "Choose a friend who is still in the scene." };
    }
    addCondition(ally, "helped");
    pushLog(next, `${current.name} helps ${ally.name}. ${ally.name}'s next attack has advantage.`);
    afterAction(next);
    return { state: next, error: null };
  }

  if (action.type === "heal") {
    if (!current.heal) return { state, error: "That hero cannot heal." };
    const ally = byId(next, action.targetId);
    if (!ally || ally.side !== "party") return { state, error: "Choose a friend to comfort." };
    const roll = rollExpression(current.heal, random);
    const amount = Math.max(1, Math.min(12, roll.total));
    if (ally.out !== "none" || ally.hp <= 0) {
      ally.out = "none";
      ally.hp = Math.min(ally.maxHp, amount);
    } else {
      ally.hp = Math.min(ally.maxHp, ally.hp + amount);
    }
    pushLog(next, `${current.name} shares a warm light with ${ally.name}: ${describeRoll(roll)} ${ally.name} now has ${ally.hp} HP.`);
    afterAction(next);
    return { state: next, error: null };
  }

  const target = byId(next, action.targetId);
  if (!target || target.side !== "enemy" || target.out !== "none") {
    return { state, error: "Choose a critter that is still in the scene." };
  }
  strike(next, current, target, random, "");
  afterAction(next);
  return { state: next, error: null };
}

export function applyEnemyChoice(
  state: EncounterState,
  choice: EnemyChoice,
  random: RandomSource,
): ActionResult {
  if (state.status !== "active") return { state, error: "This scene is already over." };
  const actor = currentCombatant(state);
  if (!actor || actor.side !== "enemy") return { state, error: "It is not a critter's turn." };

  const next = cloneState(state);
  const current = currentCombatant(next);
  if (!current) return { state, error: "It is not a critter's turn." };

  if (choice.action === "dodge") {
    addCondition(current, "dodging");
    pushLog(next, choice.flavor || `${current.name} hunkers down.`);
    afterAction(next);
    return { state: next, error: null };
  }

  if (choice.action === "flee") {
    current.out = "fled";
    current.hp = Math.max(0, current.hp);
    current.conditions = [];
    pushLog(next, choice.flavor || `${current.name} decides this is too much and scurries away.`);
    afterAction(next);
    return { state: next, error: null };
  }

  if (choice.action === "help") {
    const ally = pickAlly(next, current, choice.targetId);
    if (ally) {
      addCondition(ally, "helped");
      pushLog(next, choice.flavor || `${current.name} encourages ${ally.name}.`);
      afterAction(next);
      return { state: next, error: null };
    }
  }

  const target = pickOpponent(next, current, choice.targetId);
  if (!target) {
    pushLog(next, `${current.name} looks around, but there is nobody left to face.`);
    afterAction(next);
    return { state: next, error: null };
  }
  strike(next, current, target, random, choice.flavor);
  afterAction(next);
  return { state: next, error: null };
}

export function parseEnemyChoice(raw: unknown): EnemyChoice {
  const record = asRecord(raw);
  const actionRaw = typeof record?.action === "string" ? record.action : "attack";
  const action = actionRaw === "dodge" || actionRaw === "help" || actionRaw === "flee" ? actionRaw : "attack";
  return {
    action,
    targetId: typeof record?.targetId === "string" ? record.targetId.slice(0, 80) : "",
    flavor: clipText(record?.flavor, 160),
  };
}

export interface EncounterPick {
  title: string;
  picks: { name: string; count: number }[];
  loot: string[];
}

export function parseEncounterPicks(raw: unknown): EncounterPick | null {
  const record = asRecord(raw);
  const listed = Array.isArray(record?.monsters) ? record.monsters : Array.isArray(record?.enemies) ? record.enemies : null;
  if (!record || !listed || listed.length === 0) return null;
  const picks: { name: string; count: number }[] = [];
  let total = 0;
  for (const entry of listed) {
    if (picks.length >= 3 || total >= 6) break;
    const item = asRecord(entry) ?? {};
    const name = clipText(item.name, 80);
    if (!name) continue;
    const count = Math.min(4, 6 - total, clampInt(item.count, 1, 4, 1));
    if (count < 1) break;
    picks.push({ name, count });
    total += count;
  }
  if (picks.length === 0) return null;
  const loot = Array.isArray(record.loot) ? record.loot.map((item) => clipText(item, 60)).filter(Boolean).slice(0, 4) : [];
  return { title: clipText(record.title, 60) || "A gentle challenge", picks, loot };
}

export function dismissEncounter(state: EncounterState): EncounterState {
  const next = cloneState(state);
  next.dismissed = true;
  return next;
}

export function shareXp(people: number, xp: number): number[] {
  if (!Number.isInteger(people) || people < 1 || !Number.isInteger(xp) || xp <= 0) return [];
  const each = Math.floor(xp / people);
  let extra = xp % people;
  return Array.from({ length: people }, () => {
    const share = each + (extra > 0 ? 1 : 0);
    if (extra > 0) extra -= 1;
    return share;
  });
}

export function partyIds(state: EncounterState): string[] {
  return state.combatants.filter((combatant) => combatant.side === "party").map((combatant) => combatant.id);
}

function strike(state: EncounterState, attacker: Combatant, target: Combatant, random: RandomSource, flavor: string): void {
  if (flavor) pushLog(state, flavor);
  const attacks = attacksOf(attacker);
  const multi = attacker.multiattack ?? [];
  const sequence = multi.length > 0 ? multi : [attacks[0]?.name ?? "Attack"];
  const pack =
    attacker.packTactics &&
    state.combatants.some((combatant) => combatant.side === "enemy" && combatant.id !== attacker.id && combatant.out === "none");
  if (pack) pushLog(state, `${attacker.name} fights harder with a friend nearby.`);
  for (const name of sequence) {
    const live = byId(state, target.id);
    if (!live || live.out !== "none") break;
    const attack = attacks.find((option) => option.name === name) ?? attacks[0];
    if (!attack) break;
    performAttack(state, attacker, live, random, attack, pack);
  }
}

function performAttack(
  state: EncounterState,
  attacker: Combatant,
  target: Combatant,
  random: RandomSource,
  attack: AttackOption,
  pack: boolean,
): void {
  const mode = attackMode(attacker, target, pack);
  const roll = rollExpression(`1d20${signed(attack.bonus)}`, random, mode);
  attacker.conditions = attacker.conditions.filter((condition) => condition !== "helped");

  const missed = roll.fumble || (!roll.critical && roll.total < target.ac);
  if (missed) {
    pushLog(state, `${attacker.name} uses ${attack.name} against ${target.name}: ${describeRoll(roll)} vs AC ${target.ac}. Miss.`);
    return;
  }

  const damage = attack.damage.length > 0 ? rollDamage(attack.damage, random, roll.critical) : null;
  const harm = damage ? Math.max(0, damage.total) : 0;
  target.hp = Math.max(0, target.hp - harm);
  if (target.hp === 0 && harm > 0) {
    target.out = "down";
    target.conditions = [];
  }
  const crit = roll.critical ? " Critical hit." : "";
  const harmText = damage ? ` Damage ${damage.text}.` : " No hit point damage.";
  const health =
    target.out === "down" ? ` ${target.name} is knocked out, safe but out of the scene.` : ` ${target.name} has ${target.hp} HP.`;
  pushLog(
    state,
    `${attacker.name} uses ${attack.name} against ${target.name}: ${describeRoll(roll)} vs AC ${target.ac}. Hit.${crit}${harmText}${health}`,
  );
}

function attacksOf(combatant: Combatant): AttackOption[] {
  if (combatant.attacks && combatant.attacks.length > 0) return combatant.attacks;
  return [{ name: "Attack", bonus: combatant.attackBonus, damage: combatant.damage ? [combatant.damage] : [] }];
}

function attackMode(attacker: Combatant, target: Combatant, pack: boolean): "normal" | "advantage" | "disadvantage" {
  const advantage = pack || attacker.conditions.includes("helped");
  const disadvantage = attacker.conditions.includes("frightened") || target.conditions.includes("dodging");
  if (advantage === disadvantage) return "normal";
  return advantage ? "advantage" : "disadvantage";
}

function afterAction(state: EncounterState): void {
  if (finishIfOver(state)) return;
  advance(state);
  finishIfOver(state);
}

function advance(state: EncounterState): void {
  if (state.status !== "active") return;
  const total = state.order.length;
  let wrapped = false;
  for (let step = 1; step <= total; step += 1) {
    const nextIndex = (state.turnIndex + step) % total;
    if (!wrapped && nextIndex <= state.turnIndex) {
      state.round += 1;
      wrapped = true;
    }
    const next = byId(state, state.order[nextIndex] ?? "");
    if (next && next.out === "none") {
      state.turnIndex = nextIndex;
      next.conditions = next.conditions.filter((condition) => condition !== "dodging");
      return;
    }
  }
}

function finishIfOver(state: EncounterState): boolean {
  const party = state.combatants.filter((combatant) => combatant.side === "party");
  const enemies = state.combatants.filter((combatant) => combatant.side === "enemy");
  const partyUp = party.some((combatant) => combatant.out === "none");
  const enemiesUp = enemies.some((combatant) => combatant.out === "none");
  if (!enemiesUp && partyUp) {
    const someoneFled = enemies.some((combatant) => combatant.out === "fled");
    const awarded = someoneFled ? Math.max(1, Math.floor(state.xp / 2)) : state.xp;
    state.status = "victory";
    state.xpAwarded = awarded;
    state.note = someoneFled
      ? "Some critters scampered off. The party still wins the scene."
      : "The challenge is over, and the party shares the reward.";
    const loot = state.loot.length > 0 ? ` Loot: ${state.loot.join(", ")}.` : "";
    pushLog(state, `Victory. The party earns ${awarded} XP.${loot} ${state.note}`);
    return true;
  }
  if (!partyUp) {
    state.status = "defeat";
    state.xpAwarded = 0;
    state.note = "The party gets knocked over, then wakes up safe and sound. Nobody is really hurt.";
    for (const member of party) {
      member.out = "none";
      member.hp = 1;
      member.conditions = [];
    }
    pushLog(state, state.note);
    return true;
  }
  return false;
}

function pickOpponent(state: EncounterState, actor: Combatant, requestedId: string): Combatant | null {
  const side: Side = actor.side === "enemy" ? "party" : "enemy";
  const opponents = state.combatants.filter((combatant) => combatant.side === side && combatant.out === "none");
  return opponents.find((combatant) => combatant.id === requestedId) ?? lowestHp(opponents);
}

function pickAlly(state: EncounterState, actor: Combatant, requestedId: string): Combatant | null {
  const allies = state.combatants.filter(
    (combatant) => combatant.side === actor.side && combatant.id !== actor.id && combatant.out === "none",
  );
  return allies.find((combatant) => combatant.id === requestedId) ?? allies[0] ?? null;
}

function lowestHp(combatants: Combatant[]): Combatant | null {
  return (
    combatants.toSorted((left, right) => left.hp - right.hp || left.name.localeCompare(right.name))[0] ?? null
  );
}

function addCondition(combatant: Combatant, condition: Condition): void {
  if (!combatant.conditions.includes(condition)) combatant.conditions.push(condition);
}

function signed(modifier: number): string {
  if (modifier === 0) return "";
  return modifier > 0 ? `+${modifier}` : `${modifier}`;
}

function formatModifier(modifier: number): string {
  return modifier > 0 ? `+ ${modifier}` : modifier < 0 ? `- ${Math.abs(modifier)}` : "+ 0";
}

function clampInt(value: unknown, min: number, max: number, fallback: number): number {
  const number = typeof value === "number" ? value : typeof value === "string" && value.trim() !== "" ? Number(value) : Number.NaN;
  if (!Number.isInteger(number)) return fallback;
  return Math.min(max, Math.max(min, number));
}

function asRecord(raw: unknown): Record<string, unknown> | null {
  if (!raw || typeof raw !== "object" || Array.isArray(raw)) return null;
  return raw as Record<string, unknown>;
}

function byId(state: EncounterState, id: string): Combatant | undefined {
  return state.combatants.find((combatant) => combatant.id === id);
}

function pushLog(state: EncounterState, text: string): void {
  state.log.push({ text });
}

function cloneState(state: EncounterState): EncounterState {
  return structuredClone(state);
}
