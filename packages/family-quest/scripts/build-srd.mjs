/**
 * Builds the committed SRD bestiary and lore files from the 5e-bits SRD JSON.
 *
 *   node scripts/build-srd.mjs          # download the pinned commit and rewrite data + migration
 *   node scripts/build-srd.mjs --check  # validate the committed files, no network
 *
 * Source: https://github.com/5e-bits/5e-database (MIT for the compilation).
 * The JSON is the D&D 5.1 Systems Reference Document, © Wizards of the Coast LLC, CC BY 4.0.
 * Only the SRD files are read. Madness, diseases, and poisons are left out of the family library.
 */
import { createHash } from "node:crypto";
import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const COMMIT = "a6212beb4b278917c2cff41c2b04c4ef4f3e0d6f";
const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const DATA = path.join(ROOT, "data");
const RAW = "https://raw.githubusercontent.com/5e-bits/5e-database/" + COMMIT + "/src/2014/en";
const SKIP_RULES = new Set(["madness", "diseases", "poisons"]);
const NUMBER_WORDS = { one: 1, two: 2, three: 3, four: 4, five: 5, six: 6 };

const monstersPath = path.join(DATA, "srd-monsters.json");
const lorePath = path.join(DATA, "srd-lore.json");
const migrationPath = path.join(ROOT, "migrations", "0002_srd.sql");

if (process.argv.includes("--check")) {
  await check();
} else {
  await build();
}

async function build() {
  const [monsters, rules, conditions, skills, abilities, spells] = await Promise.all([
    fetchJson("5e-SRD-Monsters.json"),
    fetchJson("5e-SRD-Rule-Sections.json"),
    fetchJson("5e-SRD-Conditions.json"),
    fetchJson("5e-SRD-Skills.json"),
    fetchJson("5e-SRD-Ability-Scores.json"),
    fetchJson("5e-SRD-Spells.json"),
  ]);
  const catalog = monsters.map(compactMonster).toSorted((left, right) => left.name.localeCompare(right.name));
  const lore = [
    ...rules.filter((rule) => !SKIP_RULES.has(rule.index)).flatMap((rule) => chunkText(`rule-${rule.index}`, rule.name, strip(rule.desc))),
    ...conditions.map((condition) => ({
      id: `condition-${condition.index}`,
      title: `Condition: ${condition.name}`,
      body: strip(condition.desc),
      source: "srd",
    })),
    ...skills.map((skill) => ({
      id: `skill-${skill.index}`,
      title: `Skill: ${skill.name}`,
      body: `${skill.name} (${skill.ability_score?.name ?? "ability"}). ${strip(skill.desc)}`,
      source: "srd",
    })),
    ...abilities.map((ability) => ({
      id: `ability-${ability.index}`,
      title: `Ability: ${ability.full_name ?? ability.name}`,
      body: `${ability.full_name ?? ability.name}. ${strip(ability.desc)}`,
      source: "srd",
    })),
    ...spells.flatMap((spell) => chunkText(`spell-${spell.index}`, `Spell: ${spell.name}`, spellText(spell))),
    ...catalog.map((monster) => ({
      id: `mon-${monster.id}`.slice(0, 60),
      title: `Monster: ${monster.name}`,
      body: statLine(monster),
      source: "srd",
    })),
  ];
  assertUnique(catalog.map((monster) => monster.id), "monster id");
  assertUnique(lore.map((chunk) => chunk.id), "lore id");
  await mkdir(DATA, { recursive: true });
  const monsterDoc = {
    license: "CC-BY-4.0",
    work: "Dungeons & Dragons Systems Reference Document 5.1",
    copyright: "Wizards of the Coast LLC",
    compilation: "5e-bits/5e-database",
    compilationLicense: "MIT",
    commit: COMMIT,
    monsters: catalog,
  };
  const loreDoc = {
    license: "CC-BY-4.0",
    work: "Dungeons & Dragons Systems Reference Document 5.1",
    copyright: "Wizards of the Coast LLC",
    compilation: "5e-bits/5e-database",
    compilationLicense: "MIT",
    commit: COMMIT,
    omitted: ["Madness", "Diseases", "Poisons"],
    chunks: lore,
  };
  await writeFile(monstersPath, JSON.stringify(monsterDoc));
  await writeFile(lorePath, JSON.stringify(loreDoc));
  await writeFile(migrationPath, migrationSql(catalog, lore));
  console.log(`monsters ${catalog.length}, lore chunks ${lore.length}`);
  await check();
}

async function check() {
  const monsters = JSON.parse(await readFile(monstersPath, "utf8"));
  const lore = JSON.parse(await readFile(lorePath, "utf8"));
  const migration = await readFile(migrationPath, "utf8");
  if (monsters.commit !== COMMIT || lore.commit !== COMMIT) throw new Error("SRD commit pin drifted.");
  if (monsters.monsters.length < 300) throw new Error(`Expected about 300 monsters, found ${monsters.monsters.length}.`);
  const goblin = monsters.monsters.find((monster) => monster.id === "goblin");
  if (!goblin || goblin.ac !== 15 || goblin.hp !== 7 || goblin.attacks[0]?.damage?.[0] !== "1d6+2") {
    throw new Error("Goblin stat block did not match the SRD.");
  }
  const owlbear = monsters.monsters.find((monster) => monster.id === "owlbear");
  if (!owlbear || owlbear.multiattack.join(",") !== "Beak,Claws") {
    throw new Error(`Owlbear multiattack was ${owlbear?.multiattack?.join(",")}.`);
  }
  const wolf = monsters.monsters.find((monster) => monster.id === "wolf");
  if (!wolf?.packTactics) throw new Error("Wolf is missing Pack Tactics.");
  if (lore.chunks.length < 100) throw new Error("Lore library is unexpectedly small.");
  if (!lore.chunks.some((chunk) => /advantage/i.test(chunk.body) && /disadvantage/i.test(chunk.body))) {
    throw new Error("Advantage and disadvantage rules are missing.");
  }
  if (lore.chunks.some((chunk) => /^(Madness|Diseases|Poisons)\b/.test(chunk.title))) {
    throw new Error("A graphic SRD chapter was indexed.");
  }
  const monsterInserts = migration.split("\n").filter((line) => line.startsWith("INSERT INTO monsters")).length;
  const loreInserts = migration.split("\n").filter((line) => line.startsWith("INSERT INTO lore_chunks")).length;
  if (monsterInserts !== monsters.monsters.length || loreInserts !== lore.chunks.length) {
    throw new Error("Migration row counts do not match the JSON.");
  }
  if (!migration.includes("'goblin'")) throw new Error("Migration is missing the goblin.");
  const hash = createHash("sha256").update(migration).digest("hex").slice(0, 12);
  console.log(`SRD check ok: ${monsters.monsters.length} monsters, ${lore.chunks.length} lore chunks, migration ${hash}`);
}

async function fetchJson(name) {
  const response = await fetch(`${RAW}/${name}`);
  if (!response.ok) throw new Error(`Could not download ${name}: ${response.status}`);
  return response.json();
}

function compactMonster(raw) {
  const actions = Array.isArray(raw.actions) ? raw.actions : [];
  const attacks = actions
    .filter((action) => typeof action.attack_bonus === "number")
    .map((action) => ({
      name: String(action.name).slice(0, 40),
      bonus: action.attack_bonus,
      damage: damageParts(action),
    }))
    .slice(0, 8);
  const cr = Number(raw.challenge_rating);
  return {
    id: String(raw.index),
    name: String(raw.name),
    crLabel: crLabel(cr),
    crValue: cr,
    xp: Number(raw.xp) || 0,
    size: String(raw.size ?? ""),
    type: String(raw.type ?? ""),
    ac: Number(raw.armor_class?.[0]?.value) || 10,
    hp: Number(raw.hit_points) || 1,
    hitDice: String(raw.hit_dice ?? ""),
    dexterity: Number(raw.dexterity) || 10,
    attacks,
    multiattack: parseMultiattack(actions),
    packTactics: (raw.special_abilities ?? []).some((ability) => ability.name === "Pack Tactics"),
  };
}

function damageParts(action) {
  const parts = [];
  for (const entry of action.damage ?? []) {
    const dice = String(entry.damage_dice ?? "").replace(/\s+/g, "");
    if (/^\d+$/.test(dice) || /^\d*d(?:4|6|8|10|12|20)(?:[+-]\d+)?$/i.test(dice)) parts.push(dice.toLowerCase());
  }
  return parts;
}

function parseMultiattack(actions) {
  const multi = actions.find((action) => String(action.name).toLowerCase() === "multiattack");
  const weapons = actions.filter((action) => typeof action.attack_bonus === "number");
  if (!multi || weapons.length === 0) return [];
  const desc = String(multi.desc ?? "").toLowerCase();
  const specific = [...desc.matchAll(/(one|two|three|four|five|six|\d+)\s+with\s+its\s+([a-z]+)/g)];
  if (specific.length > 0) {
    const sequence = [];
    for (const match of specific) {
      const count = wordToCount(match[1]);
      const token = match[2].replace(/s$/, "");
      const attack = weapons.find((item) => {
        const name = item.name.toLowerCase().replace(/s$/, "");
        return name.includes(token) || token.includes(name);
      });
      if (!attack) continue;
      for (let index = 0; index < count; index += 1) sequence.push(attack.name);
    }
    if (sequence.length > 0) return sequence.slice(0, 6);
  }
  const broad = desc.match(/makes\s+(one|two|three|four|five|six|\d+)\s+attacks/);
  const count = broad ? wordToCount(broad[1]) : Math.min(2, weapons.length);
  return Array.from({ length: Math.min(count, 6) }, (_, index) => weapons[index % weapons.length].name);
}

function wordToCount(word) {
  return NUMBER_WORDS[word] ?? (Number.isInteger(Number(word)) ? Number(word) : 1);
}

function crLabel(value) {
  if (value === 0.125) return "1/8";
  if (value === 0.25) return "1/4";
  if (value === 0.5) return "1/2";
  return String(value);
}

function spellText(spell) {
  const level = spell.level === 0 ? "Cantrip" : `Level ${spell.level}`;
  const school = spell.school?.name ?? "magic";
  return [
    `${spell.name}. ${level} ${school}.`,
    `Casting time: ${spell.casting_time ?? "unknown"}.`,
    `Range: ${spell.range ?? "unknown"}.`,
    `Duration: ${spell.duration ?? "unknown"}.`,
    strip(Array.isArray(spell.desc) ? spell.desc.join("\n\n") : String(spell.desc ?? "")),
  ].join(" ");
}

function statLine(monster) {
  const attacks =
    monster.attacks.length === 0
      ? "No weapon attack in the SRD stat block."
      : monster.attacks
          .map((attack) => `${attack.name} +${attack.bonus} (${attack.damage.join(" + ") || "no hit point damage"})`)
          .join("; ");
  const multi = monster.multiattack.length > 0 ? ` Multiattack: ${monster.multiattack.join(", ")}.` : "";
  const pack = monster.packTactics ? " Pack Tactics." : "";
  return `${monster.name}. ${monster.size} ${monster.type}, CR ${monster.crLabel}, AC ${monster.ac}, HP ${monster.hp} (${monster.hitDice}), Dex ${monster.dexterity}. Attacks: ${attacks}.${multi}${pack}`;
}

function chunkText(idBase, title, text) {
  const blocks = text.split(/\n(?=#{1,3} )/).flatMap((block) => wrap(block.trim()));
  const pieces = blocks.length > 0 ? blocks : wrap(text);
  return pieces.map((body, index) => ({
    id: `${idBase}-${index}`.slice(0, 60),
    title: pieces.length > 1 ? `${title} (${index + 1})` : title,
    body,
    source: "srd",
  }));
}

function wrap(text) {
  const parts = [];
  let rest = text.trim();
  while (rest.length > 1400) {
    let cut = rest.lastIndexOf("\n\n", 1400);
    if (cut < 400) cut = rest.lastIndexOf(" ", 1400);
    if (cut < 400) cut = 1400;
    parts.push(rest.slice(0, cut).trim());
    rest = rest.slice(cut).trim();
  }
  if (rest) parts.push(rest);
  return parts;
}

function strip(value) {
  return String(value ?? "")
    .replace(/\r/g, "")
    .replace(/\[(.*?)\]\(.*?\)/g, "$1")
    .trim();
}

function migrationSql(catalog, lore) {
  const created = "2026-10-14T00:00:00.000Z";
  const lines = [
    "-- SRD 5.1 bestiary and rules library.",
    "-- Dungeons & Dragons Systems Reference Document 5.1, copyright Wizards of the Coast LLC, CC BY 4.0.",
    `-- Structured JSON compiled by 5e-bits/5e-database (MIT), commit ${COMMIT}.`,
    "-- Madness, diseases, and poisons are not imported.",
    "",
    `CREATE TABLE monsters (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  name_key TEXT NOT NULL UNIQUE,
  source TEXT NOT NULL,
  cr_label TEXT NOT NULL,
  cr_value REAL NOT NULL,
  xp INTEGER NOT NULL,
  size TEXT NOT NULL,
  creature_type TEXT NOT NULL,
  ac INTEGER NOT NULL,
  hp INTEGER NOT NULL,
  hit_dice TEXT NOT NULL,
  dexterity INTEGER NOT NULL,
  attacks_json TEXT NOT NULL,
  multiattack_json TEXT NOT NULL,
  pack_tactics INTEGER NOT NULL DEFAULT 0,
  note TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL
);`,
    "CREATE INDEX monsters_cr_idx ON monsters (cr_value, name);",
    "",
    `CREATE TABLE lore_chunks (
  id TEXT PRIMARY KEY,
  source TEXT NOT NULL,
  note_id TEXT,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  indexed INTEGER NOT NULL DEFAULT 0
);`,
    "CREATE INDEX lore_chunks_lookup_idx ON lore_chunks (source, indexed);",
    "",
    `CREATE TABLE lore_notes (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  r2_key TEXT NOT NULL,
  bytes INTEGER NOT NULL,
  created_at TEXT NOT NULL
);`,
    "",
  ];
  for (const monster of catalog) {
    lines.push(
      `INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES (${sql(monster.id)}, ${sql(monster.name)}, ${sql(monster.name.toLowerCase())}, 'srd', ${sql(monster.crLabel)}, ${monster.crValue}, ${monster.xp}, ${sql(monster.size)}, ${sql(monster.type)}, ${monster.ac}, ${monster.hp}, ${sql(monster.hitDice)}, ${monster.dexterity}, ${sql(JSON.stringify(monster.attacks))}, ${sql(JSON.stringify(monster.multiattack))}, ${monster.packTactics ? 1 : 0}, '', ${sql(created)});`,
    );
  }
  lines.push("");
  for (const chunk of lore) {
    lines.push(
      `INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES (${sql(chunk.id)}, 'srd', NULL, ${sql(chunk.title)}, ${sql(chunk.body)}, 0);`,
    );
  }
  lines.push("");
  return lines.join("\n");
}

function sql(value) {
  return `'${String(value).replaceAll("'", "''")}'`;
}

function assertUnique(ids, label) {
  const seen = new Set();
  for (const id of ids) {
    if (seen.has(id)) throw new Error(`Duplicate ${label}: ${id}`);
    seen.add(id);
  }
}
