import type { CapResult } from "./cost";
import type { EncounterState } from "./encounter";
import type { MonsterStat } from "./bestiary";

export interface CampaignRecord {
  id: string;
  title: string;
  premise: string;
  summary: string;
  status: string;
  created_at: string;
  updated_at: string;
  party: string;
}

export interface CharacterRecord {
  id: string;
  campaign_id: string;
  name: string;
  class_id: string;
  class_name: string;
  ancestry: string;
  level: number;
  xp: number;
  hp: number;
  max_hp: number;
  ac: number;
  strength: number;
  dexterity: number;
  constitution: number;
  intelligence: number;
  wisdom: number;
  charisma: number;
  inventory: string;
  portrait: string;
}

export interface MessageRecord {
  id: string;
  campaign_id: string;
  role: string;
  speaker: string;
  content: string;
  created_at: string;
}

export interface EncounterRecord {
  id: string;
  campaign_id: string;
  status: string;
  state_json: string;
  created_at: string;
  updated_at: string;
}

export interface NewCharacter {
  id: string;
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
}

export async function listCampaigns(db: D1Database): Promise<CampaignRecord[]> {
  const result = await db
    .prepare(
      `SELECT c.id, c.title, c.premise, c.summary, c.status, c.created_at, c.updated_at,
              COALESCE(GROUP_CONCAT(ch.name, ', '), '') AS party
       FROM campaigns c
       LEFT JOIN characters ch ON ch.campaign_id = c.id
       GROUP BY c.id
       ORDER BY c.updated_at DESC`,
    )
    .all<CampaignRecord>();
  return result.results;
}

export async function getCampaign(db: D1Database, id: string): Promise<CampaignRecord | null> {
  return db
    .prepare(
      `SELECT id, title, premise, summary, status, created_at, updated_at, '' AS party
       FROM campaigns WHERE id = ?`,
    )
    .bind(id)
    .first<CampaignRecord>();
}

export async function listCharacters(db: D1Database, campaignId: string): Promise<CharacterRecord[]> {
  const result = await db
    .prepare(
      `SELECT id, campaign_id, name, class_id, class_name, ancestry, level, xp, hp, max_hp, ac,
              strength, dexterity, constitution, intelligence, wisdom, charisma, inventory, portrait
       FROM characters WHERE campaign_id = ? ORDER BY created_at ASC`,
    )
    .bind(campaignId)
    .all<CharacterRecord>();
  return result.results;
}

export async function listMessages(db: D1Database, campaignId: string): Promise<MessageRecord[]> {
  const result = await db
    .prepare(
      `SELECT id, campaign_id, role, speaker, content, created_at
       FROM messages WHERE campaign_id = ? ORDER BY created_at DESC LIMIT 80`,
    )
    .bind(campaignId)
    .all<MessageRecord>();
  return result.results.toReversed();
}

export async function createQuest(
  db: D1Database,
  campaign: { id: string; title: string; premise: string; summary: string; createdAt: string },
  characters: NewCharacter[],
  opening: { id: string; content: string },
): Promise<void> {
  const statements: D1PreparedStatement[] = [
    db
      .prepare(
        `INSERT INTO campaigns (id, title, premise, summary, status, created_at, updated_at)
         VALUES (?, ?, ?, ?, 'active', ?, ?)`,
      )
      .bind(campaign.id, campaign.title, campaign.premise, campaign.summary, campaign.createdAt, campaign.createdAt),
    ...characters.map((character) =>
      db
        .prepare(
          `INSERT INTO characters (
             id, campaign_id, name, class_id, class_name, ancestry, level, xp, hp, max_hp, ac,
             strength, dexterity, constitution, intelligence, wisdom, charisma, inventory, portrait, created_at
           ) VALUES (?, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        )
        .bind(
          character.id,
          campaign.id,
          character.name,
          character.classId,
          character.className,
          character.ancestry,
          character.level,
          character.hp,
          character.maxHp,
          character.ac,
          character.strength,
          character.dexterity,
          character.constitution,
          character.intelligence,
          character.wisdom,
          character.charisma,
          character.inventory,
          character.portrait,
          campaign.createdAt,
        ),
    ),
    db
      .prepare(`INSERT INTO messages (id, campaign_id, role, speaker, content, created_at) VALUES (?, ?, 'dm', 'Dungeon Master', ?, ?)`)
      .bind(opening.id, campaign.id, opening.content, campaign.createdAt),
  ];
  await db.batch(statements);
}

export async function touchCampaign(db: D1Database, id: string, updatedAt: string, summary?: string): Promise<void> {
  if (summary === undefined) {
    await db.prepare("UPDATE campaigns SET updated_at = ? WHERE id = ?").bind(updatedAt, id).run();
    return;
  }
  await db.prepare("UPDATE campaigns SET summary = ?, updated_at = ? WHERE id = ?").bind(summary, updatedAt, id).run();
}

export async function addMessage(
  db: D1Database,
  message: { id: string; campaignId: string; role: string; speaker: string; content: string; createdAt: string },
): Promise<void> {
  await db
    .prepare(`INSERT INTO messages (id, campaign_id, role, speaker, content, created_at) VALUES (?, ?, ?, ?, ?, ?)`)
    .bind(message.id, message.campaignId, message.role, message.speaker, message.content, message.createdAt)
    .run();
}

export async function updateCharacter(
  db: D1Database,
  input: { id: string; campaignId: string; hp: number; inventory: string; portrait: string },
): Promise<void> {
  await db
    .prepare("UPDATE characters SET hp = ?, inventory = ?, portrait = ? WHERE id = ? AND campaign_id = ?")
    .bind(input.hp, input.inventory, input.portrait, input.id, input.campaignId)
    .run();
}

export async function levelCharacter(
  db: D1Database,
  input: { id: string; campaignId: string; level: number; hp: number; maxHp: number },
): Promise<void> {
  await db
    .prepare("UPDATE characters SET level = ?, hp = ?, max_hp = ? WHERE id = ? AND campaign_id = ?")
    .bind(input.level, input.hp, input.maxHp, input.id, input.campaignId)
    .run();
}

export async function syncParty(db: D1Database, campaignId: string, state: EncounterState): Promise<void> {
  const party = state.combatants.filter((combatant) => combatant.side === "party");
  if (party.length === 0) return;
  await db.batch(
    party.map((combatant) =>
      db
        .prepare("UPDATE characters SET hp = ? WHERE id = ? AND campaign_id = ?")
        .bind(combatant.hp, combatant.id, campaignId),
    ),
  );
}

export async function awardXp(db: D1Database, campaignId: string, shares: { id: string; xp: number }[]): Promise<void> {
  const grants = shares.filter((share) => share.xp > 0);
  if (grants.length === 0) return;
  await db.batch(
    grants.map((share) =>
      db.prepare("UPDATE characters SET xp = xp + ? WHERE id = ? AND campaign_id = ?").bind(share.xp, share.id, campaignId),
    ),
  );
}

export async function latestEncounter(db: D1Database, campaignId: string): Promise<EncounterRecord | null> {
  return db
    .prepare(
      `SELECT id, campaign_id, status, state_json, created_at, updated_at
       FROM encounters WHERE campaign_id = ? ORDER BY updated_at DESC LIMIT 1`,
    )
    .bind(campaignId)
    .first<EncounterRecord>();
}

export async function insertEncounter(
  db: D1Database,
  row: { id: string; campaignId: string; state: EncounterState; createdAt: string },
): Promise<void> {
  await db
    .prepare(
      `INSERT INTO encounters (id, campaign_id, status, state_json, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?)`,
    )
    .bind(row.id, row.campaignId, row.state.status, JSON.stringify(row.state), row.createdAt, row.createdAt)
    .run();
}

export async function saveEncounter(
  db: D1Database,
  row: { id: string; state: EncounterState; updatedAt: string },
): Promise<void> {
  await db
    .prepare("UPDATE encounters SET status = ?, state_json = ?, updated_at = ? WHERE id = ?")
    .bind(row.state.status, JSON.stringify(row.state), row.updatedAt, row.id)
    .run();
}

export async function deleteCampaign(db: D1Database, id: string): Promise<void> {
  await db.batch([
    db.prepare("DELETE FROM messages WHERE campaign_id = ?").bind(id),
    db.prepare("DELETE FROM characters WHERE campaign_id = ?").bind(id),
    db.prepare("DELETE FROM encounters WHERE campaign_id = ?").bind(id),
    db.prepare("DELETE FROM campaigns WHERE id = ?").bind(id),
  ]);
}

/** Same transition as consumeCount: increment only while today's count is under the cap. */
export async function consumeDailyCap(db: D1Database, day: string, cap: number): Promise<CapResult> {
  if (!Number.isInteger(cap) || cap < 0) throw new Error("Cap is invalid.");
  if (cap === 0) {
    const used = await usageCount(db, day);
    return { day, cap, used, remaining: 0, allowed: false };
  }
  const row = await db
    .prepare(
      `INSERT INTO ai_usage (day, kind, "count") VALUES (?1, 'all', 1)
       ON CONFLICT(day, kind) DO UPDATE SET "count" = "count" + 1
       WHERE ai_usage."count" < ?2
       RETURNING "count" AS used`,
    )
    .bind(day, cap)
    .first<{ used: number }>();
  if (!row) {
    const used = await usageCount(db, day);
    return { day, cap, used, remaining: 0, allowed: false };
  }
  return { day, cap, used: row.used, remaining: Math.max(0, cap - row.used), allowed: true };
}

export async function usageCount(db: D1Database, day: string): Promise<number> {
  const row = await db
    .prepare(`SELECT "count" AS used FROM ai_usage WHERE day = ? AND kind = 'all'`)
    .bind(day)
    .first<{ used: number }>();
  return row?.used ?? 0;
}

export interface MonsterRow {
  id: string;
  name: string;
  name_key: string;
  source: string;
  cr_label: string;
  cr_value: number;
  xp: number;
  size: string;
  creature_type: string;
  ac: number;
  hp: number;
  hit_dice: string;
  dexterity: number;
  attacks_json: string;
  multiattack_json: string;
  pack_tactics: number;
  note: string;
}

export async function listMonsters(db: D1Database, query: string, maxCr: number | null, limit = 80): Promise<MonsterStat[]> {
  const needle = `%${query.trim().toLowerCase().replace(/[%_]/g, "")}%`;
  const sql =
    maxCr === null
      ? `SELECT * FROM monsters WHERE name_key LIKE ?1 ORDER BY cr_value, name LIMIT ?2`
      : `SELECT * FROM monsters WHERE name_key LIKE ?1 AND cr_value <= ?2 ORDER BY cr_value, name LIMIT ?3`;
  const statement = db.prepare(sql);
  const result =
    maxCr === null ? await statement.bind(needle, limit).all<MonsterRow>() : await statement.bind(needle, maxCr, limit).all<MonsterRow>();
  return (result.results ?? []).map(monsterFromRow);
}

export async function listSuitableMonsters(db: D1Database, maxCr: number): Promise<MonsterStat[]> {
  const result = await db
    .prepare(
      `SELECT * FROM (
         SELECT * FROM monsters WHERE cr_value <= ?1 AND source = 'homebrew'
         UNION ALL
         SELECT * FROM monsters WHERE cr_value <= ?1 AND source = 'srd'
       ) AS picked
       ORDER BY CASE source WHEN 'homebrew' THEN 0 ELSE 1 END, cr_value DESC, name
       LIMIT 24`,
    )
    .bind(maxCr)
    .all<MonsterRow>();
  return (result.results ?? []).map(monsterFromRow);
}

export async function getMonster(db: D1Database, id: string): Promise<MonsterStat | null> {
  const row = await db.prepare("SELECT * FROM monsters WHERE id = ?").bind(id).first<MonsterRow>();
  return row ? monsterFromRow(row) : null;
}

export async function monsterNameTaken(db: D1Database, nameKey: string, exceptId: string): Promise<boolean> {
  const row = await db
    .prepare("SELECT id FROM monsters WHERE name_key = ? AND id != ?")
    .bind(nameKey, exceptId)
    .first<{ id: string }>();
  return Boolean(row);
}

export async function saveMonster(db: D1Database, monster: MonsterStat, createdAt: string): Promise<void> {
  await db
    .prepare(
      `INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at)
       VALUES (?1, ?2, ?3, 'homebrew', ?4, ?5, ?6, ?7, ?8, ?9, ?10, '', ?11, ?12, ?13, ?14, ?15, ?16)
       ON CONFLICT(id) DO UPDATE SET
         name = excluded.name,
         name_key = excluded.name_key,
         cr_label = excluded.cr_label,
         cr_value = excluded.cr_value,
         xp = excluded.xp,
         ac = excluded.ac,
         hp = excluded.hp,
         dexterity = excluded.dexterity,
         attacks_json = excluded.attacks_json,
         multiattack_json = excluded.multiattack_json,
         pack_tactics = excluded.pack_tactics,
         note = excluded.note
       WHERE monsters.source = 'homebrew'`,
    )
    .bind(
      monster.id,
      monster.name,
      monster.nameKey,
      monster.crLabel,
      monster.crValue,
      monster.xp,
      monster.size,
      monster.type,
      monster.ac,
      monster.hp,
      monster.dexterity,
      JSON.stringify(monster.attacks),
      JSON.stringify(monster.multiattack),
      monster.packTactics ? 1 : 0,
      monster.note,
      createdAt,
    )
    .run();
}

export async function deleteMonster(db: D1Database, id: string): Promise<boolean> {
  const result = await db.prepare("DELETE FROM monsters WHERE id = ? AND source = 'homebrew'").bind(id).run();
  return (result.meta.changes ?? 0) > 0;
}

export interface LoreRow {
  id: string;
  source: string;
  note_id: string | null;
  title: string;
  body: string;
  indexed: number;
}

export interface NoteRow {
  id: string;
  title: string;
  r2_key: string;
  bytes: number;
  created_at: string;
}

export async function loreCounts(db: D1Database): Promise<{ total: number; indexed: number }> {
  const row = await db
    .prepare("SELECT COUNT(*) AS total, COALESCE(SUM(indexed), 0) AS indexed FROM lore_chunks")
    .first<{ total: number; indexed: number }>();
  return { total: row?.total ?? 0, indexed: row?.indexed ?? 0 };
}

export async function listNotes(db: D1Database): Promise<NoteRow[]> {
  const result = await db.prepare("SELECT * FROM lore_notes ORDER BY created_at DESC LIMIT 40").all<NoteRow>();
  return result.results ?? [];
}

export async function insertNote(db: D1Database, note: NoteRow, chunks: { id: string; title: string; body: string }[]): Promise<void> {
  const statements = [
    db.prepare("INSERT INTO lore_notes (id, title, r2_key, bytes, created_at) VALUES (?, ?, ?, ?, ?)").bind(
      note.id,
      note.title,
      note.r2_key,
      note.bytes,
      note.created_at,
    ),
    ...chunks.map((chunk) =>
      db
        .prepare("INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES (?, 'note', ?, ?, ?, 0)")
        .bind(chunk.id, note.id, chunk.title, chunk.body),
    ),
  ];
  await db.batch(statements);
}

export async function deleteNote(db: D1Database, id: string): Promise<NoteRow | null> {
  const note = await db.prepare("SELECT * FROM lore_notes WHERE id = ?").bind(id).first<NoteRow>();
  if (!note) return null;
  await db.batch([
    db.prepare("DELETE FROM lore_chunks WHERE note_id = ?").bind(id),
    db.prepare("DELETE FROM lore_notes WHERE id = ?").bind(id),
  ]);
  return note;
}

export async function noteChunkIds(db: D1Database, noteId: string): Promise<string[]> {
  const result = await db.prepare("SELECT id FROM lore_chunks WHERE note_id = ?").bind(noteId).all<{ id: string }>();
  return (result.results ?? []).map((row) => row.id);
}

export async function nextUnindexedChunks(db: D1Database, limit: number): Promise<LoreRow[]> {
  const result = await db
    .prepare("SELECT * FROM lore_chunks WHERE indexed = 0 ORDER BY source, id LIMIT ?")
    .bind(limit)
    .all<LoreRow>();
  return result.results ?? [];
}

export async function markChunksIndexed(db: D1Database, ids: string[]): Promise<void> {
  if (ids.length === 0) return;
  const marks = ids.map(() => "?").join(", ");
  await db.prepare(`UPDATE lore_chunks SET indexed = 1 WHERE id IN (${marks})`).bind(...ids).run();
}

export async function chunksByIds(db: D1Database, ids: string[]): Promise<LoreRow[]> {
  if (ids.length === 0) return [];
  const marks = ids.map(() => "?").join(", ");
  const result = await db.prepare(`SELECT * FROM lore_chunks WHERE id IN (${marks})`).bind(...ids).all<LoreRow>();
  return result.results ?? [];
}

export async function searchLoreText(db: D1Database, words: string[]): Promise<LoreRow[]> {
  const usable = words.filter((word) => word.length > 2).slice(0, 6);
  if (usable.length === 0) return [];
  const clauses = usable.map(() => "(title LIKE ? OR body LIKE ?)").join(" OR ");
  const binds = usable.flatMap((word) => {
    const needle = `%${word.replace(/[%_]/g, "")}%`;
    return [needle, needle];
  });
  const result = await db.prepare(`SELECT * FROM lore_chunks WHERE ${clauses} LIMIT 40`).bind(...binds).all<LoreRow>();
  return result.results ?? [];
}

function monsterFromRow(row: MonsterRow): MonsterStat {
  return {
    id: row.id,
    name: row.name,
    nameKey: row.name_key,
    source: row.source === "homebrew" ? "homebrew" : "srd",
    crLabel: row.cr_label,
    crValue: row.cr_value,
    xp: row.xp,
    size: row.size,
    type: row.creature_type,
    ac: row.ac,
    hp: row.hp,
    hitDice: row.hit_dice,
    dexterity: row.dexterity,
    attacks: parseJsonArray(row.attacks_json),
    multiattack: parseStringArray(row.multiattack_json),
    packTactics: row.pack_tactics === 1,
    note: row.note,
  };
}

function parseJsonArray(value: string): MonsterStat["attacks"] {
  try {
    const parsed = JSON.parse(value) as unknown;
    if (!Array.isArray(parsed)) return [];
    return parsed.flatMap((entry) => {
      if (!entry || typeof entry !== "object") return [];
      const record = entry as { name?: unknown; bonus?: unknown; damage?: unknown };
      const name = typeof record.name === "string" ? record.name : "";
      const bonus = typeof record.bonus === "number" ? record.bonus : 0;
      const damage = Array.isArray(record.damage) ? record.damage.filter((part): part is string => typeof part === "string") : [];
      return name ? [{ name, bonus, damage }] : [];
    });
  } catch {
    return [];
  }
}

function parseStringArray(value: string): string[] {
  try {
    const parsed = JSON.parse(value) as unknown;
    return Array.isArray(parsed) ? parsed.filter((item): item is string => typeof item === "string") : [];
  } catch {
    return [];
  }
}
