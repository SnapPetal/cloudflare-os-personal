-- SRD 5.1 bestiary and rules library.
-- Dungeons & Dragons Systems Reference Document 5.1, copyright Wizards of the Coast LLC, CC BY 4.0.
-- Structured JSON compiled by 5e-bits/5e-database (MIT), commit a6212beb4b278917c2cff41c2b04c4ef4f3e0d6f.
-- Madness, diseases, and poisons are not imported.

CREATE TABLE monsters (
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
);
CREATE INDEX monsters_cr_idx ON monsters (cr_value, name);

CREATE TABLE lore_chunks (
  id TEXT PRIMARY KEY,
  source TEXT NOT NULL,
  note_id TEXT,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  indexed INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX lore_chunks_lookup_idx ON lore_chunks (source, indexed);

CREATE TABLE lore_notes (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  r2_key TEXT NOT NULL,
  bytes INTEGER NOT NULL,
  created_at TEXT NOT NULL
);

INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('aboleth', 'Aboleth', 'aboleth', 'srd', '10', 10, 5900, 'Large', 'aberration', 17, 135, '18d10', 9, '[{"name":"Tentacle","bonus":9,"damage":["2d6+5","1d12"]},{"name":"Tail","bonus":9,"damage":["3d6+5"]}]', '["Tentacle","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('acolyte', 'Acolyte', 'acolyte', 'srd', '1/4', 0.25, 50, 'Medium', 'humanoid', 10, 9, '2d8', 10, '[{"name":"Club","bonus":2,"damage":["1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-black-dragon', 'Adult Black Dragon', 'adult black dragon', 'srd', '14', 14, 11500, 'Huge', 'dragon', 19, 195, '17d12', 14, '[{"name":"Bite","bonus":11,"damage":["2d10+6","1d8"]},{"name":"Claw","bonus":11,"damage":["2d6+6"]},{"name":"Tail","bonus":11,"damage":["2d8+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-blue-dragon', 'Adult Blue Dragon', 'adult blue dragon', 'srd', '16', 16, 15000, 'Huge', 'dragon', 19, 225, '18d12', 10, '[{"name":"Bite","bonus":12,"damage":["2d10+7","1d10"]},{"name":"Claw","bonus":12,"damage":["2d6+7"]},{"name":"Tail","bonus":12,"damage":["2d8+7"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-brass-dragon', 'Adult Brass Dragon', 'adult brass dragon', 'srd', '13', 13, 10000, 'Huge', 'dragon', 18, 172, '15d12', 10, '[{"name":"Bite","bonus":11,"damage":["2d10+6"]},{"name":"Claw","bonus":11,"damage":["2d6+6"]},{"name":"Tail","bonus":11,"damage":["2d8+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-bronze-dragon', 'Adult Bronze Dragon', 'adult bronze dragon', 'srd', '15', 15, 13000, 'Huge', 'dragon', 19, 212, '17d12', 10, '[{"name":"Bite","bonus":12,"damage":["2d10+7"]},{"name":"Claw","bonus":12,"damage":["2d6+7"]},{"name":"Tail","bonus":12,"damage":["2d8+7"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-copper-dragon', 'Adult Copper Dragon', 'adult copper dragon', 'srd', '14', 14, 11500, 'Huge', 'dragon', 18, 184, '16d12', 12, '[{"name":"Bite","bonus":11,"damage":["2d10+6"]},{"name":"Claw","bonus":11,"damage":["2d6+6"]},{"name":"Tail","bonus":11,"damage":["2d8+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-gold-dragon', 'Adult Gold Dragon', 'adult gold dragon', 'srd', '17', 17, 18000, 'Huge', 'dragon', 19, 256, '19d12', 14, '[{"name":"Bite","bonus":14,"damage":["2d10+8"]},{"name":"Claw","bonus":14,"damage":["2d6+8"]},{"name":"Tail","bonus":14,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-green-dragon', 'Adult Green Dragon', 'adult green dragon', 'srd', '15', 15, 13000, 'Huge', 'dragon', 19, 207, '18d12', 12, '[{"name":"Bite","bonus":11,"damage":["2d10+6","2d6"]},{"name":"Claw","bonus":11,"damage":["2d6+6"]},{"name":"Tail","bonus":11,"damage":["2d8+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-red-dragon', 'Adult Red Dragon', 'adult red dragon', 'srd', '17', 17, 18000, 'Huge', 'dragon', 19, 256, '19d12', 10, '[{"name":"Bite","bonus":14,"damage":["2d10+8","2d6"]},{"name":"Claw","bonus":14,"damage":["2d6+8"]},{"name":"Tail","bonus":14,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-silver-dragon', 'Adult Silver Dragon', 'adult silver dragon', 'srd', '16', 16, 15000, 'Huge', 'dragon', 19, 243, '18d12', 10, '[{"name":"Bite","bonus":13,"damage":["2d10+8"]},{"name":"Claw","bonus":13,"damage":["2d6+8"]},{"name":"Tail","bonus":13,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('adult-white-dragon', 'Adult White Dragon', 'adult white dragon', 'srd', '13', 13, 10000, 'Huge', 'dragon', 18, 200, '16d12', 10, '[{"name":"Bite","bonus":11,"damage":["2d10+6","1d8"]},{"name":"Claw","bonus":11,"damage":["2d6+6"]},{"name":"Tail","bonus":11,"damage":["2d8+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('air-elemental', 'Air Elemental', 'air elemental', 'srd', '5', 5, 1800, 'Large', 'elemental', 15, 90, '12d10', 20, '[{"name":"Slam","bonus":8,"damage":["2d8+5"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-black-dragon', 'Ancient Black Dragon', 'ancient black dragon', 'srd', '21', 21, 33000, 'Gargantuan', 'dragon', 22, 367, '21d20', 14, '[{"name":"Bite","bonus":15,"damage":["2d10+8","2d8"]},{"name":"Claw","bonus":15,"damage":["2d6+8"]},{"name":"Tail","bonus":15,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-blue-dragon', 'Ancient Blue Dragon', 'ancient blue dragon', 'srd', '23', 23, 50000, 'Gargantuan', 'dragon', 22, 481, '26d20', 10, '[{"name":"Bite","bonus":16,"damage":["2d10+9","2d10"]},{"name":"Claw","bonus":16,"damage":["2d6+9"]},{"name":"Tail","bonus":16,"damage":["2d8+9"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-brass-dragon', 'Ancient Brass Dragon', 'ancient brass dragon', 'srd', '20', 20, 25000, 'Gargantuan', 'dragon', 20, 297, '17d20', 10, '[{"name":"Bite","bonus":14,"damage":["2d10+8"]},{"name":"Claw","bonus":14,"damage":["2d6+8"]},{"name":"Tail","bonus":14,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-bronze-dragon', 'Ancient Bronze Dragon', 'ancient bronze dragon', 'srd', '22', 22, 41000, 'Gargantuan', 'dragon', 22, 444, '24d20', 10, '[{"name":"Bite","bonus":16,"damage":["2d10+9"]},{"name":"Claw","bonus":16,"damage":["2d6+9"]},{"name":"Tail","bonus":16,"damage":["2d8+9"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-copper-dragon', 'Ancient Copper Dragon', 'ancient copper dragon', 'srd', '21', 21, 33000, 'Gargantuan', 'dragon', 21, 350, '20d20', 12, '[{"name":"Bite","bonus":15,"damage":["2d10+8"]},{"name":"Claw","bonus":15,"damage":["2d6+8"]},{"name":"Tail","bonus":15,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-gold-dragon', 'Ancient Gold Dragon', 'ancient gold dragon', 'srd', '24', 24, 62000, 'Gargantuan', 'dragon', 22, 546, '28d20', 14, '[{"name":"Bite","bonus":17,"damage":["2d10+10"]},{"name":"Claw","bonus":17,"damage":["2d6+10"]},{"name":"Tail","bonus":17,"damage":["2d8+10"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-green-dragon', 'Ancient Green Dragon', 'ancient green dragon', 'srd', '22', 22, 41000, 'Gargantuan', 'dragon', 21, 385, '22d20', 12, '[{"name":"Bite","bonus":15,"damage":["2d10+8","3d6"]},{"name":"Claw","bonus":15,"damage":["4d6+8"]},{"name":"Tail","bonus":15,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-red-dragon', 'Ancient Red Dragon', 'ancient red dragon', 'srd', '24', 24, 62000, 'Gargantuan', 'dragon', 22, 546, '28d20', 10, '[{"name":"Bite","bonus":17,"damage":["2d10+10","4d6"]},{"name":"Claw","bonus":17,"damage":["2d6+10"]},{"name":"Tail","bonus":17,"damage":["2d8+10"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-silver-dragon', 'Ancient Silver Dragon', 'ancient silver dragon', 'srd', '23', 23, 50000, 'Gargantuan', 'dragon', 22, 487, '25d20', 10, '[{"name":"Bite","bonus":17,"damage":["2d10+10"]},{"name":"Claw","bonus":17,"damage":["2d6+10"]},{"name":"Tail","bonus":17,"damage":["2d8+10"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ancient-white-dragon', 'Ancient White Dragon', 'ancient white dragon', 'srd', '20', 20, 25000, 'Gargantuan', 'dragon', 20, 333, '18d20', 10, '[{"name":"Bite","bonus":14,"damage":["2d10+8","2d8"]},{"name":"Claw","bonus":14,"damage":["2d6+8"]},{"name":"Tail","bonus":14,"damage":["2d8+8"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('androsphinx', 'Androsphinx', 'androsphinx', 'srd', '17', 17, 18000, 'Large', 'monstrosity', 17, 199, '19d10', 10, '[{"name":"Claw","bonus":12,"damage":["2d10+6"]}]', '["Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('animated-armor', 'Animated Armor', 'animated armor', 'srd', '1', 1, 200, 'Medium', 'construct', 18, 33, '6d8', 11, '[{"name":"Slam","bonus":4,"damage":["1d6+2"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ankheg', 'Ankheg', 'ankheg', 'srd', '2', 2, 450, 'Large', 'monstrosity', 14, 39, '6d10', 11, '[{"name":"Bite","bonus":5,"damage":["2d6+3","1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ape', 'Ape', 'ape', 'srd', '1/2', 0.5, 100, 'Medium', 'beast', 12, 19, '3d8', 14, '[{"name":"Fist","bonus":5,"damage":["1d6+3"]},{"name":"Rock","bonus":5,"damage":["1d6+3"]}]', '["Fist","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('archmage', 'Archmage', 'archmage', 'srd', '12', 12, 8400, 'Medium', 'humanoid', 12, 99, '18d8', 14, '[{"name":"Dagger","bonus":6,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('assassin', 'Assassin', 'assassin', 'srd', '8', 8, 3900, 'Medium', 'humanoid', 15, 78, '12d8', 16, '[{"name":"Shortsword","bonus":6,"damage":["1d6+3","7d6"]},{"name":"Light Crossbow","bonus":6,"damage":["1d8+3","7d6"]}]', '["Shortsword","Light Crossbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('awakened-shrub', 'Awakened Shrub', 'awakened shrub', 'srd', '0', 0, 10, 'Small', 'plant', 9, 10, '3d6', 8, '[{"name":"Rake","bonus":1,"damage":["1d4-1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('awakened-tree', 'Awakened Tree', 'awakened tree', 'srd', '2', 2, 450, 'Huge', 'plant', 13, 59, '7d12', 6, '[{"name":"Slam","bonus":6,"damage":["3d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('axe-beak', 'Axe Beak', 'axe beak', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 11, 19, '3d10', 12, '[{"name":"Beak","bonus":4,"damage":["1d8+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('azer', 'Azer', 'azer', 'srd', '2', 2, 450, 'Medium', 'elemental', 15, 39, '6d8', 12, '[{"name":"Warhammer","bonus":5,"damage":["1d8+3","1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('baboon', 'Baboon', 'baboon', 'srd', '0', 0, 10, 'Small', 'beast', 12, 3, '1d6', 14, '[{"name":"Bite","bonus":1,"damage":["1d4-1"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('badger', 'Badger', 'badger', 'srd', '0', 0, 10, 'Tiny', 'beast', 10, 3, '1d4', 11, '[{"name":"Bite","bonus":2,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('balor', 'Balor', 'balor', 'srd', '19', 19, 22000, 'Huge', 'fiend', 19, 262, '21d12', 15, '[{"name":"Longsword","bonus":14,"damage":["3d8+8","3d8"]},{"name":"Whip","bonus":14,"damage":["2d6+8","3d6"]}]', '["Longsword","Whip"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bandit', 'Bandit', 'bandit', 'srd', '1/8', 0.125, 25, 'Medium', 'humanoid', 12, 11, '2d8', 12, '[{"name":"Scimitar","bonus":3,"damage":["1d6+1"]},{"name":"Light Crossbow","bonus":3,"damage":["1d8+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bandit-captain', 'Bandit Captain', 'bandit captain', 'srd', '2', 2, 450, 'Medium', 'humanoid', 15, 65, '10d8', 16, '[{"name":"Scimitar","bonus":5,"damage":["1d6+3"]},{"name":"Dagger","bonus":5,"damage":["1d4+3"]}]', '["Scimitar","Scimitar","Dagger"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('barbed-devil', 'Barbed Devil', 'barbed devil', 'srd', '5', 5, 1800, 'Medium', 'fiend', 15, 110, '13d8', 17, '[{"name":"Claw","bonus":6,"damage":["1d6+3"]},{"name":"Tail","bonus":6,"damage":["2d6+3"]},{"name":"Hurl Flame","bonus":5,"damage":["3d6"]}]', '["Tail","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('basilisk', 'Basilisk', 'basilisk', 'srd', '3', 3, 700, 'Medium', 'monstrosity', 12, 52, '8d8', 8, '[{"name":"Bite","bonus":5,"damage":["2d6+3","2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bat', 'Bat', 'bat', 'srd', '0', 0, 10, 'Tiny', 'beast', 12, 1, '1d4', 15, '[{"name":"Bite","bonus":0,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bearded-devil', 'Bearded Devil', 'bearded devil', 'srd', '3', 3, 700, 'Medium', 'fiend', 13, 52, '8d8', 15, '[{"name":"Beard","bonus":5,"damage":["1d8+2"]},{"name":"Glaive","bonus":5,"damage":["1d10+3"]}]', '["Beard","Glaive"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('behir', 'Behir', 'behir', 'srd', '11', 11, 7200, 'Huge', 'monstrosity', 17, 168, '16d12', 16, '[{"name":"Bite","bonus":10,"damage":["3d10+6"]},{"name":"Constrict","bonus":10,"damage":["2d10+6","2d10+6"]}]', '["Bite"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('berserker', 'Berserker', 'berserker', 'srd', '2', 2, 450, 'Medium', 'humanoid', 13, 67, '9d8', 12, '[{"name":"Greataxe","bonus":5,"damage":["1d12+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('black-bear', 'Black Bear', 'black bear', 'srd', '1/2', 0.5, 100, 'Medium', 'beast', 11, 19, '3d8', 10, '[{"name":"Bite","bonus":3,"damage":["1d6+2"]},{"name":"Claws","bonus":3,"damage":["2d4+2"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('black-dragon-wyrmling', 'Black Dragon Wyrmling', 'black dragon wyrmling', 'srd', '2', 2, 450, 'Medium', 'dragon', 17, 33, '6d8', 14, '[{"name":"Bite","bonus":4,"damage":["1d10+2","1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('black-pudding', 'Black Pudding', 'black pudding', 'srd', '4', 4, 1100, 'Large', 'ooze', 7, 85, '10d10', 5, '[{"name":"Pseudopod","bonus":5,"damage":["1d6+3","4d8"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('blink-dog', 'Blink Dog', 'blink dog', 'srd', '1/4', 0.25, 50, 'Medium', 'fey', 13, 22, '4d8', 17, '[{"name":"Bite","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('blood-hawk', 'Blood Hawk', 'blood hawk', 'srd', '1/8', 0.125, 25, 'Small', 'beast', 12, 7, '2d6', 14, '[{"name":"Beak","bonus":4,"damage":["1d4+2"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('blue-dragon-wyrmling', 'Blue Dragon Wyrmling', 'blue dragon wyrmling', 'srd', '3', 3, 700, 'Medium', 'dragon', 17, 52, '8d8', 10, '[{"name":"Bite","bonus":5,"damage":["1d10+3","1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('boar', 'Boar', 'boar', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 11, 11, '2d8', 11, '[{"name":"Tusk","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bone-devil', 'Bone Devil', 'bone devil', 'srd', '9', 9, 5000, 'Large', 'fiend', 19, 142, '15d10', 16, '[{"name":"Claw","bonus":8,"damage":["1d8+4"]},{"name":"Sting","bonus":8,"damage":["2d8+4","5d6"]}]', '["Claw","Claw","Sting"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('brass-dragon-wyrmling', 'Brass Dragon Wyrmling', 'brass dragon wyrmling', 'srd', '1', 1, 100, 'Medium', 'dragon', 16, 16, '3d8', 10, '[{"name":"Bite","bonus":4,"damage":["1d10+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bronze-dragon-wyrmling', 'Bronze Dragon Wyrmling', 'bronze dragon wyrmling', 'srd', '2', 2, 450, 'Medium', 'dragon', 17, 32, '5d8', 10, '[{"name":"Bite","bonus":5,"damage":["1d10+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('brown-bear', 'Brown Bear', 'brown bear', 'srd', '1', 1, 200, 'Large', 'beast', 11, 34, '4d10', 10, '[{"name":"Bite","bonus":5,"damage":["1d8+4"]},{"name":"Claws","bonus":5,"damage":["2d6+4"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bugbear', 'Bugbear', 'bugbear', 'srd', '1', 1, 200, 'Medium', 'humanoid', 16, 27, '5d8', 14, '[{"name":"Morningstar","bonus":4,"damage":["2d8+2"]},{"name":"Javelin","bonus":4,"damage":["2d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('bulette', 'Bulette', 'bulette', 'srd', '5', 5, 1800, 'Large', 'monstrosity', 17, 94, '9d10', 11, '[{"name":"Bite","bonus":7,"damage":["4d12+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('camel', 'Camel', 'camel', 'srd', '1/8', 0.125, 25, 'Large', 'beast', 9, 15, '2d10', 8, '[{"name":"Bite","bonus":5,"damage":["1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('cat', 'Cat', 'cat', 'srd', '0', 0, 10, 'Tiny', 'beast', 12, 2, '1d4', 15, '[{"name":"Claws","bonus":0,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('centaur', 'Centaur', 'centaur', 'srd', '2', 2, 450, 'Large', 'monstrosity', 12, 45, '6d10', 14, '[{"name":"Pike","bonus":6,"damage":["1d10+4"]},{"name":"Hooves","bonus":6,"damage":["2d6+4"]},{"name":"Longbow","bonus":4,"damage":["1d8+2"]}]', '["Pike","Hooves","Longbow","Longbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('chain-devil', 'Chain Devil', 'chain devil', 'srd', '8', 8, 3900, 'Medium', 'fiend', 16, 85, '10d8', 15, '[{"name":"Chain","bonus":8,"damage":["2d6+4"]}]', '["Chain","Chain"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('chimera', 'Chimera', 'chimera', 'srd', '6', 6, 2300, 'Large', 'monstrosity', 14, 114, '12d10', 11, '[{"name":"Bite","bonus":7,"damage":["2d6+4"]},{"name":"Horns","bonus":7,"damage":["1d12+4"]},{"name":"Claws","bonus":7,"damage":["2d6+4"]}]', '["Bite","Horns","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('chuul', 'Chuul', 'chuul', 'srd', '4', 4, 1100, 'Large', 'aberration', 16, 93, '11d10', 10, '[{"name":"Pincer","bonus":6,"damage":["2d6+4"]}]', '["Pincer"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('clay-golem', 'Clay Golem', 'clay golem', 'srd', '9', 9, 5000, 'Large', 'construct', 14, 133, '14d10', 9, '[{"name":"Slam","bonus":8,"damage":["2d10+5"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('cloaker', 'Cloaker', 'cloaker', 'srd', '8', 8, 3900, 'Large', 'aberration', 14, 78, '12d10', 15, '[{"name":"Bite","bonus":6,"damage":["2d6+3"]},{"name":"Tail","bonus":6,"damage":["1d8+3"]}]', '["Bite","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('cloud-giant', 'Cloud Giant', 'cloud giant', 'srd', '9', 9, 5000, 'Huge', 'giant', 14, 200, '16d12', 10, '[{"name":"Morningstar","bonus":12,"damage":["3d8+8"]},{"name":"Rock","bonus":12,"damage":["4d10+8"]}]', '["Morningstar","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('cockatrice', 'Cockatrice', 'cockatrice', 'srd', '1/2', 0.5, 100, 'Small', 'monstrosity', 11, 27, '6d6', 12, '[{"name":"Bite","bonus":3,"damage":["1d4+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('commoner', 'Commoner', 'commoner', 'srd', '0', 0, 10, 'Medium', 'humanoid', 10, 4, '1d8', 10, '[{"name":"Club","bonus":2,"damage":["1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('constrictor-snake', 'Constrictor Snake', 'constrictor snake', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 12, 13, '2d10', 14, '[{"name":"Bite","bonus":4,"damage":["1d6+2"]},{"name":"Constrict","bonus":4,"damage":["1d8+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('copper-dragon-wyrmling', 'Copper Dragon Wyrmling', 'copper dragon wyrmling', 'srd', '1', 1, 200, 'Medium', 'dragon', 16, 22, '4d8', 12, '[{"name":"Bite","bonus":4,"damage":["1d10+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('couatl', 'Couatl', 'couatl', 'srd', '4', 4, 1100, 'Medium', 'celestial', 19, 97, '13d8', 20, '[{"name":"Bite","bonus":8,"damage":["1d6+5"]},{"name":"Constrict","bonus":6,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('crab', 'Crab', 'crab', 'srd', '0', 0, 10, 'Tiny', 'beast', 11, 2, '1d4', 11, '[{"name":"Claw","bonus":0,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('crocodile', 'Crocodile', 'crocodile', 'srd', '1/2', 0.5, 100, 'Large', 'beast', 12, 19, '3d10', 10, '[{"name":"Bite","bonus":4,"damage":["1d10+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('cult-fanatic', 'Cult Fanatic', 'cult fanatic', 'srd', '2', 2, 450, 'Medium', 'humanoid', 13, 22, '6d8', 14, '[{"name":"Dagger","bonus":4,"damage":["1d4+2"]}]', '["Dagger"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('cultist', 'Cultist', 'cultist', 'srd', '1/8', 0.125, 25, 'Medium', 'humanoid', 12, 9, '2d8', 12, '[{"name":"Scimitar","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('darkmantle', 'Darkmantle', 'darkmantle', 'srd', '1/2', 0.5, 100, 'Small', 'monstrosity', 11, 22, '5d6', 12, '[{"name":"Crush","bonus":5,"damage":["1d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('death-dog', 'Death Dog', 'death dog', 'srd', '1', 1, 200, 'Medium', 'monstrosity', 12, 39, '6d8', 14, '[{"name":"Bite","bonus":4,"damage":["1d6+2"]}]', '["Bite"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('deep-gnome-svirfneblin', 'Deep Gnome (Svirfneblin)', 'deep gnome (svirfneblin)', 'srd', '1/2', 0.5, 50, 'Small', 'humanoid', 15, 16, '3d6', 14, '[{"name":"War Pick","bonus":4,"damage":["1d8+2"]},{"name":"Poisoned Dart","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('deer', 'Deer', 'deer', 'srd', '0', 0, 10, 'Medium', 'beast', 13, 4, '1d8', 16, '[{"name":"Bite","bonus":2,"damage":["1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('deva', 'Deva', 'deva', 'srd', '10', 10, 5900, 'Medium', 'celestial', 17, 136, '16d8', 18, '[{"name":"Mace","bonus":8,"damage":["1d6+4","4d8"]}]', '["Mace"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('dire-wolf', 'Dire Wolf', 'dire wolf', 'srd', '1', 1, 200, 'Large', 'beast', 14, 37, '5d10', 15, '[{"name":"Bite","bonus":5,"damage":["2d6+3"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('djinni', 'Djinni', 'djinni', 'srd', '11', 11, 7200, 'Large', 'elemental', 17, 161, '14d10', 15, '[{"name":"Scimitar","bonus":9,"damage":["2d6+5"]}]', '["Scimitar"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('doppelganger', 'Doppelganger', 'doppelganger', 'srd', '3', 3, 700, 'Medium', 'monstrosity', 14, 52, '8d8', 18, '[{"name":"Slam","bonus":6,"damage":["1d6+4"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('draft-horse', 'Draft Horse', 'draft horse', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 10, 19, '3d10', 10, '[{"name":"Hooves","bonus":6,"damage":["2d4+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('dragon-turtle', 'Dragon Turtle', 'dragon turtle', 'srd', '17', 17, 18000, 'Gargantuan', 'dragon', 20, 341, '22d20', 10, '[{"name":"Bite","bonus":13,"damage":["3d12+7"]},{"name":"Claw","bonus":13,"damage":["2d8+7"]},{"name":"Tail","bonus":13,"damage":["3d12+7"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('dretch', 'Dretch', 'dretch', 'srd', '1/4', 0.25, 25, 'Small', 'fiend', 11, 18, '4d6', 11, '[{"name":"Bite","bonus":2,"damage":["1d6"]},{"name":"Claws","bonus":2,"damage":["2d4"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('drider', 'Drider', 'drider', 'srd', '6', 6, 2300, 'Large', 'monstrosity', 19, 123, '13d10', 16, '[{"name":"Bite","bonus":6,"damage":["1d4","2d8"]},{"name":"Longsword","bonus":6,"damage":[]},{"name":"Longbow","bonus":6,"damage":["1d8+3","1d8"]}]', '["Bite","Longsword","Longbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('drow', 'Drow', 'drow', 'srd', '1/4', 0.25, 50, 'Medium', 'humanoid', 15, 13, '3d8', 14, '[{"name":"Shortsword","bonus":4,"damage":["1d6+2"]},{"name":"Hand Crossbow","bonus":4,"damage":["1d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('druid', 'Druid', 'druid', 'srd', '2', 2, 450, 'Medium', 'humanoid', 11, 27, '5d8', 12, '[{"name":"Quarterstaff","bonus":2,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('dryad', 'Dryad', 'dryad', 'srd', '1', 1, 200, 'Medium', 'fey', 11, 22, '5d8', 12, '[{"name":"Club","bonus":2,"damage":["1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('duergar', 'Duergar', 'duergar', 'srd', '1', 1, 200, 'Medium', 'humanoid', 16, 26, '4d8', 11, '[{"name":"War Pick","bonus":4,"damage":["1d8+2"]},{"name":"Javelin","bonus":4,"damage":["1d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('dust-mephit', 'Dust Mephit', 'dust mephit', 'srd', '1/2', 0.5, 100, 'Small', 'elemental', 12, 17, '5d6', 14, '[{"name":"Claws","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('eagle', 'Eagle', 'eagle', 'srd', '0', 0, 10, 'Small', 'beast', 12, 3, '1d6', 15, '[{"name":"Talons","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('earth-elemental', 'Earth Elemental', 'earth elemental', 'srd', '5', 5, 1800, 'Large', 'elemental', 17, 126, '12d10', 8, '[{"name":"Slam","bonus":8,"damage":["2d8+5"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('efreeti', 'Efreeti', 'efreeti', 'srd', '11', 11, 7200, 'Large', 'elemental', 17, 200, '16d10', 12, '[{"name":"Scimitar","bonus":10,"damage":["2d6+6","2d6"]},{"name":"Hurl Flame","bonus":7,"damage":["5d6"]}]', '["Scimitar","Hurl Flame"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('elephant', 'Elephant', 'elephant', 'srd', '4', 4, 1100, 'Huge', 'beast', 12, 76, '8d12', 9, '[{"name":"Gore","bonus":8,"damage":["3d8+6"]},{"name":"Stomp","bonus":8,"damage":["3d10+6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('elk', 'Elk', 'elk', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 10, 13, '2d10', 10, '[{"name":"Ram","bonus":5,"damage":["1d6+3"]},{"name":"Hooves","bonus":5,"damage":["2d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('erinyes', 'Erinyes', 'erinyes', 'srd', '12', 12, 8400, 'Medium', 'fiend', 18, 153, '18d8', 16, '[{"name":"Longsword","bonus":8,"damage":["3d8"]},{"name":"Longbow","bonus":7,"damage":["1d8+3","3d8"]}]', '["Longsword","Longbow","Longsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ettercap', 'Ettercap', 'ettercap', 'srd', '2', 2, 450, 'Medium', 'monstrosity', 13, 44, '8d8', 15, '[{"name":"Bite","bonus":4,"damage":["1d8+2","1d8"]},{"name":"Claws","bonus":4,"damage":["2d4+2"]},{"name":"Web","bonus":4,"damage":[]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ettin', 'Ettin', 'ettin', 'srd', '4', 4, 1100, 'Large', 'giant', 12, 85, '10d10', 8, '[{"name":"Battleaxe","bonus":7,"damage":["2d8+5"]},{"name":"Morningstar","bonus":7,"damage":["2d8+5"]}]', '["Battleaxe","Morningstar"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('fire-elemental', 'Fire Elemental', 'fire elemental', 'srd', '5', 5, 1800, 'Large', 'elemental', 13, 102, '12d10', 17, '[{"name":"Touch","bonus":6,"damage":["2d6+3"]}]', '["Touch"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('fire-giant', 'Fire Giant', 'fire giant', 'srd', '9', 9, 5000, 'Huge', 'giant', 18, 162, '13d12', 9, '[{"name":"Greatsword","bonus":11,"damage":["6d6+7"]},{"name":"Rock","bonus":11,"damage":["4d10+7"]}]', '["Greatsword","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('flesh-golem', 'Flesh Golem', 'flesh golem', 'srd', '5', 5, 1800, 'Medium', 'construct', 9, 93, '11d8', 9, '[{"name":"Slam","bonus":7,"damage":["2d8+4"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('flying-snake', 'Flying Snake', 'flying snake', 'srd', '1/8', 0.125, 25, 'Tiny', 'beast', 14, 5, '2d4', 18, '[{"name":"Bite","bonus":6,"damage":["1","3d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('flying-sword', 'Flying Sword', 'flying sword', 'srd', '1/4', 0.25, 50, 'Small', 'construct', 17, 17, '5d6', 15, '[{"name":"Longsword","bonus":3,"damage":["1d8+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('frog', 'Frog', 'frog', 'srd', '0', 0, 0, 'Tiny', 'beast', 11, 1, '1d4', 13, '[]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('frost-giant', 'Frost Giant', 'frost giant', 'srd', '8', 8, 3900, 'Huge', 'giant', 15, 138, '12d12', 9, '[{"name":"Greataxe","bonus":9,"damage":["3d12+6"]},{"name":"Rock","bonus":9,"damage":["4d10+6"]}]', '["Greataxe","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gargoyle', 'Gargoyle', 'gargoyle', 'srd', '2', 2, 450, 'Medium', 'elemental', 15, 52, '7d8', 11, '[{"name":"Bite","bonus":4,"damage":["1d6+2"]},{"name":"Claws","bonus":4,"damage":["1d6+2"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gelatinous-cube', 'Gelatinous Cube', 'gelatinous cube', 'srd', '2', 2, 450, 'Large', 'ooze', 6, 84, '8d10', 3, '[{"name":"Pseudopod","bonus":4,"damage":["3d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ghast', 'Ghast', 'ghast', 'srd', '2', 2, 450, 'Medium', 'undead', 13, 36, '8d8', 17, '[{"name":"Bite","bonus":3,"damage":["2d8+3"]},{"name":"Claws","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ghost', 'Ghost', 'ghost', 'srd', '4', 4, 1100, 'Medium', 'undead', 11, 45, '10d8', 13, '[{"name":"Withering Touch","bonus":5,"damage":["4d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ghoul', 'Ghoul', 'ghoul', 'srd', '1', 1, 200, 'Medium', 'undead', 12, 22, '5d8', 15, '[{"name":"Bite","bonus":2,"damage":["2d6+2"]},{"name":"Claws","bonus":4,"damage":["2d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-ape', 'Giant Ape', 'giant ape', 'srd', '7', 7, 2900, 'Huge', 'beast', 12, 157, '15d12', 14, '[{"name":"Fist","bonus":9,"damage":["3d10+6"]},{"name":"Rock","bonus":9,"damage":["7d6+6"]}]', '["Fist","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-badger', 'Giant Badger', 'giant badger', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 10, 13, '2d8', 10, '[{"name":"Bite","bonus":3,"damage":["1d6+1"]},{"name":"Claws","bonus":3,"damage":["2d4+1"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-bat', 'Giant Bat', 'giant bat', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 13, 22, '4d10', 16, '[{"name":"Bite","bonus":4,"damage":["1d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-boar', 'Giant Boar', 'giant boar', 'srd', '2', 2, 450, 'Large', 'beast', 12, 42, '5d10', 10, '[{"name":"Tusk","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-centipede', 'Giant Centipede', 'giant centipede', 'srd', '1/4', 0.25, 50, 'Small', 'beast', 13, 4, '1d6', 14, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-constrictor-snake', 'Giant Constrictor Snake', 'giant constrictor snake', 'srd', '2', 2, 450, 'Huge', 'beast', 12, 60, '8d12', 14, '[{"name":"Bite","bonus":6,"damage":["2d6+4"]},{"name":"Constrict","bonus":6,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-crab', 'Giant Crab', 'giant crab', 'srd', '1/8', 0.125, 25, 'Medium', 'beast', 15, 13, '3d8', 15, '[{"name":"Claw","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-crocodile', 'Giant Crocodile', 'giant crocodile', 'srd', '5', 5, 1800, 'Huge', 'beast', 14, 85, '9d12', 9, '[{"name":"Bite","bonus":8,"damage":["3d10+5"]},{"name":"Tail","bonus":8,"damage":["2d8+5"]}]', '["Bite","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-eagle', 'Giant Eagle', 'giant eagle', 'srd', '1', 1, 200, 'Large', 'beast', 13, 26, '4d10', 17, '[{"name":"Beak","bonus":5,"damage":["1d6+3"]},{"name":"Talons","bonus":5,"damage":["2d6+3"]}]', '["Beak","Talons"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-elk', 'Giant Elk', 'giant elk', 'srd', '2', 2, 450, 'Huge', 'beast', 14, 42, '5d12', 16, '[{"name":"Ram","bonus":6,"damage":["2d6+4"]},{"name":"Hooves","bonus":6,"damage":["4d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-fire-beetle', 'Giant Fire Beetle', 'giant fire beetle', 'srd', '0', 0, 10, 'Small', 'beast', 13, 4, '1d6', 10, '[{"name":"Bite","bonus":1,"damage":["1d6-1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-frog', 'Giant Frog', 'giant frog', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 11, 18, '4d8', 13, '[{"name":"Bite","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-goat', 'Giant Goat', 'giant goat', 'srd', '1/2', 0.5, 100, 'Large', 'beast', 11, 19, '3d10', 11, '[{"name":"Ram","bonus":5,"damage":["2d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-hyena', 'Giant Hyena', 'giant hyena', 'srd', '1', 1, 200, 'Large', 'beast', 12, 45, '6d10', 14, '[{"name":"Bite","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-lizard', 'Giant Lizard', 'giant lizard', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 12, 19, '3d10', 12, '[{"name":"Bite","bonus":4,"damage":["1d8+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-octopus', 'Giant Octopus', 'giant octopus', 'srd', '1', 1, 200, 'Large', 'beast', 11, 52, '8d10', 13, '[{"name":"Tentacles","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-owl', 'Giant Owl', 'giant owl', 'srd', '1/4', 0.25, 50, 'Large', 'beast', 12, 19, '3d10', 15, '[{"name":"Talons","bonus":3,"damage":["2d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-poisonous-snake', 'Giant Poisonous Snake', 'giant poisonous snake', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 14, 11, '2d8', 18, '[{"name":"Bite","bonus":6,"damage":["1d4+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-rat', 'Giant Rat', 'giant rat', 'srd', '1/8', 0.125, 25, 'Small', 'beast', 12, 7, '2d6', 15, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-rat-diseased', 'Giant Rat (Diseased)', 'giant rat (diseased)', 'srd', '1/8', 0.125, 25, 'Small', 'beast', 12, 7, '2d6', 15, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-scorpion', 'Giant Scorpion', 'giant scorpion', 'srd', '3', 3, 700, 'Large', 'beast', 15, 52, '7d10', 13, '[{"name":"Claw","bonus":4,"damage":["1d8+2"]},{"name":"Sting","bonus":4,"damage":["1d10+2"]}]', '["Claw","Claw","Sting"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-sea-horse', 'Giant Sea Horse', 'giant sea horse', 'srd', '1/2', 0.5, 100, 'Large', 'beast', 13, 16, '3d10', 15, '[{"name":"Ram","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-shark', 'Giant Shark', 'giant shark', 'srd', '5', 5, 1800, 'Huge', 'beast', 13, 126, '11d12', 11, '[{"name":"Bite","bonus":9,"damage":["3d10+6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-spider', 'Giant Spider', 'giant spider', 'srd', '1', 1, 200, 'Large', 'beast', 14, 26, '4d10', 16, '[{"name":"Bite","bonus":5,"damage":["1d8+3"]},{"name":"Web","bonus":5,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-toad', 'Giant Toad', 'giant toad', 'srd', '1', 1, 200, 'Large', 'beast', 11, 39, '6d10', 13, '[{"name":"Bite","bonus":4,"damage":["1d10+2","1d10"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-vulture', 'Giant Vulture', 'giant vulture', 'srd', '1', 1, 200, 'Large', 'beast', 10, 22, '3d10', 10, '[{"name":"Beak","bonus":4,"damage":["2d4+2"]},{"name":"Talons","bonus":4,"damage":["2d6+2"]}]', '["Beak","Talons"]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-wasp', 'Giant Wasp', 'giant wasp', 'srd', '1/2', 0.5, 100, 'Medium', 'beast', 12, 13, '3d8', 14, '[{"name":"Sting","bonus":4,"damage":["1d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-weasel', 'Giant Weasel', 'giant weasel', 'srd', '1/8', 0.125, 25, 'Medium', 'beast', 13, 9, '2d8', 16, '[{"name":"Bite","bonus":5,"damage":["1d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('giant-wolf-spider', 'Giant Wolf Spider', 'giant wolf spider', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 13, 11, '2d8', 16, '[{"name":"Bite","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gibbering-mouther', 'Gibbering Mouther', 'gibbering mouther', 'srd', '2', 2, 450, 'Medium', 'aberration', 9, 67, '9d8', 8, '[{"name":"Bites","bonus":2,"damage":["5d6"]}]', '["Bites"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('glabrezu', 'Glabrezu', 'glabrezu', 'srd', '9', 9, 5000, 'Large', 'fiend', 17, 157, '15d10', 15, '[{"name":"Pincer","bonus":9,"damage":["2d10+5"]},{"name":"Fist","bonus":9,"damage":["2d4+2"]}]', '["Pincer","Pincer","Fist","Fist"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gladiator', 'Gladiator', 'gladiator', 'srd', '5', 5, 1800, 'Medium', 'humanoid', 16, 112, '15d8', 15, '[{"name":"Spear","bonus":7,"damage":[]},{"name":"Shield Bash","bonus":7,"damage":["2d4+4"]}]', '["Spear","Shield Bash"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gnoll', 'Gnoll', 'gnoll', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 15, 22, '5d8', 12, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]},{"name":"Spear","bonus":4,"damage":[]},{"name":"Longbow","bonus":3,"damage":["1d8+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('goat', 'Goat', 'goat', 'srd', '0', 0, 10, 'Medium', 'beast', 10, 4, '1d8', 10, '[{"name":"Ram","bonus":3,"damage":["1d4+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('goblin', 'Goblin', 'goblin', 'srd', '1/4', 0.25, 50, 'Small', 'humanoid', 15, 7, '2d6', 14, '[{"name":"Scimitar","bonus":4,"damage":["1d6+2"]},{"name":"Shortbow","bonus":4,"damage":["1d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gold-dragon-wyrmling', 'Gold Dragon Wyrmling', 'gold dragon wyrmling', 'srd', '3', 3, 700, 'Medium', 'dragon', 17, 60, '8d8', 14, '[{"name":"Bite","bonus":6,"damage":["1d10+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gorgon', 'Gorgon', 'gorgon', 'srd', '5', 5, 1800, 'Large', 'monstrosity', 19, 114, '12d10', 11, '[{"name":"Gore","bonus":8,"damage":["2d12+5"]},{"name":"Hooves","bonus":8,"damage":["2d10+5"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gray-ooze', 'Gray Ooze', 'gray ooze', 'srd', '1/2', 0.5, 100, 'Medium', 'ooze', 8, 22, '3d8', 6, '[{"name":"Pseudopod","bonus":3,"damage":["1d6+1","2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('green-dragon-wyrmling', 'Green Dragon Wyrmling', 'green dragon wyrmling', 'srd', '2', 2, 450, 'Medium', 'dragon', 17, 38, '7d8', 12, '[{"name":"Bite","bonus":4,"damage":["1d10+2","1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('green-hag', 'Green Hag', 'green hag', 'srd', '3', 3, 700, 'Medium', 'fey', 17, 82, '11d8', 12, '[{"name":"Claws","bonus":6,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('grick', 'Grick', 'grick', 'srd', '2', 2, 450, 'Medium', 'monstrosity', 14, 27, '6d8', 14, '[{"name":"Tentacles","bonus":4,"damage":["2d6+2"]},{"name":"Beak","bonus":4,"damage":["1d6+2"]}]', '["Tentacles","Beak"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('griffon', 'Griffon', 'griffon', 'srd', '2', 2, 450, 'Large', 'monstrosity', 12, 59, '7d10', 15, '[{"name":"Beak","bonus":6,"damage":["1d8+4"]},{"name":"Claws","bonus":6,"damage":["2d6+4"]}]', '["Beak","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('grimlock', 'Grimlock', 'grimlock', 'srd', '1/4', 0.25, 50, 'Medium', 'humanoid', 11, 11, '2d8', 12, '[{"name":"Spiked Bone Club","bonus":5,"damage":["1d4+3","1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('guard', 'Guard', 'guard', 'srd', '1/8', 0.125, 25, 'Medium', 'humanoid', 16, 11, '2d8', 12, '[{"name":"Spear","bonus":3,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('guardian-naga', 'Guardian Naga', 'guardian naga', 'srd', '10', 10, 5900, 'Large', 'monstrosity', 18, 127, '15d10', 18, '[{"name":"Bite","bonus":8,"damage":["1d8+4"]},{"name":"Spit Poison","bonus":8,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('gynosphinx', 'Gynosphinx', 'gynosphinx', 'srd', '11', 11, 7200, 'Large', 'monstrosity', 17, 136, '16d10', 15, '[{"name":"Claw","bonus":9,"damage":["2d8+4"]}]', '["Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('half-red-dragon-veteran', 'Half-Red Dragon Veteran', 'half-red dragon veteran', 'srd', '5', 5, 1800, 'Medium', 'humanoid', 18, 65, '10d8', 13, '[{"name":"Longsword","bonus":5,"damage":[]},{"name":"Shortsword","bonus":5,"damage":["1d6+3"]},{"name":"Heavy Crossbow","bonus":3,"damage":["1d10+1"]}]', '["Longsword","Shortsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('harpy', 'Harpy', 'harpy', 'srd', '1', 1, 200, 'Medium', 'monstrosity', 11, 38, '7d8', 13, '[{"name":"Claws","bonus":3,"damage":["2d4+1"]},{"name":"Club","bonus":3,"damage":["1d4+1"]}]', '["Claws","Club"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hawk', 'Hawk', 'hawk', 'srd', '0', 0, 10, 'Tiny', 'beast', 13, 1, '1d4', 16, '[{"name":"Talons","bonus":5,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hell-hound', 'Hell Hound', 'hell hound', 'srd', '3', 3, 700, 'Medium', 'fiend', 15, 45, '7d8', 12, '[{"name":"Bite","bonus":5,"damage":["1d8+3","2d6"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hezrou', 'Hezrou', 'hezrou', 'srd', '8', 8, 3900, 'Large', 'fiend', 16, 136, '13d10', 17, '[{"name":"Bite","bonus":7,"damage":["2d10+4"]},{"name":"Claws","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claws","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hill-giant', 'Hill Giant', 'hill giant', 'srd', '5', 5, 1800, 'Huge', 'giant', 13, 105, '10d12', 8, '[{"name":"Greatclub","bonus":8,"damage":["3d8+5"]},{"name":"Rock","bonus":8,"damage":["3d10+5"]}]', '["Greatclub","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hippogriff', 'Hippogriff', 'hippogriff', 'srd', '1', 1, 200, 'Large', 'monstrosity', 11, 19, '3d10', 13, '[{"name":"Beak","bonus":5,"damage":["1d10+3"]},{"name":"Claws","bonus":5,"damage":["2d6+3"]}]', '["Beak","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hobgoblin', 'Hobgoblin', 'hobgoblin', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 18, 11, '2d8', 12, '[{"name":"Longsword","bonus":3,"damage":[]},{"name":"Longbow","bonus":3,"damage":["1d8+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('homunculus', 'Homunculus', 'homunculus', 'srd', '0', 0, 10, 'Tiny', 'construct', 13, 5, '2d4', 15, '[{"name":"Bite","bonus":4,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('horned-devil', 'Horned Devil', 'horned devil', 'srd', '11', 11, 7200, 'Large', 'fiend', 18, 178, '17d10', 17, '[{"name":"Fork","bonus":10,"damage":["2d8+6"]},{"name":"Tail","bonus":10,"damage":["1d8+6"]},{"name":"Hurl Flame","bonus":7,"damage":["4d6"]}]', '["Fork","Fork","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hunter-shark', 'Hunter Shark', 'hunter shark', 'srd', '2', 2, 450, 'Large', 'beast', 12, 45, '6d10', 13, '[{"name":"Bite","bonus":6,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hydra', 'Hydra', 'hydra', 'srd', '8', 8, 3900, 'Huge', 'monstrosity', 15, 172, '15d12', 12, '[{"name":"Bite","bonus":8,"damage":["1d10+5"]}]', '["Bite"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('hyena', 'Hyena', 'hyena', 'srd', '0', 0, 10, 'Medium', 'beast', 11, 5, '1d8', 13, '[{"name":"Bite","bonus":2,"damage":["1d6"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ice-devil', 'Ice Devil', 'ice devil', 'srd', '14', 14, 11500, 'Large', 'fiend', 18, 180, '19d10', 14, '[{"name":"Bite","bonus":10,"damage":["2d6+5","3d6"]},{"name":"Claws","bonus":10,"damage":["2d4+5","3d6"]},{"name":"Tail","bonus":10,"damage":["2d6+5","3d6"]}]', '["Bite","Claws","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ice-mephit', 'Ice Mephit', 'ice mephit', 'srd', '1/2', 0.5, 100, 'Small', 'elemental', 11, 21, '6d6', 13, '[{"name":"Claws","bonus":3,"damage":["1d4+1","1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('imp', 'Imp', 'imp', 'srd', '1', 1, 200, 'Tiny', 'fiend', 13, 10, '3d4', 17, '[{"name":"Sting (Bite in Beast Form)","bonus":5,"damage":["1d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('invisible-stalker', 'Invisible Stalker', 'invisible stalker', 'srd', '6', 6, 2300, 'Medium', 'elemental', 14, 104, '16d8', 19, '[{"name":"Slam","bonus":6,"damage":["2d6+3"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('iron-golem', 'Iron Golem', 'iron golem', 'srd', '16', 16, 15000, 'Large', 'construct', 20, 210, '20d10', 9, '[{"name":"Slam","bonus":13,"damage":["3d8+7"]},{"name":"Sword","bonus":13,"damage":["3d10+7"]}]', '["Slam","Sword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('jackal', 'Jackal', 'jackal', 'srd', '0', 0, 10, 'Small', 'beast', 12, 3, '1d6', 15, '[{"name":"Bite","bonus":1,"damage":["1d4-1"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('killer-whale', 'Killer Whale', 'killer whale', 'srd', '3', 3, 700, 'Huge', 'beast', 12, 90, '12d12', 10, '[{"name":"Bite","bonus":6,"damage":["5d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('knight', 'Knight', 'knight', 'srd', '3', 3, 700, 'Medium', 'humanoid', 18, 52, '8d8', 11, '[{"name":"Greatsword","bonus":5,"damage":["2d6+3"]},{"name":"Heavy Crossbow","bonus":2,"damage":["1d10"]}]', '["Greatsword","Heavy Crossbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('kobold', 'Kobold', 'kobold', 'srd', '1/8', 0.125, 25, 'Small', 'humanoid', 12, 5, '2d6', 15, '[{"name":"Dagger","bonus":4,"damage":["1d4+2"]},{"name":"Sling","bonus":4,"damage":["1d4+2"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('kraken', 'Kraken', 'kraken', 'srd', '23', 23, 50000, 'Gargantuan', 'monstrosity', 18, 472, '27d20', 11, '[{"name":"Bite","bonus":7,"damage":["3d8+10"]},{"name":"Tentacle","bonus":7,"damage":["3d6+10"]}]', '["Bite","Tentacle"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('lamia', 'Lamia', 'lamia', 'srd', '4', 4, 1100, 'Large', 'monstrosity', 13, 97, '13d10', 13, '[{"name":"Claws","bonus":5,"damage":["2d10+3"]},{"name":"Dagger","bonus":5,"damage":["1d4+3"]},{"name":"Intoxicating Touch","bonus":5,"damage":[]}]', '["Claws","Dagger"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('lemure', 'Lemure', 'lemure', 'srd', '0', 0, 10, 'Medium', 'fiend', 7, 13, '3d8', 5, '[{"name":"Fist","bonus":3,"damage":["1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('lich', 'Lich', 'lich', 'srd', '21', 21, 33000, 'Medium', 'undead', 17, 135, '18d8', 16, '[{"name":"Paralyzing Touch","bonus":12,"damage":["3d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('lion', 'Lion', 'lion', 'srd', '1', 1, 200, 'Large', 'beast', 12, 26, '4d10', 15, '[{"name":"Bite","bonus":5,"damage":["1d8+3"]},{"name":"Claw","bonus":5,"damage":["1d6+3"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('lizard', 'Lizard', 'lizard', 'srd', '0', 0, 10, 'Tiny', 'beast', 10, 2, '1d4', 11, '[{"name":"Bite","bonus":0,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('lizardfolk', 'Lizardfolk', 'lizardfolk', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 13, 22, '4d8', 10, '[{"name":"Bite","bonus":4,"damage":["1d6+2"]},{"name":"Heavy Club","bonus":4,"damage":["1d6+2"]},{"name":"Javelin","bonus":4,"damage":["1d6+2"]},{"name":"Spiked Shield","bonus":4,"damage":["1d6+2"]}]', '["Bite","Heavy Club"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mage', 'Mage', 'mage', 'srd', '6', 6, 2300, 'Medium', 'humanoid', 12, 40, '9d8', 14, '[{"name":"Dagger","bonus":5,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('magma-mephit', 'Magma Mephit', 'magma mephit', 'srd', '1/2', 0.5, 100, 'Small', 'elemental', 11, 22, '5d6', 12, '[{"name":"Claws","bonus":3,"damage":["1d4+1","1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('magmin', 'Magmin', 'magmin', 'srd', '1/2', 0.5, 100, 'Small', 'elemental', 14, 9, '2d6', 15, '[{"name":"Touch","bonus":4,"damage":["2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mammoth', 'Mammoth', 'mammoth', 'srd', '6', 6, 2300, 'Huge', 'beast', 13, 126, '11d12', 9, '[{"name":"Gore","bonus":10,"damage":["4d8+7"]},{"name":"Stomp","bonus":10,"damage":["4d10+7"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('manticore', 'Manticore', 'manticore', 'srd', '3', 3, 700, 'Large', 'monstrosity', 14, 68, '8d10', 16, '[{"name":"Bite","bonus":5,"damage":["1d8+3"]},{"name":"Claw","bonus":5,"damage":["1d6+3"]},{"name":"Tail Spike","bonus":5,"damage":["1d8+3"]}]', '["Bite","Claw","Claw","Tail Spike","Tail Spike","Tail Spike"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('marilith', 'Marilith', 'marilith', 'srd', '16', 16, 15000, 'Large', 'fiend', 18, 189, '18d10', 20, '[{"name":"Longsword","bonus":9,"damage":["2d8+4"]},{"name":"Tail","bonus":9,"damage":["2d10+4"]}]', '["Longsword","Longsword","Longsword","Longsword","Longsword","Longsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mastiff', 'Mastiff', 'mastiff', 'srd', '1/8', 0.125, 25, 'Medium', 'beast', 12, 5, '1d8', 14, '[{"name":"Bite","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('medusa', 'Medusa', 'medusa', 'srd', '6', 6, 2300, 'Medium', 'monstrosity', 15, 127, '17d8', 15, '[{"name":"Snake Hair","bonus":5,"damage":["1d4+2","4d6"]},{"name":"Shortsword","bonus":5,"damage":["1d6+2"]},{"name":"Longbow","bonus":5,"damage":["1d8+2","2d6"]}]', '["Snake Hair","Shortsword","Shortsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('merfolk', 'Merfolk', 'merfolk', 'srd', '1/8', 0.125, 25, 'Medium', 'humanoid', 11, 11, '2d8', 13, '[{"name":"Spear","bonus":2,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('merrow', 'Merrow', 'merrow', 'srd', '2', 2, 450, 'Large', 'monstrosity', 13, 45, '6d10', 10, '[{"name":"Bite","bonus":6,"damage":["1d8+4"]},{"name":"Claws","bonus":6,"damage":["2d4+4"]},{"name":"Harpoon","bonus":6,"damage":["2d6+4"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mimic', 'Mimic', 'mimic', 'srd', '2', 2, 450, 'Medium', 'monstrosity', 12, 58, '9d8', 12, '[{"name":"Pseudopod","bonus":5,"damage":["1d8+3"]},{"name":"Bite","bonus":5,"damage":["1d8+3","1d8"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('minotaur', 'Minotaur', 'minotaur', 'srd', '3', 3, 700, 'Large', 'monstrosity', 14, 76, '9d10', 11, '[{"name":"Greataxe","bonus":6,"damage":["2d12+4"]},{"name":"Gore","bonus":6,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('minotaur-skeleton', 'Minotaur Skeleton', 'minotaur skeleton', 'srd', '2', 2, 450, 'Large', 'undead', 12, 67, '9d10', 11, '[{"name":"Greataxe","bonus":6,"damage":["2d12+4"]},{"name":"Gore","bonus":6,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mule', 'Mule', 'mule', 'srd', '1/8', 0.125, 25, 'Medium', 'beast', 10, 11, '2d8', 10, '[{"name":"Hooves","bonus":2,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mummy', 'Mummy', 'mummy', 'srd', '3', 3, 700, 'Medium', 'undead', 11, 58, '9d8', 8, '[{"name":"Rotting Fist","bonus":5,"damage":["2d6+3","3d6"]}]', '["Rotting Fist"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('mummy-lord', 'Mummy Lord', 'mummy lord', 'srd', '15', 15, 13000, 'Medium', 'undead', 17, 97, '13d8', 10, '[{"name":"Rotting Fist","bonus":9,"damage":["3d6+4","6d6"]}]', '["Rotting Fist"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('nalfeshnee', 'Nalfeshnee', 'nalfeshnee', 'srd', '13', 13, 10000, 'Large', 'fiend', 18, 184, '16d10', 10, '[{"name":"Bite","bonus":10,"damage":["5d10+5"]},{"name":"Claw","bonus":10,"damage":["3d6+5"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('night-hag', 'Night Hag', 'night hag', 'srd', '5', 5, 1800, 'Medium', 'fiend', 17, 112, '15d8', 15, '[{"name":"Claws (Hag Form Only)","bonus":7,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('nightmare', 'Nightmare', 'nightmare', 'srd', '3', 3, 700, 'Large', 'fiend', 13, 68, '8d10', 15, '[{"name":"Hooves","bonus":6,"damage":["2d8+4","2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('noble', 'Noble', 'noble', 'srd', '1/8', 0.125, 25, 'Medium', 'humanoid', 15, 9, '2d8', 12, '[{"name":"Rapier","bonus":3,"damage":["1d8+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ochre-jelly', 'Ochre Jelly', 'ochre jelly', 'srd', '2', 2, 450, 'Large', 'ooze', 8, 45, '6d10', 6, '[{"name":"Pseudopod","bonus":4,"damage":["2d6+2","1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('octopus', 'Octopus', 'octopus', 'srd', '0', 0, 10, 'Small', 'beast', 12, 3, '1d6', 15, '[{"name":"Tentacles","bonus":4,"damage":["1"]},{"name":"Ink Cloud","bonus":0,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ogre', 'Ogre', 'ogre', 'srd', '2', 2, 450, 'Large', 'giant', 11, 59, '7d10', 8, '[{"name":"Greatclub","bonus":6,"damage":["2d8+4"]},{"name":"Javelin","bonus":6,"damage":["2d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('ogre-zombie', 'Ogre Zombie', 'ogre zombie', 'srd', '2', 2, 450, 'Large', 'undead', 8, 85, '9d10', 6, '[{"name":"Morningstar","bonus":6,"damage":["2d8+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('oni', 'Oni', 'oni', 'srd', '7', 7, 2900, 'Large', 'giant', 16, 110, '13d10', 11, '[{"name":"Claw (Oni Form Only)","bonus":7,"damage":["1d8+4"]},{"name":"Glaive","bonus":7,"damage":["2d10+4"]}]', '["Claw (Oni Form Only)","Glaive"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('orc', 'Orc', 'orc', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 13, 15, '2d8', 12, '[{"name":"Greataxe","bonus":5,"damage":["1d12+3"]},{"name":"Javelin","bonus":5,"damage":["1d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('otyugh', 'Otyugh', 'otyugh', 'srd', '5', 5, 1800, 'Large', 'aberration', 14, 114, '12d10', 11, '[{"name":"Bite","bonus":6,"damage":["2d8+3"]},{"name":"Tentacle","bonus":6,"damage":["1d8+3","1d8"]}]', '["Bite","Tentacle","Tentacle"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('owl', 'Owl', 'owl', 'srd', '0', 0, 10, 'Tiny', 'beast', 11, 1, '1d4', 13, '[{"name":"Talons","bonus":3,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('owlbear', 'Owlbear', 'owlbear', 'srd', '3', 3, 700, 'Large', 'monstrosity', 13, 59, '7d10', 12, '[{"name":"Beak","bonus":7,"damage":["1d10+5"]},{"name":"Claws","bonus":7,"damage":["2d8+5"]}]', '["Beak","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('panther', 'Panther', 'panther', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 12, 13, '3d8', 15, '[{"name":"Bite","bonus":4,"damage":["1d6+2"]},{"name":"Claw","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('pegasus', 'Pegasus', 'pegasus', 'srd', '2', 2, 450, 'Large', 'celestial', 12, 59, '7d10', 15, '[{"name":"Hooves","bonus":6,"damage":["2d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('phase-spider', 'Phase Spider', 'phase spider', 'srd', '3', 3, 700, 'Large', 'monstrosity', 13, 32, '5d10', 15, '[{"name":"Bite","bonus":4,"damage":["1d10+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('pit-fiend', 'Pit Fiend', 'pit fiend', 'srd', '20', 20, 25000, 'Large', 'fiend', 19, 300, '24d10', 14, '[{"name":"Bite","bonus":14,"damage":["4d6+8"]},{"name":"Claw","bonus":14,"damage":["2d8+8"]},{"name":"Mace","bonus":14,"damage":["2d6+8"]},{"name":"Tail","bonus":14,"damage":["3d10+8"]}]', '["Bite","Claw","Mace","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('planetar', 'Planetar', 'planetar', 'srd', '16', 16, 15000, 'Large', 'celestial', 19, 200, '16d10', 20, '[{"name":"Greatsword","bonus":12,"damage":["4d6+7","5d8"]}]', '["Greatsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('plesiosaurus', 'Plesiosaurus', 'plesiosaurus', 'srd', '2', 2, 450, 'Large', 'beast', 13, 68, '8d10', 15, '[{"name":"Bite","bonus":6,"damage":["3d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('poisonous-snake', 'Poisonous Snake', 'poisonous snake', 'srd', '1/8', 0.125, 25, 'Tiny', 'beast', 13, 2, '1d4', 16, '[{"name":"Bite","bonus":5,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('polar-bear', 'Polar Bear', 'polar bear', 'srd', '2', 2, 450, 'Large', 'beast', 12, 42, '5d10', 10, '[{"name":"Bite","bonus":7,"damage":["1d8+5"]},{"name":"Claws","bonus":7,"damage":["2d6+5"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('pony', 'Pony', 'pony', 'srd', '1/8', 0.125, 25, 'Medium', 'beast', 10, 11, '2d8', 10, '[{"name":"Hooves","bonus":4,"damage":["2d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('priest', 'Priest', 'priest', 'srd', '2', 2, 450, 'Medium', 'humanoid', 13, 27, '5d8', 10, '[{"name":"Mace","bonus":2,"damage":["1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('pseudodragon', 'Pseudodragon', 'pseudodragon', 'srd', '1/4', 0.25, 50, 'Tiny', 'dragon', 13, 7, '2d4', 15, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]},{"name":"Sting","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('purple-worm', 'Purple Worm', 'purple worm', 'srd', '15', 15, 13000, 'Gargantuan', 'monstrosity', 18, 247, '15d20', 7, '[{"name":"Bite","bonus":9,"damage":["3d8+9"]},{"name":"Tail Stinger","bonus":9,"damage":["3d6+9"]}]', '["Bite","Tail Stinger"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('quasit', 'Quasit', 'quasit', 'srd', '1', 1, 200, 'Tiny', 'fiend', 13, 7, '3d4', 17, '[{"name":"Claw (Bite in Beast Form)","bonus":4,"damage":["1d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('quipper', 'Quipper', 'quipper', 'srd', '0', 0, 10, 'Tiny', 'beast', 13, 1, '1d4', 16, '[{"name":"Bite","bonus":5,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('rakshasa', 'Rakshasa', 'rakshasa', 'srd', '13', 13, 10000, 'Medium', 'fiend', 16, 110, '13d8', 17, '[{"name":"Claw","bonus":7,"damage":["2d6+2"]}]', '["Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('rat', 'Rat', 'rat', 'srd', '0', 0, 10, 'Tiny', 'beast', 10, 1, '1d4', 11, '[{"name":"Bite","bonus":0,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('raven', 'Raven', 'raven', 'srd', '0', 0, 10, 'Tiny', 'beast', 12, 1, '1d4', 14, '[{"name":"Beak","bonus":4,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('red-dragon-wyrmling', 'Red Dragon Wyrmling', 'red dragon wyrmling', 'srd', '4', 4, 1100, 'Medium', 'dragon', 17, 75, '10d8', 10, '[{"name":"Bite","bonus":6,"damage":["1d10+4","1d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('reef-shark', 'Reef Shark', 'reef shark', 'srd', '1/2', 0.5, 100, 'Medium', 'beast', 12, 22, '4d8', 13, '[{"name":"Bite","bonus":4,"damage":["1d8+2"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('remorhaz', 'Remorhaz', 'remorhaz', 'srd', '11', 11, 7200, 'Huge', 'monstrosity', 17, 195, '17d12', 13, '[{"name":"Bite","bonus":11,"damage":["6d10+7","3d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('rhinoceros', 'Rhinoceros', 'rhinoceros', 'srd', '2', 2, 450, 'Large', 'beast', 11, 45, '6d10', 8, '[{"name":"Gore","bonus":7,"damage":["2d8+5"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('riding-horse', 'Riding Horse', 'riding horse', 'srd', '1/4', 0.25, 25, 'Large', 'beast', 10, 13, '2d10', 10, '[{"name":"Hooves","bonus":5,"damage":["2d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('roc', 'Roc', 'roc', 'srd', '11', 11, 7200, 'Gargantuan', 'monstrosity', 15, 248, '16d20', 10, '[{"name":"Beak","bonus":13,"damage":["4d8+9"]},{"name":"Talons","bonus":13,"damage":["4d6+9"]}]', '["Beak","Talons"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('roper', 'Roper', 'roper', 'srd', '5', 5, 1800, 'Large', 'monstrosity', 20, 93, '11d10', 8, '[{"name":"Bite","bonus":7,"damage":["4d8+4"]},{"name":"Tendril","bonus":7,"damage":[]}]', '["Bite","Tendril","Bite","Tendril"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('rug-of-smothering', 'Rug of Smothering', 'rug of smothering', 'srd', '2', 2, 450, 'Large', 'construct', 12, 33, '6d10', 14, '[{"name":"Smother","bonus":5,"damage":[]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('rust-monster', 'Rust Monster', 'rust monster', 'srd', '1/2', 0.5, 100, 'Medium', 'monstrosity', 14, 27, '5d8', 12, '[{"name":"Bite","bonus":3,"damage":["1d8+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('saber-toothed-tiger', 'Saber-Toothed Tiger', 'saber-toothed tiger', 'srd', '2', 2, 450, 'Large', 'beast', 12, 52, '7d10', 14, '[{"name":"Bite","bonus":6,"damage":["1d10+5"]},{"name":"Claw","bonus":6,"damage":["2d6+5"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('sahuagin', 'Sahuagin', 'sahuagin', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 12, 22, '4d8', 11, '[{"name":"Bite","bonus":3,"damage":["1d4+1"]},{"name":"Claws","bonus":3,"damage":["1d4+1"]},{"name":"Spear","bonus":3,"damage":[]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('salamander', 'Salamander', 'salamander', 'srd', '5', 5, 1800, 'Large', 'elemental', 15, 90, '12d10', 14, '[{"name":"Spear","bonus":7,"damage":["1d6"]},{"name":"Tail","bonus":7,"damage":["2d6+4","2d6"]}]', '["Spear","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('satyr', 'Satyr', 'satyr', 'srd', '1/2', 0.5, 100, 'Medium', 'fey', 14, 31, '7d8', 16, '[{"name":"Ram","bonus":3,"damage":["2d4+1"]},{"name":"Shortsword","bonus":5,"damage":["1d6+3"]},{"name":"Shortbow","bonus":5,"damage":["1d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('scorpion', 'Scorpion', 'scorpion', 'srd', '0', 0, 10, 'Tiny', 'beast', 11, 1, '1d4', 11, '[{"name":"Sting","bonus":2,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('scout', 'Scout', 'scout', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 13, 16, '3d8', 14, '[{"name":"Shortsword","bonus":4,"damage":["1d6+2"]},{"name":"Longbow","bonus":4,"damage":["1d8+2"]}]', '["Shortsword","Longbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('sea-hag', 'Sea Hag', 'sea hag', 'srd', '2', 2, 450, 'Medium', 'fey', 14, 52, '7d8', 13, '[{"name":"Claws","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('sea-horse', 'Sea Horse', 'sea horse', 'srd', '0', 0, 0, 'Tiny', 'beast', 11, 1, '1d4', 12, '[]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('shadow', 'Shadow', 'shadow', 'srd', '1/2', 0.5, 100, 'Medium', 'undead', 12, 16, '3d8', 14, '[{"name":"Strength Drain","bonus":4,"damage":["2d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('shambling-mound', 'Shambling Mound', 'shambling mound', 'srd', '5', 5, 1800, 'Large', 'plant', 15, 136, '16d10', 8, '[{"name":"Slam","bonus":7,"damage":["2d8+4"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('shield-guardian', 'Shield Guardian', 'shield guardian', 'srd', '7', 7, 2900, 'Large', 'construct', 17, 142, '15d10', 8, '[{"name":"Fist","bonus":7,"damage":["2d6+4"]}]', '["Fist"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('shrieker', 'Shrieker', 'shrieker', 'srd', '0', 0, 10, 'Medium', 'plant', 5, 13, '3d8', 1, '[]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('silver-dragon-wyrmling', 'Silver Dragon Wyrmling', 'silver dragon wyrmling', 'srd', '2', 2, 450, 'Medium', 'dragon', 17, 45, '6d8', 10, '[{"name":"Bite","bonus":6,"damage":["1d10+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('skeleton', 'Skeleton', 'skeleton', 'srd', '1/4', 0.25, 50, 'Medium', 'undead', 13, 13, '2d8', 14, '[{"name":"Shortsword","bonus":4,"damage":["1d6+2"]},{"name":"Shortbow","bonus":4,"damage":["1d6+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('solar', 'Solar', 'solar', 'srd', '21', 21, 33000, 'Large', 'celestial', 21, 243, '18d10', 22, '[{"name":"Greatsword","bonus":15,"damage":["4d6+8","6d8"]},{"name":"Slaying Longbow","bonus":13,"damage":["2d8+6","6d8"]}]', '["Greatsword","Slaying Longbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('specter', 'Specter', 'specter', 'srd', '1', 1, 200, 'Medium', 'undead', 12, 22, '5d8', 14, '[{"name":"Life Drain","bonus":4,"damage":["3d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('spider', 'Spider', 'spider', 'srd', '0', 0, 10, 'Tiny', 'beast', 12, 1, '1d4', 14, '[{"name":"Bite","bonus":4,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('spirit-naga', 'Spirit Naga', 'spirit naga', 'srd', '8', 8, 3900, 'Large', 'monstrosity', 15, 75, '10d10', 17, '[{"name":"Bite","bonus":7,"damage":["1d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('sprite', 'Sprite', 'sprite', 'srd', '1/4', 0.25, 50, 'Tiny', 'fey', 15, 2, '1d4', 18, '[{"name":"Longsword","bonus":2,"damage":["1"]},{"name":"Shortbow","bonus":6,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('spy', 'Spy', 'spy', 'srd', '1', 1, 200, 'Medium', 'humanoid', 12, 27, '6d8', 15, '[{"name":"Shortsword","bonus":4,"damage":["1d6+2"]},{"name":"Hand Crossbow","bonus":4,"damage":["1d6+2"]}]', '["Shortsword","Hand Crossbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('steam-mephit', 'Steam Mephit', 'steam mephit', 'srd', '1/4', 0.25, 50, 'Small', 'elemental', 10, 21, '6d6', 11, '[{"name":"Claws","bonus":2,"damage":["1d4","1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('stirge', 'Stirge', 'stirge', 'srd', '1/8', 0.125, 25, 'Tiny', 'beast', 14, 2, '1d4', 16, '[{"name":"Blood Drain","bonus":5,"damage":["1d4+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('stone-giant', 'Stone Giant', 'stone giant', 'srd', '7', 7, 2900, 'Huge', 'giant', 17, 126, '11d12', 15, '[{"name":"Greatclub","bonus":9,"damage":["3d8+6"]},{"name":"Rock","bonus":9,"damage":["4d10+6"]}]', '["Greatclub","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('stone-golem', 'Stone Golem', 'stone golem', 'srd', '10', 10, 5900, 'Large', 'construct', 17, 178, '17d10', 9, '[{"name":"Slam","bonus":10,"damage":["3d8+6"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('storm-giant', 'Storm Giant', 'storm giant', 'srd', '13', 13, 10000, 'Huge', 'giant', 16, 230, '20d12', 14, '[{"name":"Greatsword","bonus":14,"damage":["6d6+9"]},{"name":"Rock","bonus":14,"damage":["4d12+9"]}]', '["Greatsword","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('succubus-incubus', 'Succubus/Incubus', 'succubus/incubus', 'srd', '4', 4, 1100, 'Medium', 'fiend', 15, 66, '12d8', 17, '[{"name":"Claw (Fiend Form Only)","bonus":5,"damage":["1d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-bats', 'Swarm of Bats', 'swarm of bats', 'srd', '1/4', 0.25, 50, 'Medium', 'swarm of Tiny beasts', 12, 22, '5d8', 15, '[{"name":"Bites","bonus":4,"damage":["2d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-beetles', 'Swarm of Beetles', 'swarm of beetles', 'srd', '1/2', 0.5, 100, 'Medium', 'swarm of Tiny beasts', 12, 22, '5d8', 13, '[{"name":"Bites","bonus":3,"damage":["4d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-centipedes', 'Swarm of Centipedes', 'swarm of centipedes', 'srd', '1/2', 0.5, 100, 'Medium', 'swarm of Tiny beasts', 12, 22, '5d8', 13, '[{"name":"Bites","bonus":3,"damage":["4d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-insects', 'Swarm of Insects', 'swarm of insects', 'srd', '1/2', 0.5, 100, 'Medium', 'swarm of Tiny beasts', 12, 22, '5d8', 13, '[{"name":"Bites","bonus":3,"damage":["4d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-poisonous-snakes', 'Swarm of Poisonous Snakes', 'swarm of poisonous snakes', 'srd', '2', 2, 450, 'Medium', 'swarm of Tiny beasts', 14, 36, '8d8', 18, '[{"name":"Bites","bonus":6,"damage":["2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-quippers', 'Swarm of Quippers', 'swarm of quippers', 'srd', '1', 1, 200, 'Medium', 'swarm of Tiny beasts', 13, 28, '8d8', 16, '[{"name":"Bites","bonus":5,"damage":["4d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-rats', 'Swarm of Rats', 'swarm of rats', 'srd', '1/4', 0.25, 50, 'Medium', 'swarm of Tiny beasts', 10, 24, '7d8', 11, '[{"name":"Bites","bonus":2,"damage":["2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-ravens', 'Swarm of Ravens', 'swarm of ravens', 'srd', '1/4', 0.25, 50, 'Medium', 'swarm of Tiny beasts', 12, 24, '7d8', 14, '[{"name":"Beaks","bonus":4,"damage":["2d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-spiders', 'Swarm of Spiders', 'swarm of spiders', 'srd', '1/2', 0.5, 100, 'Medium', 'swarm of Tiny beasts', 12, 22, '5d8', 13, '[{"name":"Bites","bonus":3,"damage":["4d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('swarm-of-wasps', 'Swarm of Wasps', 'swarm of wasps', 'srd', '1/2', 0.5, 100, 'Medium', 'swarm of Tiny beasts', 12, 22, '5d8', 13, '[{"name":"Bites","bonus":3,"damage":["4d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('tarrasque', 'Tarrasque', 'tarrasque', 'srd', '30', 30, 155000, 'Gargantuan', 'monstrosity', 25, 676, '33d20', 11, '[{"name":"Bite","bonus":19,"damage":["4d12+10"]},{"name":"Claw","bonus":19,"damage":["4d8+10"]},{"name":"Horns","bonus":19,"damage":["4d10+10"]},{"name":"Tail","bonus":19,"damage":["4d6+10"]}]', '["Bite","Claw","Claw","Horns","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('thug', 'Thug', 'thug', 'srd', '1/2', 0.5, 100, 'Medium', 'humanoid', 11, 32, '5d8', 11, '[{"name":"Mace","bonus":4,"damage":["1d6+2"]},{"name":"Heavy Crossbow","bonus":2,"damage":["1d10"]}]', '["Mace","Heavy Crossbow"]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('tiger', 'Tiger', 'tiger', 'srd', '1', 1, 200, 'Large', 'beast', 12, 37, '5d10', 15, '[{"name":"Bite","bonus":5,"damage":["1d10+3"]},{"name":"Claw","bonus":5,"damage":["1d8+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('treant', 'Treant', 'treant', 'srd', '9', 9, 5000, 'Huge', 'plant', 16, 138, '12d12', 8, '[{"name":"Slam","bonus":10,"damage":["3d6+6"]},{"name":"Rock","bonus":10,"damage":["4d10+6"]}]', '["Slam","Rock"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('tribal-warrior', 'Tribal Warrior', 'tribal warrior', 'srd', '1/8', 0.125, 25, 'Medium', 'humanoid', 12, 11, '2d8', 11, '[{"name":"Spear","bonus":3,"damage":[]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('triceratops', 'Triceratops', 'triceratops', 'srd', '5', 5, 1800, 'Huge', 'beast', 13, 95, '10d12', 9, '[{"name":"Gore","bonus":9,"damage":["4d8+6"]},{"name":"Stomp","bonus":9,"damage":["3d10+6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('troll', 'Troll', 'troll', 'srd', '5', 5, 1800, 'Large', 'giant', 15, 84, '8d10', 13, '[{"name":"Bite","bonus":7,"damage":["1d6+4"]},{"name":"Claw","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('tyrannosaurus-rex', 'Tyrannosaurus Rex', 'tyrannosaurus rex', 'srd', '8', 8, 3900, 'Huge', 'beast', 13, 136, '13d12', 10, '[{"name":"Bite","bonus":10,"damage":["4d12+7"]},{"name":"Tail","bonus":10,"damage":["3d8+7"]}]', '["Bite","Tail"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('unicorn', 'Unicorn', 'unicorn', 'srd', '5', 5, 1800, 'Large', 'celestial', 12, 67, '9d10', 14, '[{"name":"Hooves","bonus":7,"damage":["2d6+4"]},{"name":"Horn","bonus":7,"damage":["1d8+4"]}]', '["Hooves","Horn"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('vampire-spawn', 'Vampire Spawn', 'vampire spawn', 'srd', '5', 5, 1800, 'Medium', 'undead', 15, 82, '11d8', 16, '[{"name":"Bite","bonus":6,"damage":["1d6+3","2d6"]},{"name":"Claws","bonus":6,"damage":["2d4+3"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('vampire-bat', 'Vampire, Bat Form', 'vampire, bat form', 'srd', '13', 13, 10000, 'Medium', 'undead', 16, 144, '17d8', 18, '[{"name":"Bite","bonus":9,"damage":["1d6+4","3d6"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('vampire-mist', 'Vampire, Mist Form', 'vampire, mist form', 'srd', '13', 13, 10000, 'Medium', 'undead', 16, 144, '17d8', 18, '[]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('vampire-vampire', 'Vampire, Vampire Form', 'vampire, vampire form', 'srd', '13', 13, 10000, 'Medium', 'undead', 16, 144, '17d8', 18, '[{"name":"Unarmed Strike","bonus":9,"damage":["1d8+4"]},{"name":"Bite","bonus":9,"damage":["1d6+4","3d6"]}]', '["Unarmed Strike","Bite"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('veteran', 'Veteran', 'veteran', 'srd', '3', 3, 700, 'Medium', 'humanoid', 17, 58, '9d8', 13, '[{"name":"Longsword","bonus":5,"damage":[]},{"name":"Shortsword","bonus":5,"damage":["1d6+3"]},{"name":"Heavy Crossbow","bonus":3,"damage":["1d10+1"]}]', '["Longsword","Shortsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('violet-fungus', 'Violet Fungus', 'violet fungus', 'srd', '1/4', 0.25, 50, 'Medium', 'plant', 5, 18, '4d8', 1, '[{"name":"Rotting Touch","bonus":2,"damage":["1d8"]}]', '["Rotting Touch"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('vrock', 'Vrock', 'vrock', 'srd', '6', 6, 2300, 'Large', 'fiend', 15, 104, '11d10', 15, '[{"name":"Beak","bonus":6,"damage":["2d6+3"]},{"name":"Talons","bonus":6,"damage":["2d10+3"]}]', '["Beak","Talons"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('vulture', 'Vulture', 'vulture', 'srd', '0', 0, 10, 'Medium', 'beast', 10, 5, '1d8', 10, '[{"name":"Beak","bonus":2,"damage":["1d4"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('warhorse', 'Warhorse', 'warhorse', 'srd', '1/2', 0.5, 100, 'Large', 'beast', 11, 19, '3d10', 12, '[{"name":"Hooves","bonus":6,"damage":["2d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('warhorse-skeleton', 'Warhorse Skeleton', 'warhorse skeleton', 'srd', '1/2', 0.5, 100, 'Large', 'undead', 13, 22, '3d10', 12, '[{"name":"Hooves","bonus":6,"damage":["2d6+4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('water-elemental', 'Water Elemental', 'water elemental', 'srd', '5', 5, 1800, 'Large', 'elemental', 14, 114, '12d10', 14, '[{"name":"Slam","bonus":7,"damage":["2d8+4"]}]', '["Slam"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('weasel', 'Weasel', 'weasel', 'srd', '0', 0, 10, 'Tiny', 'beast', 13, 1, '1d4', 16, '[{"name":"Bite","bonus":5,"damage":["1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('werebear-bear', 'Werebear, Bear Form', 'werebear, bear form', 'srd', '5', 5, 1800, 'Medium', 'humanoid', 11, 135, '18d8', 10, '[{"name":"Bite","bonus":7,"damage":["2d10+4"]},{"name":"Claw","bonus":7,"damage":["2d8+4"]}]', '["Bite","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('werebear-human', 'Werebear, Human Form', 'werebear, human form', 'srd', '5', 5, 1800, 'Medium', 'humanoid', 10, 135, '18d8', 10, '[{"name":"Greataxe","bonus":7,"damage":["1d12+4"]}]', '["Greataxe"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('werebear-hybrid', 'Werebear, Hybrid Form', 'werebear, hybrid form', 'srd', '5', 5, 1800, 'Medium', 'humanoid', 11, 135, '18d8', 10, '[{"name":"Bite","bonus":7,"damage":["2d10+4"]},{"name":"Claw","bonus":7,"damage":["2d8+4"]},{"name":"Greataxe","bonus":7,"damage":["1d12+4"]}]', '["Bite","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wereboar-boar', 'Wereboar, Boar Form', 'wereboar, boar form', 'srd', '4', 4, 1100, 'Medium', 'humanoid', 11, 78, '12d8', 10, '[{"name":"Tusks","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wereboar-human', 'Wereboar, Human Form', 'wereboar, human form', 'srd', '4', 4, 1100, 'Medium', 'humanoid', 10, 78, '12d8', 10, '[{"name":"Maul","bonus":5,"damage":["2d6+3"]}]', '["Maul","Maul"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wereboar-hybrid', 'Wereboar, Hybrid Form', 'wereboar, hybrid form', 'srd', '4', 4, 1100, 'Medium', 'humanoid', 11, 78, '12d8', 10, '[{"name":"Maul","bonus":5,"damage":["2d6+3"]},{"name":"Tusks","bonus":5,"damage":["2d6+3"]}]', '["Maul","Tusks"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wererat-human', 'Wererat, Human Form', 'wererat, human form', 'srd', '2', 2, 450, 'Medium', 'humanoid', 12, 33, '6d8', 15, '[{"name":"Shortsword","bonus":4,"damage":["1d6+2"]},{"name":"Hand Crossbow","bonus":4,"damage":["1d6+2"]}]', '["Shortsword","Hand Crossbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wererat-hybrid', 'Wererat, Hybrid Form', 'wererat, hybrid form', 'srd', '2', 2, 450, 'Medium', 'humanoid', 12, 33, '6d8', 15, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]},{"name":"Shortsword","bonus":4,"damage":["1d6+2"]},{"name":"Hand Crossbow","bonus":4,"damage":["1d6+2"]}]', '["Bite","Shortsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wererat-rat', 'Wererat, Rat Form', 'wererat, rat form', 'srd', '2', 2, 450, 'Medium', 'humanoid', 12, 33, '6d8', 15, '[{"name":"Bite","bonus":4,"damage":["1d4+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('weretiger-human', 'Weretiger, Human Form', 'weretiger, human form', 'srd', '4', 4, 1100, 'Medium', 'humanoid', 12, 120, '16d8', 15, '[{"name":"Scimitar","bonus":5,"damage":["1d6+3"]},{"name":"Longbow","bonus":4,"damage":["1d8+2"]}]', '["Scimitar","Longbow"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('weretiger-hybrid', 'Weretiger, Hybrid Form', 'weretiger, hybrid form', 'srd', '4', 4, 1100, 'Medium', 'humanoid', 12, 120, '16d8', 15, '[{"name":"Bite","bonus":5,"damage":["1d10+3"]},{"name":"Claw","bonus":5,"damage":["1d8+3"]},{"name":"Scimitar","bonus":5,"damage":["1d6+3"]},{"name":"Longbow","bonus":4,"damage":["1d8+2"]}]', '["Bite","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('weretiger-tiger', 'Weretiger, Tiger Form', 'weretiger, tiger form', 'srd', '4', 4, 1100, 'Medium', 'humanoid', 12, 120, '16d8', 15, '[{"name":"Bite","bonus":5,"damage":["1d10+3"]},{"name":"Claw","bonus":5,"damage":["1d8+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('werewolf-human', 'Werewolf, Human Form', 'werewolf, human form', 'srd', '3', 3, 700, 'Medium', 'humanoid', 11, 58, '9d8', 13, '[{"name":"Spear","bonus":4,"damage":[]}]', '["Spear","Spear"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('werewolf-hybrid', 'Werewolf, Hybrid Form', 'werewolf, hybrid form', 'srd', '3', 3, 700, 'Medium', 'humanoid', 12, 58, '9d8', 13, '[{"name":"Bite","bonus":4,"damage":["1d8+2"]},{"name":"Claws","bonus":4,"damage":["2d4+2"]}]', '["Bite","Claws"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('werewolf-wolf', 'Werewolf, Wolf Form', 'werewolf, wolf form', 'srd', '3', 3, 700, 'Medium', 'humanoid', 12, 58, '9d8', 13, '[{"name":"Bite","bonus":4,"damage":["1d8+2"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('white-dragon-wyrmling', 'White Dragon Wyrmling', 'white dragon wyrmling', 'srd', '2', 2, 450, 'Medium', 'dragon', 16, 32, '5d8', 10, '[{"name":"Bite","bonus":4,"damage":["1d10+2","1d4"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wight', 'Wight', 'wight', 'srd', '3', 3, 700, 'Medium', 'undead', 14, 45, '6d8', 14, '[{"name":"Life Drain","bonus":4,"damage":["1d6+2"]},{"name":"Longsword","bonus":4,"damage":[]},{"name":"Longbow","bonus":4,"damage":["1d8+2"]}]', '["Life Drain","Longsword"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('will-o-wisp', 'Will-o''-Wisp', 'will-o''-wisp', 'srd', '2', 2, 450, 'Tiny', 'undead', 19, 22, '9d4', 28, '[{"name":"Shock","bonus":4,"damage":["2d8"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('winter-wolf', 'Winter Wolf', 'winter wolf', 'srd', '3', 3, 700, 'Large', 'monstrosity', 13, 75, '10d10', 13, '[{"name":"Bite","bonus":6,"damage":["2d6+4"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wolf', 'Wolf', 'wolf', 'srd', '1/4', 0.25, 50, 'Medium', 'beast', 13, 11, '2d8', 15, '[{"name":"Bite","bonus":4,"damage":["2d4+2"]}]', '[]', 1, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('worg', 'Worg', 'worg', 'srd', '1/2', 0.5, 100, 'Large', 'monstrosity', 13, 26, '4d10', 13, '[{"name":"Bite","bonus":5,"damage":["2d6+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wraith', 'Wraith', 'wraith', 'srd', '5', 5, 1800, 'Medium', 'undead', 13, 67, '9d8', 16, '[{"name":"Life Drain","bonus":6,"damage":["4d8+3"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('wyvern', 'Wyvern', 'wyvern', 'srd', '6', 6, 2300, 'Large', 'dragon', 13, 110, '13d10', 10, '[{"name":"Bite","bonus":7,"damage":["2d6+4"]},{"name":"Claws","bonus":7,"damage":["2d8+4"]},{"name":"Stinger","bonus":7,"damage":["2d6+4"]}]', '["Bite","Stinger"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('xorn', 'Xorn', 'xorn', 'srd', '5', 5, 1800, 'Medium', 'elemental', 19, 73, '7d8', 10, '[{"name":"Bite","bonus":6,"damage":["3d6+3"]},{"name":"Claw","bonus":6,"damage":["1d6+3"]}]', '["Bite","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-black-dragon', 'Young Black Dragon', 'young black dragon', 'srd', '7', 7, 2900, 'Large', 'dragon', 18, 127, '15d10', 14, '[{"name":"Bite","bonus":7,"damage":["2d10+4","1d8"]},{"name":"Claw","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-blue-dragon', 'Young Blue Dragon', 'young blue dragon', 'srd', '9', 9, 5000, 'Large', 'dragon', 18, 152, '16d10', 10, '[{"name":"Bite","bonus":9,"damage":["2d10+5","1d10"]},{"name":"Claw","bonus":9,"damage":["2d6+5"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-brass-dragon', 'Young Brass Dragon', 'young brass dragon', 'srd', '6', 6, 2300, 'Large', 'dragon', 17, 110, '13d10', 10, '[{"name":"Bite","bonus":7,"damage":["2d10+4"]},{"name":"Claw","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-bronze-dragon', 'Young Bronze Dragon', 'young bronze dragon', 'srd', '8', 8, 3900, 'Large', 'dragon', 18, 142, '15d10', 10, '[{"name":"Bite","bonus":8,"damage":["2d10+5"]},{"name":"Claw","bonus":8,"damage":["2d6+5"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-copper-dragon', 'Young Copper Dragon', 'young copper dragon', 'srd', '7', 7, 2900, 'Large', 'dragon', 17, 119, '14d10', 12, '[{"name":"Bite","bonus":7,"damage":["2d10+4"]},{"name":"Claw","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-gold-dragon', 'Young Gold Dragon', 'young gold dragon', 'srd', '10', 10, 5900, 'Large', 'dragon', 18, 178, '17d10', 14, '[{"name":"Bite","bonus":10,"damage":["2d10+6"]},{"name":"Claw","bonus":10,"damage":["2d6+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-green-dragon', 'Young Green Dragon', 'young green dragon', 'srd', '8', 8, 3900, 'Large', 'dragon', 18, 136, '16d10', 12, '[{"name":"Bite","bonus":7,"damage":["2d10+4","2d6"]},{"name":"Claw","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-red-dragon', 'Young Red Dragon', 'young red dragon', 'srd', '10', 10, 5900, 'Large', 'dragon', 18, 178, '17d10', 10, '[{"name":"Bite","bonus":10,"damage":["2d10+6","1d6"]},{"name":"Claw","bonus":10,"damage":["2d6+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-silver-dragon', 'Young Silver Dragon', 'young silver dragon', 'srd', '9', 9, 5000, 'Large', 'dragon', 18, 168, '16d10', 10, '[{"name":"Bite","bonus":10,"damage":["2d10+6"]},{"name":"Claw","bonus":10,"damage":["2d6+6"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('young-white-dragon', 'Young White Dragon', 'young white dragon', 'srd', '6', 6, 2300, 'Large', 'dragon', 17, 133, '14d10', 10, '[{"name":"Bite","bonus":7,"damage":["2d10+4","1d8"]},{"name":"Claw","bonus":7,"damage":["2d6+4"]}]', '["Bite","Claw","Claw"]', 0, '', '2026-10-14T00:00:00.000Z');
INSERT INTO monsters (id, name, name_key, source, cr_label, cr_value, xp, size, creature_type, ac, hp, hit_dice, dexterity, attacks_json, multiattack_json, pack_tactics, note, created_at) VALUES ('zombie', 'Zombie', 'zombie', 'srd', '1/4', 0.25, 50, 'Medium', 'undead', 8, 22, '3d8', 6, '[{"name":"Slam","bonus":3,"damage":["1d6+1"]}]', '[]', 0, '', '2026-10-14T00:00:00.000Z');

INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-0', 'srd', NULL, 'The Order of Combat (1)', '## The Order of Combat

A typical combat encounter is a clash between two sides, a flurry of weapon swings, feints, parries, footwork, and spellcasting. The game organizes the chaos of combat into a cycle of rounds and turns. A **round** represents about 6 seconds in the game world. During a round, each participant in a battle takes a **turn**. The order of turns is determined at the beginning of a combat encounter, when everyone rolls initiative. Once everyone has taken a turn, the fight continues to the next round if neither side has defeated the other.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-1', 'srd', NULL, 'The Order of Combat (2)', '### Combat Step by Step

1.  **Determine surprise.** The GM determines whether anyone involved in the combat encounter is surprised.
2.  **Establish positions.** The GM decides where all the characters and monsters are located. Given the adventurers'' marching order or their stated positions in the room or other location, the GM figures out where the adversaries are/how far away and in what direction.
3.  **Roll initiative.** Everyone involved in the combat encounter rolls initiative, determining the order of combatants'' turns.
4.  **Take turns.** Each participant in the battle takes a turn in initiative order.
5.  **Begin the next round.** When everyone involved in the combat has had a turn, the round ends. Repeat step 4 until the fighting stops.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-2', 'srd', NULL, 'The Order of Combat (3)', '### Surprise

A band of adventurers sneaks up on a bandit camp, springing from the trees to attack them. A gelatinous cube glides down a dungeon passage, unnoticed by the adventurers until the cube engulfs one of them. In these situations, one side of the battle gains surprise over the other.

The GM determines who might be surprised. If neither side tries to be stealthy, they automatically notice each other. Otherwise, the GM compares the Dexterity (Stealth) checks of anyone hiding with the passive Wisdom (Perception) score of each creature on the opposing side. Any character or monster that doesn''t notice a threat is surprised at the start of the encounter.

If you''re surprised, you can''t move or take an action on your first turn of the combat, and you can''t take a reaction until that turn ends. A member of a group can be surprised even if the other members aren''t.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-3', 'srd', NULL, 'The Order of Combat (4)', '### Initiative

Initiative determines the order of turns during combat. When combat starts, every participant makes a Dexterity check to determine their place in the initiative order. The GM makes one roll for an entire group of identical creatures, so each member of the group acts at the same time.

The GM ranks the combatants in order from the one with the highest Dexterity check total to the one with the lowest. This is the order (called the initiative order) in which they act during each round. The initiative order remains the same from round to round.

If a tie occurs, the GM decides the order among tied GM-controlled creatures, and the players decide the order among their tied characters. The GM can decide the order if the tie is between a monster and a player character. Optionally, the GM can have the tied characters and monsters each roll a d20 to determine the order, highest roll going first.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-4', 'srd', NULL, 'The Order of Combat (5)', '### Your Turn

On your turn, you can **move** a distance up to your speed and **take one action**. You decide whether to move first or take your action first. Your speed--sometimes called your walking speed--is noted on your character sheet.

The most common actions you can take are described in the "Actions in Combat" section later in this chapter. Many class features and other abilities provide additional options for your action.

The "Movement and Position" section later in this chapter gives the rules for your move.

You can forgo moving, taking an action, or doing anything at all on your turn. If you can''t decide what to do on your turn, consider taking the Dodge or Ready action, as described in "Actions in Combat."

#### Bonus Actions

Various class features, spells, and other abilities let you take an additional action on your turn called a bonus action. The Cunning Action feature, for example, allows a rogue to take a bonus action. You can take a bonus action only when a special ability, spell, or other feature of the game states that you can do something as a bonus action. You otherwise don''t have a bonus action to take.

You can take only one bonus action on your turn, so you must choose which bonus action to use when you have more than one available.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-5', 'srd', NULL, 'The Order of Combat (6)', 'You choose when to take a bonus action during your turn, unless the bonus action''s timing is specified, and anything that deprives you of your ability to take actions also prevents you from taking a bonus action.

#### Other Activity on Your Turn

Your turn can include a variety of flourishes that require neither your action nor your move.

You can communicate however you are able, through brief utterances and gestures, as you take your turn.

You can also interact with one object or feature of the environment for free, during either your move or your action. For example, you could open a door during your move as you stride toward a foe, or you could draw your weapon as part of the same action you use to attack.

If you want to interact with a second object, you need to use your action. Some magic items and other special objects always require an action to use, as stated in their descriptions.

The GM might require you to use an action for any of these activities when it needs special care or when it presents an unusual obstacle. For instance, the GM could reasonably expect you to use an action to open a stuck door or turn a crank to lower a drawbridge.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-order-of-combat-6', 'srd', NULL, 'The Order of Combat (7)', '### Reactions

Certain special abilities, spells, and situations allow you to take a special action called a reaction. A reaction is an instant response to a trigger of some kind, which can occur on your turn or on someone else''s. The opportunity attack, described later in this chapter, is the most common type of reaction.

When you take a reaction, you can''t take another one until the start of your next turn. If the reaction interrupts another creature''s turn, that creature can continue its turn right after the reaction.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-0', 'srd', NULL, 'Movement and Position (1)', '## Movement and Position

In combat, characters and monsters are in constant motion, often using movement and position to gain the upper hand.

On your turn, you can move a distance up to your speed. You can use as much or as little of your speed as you like on your turn, following the rules here.

Your movement can include jumping, climbing, and swimming. These different modes of movement can be combined with walking, or they can constitute your entire move. However you''re moving, you deduct the distance of each part of your move from your speed until it is used up or until you are done moving.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-1', 'srd', NULL, 'Movement and Position (2)', '### Breaking Up Your Move

You can break up your movement on your turn, using some of your speed before and after your action. For example, if you have a speed of 30 feet, you can move 10 feet, take your action, and then move 20 feet.

#### Moving between Attacks

If you take an action that includes more than one weapon attack, you can break up your movement even further by moving between those attacks. For example, a fighter who can make two attacks with the Extra Attack feature and who has a speed of 25 feet could move 10 feet, make an attack, move 15 feet, and then attack again.

#### Using Different Speeds

If you have more than one speed, such as your walking speed and a flying speed, you can switch back and forth between your speeds during your move. Whenever you switch, subtract the distance you''ve already moved from the new speed. The result determines how much farther you can move. If the result is 0 or less, you can''t use the new speed during the current move.

For example, if you have a speed of 30 and a flying speed of 60 because a wizard cast the *fly* spell on you, you could fly 20 feet, then walk 10 feet, and then leap into the air to fly 30 feet more.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-2', 'srd', NULL, 'Movement and Position (3)', '### Difficult Terrain

Combat rarely takes place in bare rooms or on featureless plains. Boulder-strewn caverns, briar-choked forests, treacherous staircases-the setting of a typical fight contains difficult terrain.

Every foot of movement in difficult terrain costs 1 extra foot. This rule is true even if multiple things in a space count as difficult terrain.

Low furniture, rubble, undergrowth, steep stairs, snow, and shallow bogs are examples of difficult terrain. The space of another creature, whether hostile or not, also counts as difficult terrain.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-3', 'srd', NULL, 'Movement and Position (4)', '### Being Prone

Combatants often find themselves lying on the ground, either because they are knocked down or because they throw themselves down. In the game, they are prone, a condition described in appendix PH-A.

You can **drop prone** without using any of your speed. **Standing up** takes more effort; doing so costs an amount of movement equal to half your speed. For example, if your speed is 30 feet, you must spend

15 feet of movement to stand up. You can''t stand up if you don''t have enough movement left or if your speed is 0.

To move while prone, you must **crawl** or use magic such as teleportation. Every foot of movement while crawling costs 1 extra foot. Crawling 1 foot in difficult terrain, therefore, costs 3 feet of movement.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-4', 'srd', NULL, 'Movement and Position (5)', '### Moving Around Other Creatures

You can move through a nonhostile creature''s space. In contrast, you can move through a hostile creature''s space only if the creature is at least two sizes larger or smaller than you. Remember that another creature''s space is difficult terrain for you.

Whether a creature is a friend or an enemy, you can''t willingly end your move in its space.

If you leave a hostile creature''s reach during your move, you provoke an opportunity attack, as explained later in the chapter.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-5', 'srd', NULL, 'Movement and Position (6)', '### Flying Movement

Flying creatures enjoy many benefits of mobility, but they must also deal with the danger of falling. If a flying creature is knocked prone, has its speed reduced to 0, or is otherwise deprived of the ability to move, the creature falls, unless it has the ability to hover or it is being held aloft by magic, such as by the *fly* spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-6', 'srd', NULL, 'Movement and Position (7)', '### Creature Size

Each creature takes up a different amount of space. The Size Categories table shows how much space a creature of a particular size controls in combat. Objects sometimes use the same size categories.

#### Size Categories

| Size       | Space                  |
|------------|------------------------|
| Tiny       | 2.5 by 2.5 ft.           |
| Small      | 5 by 5 ft.             |
| Medium     | 5 by 5 ft.             |
| Large      | 10 by 10 ft.           |
| Huge       | 15 by 15 ft.           |
| Gargantuan | 20 by 20 ft. or larger |

#### Space

A creature''s space is the area in feet that it effectively controls in combat, not an expression of its physical dimensions. A typical Medium creature isn''t 5 feet wide, for example, but it does control a space that wide. If a Medium hobgoblin stands in a 5-foot-wide doorway, other creatures can''t get through unless the hobgoblin lets them.

A creature''s space also reflects the area it needs to fight effectively. For that reason, there''s a limit to the number of creatures that can surround another creature in combat. Assuming Medium combatants, eight creatures can fit in a 5-foot radius around another one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-7', 'srd', NULL, 'Movement and Position (8)', 'Because larger creatures take up more space, fewer of them can surround a creature. If five Large creatures crowd around a Medium or smaller one, there''s little room for anyone else. In contrast, as many as twenty Medium creatures can surround a Gargantuan one.

#### Squeezing into a Smaller Space

A creature can squeeze through a space that is large enough for a creature one size smaller than it. Thus, a Large creature can squeeze through a passage that''s only 5 feet wide. While squeezing through a space, a creature must spend 1 extra foot for every foot it moves there, and it has disadvantage on attack rolls and Dexterity saving throws. Attack rolls against the creature have advantage while it''s in the smaller space.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-and-position-8', 'srd', NULL, 'Movement and Position (9)', '### Interacting with Objects Around You

Here are a few examples of the sorts of thing you can do in tandem with your movement and action:
- draw or sheathe a sword
- open or close a door
- withdraw a potion from your backpack
- pick up a dropped axe
- take a bauble from a table
- remove a ring from your finger
- stuff some food into your mouth
- plant a banner in the ground
- fish a few coins from your belt pouch
- drink all the ale in a flagon
- throw a lever or a switch
- pull a torch from a sconce
- take a book from a shelf you can reach
- extinguish a small flame
- don a mask
- pull the hood of your cloak up and over your head
- put your ear to a door
- kick a small stone
- turn a key in a lock
- tap the floor with a 10-foot pole
- hand an item to another character', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-0', 'srd', NULL, 'Actions in Combat (1)', '## Actions in Combat

When you take your action on your turn, you can take one of the actions presented here, an action you gained from your class or a special feature, or an action that you improvise. Many monsters have action options of their own in their stat blocks.

When you describe an action not detailed elsewhere in the rules, the GM tells you whether that action is possible and what kind of roll you need to make, if any, to determine success or failure.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-1', 'srd', NULL, 'Actions in Combat (2)', '### Attack

The most common action to take in combat is the Attack action, whether you are swinging a sword, firing an arrow from a bow, or brawling with your fists.

With this action, you make one melee or ranged attack. See the "Making an Attack" section for the rules that govern attacks.

Certain features, such as the Extra Attack feature of the fighter, allow you to make more than one attack with this action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-2', 'srd', NULL, 'Actions in Combat (3)', '### Cast a Spell

Spellcasters such as wizards and clerics, as well as many monsters, have access to spells and can use them to great effect in combat. Each spell has a casting time, which specifies whether the caster must use an action, a reaction, minutes, or even hours to cast the spell. Casting a spell is, therefore, not necessarily an action. Most spells do have a casting time of 1 action, so a spellcaster often uses his or her action in combat to cast such a spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-3', 'srd', NULL, 'Actions in Combat (4)', '### Dash

When you take the Dash action, you gain extra movement for the current turn. The increase equals your speed, after applying any modifiers. With a speed of 30 feet, for example, you can move up to 60 feet on your turn if you dash.

Any increase or decrease to your speed changes this additional movement by the same amount. If your speed of 30 feet is reduced to 15 feet, for instance, you can move up to 30 feet this turn if you dash.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-4', 'srd', NULL, 'Actions in Combat (5)', '### Disengage

If you take the Disengage action, your movement doesn''t provoke opportunity attacks for the rest of the turn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-5', 'srd', NULL, 'Actions in Combat (6)', '### Dodge

When you take the Dodge action, you focus entirely on avoiding attacks. Until the start of your next turn, any attack roll made against you has disadvantage if you can see the attacker, and you make Dexterity saving throws with advantage. You lose this benefit if you are incapacitated (as explained in appendix PH-A) or if your speed drops to 0.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-6', 'srd', NULL, 'Actions in Combat (7)', '### Help

You can lend your aid to another creature in the completion of a task. When you take the Help action, the creature you aid gains advantage on the next ability check it makes to perform the task you are helping with, provided that it makes the check before the start of your next turn.

Alternatively, you can aid a friendly creature in attacking a creature within 5 feet of you. You feint, distract the target, or in some other way team up to make your ally''s attack more effective. If your ally attacks the target before your next turn, the first attack roll is made with advantage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-7', 'srd', NULL, 'Actions in Combat (8)', '### Hide

When you take the Hide action, you make a Dexterity (Stealth) check in an attempt to hide, following the rules for hiding. If you succeed, you gain certain benefits, as described in the "Unseen Attackers and Targets" section later in this chapter.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-8', 'srd', NULL, 'Actions in Combat (9)', '### Ready

Sometimes you want to get the jump on a foe or wait for a particular circumstance before you act. To do so, you can take the Ready action on your turn, which lets you act using your reaction before the start of your next turn.

First, you decide what perceivable circumstance will trigger your reaction. Then, you choose the action you will take in response to that trigger, or you choose to move up to your speed in response to it. Examples include "If the cultist steps on the trapdoor, I''ll pull the lever that opens it," and "If the goblin steps next to me, I move away."

When the trigger occurs, you can either take your reaction right after the trigger finishes or ignore the trigger. Remember that you can take only one reaction per round.

When you ready a spell, you cast it as normal but hold its energy, which you release with your reaction when the trigger occurs. To be readied, a spell must have a casting time of 1 action, and holding onto the spell''s magic requires concentration. If your concentration is broken, the spell dissipates without taking effect. For example, if you are concentrating on the *web* spell and ready *magic missile*, your *web* spell ends, and if you take damage before you release *magic missile* with your reaction, your concentration might be broken.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-9', 'srd', NULL, 'Actions in Combat (10)', '### Search

When you take the Search action, you devote your attention to finding something. Depending on the nature of your search, the GM might have you make a Wisdom (Perception) check or an Intelligence (Investigation) check.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-actions-in-combat-10', 'srd', NULL, 'Actions in Combat (11)', '### Use an Object

You normally interact with an object while doing something else, such as when you draw a sword as part of an attack. When an object requires your action for its use, you take the Use an Object action. This action is also useful when you want to interact with more than one object on your turn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-0', 'srd', NULL, 'Making an Attack (1)', '## Making an Attack

Whether you''re striking with a melee weapon, firing a weapon at range, or making an attack roll as part of a spell, an attack has a simple structure.

1.  **Choose a target.** Pick a target within your attack''s range: a creature, an object, or a location.
2.  **Determine modifiers.** The GM determines whether the target has cover and whether you have advantage or disadvantage against the target. In addition, spells, special abilities, and other effects can apply penalties or bonuses to your attack roll.
3.  **Resolve the attack.** You make the attack roll. On a hit, you roll damage, unless the particular attack has rules that specify otherwise. Some attacks cause special effects in addition to or instead of damage.

If there''s ever any question whether something you''re doing counts as an attack, the rule is simple: if you''re making an attack roll, you''re making an attack.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-1', 'srd', NULL, 'Making an Attack (2)', '### Attack Rolls

When you make an attack, your attack roll determines whether the attack hits or misses. To make an attack roll, roll a d20 and add the appropriate modifiers. If the total of the roll plus modifiers equals or exceeds the target''s Armor Class (AC), the attack hits. The AC of a character is determined at character creation, whereas the AC of a monster is in its stat block.

#### Modifiers to the Roll

When a character makes an attack roll, the two most common modifiers to the roll are an ability modifier and the character''s proficiency bonus. When a monster makes an attack roll, it uses whatever modifier is provided in its stat block.

***Ability Modifier.*** The ability modifier used for a melee weapon attack is Strength, and the ability modifier used for a ranged weapon attack is Dexterity. Weapons that have the finesse or thrown property break this rule.

Some spells also require an attack roll. The ability modifier used for a spell attack depends on the spellcasting ability of the spellcaster.

***Proficiency Bonus.*** You add your proficiency bonus to your attack roll when you attack using a weapon with which you have proficiency, as well as when you attack with a spell.

#### Rolling 1 or 20

Sometimes fate blesses or curses a combatant, causing the novice to hit and the veteran to miss.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-2', 'srd', NULL, 'Making an Attack (3)', 'If the d20 roll for an attack is a 20, the attack hits regardless of any modifiers or the target''s AC. This is called a critical hit, which is explained later in this chapter.

If the d20 roll for an attack is a 1, the attack misses regardless of any modifiers or the target''s AC.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-3', 'srd', NULL, 'Making an Attack (4)', '### Unseen Attackers and Targets

Combatants often try to escape their foes'' notice by hiding, casting the invisibility spell, or lurking in darkness.

When you attack a target that you can''t see, you have disadvantage on the attack roll. This is true whether you''re guessing the target''s location or you''re targeting a creature you can hear but not see. If the target isn''t in the location you targeted, you automatically miss, but the GM typically just says that the attack missed, not whether you guessed the target''s location correctly.

When a creature can''t see you, you have advantage on attack rolls against it. If you are hidden-both unseen and unheard-when you make an attack, you give away your location when the attack hits or misses.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-4', 'srd', NULL, 'Making an Attack (5)', '### Ranged Attacks

When you make a ranged attack, you fire a bow or a crossbow, hurl a handaxe, or otherwise send projectiles to strike a foe at a distance. A monster might shoot spines from its tail. Many spells also involve making a ranged attack.

#### Range

You can make ranged attacks only against targets within a specified range.

If a ranged attack, such as one made with a spell, has a single range, you can''t attack a target beyond this range.

Some ranged attacks, such as those made with a longbow or a shortbow, have two ranges. The smaller number is the normal range, and the larger number is the long range. Your attack roll has disadvantage when your target is beyond normal range, and you can''t attack a target beyond the long range.

#### Ranged Attacks in Close Combat

Aiming a ranged attack is more difficult when a foe is next to you. When you make a ranged attack with a weapon, a spell, or some other means, you have disadvantage on the attack roll if you are within 5 feet of a hostile creature who can see you and who isn''t incapacitated.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-5', 'srd', NULL, 'Making an Attack (6)', '### Melee Attacks

Used in hand-to-hand combat, a melee attack allows you to attack a foe within your reach. A melee attack typically uses a handheld weapon such as a sword, a warhammer, or an axe. A typical monster makes a melee attack when it strikes with its claws, horns, teeth, tentacles, or other body part. A few spells also involve making a melee attack.

Most creatures have a 5-foot **reach** and can thus attack targets within 5 feet of them when making a melee attack. Certain creatures (typically those larger than Medium) have melee attacks with a greater reach than 5 feet, as noted in their descriptions.

Instead of using a weapon to make a melee weapon attack, you can use an **unarmed strike**: a punch, kick, head-butt, or similar forceful blow (none of which count as weapons). On a hit, an unarmed strike deals bludgeoning damage equal to 1 + your Strength modifier. You are proficient with your unarmed strikes.

#### Opportunity Attacks

In a fight, everyone is constantly watching for a chance to strike an enemy who is fleeing or passing by. Such a strike is called an opportunity attack.

You can make an opportunity attack when a hostile creature that you can see moves out of your reach. To make the opportunity attack, you use your reaction to make one melee attack against the provoking creature. The attack occurs right before the creature leaves your reach.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-6', 'srd', NULL, 'Making an Attack (7)', 'You can avoid provoking an opportunity attack by taking the Disengage action. You also don''t provoke an opportunity attack when you teleport or when someone or something moves you without using your movement, action, or reaction. For example, you don''t provoke an opportunity attack if an explosion hurls you out of a foe''s reach or if gravity causes you to fall past an enemy.

#### Two-Weapon Fighting

When you take the Attack action and attack with a light melee weapon that you''re holding in one hand, you can use a bonus action to attack with a different light melee weapon that you''re holding in the other hand. You don''t add your ability modifier to the damage of the bonus attack, unless that modifier is negative.

If either weapon has the thrown property, you can throw the weapon, instead of making a melee attack with it.

#### Contests in Combat

Battle often involves pitting your prowess against that of your foe. Such a challenge is represented by a contest. This section includes the most common contests that require an action in combat: grappling and shoving a creature. The GM can use these contests as models for improvising others.

#### Grappling

When you want to grab a creature or wrestle with it, you can use the Attack action to make a special melee attack, a grapple. If you''re able to make multiple attacks with the Attack action, this attack replaces one of them.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-7', 'srd', NULL, 'Making an Attack (8)', 'The target of your grapple must be no more than one size larger than you and must be within your reach. Using at least one free hand, you try to seize the target by making a grapple check instead of an attack roll: a Strength (Athletics) check contested by the target''s Strength (Athletics) or Dexterity (Acrobatics) check (the target chooses the ability to use). If you succeed, you subject the target to the grappled condition (see appendix PH-A). The condition specifies the things that end it, and you can release the target whenever you like (no action required).

***Escaping a Grapple.*** A grappled creature can use its action to escape. To do so, it must succeed on a Strength (Athletics) or Dexterity (Acrobatics) check contested by your Strength
(Athletics) check.

***Moving a Grappled Creature.*** When you move, you can drag or carry the grappled creature with you, but your speed is halved, unless the creature is two or more sizes smaller than you.

#### Shoving a Creature

Using the Attack action, you can make a special melee attack to shove a creature, either to knock it prone or push it away from you. If you''re able to make multiple attacks with the Attack action, this attack replaces one of them.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-making-an-attack-8', 'srd', NULL, 'Making an Attack (9)', 'The target must be no more than one size larger than you and must be within your reach. Instead of making an attack roll, you make a Strength (Athletics) check contested by the target''s Strength (Athletics) or Dexterity (Acrobatics) check (the target chooses the ability to use). If you win the contest, you either knock the target prone or push it 5 feet away from you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-cover-0', 'srd', NULL, 'Cover', '## Cover

Walls, trees, creatures, and other obstacles can provide cover during combat, making a target more difficult to harm. A target can benefit from cover only when an attack or other effect originates on the opposite side of the cover.

There are three degrees of cover. If a target is behind multiple sources of cover, only the most protective degree of cover applies; the degrees aren''t added together. For example, if a target is behind a creature that gives half cover and a tree trunk that gives three-quarters cover, the target has three-quarters cover.

A target with **half cover** has a +2 bonus to AC and Dexterity saving throws. A target has half cover if an obstacle blocks at least half of its body. The obstacle might be a low wall, a large piece of furniture, a narrow tree trunk, or a creature, whether that creature is an enemy or a friend.

A target with **three-quarters cover** has a +5 bonus to AC and Dexterity saving throws. A target has three-quarters cover if about three-quarters of it is covered by an obstacle. The obstacle might be a portcullis, an arrow slit, or a thick tree trunk.

A target with **total cover** can''t be targeted directly by an attack or a spell, although some spells can reach such a target by including it in an area of effect. A target has total cover if it is completely concealed by an obstacle.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-0', 'srd', NULL, 'Damage and Healing (1)', '## Damage and Healing

Injury and the risk of death are constant companions of those who explore fantasy gaming worlds. The thrust of a sword, a well-placed arrow, or a blast of flame from a *fireball* spell all have the potential to damage, or even kill, the hardiest of creatures.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-1', 'srd', NULL, 'Damage and Healing (2)', '### Hit Points

Hit points represent a combination of physical and mental durability, the will to live, and luck. Creatures with more hit points are more difficult to kill. Those with fewer hit points are more fragile.

A creature''s current hit points (usually just called hit points) can be any number from the creature''s hit point maximum down to 0. This number changes frequently as a creature takes damage or receives healing.

Whenever a creature takes damage, that damage is subtracted from its hit points. The loss of hit points has no effect on a creature''s capabilities until the creature drops to 0 hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-2', 'srd', NULL, 'Damage and Healing (3)', '### Damage Rolls

Each weapon, spell, and harmful monster ability specifies the damage it deals. You roll the damage die or dice, add any modifiers, and apply the damage to your target. Magic weapons, special abilities, and other factors can grant a bonus to damage. With a penalty, it is possible to deal 0 damage, but never negative damage.

When attacking with a **weapon**, you add your ability modifier-the same modifier used for the attack roll-to the damage. A **spell** tells you which dice to roll for damage and whether to add any modifiers.

If a spell or other effect deals damage to **more** **than one target** at the same time, roll the damage once for all of them. For example, when a wizard casts *fireball* or a cleric casts *flame strike*, the spell''s damage is rolled once for all creatures caught in the blast.

#### Critical Hits

When you score a critical hit, you get to roll extra dice for the attack''s damage against the target. Roll all of the attack''s damage dice twice and add them together. Then add any relevant modifiers as normal. To speed up play, you can roll all the damage dice at once.

For example, if you score a critical hit with a dagger, roll 2d4 for the damage, rather than 1d4, and then add your relevant ability modifier. If the attack involves other damage dice, such as from the rogue''s Sneak Attack feature, you roll those dice twice as well.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-3', 'srd', NULL, 'Damage and Healing (4)', '#### Damage Types

Different attacks, damaging spells, and other harmful effects deal different types of damage. Damage types have no rules of their own, but other rules, such as damage resistance, rely on the types.

The damage types follow, with examples to help a GM assign a damage type to a new effect.

***Acid.*** The corrosive spray of a black dragon''s breath and the dissolving enzymes secreted by a black pudding deal acid damage.

***Bludgeoning.*** Blunt force attacks-hammers, falling, constriction, and the like-deal bludgeoning damage.

***Cold.*** The infernal chill radiating from an ice devil''s spear and the frigid blast of a white dragon''s breath deal cold damage.

***Fire.*** Red dragons breathe fire, and many spells conjure flames to deal fire damage.

***Force.*** Force is pure magical energy focused into a damaging form. Most effects that deal force damage are spells, including *magic missile* and *spiritual weapon*.

***Lightning.*** A *lightning bolt* spell and a blue dragon''s breath deal lightning damage.

***Necrotic.*** Necrotic damage, dealt by certain undead and a spell such as *chill touch*, withers matter and even the soul.

***Piercing.*** Puncturing and impaling attacks, including spears and monsters'' bites, deal piercing damage.

***Poison.*** Venomous stings and the toxic gas of a green dragon''s breath deal poison damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-4', 'srd', NULL, 'Damage and Healing (5)', '***Psychic.*** Mental abilities such as a mind flayer''s psionic blast deal psychic damage.

***Radiant.*** Radiant damage, dealt by a cleric''s *flame strike* spell or an angel''s smiting weapon, sears the flesh like fire and overloads the spirit with power.

***Slashing.*** Swords, axes, and monsters'' claws deal slashing damage.

***Thunder.*** A concussive burst of sound, such as the effect of the *thunderwave* spell, deals thunder damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-5', 'srd', NULL, 'Damage and Healing (6)', '### Damage Resistance and Vulnerability

Some creatures and objects are exceedingly difficult or unusually easy to hurt with certain types of damage.

If a creature or an object has **resistance** to a damage type, damage of that type is halved against it. If a creature or an object has **vulnerability** to a damage type, damage of that type is doubled against it.

Resistance and then vulnerability are applied after all other modifiers to damage. For example, a creature has resistance to bludgeoning damage and is hit by an attack that deals 25 bludgeoning damage. The creature is also within a magical aura that reduces all damage by 5. The 25 damage is first reduced by 5 and then halved, so the creature takes 10 damage.

Multiple instances of resistance or vulnerability that affect the same damage type count as only one instance. For example, if a creature has resistance to fire damage as well as resistance to all nonmagical damage, the damage of a nonmagical fire is reduced by half against the creature, not reduced by three-quarters.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-6', 'srd', NULL, 'Damage and Healing (7)', '### Healing

Unless it results in death, damage isn''t permanent. Even death is reversible through powerful magic. Rest can restore a creature''s hit points, and magical methods such as a *cure wounds* spell or a *potion of healing* can remove damage in an instant.

When a creature receives healing of any kind, hit points regained are added to its current hit points. A creature''s hit points can''t exceed its hit point maximum, so any hit points regained in excess of this number are lost. For example, a druid grants a ranger 8 hit points of healing. If the ranger has 14 current hit points and has a hit point maximum of 20, the ranger regains 6 hit points from the druid, not 8.

A creature that has died can''t regain hit points until magic such as the *revivify* spell has restored it to life.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-7', 'srd', NULL, 'Damage and Healing (8)', '### Dropping to 0 Hit Points

When you drop to 0 hit points, you either die outright or fall unconscious, as explained in the following sections.

#### Instant Death

Massive damage can kill you instantly. When damage reduces you to 0 hit points and there is damage remaining, you die if the remaining damage equals or exceeds your hit point maximum.

For example, a cleric with a maximum of 12 hit points currently has 6 hit points. If she takes 18 damage from an attack, she is reduced to 0 hit points, but 12 damage remains. Because the remaining damage equals her hit point maximum, the cleric dies.

#### Falling Unconscious

If damage reduces you to 0 hit points and fails to kill you, you fall unconscious (see appendix PH-A). This unconsciousness ends if you regain any hit points.

#### Death Saving Throws

Whenever you start your turn with 0 hit points, you must make a special saving throw, called a death saving throw, to determine whether you creep closer to death or hang onto life. Unlike other saving throws, this one isn''t tied to any ability score. You are in the hands of fate now, aided only by spells and features that improve your chances of succeeding on a saving throw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-8', 'srd', NULL, 'Damage and Healing (9)', 'Roll a d20. If the roll is 10 or higher, you succeed. Otherwise, you fail. A success or failure has no effect by itself. On your third success, you become stable (see below). On your third failure, you die. The successes and failures don''t need to be consecutive; keep track of both until you collect three of a kind. The number of both is reset to zero when you regain any hit points or become stable.

***Rolling 1 or 20.*** When you make a death saving throw and roll a 1 on the d20, it counts as two failures. If you roll a 20 on the d20, you regain 1 hit point.

***Damage at 0 Hit Points.*** If you take any damage while you have 0 hit points, you suffer a death saving throw failure. If the damage is from a critical hit, you suffer two failures instead. If the damage equals or exceeds your hit point maximum, you suffer instant death.

#### Stabilizing a Creature

The best way to save a creature with 0 hit points is to heal it. If healing is unavailable, the creature can at least be stabilized so that it isn''t killed by a failed death saving throw.

You can use your action to administer first aid to an unconscious creature and attempt to stabilize it, which requires a successful DC 10 Wisdom (Medicine) check.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-9', 'srd', NULL, 'Damage and Healing (10)', 'A **stable** creature doesn''t make death saving throws, even though it has 0 hit points, but it does remain unconscious. The creature stops being stable, and must start making death saving throws again, if it takes any damage. A stable creature that isn''t healed regains 1 hit point after 1d4 hours.

#### Monsters and Death

Most GMs have a monster die the instant it drops to 0 hit points, rather than having it fall unconscious and make death saving throws.

Mighty villains and special nonplayer characters are common exceptions; the GM might have them fall unconscious and follow the same rules as player characters.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-10', 'srd', NULL, 'Damage and Healing (11)', '### Knocking a Creature Out

Sometimes an attacker wants to incapacitate a foe, rather than deal a killing blow. When an attacker reduces a creature to 0 hit points with a melee attack, the attacker can knock the creature out. The attacker can make this choice the instant the damage is dealt. The creature falls unconscious and is stable.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-11', 'srd', NULL, 'Damage and Healing (12)', '### Temporary Hit Points

Some spells and special abilities confer temporary hit points to a creature. Temporary hit points aren''t actual hit points; they are a buffer against damage, a pool of hit points that protect you from injury.

When you have temporary hit points and take damage, the temporary hit points are lost first, and any leftover damage carries over to your normal hit points. For example, if you have 5 temporary hit points and take 7 damage, you lose the temporary hit points and then take 2 damage.

Because temporary hit points are separate from your actual hit points, they can exceed your hit point maximum. A character can, therefore, be at full hit points and receive temporary hit points.

Healing can''t restore temporary hit points, and they can''t be added together. If you have temporary hit points and receive more of them, you decide whether to keep the ones you have or to gain the new ones. For example, if a spell grants you 12 temporary hit points when you already have 10, you can have 12 or 10, not 22.

If you have 0 hit points, receiving temporary hit points doesn''t restore you to consciousness or stabilize you. They can still absorb damage directed at you while you''re in that state, but only true healing can save you.

Unless a feature that grants you temporary hit points has a duration, they last until they''re depleted or you finish a long rest.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-mounted-combat-0', 'srd', NULL, 'Mounted Combat (1)', '## Mounted Combat

A knight charging into battle on a warhorse, a wizard casting spells from the back of a griffon, or a cleric soaring through the sky on a pegasus all enjoy the benefits of speed and mobility that a mount can provide.

A willing creature that is at least one size larger than you and that has an appropriate anatomy can serve as a mount, using the following rules.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-mounted-combat-1', 'srd', NULL, 'Mounted Combat (2)', '### Mounting and Dismounting

Once during your move, you can mount a creature that is within 5 feet of you or dismount. Doing so costs an amount of movement equal to half your speed. For example, if your speed is 30 feet, you must spend 15 feet of movement to mount a horse. Therefore, you can''t mount it if you don''t have 15 feet of movement left or if your speed is 0.

If an effect moves your mount against its will while you''re on it, you must succeed on a DC 10 Dexterity saving throw or fall off the mount, landing prone in a space within 5 feet of it. If you''re knocked prone while mounted, you must make the same saving throw.

If your mount is knocked prone, you can use your reaction to dismount it as it falls and land on your feet. Otherwise, you are dismounted and fall prone in a space within 5 feet it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-mounted-combat-2', 'srd', NULL, 'Mounted Combat (3)', '### Controlling a Mount

While you''re mounted, you have two options. You can either control the mount or allow it to act independently. Intelligent creatures, such as dragons, act independently.

You can control a mount only if it has been trained to accept a rider. Domesticated horses, donkeys, and similar creatures are assumed to have such training. The initiative of a controlled mount changes to match yours when you mount it. It moves as you direct it, and it has only three action options: Dash, Disengage, and Dodge. A controlled mount can move and act even on the turn that you mount it.

An independent mount retains its place in the initiative order. Bearing a rider puts no restrictions on the actions the mount can take, and it moves and acts as it wishes. It might flee from combat, rush to attack and devour a badly injured foe, or otherwise act against your wishes.

In either case, if the mount provokes an opportunity attack while you''re on it, the attacker can target you or the mount.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-underwater-combat-0', 'srd', NULL, 'Underwater Combat', '## Underwater Combat

When adventurers pursue sahuagin back to their undersea homes, fight off sharks in an ancient shipwreck, or find themselves in a flooded dungeon room, they must fight in a challenging environment. Underwater the following rules apply.

When making a **melee weapon attack**, a creature that doesn''t have a swimming speed (either natural or granted by magic) has disadvantage on the attack roll unless the weapon is a dagger, javelin, shortsword, spear, or trident.

A **ranged weapon attack** automatically misses a target beyond the weapon''s normal range. Even against a target within normal range, the attack roll has disadvantage unless the weapon is a crossbow, a net, or a weapon that is thrown like a javelin (including a spear, trident, or dart).

Creatures and objects that are fully immersed in water have resistance to fire damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-scores-and-modifiers-0', 'srd', NULL, 'Ability Scores and Modifiers', '## Ability Scores and Modifiers

| Score | Modifier |
|-------|----------|
| 1     | -5       |
| 2-3   | -4       |
| 4-5   | -3       |
| 6-7   | -2       |
| 8-9   | -1       |
| 10-11 | +0       |
| 12-13 | +1       |
| 14-15 | +2       |
| 16-17 | +3       |
| 18-19 | +4       |
| 20-21 | +5       |
| 22-23 | +6       |
| 24-25 | +7       |
| 26-27 | +8       |
| 28-29 | +9       |
| 30    | +10      |

To determine an ability modifier without consulting the table, subtract 10 from the ability score and then divide the total by 2 (round down).

Because ability modifiers affect almost every attack roll, ability check, and saving throw, ability modifiers come up in play more often than their associated scores.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-advantage-and-disadvantage-0', 'srd', NULL, 'Advantage and Disadvantage (1)', '## Advantage and Disadvantage

Sometimes a special ability or spell tells you that you have advantage or disadvantage on an ability check, a saving throw, or an attack roll. When that happens, you roll a second d20 when you make the roll. Use the higher of the two rolls if you have advantage, and use the lower roll if you have disadvantage. For example, if you have disadvantage and roll a 17 and a 5, you use the 5. If you instead have advantage and roll those numbers, you use the 17.

If multiple situations affect a roll and each one grants advantage or imposes disadvantage on it, you don''t roll more than one additional d20. If two favorable situations grant advantage, for example, you still roll only one additional d20.

If circumstances cause a roll to have both advantage and disadvantage, you are considered to have neither of them, and you roll one d20. This is true even if multiple circumstances impose disadvantage and only one grants advantage or vice versa. In such a situation, you have neither advantage nor disadvantage.

When you have advantage or disadvantage and something in the game, such as the halfling''s Lucky trait, lets you reroll the d20, you can reroll only one of the dice. You choose which one. For example, if a halfling has advantage or disadvantage on an ability check and rolls a 1 and a 13, the halfling could use the Lucky trait to reroll the 1.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-advantage-and-disadvantage-1', 'srd', NULL, 'Advantage and Disadvantage (2)', 'You usually gain advantage or disadvantage through the use of special abilities, actions, or spells. Inspiration can also give a character advantage. The

GM can also decide that circumstances influence a roll in one direction or the other and grant advantage or impose disadvantage as a result.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-proficiency-bonus-0', 'srd', NULL, 'Proficiency Bonus (1)', '## Proficiency Bonus

Characters have a proficiency bonus determined by level. Monsters also have this bonus, which is incorporated in their stat blocks. The bonus is used in the rules on ability checks, saving throws, and attack rolls.

Your proficiency bonus can''t be added to a single die roll or other number more than once. For example, if two different rules say you can add your proficiency bonus to a Wisdom saving throw, you nevertheless add the bonus only once when you make the save.

Occasionally, your proficiency bonus might be multiplied or divided (doubled or halved, for example) before you apply it. For example, the rogue''s Expertise feature doubles the proficiency bonus for certain ability checks. If a circumstance suggests that your proficiency bonus applies more than once to the same roll, you still add it only once and multiply or divide it only once.

By the same token, if a feature or effect allows you to multiply your proficiency bonus when making an ability check that wouldn''t normally benefit from your proficiency bonus, you still don''t add the bonus to the check. For that check your proficiency bonus is 0, given the fact that multiplying 0 by any number is still 0. For instance, if you lack proficiency in the History skill, you gain no benefit from a feature that lets you double your proficiency bonus when you make Intelligence (History) checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-proficiency-bonus-1', 'srd', NULL, 'Proficiency Bonus (2)', 'In general, you don''t multiply your proficiency bonus for attack rolls or saving throws. If a feature or effect allows you to do so, these same rules apply.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-0', 'srd', NULL, 'Ability Checks (1)', '## Ability Checks

An ability check tests a character''s or monster''s innate talent and training in an effort to overcome a challenge. The GM calls for an ability check when a character or monster attempts an action (other than an attack) that has a chance of failure. When the outcome is uncertain, the dice determine the results.

For every ability check, the GM decides which of the six abilities is relevant to the task at hand and the difficulty of the task, represented by a Difficulty Class.

The more difficult a task, the higher its DC. The Typical Difficulty Classes table shows the most common DCs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-1', 'srd', NULL, 'Ability Checks (2)', '### Typical Difficulty Classes

| Task Difficulty   | DC |
|-------------------|----|
| Very easy         | 5  |
| Easy              | 10 |
| Medium            | 15 |
| Hard              | 20 |
| Very hard         | 25 |
| Nearly impossible | 30 |

To make an ability check, roll a d20 and add the relevant ability modifier. As with other d20 rolls, apply bonuses and penalties, and compare the total to the DC. If the total equals or exceeds the DC, the ability check is a success-the creature overcomes the challenge at hand. Otherwise, it''s a failure, which means the character or monster makes no progress toward the objective or makes progress combined with a setback determined by the GM.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-2', 'srd', NULL, 'Ability Checks (3)', '### Contests

Sometimes one character''s or monster''s efforts are directly opposed to another''s. This can occur when both of them are trying to do the same thing and only one can succeed, such as attempting to snatch up a magic ring that has fallen on the floor. This situation also applies when one of them is trying to prevent the other one from accomplishing a goal--for example, when a monster tries to force open a door that an adventurer is holding closed. In situations like these, the outcome is determined by a special form of ability check, called a contest.

Both participants in a contest make ability checks appropriate to their efforts. They apply all appropriate bonuses and penalties, but instead of comparing the total to a DC, they compare the totals of their two checks. The participant with the higher check total wins the contest. That character or monster either succeeds at the action or prevents the other one from succeeding.

If the contest results in a tie, the situation remains the same as it was before the contest. Thus, one contestant might win the contest by default. If two characters tie in a contest to snatch a ring off the floor, neither character grabs it. In a contest between a monster trying to open a door and an adventurer trying to keep the door closed, a tie means that the door remains shut.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-3', 'srd', NULL, 'Ability Checks (4)', '### Skills

Each ability covers a broad range of capabilities, including skills that a character or a monster can be proficient in. A skill represents a specific aspect of an ability score, and an individual''s proficiency in a skill demonstrates a focus on that aspect. (A character''s starting skill proficiencies are determined at character creation, and a monster''s skill proficiencies appear in the monster''s stat block.)

For example, a Dexterity check might reflect a character''s attempt to pull off an acrobatic stunt, to palm an object, or to stay hidden. Each of these aspects of Dexterity has an associated skill: Acrobatics, Sleight of Hand, and Stealth, respectively. So a character who has proficiency in the Stealth skill is particularly good at Dexterity checks related to sneaking and hiding.

The skills related to each ability score are shown in the following list. (No skills are related to Constitution.) See an ability''s description in the later sections of this section for examples of how to use a skill associated with an ability.

#### Strength
- Athletics

#### Dexterity
- Acrobatics
- Sleight of Hand
- Stealth

#### Intelligence
- Arcana
- History
- Investigation
- Nature
- Religion

#### Wisdom
- Animal Handling
- Insight
- Medicine
- Perception
- Survival

#### Charisma
- Deception
- Intimidation
- Performance
- Persuasion', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-4', 'srd', NULL, 'Ability Checks (5)', 'Sometimes, the GM might ask for an ability check using a specific skill-for example, "Make a Wisdom (Perception) check." At other times, a player might ask the GM if proficiency in a particular skill applies to a check. In either case, proficiency in a skill means an individual can add his or her proficiency bonus to ability checks that involve that skill. Without proficiency in the skill, the individual makes a normal ability check.

For example, if a character attempts to climb up a dangerous cliff, the GM might ask for a Strength (Athletics) check. If the character is proficient in Athletics, the character''s proficiency bonus is added to the Strength check. If the character lacks that proficiency, he or she just makes a Strength check.

#### Variant: Skills with Different Abilities', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-5', 'srd', NULL, 'Ability Checks (6)', 'Normally, your proficiency in a skill applies only to a specific kind of ability check. Proficiency in Athletics, for example, usually applies to Strength checks. In some situations, though, your proficiency might reasonably apply to a different kind of check. In such cases, the GM might ask for a check using an unusual combination of ability and skill, or you might ask your GM if you can apply a proficiency to a different check. For example, if you have to swim from an offshore island to the mainland, your GM might call for a Constitution check to see if you have the stamina to make it that far. In this case, your GM might allow you to apply your proficiency in Athletics and ask for a Constitution (Athletics) check. So if you''re proficient in Athletics, you apply your proficiency bonus to the Constitution check just as you would normally do for a Strength (Athletics) check. Similarly, when your half-orc barbarian uses a display of raw strength to intimidate an enemy, your GM might ask for a Strength (Intimidation) check, even though Intimidation is normally associated with Charisma.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-6', 'srd', NULL, 'Ability Checks (7)', '### Passive Checks

A passive check is a special kind of ability check that doesn''t involve any die rolls. Such a check can represent the average result for a task done repeatedly, such as searching for secret doors over and over again, or can be used when the GM wants to secretly determine whether the characters succeed at something without rolling dice, such as noticing a hidden monster.

Here''s how to determine a character''s total for a passive check:

10 + all modifiers that normally apply to the check

If the character has advantage on the check, add 5. For disadvantage, subtract 5. The game refers to a passive check total as a **score**.

For example, if a 1st-level character has a Wisdom of 15 and proficiency in Perception, he or she has a passive Wisdom (Perception) score of 14.

The rules on hiding in the "Dexterity" section below rely on passive checks, as do the exploration rules.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-7', 'srd', NULL, 'Ability Checks (8)', '### Working Together

Sometimes two or more characters team up to attempt a task. The character who''s leading the effort-or the one with the highest ability modifier-can make an ability check with advantage, reflecting the help provided by the other characters. In combat, this requires the Help action.

A character can only provide help if the task is one that he or she could attempt alone. For example, trying to open a lock requires proficiency with thieves'' tools, so a character who lacks that proficiency can''t help another character in that task. Moreover, a character can help only when two or more individuals working together would actually be productive. Some tasks, such as threading a needle, are no easier with help.

#### Group Checks

When a number of individuals are trying to accomplish something as a group, the GM might ask for a group ability check. In such a situation, the characters who are skilled at a particular task help cover those who aren''t.

To make a group ability check, everyone in the group makes the ability check. If at least half the group succeeds, the whole group succeeds. Otherwise, the group fails.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-8', 'srd', NULL, 'Ability Checks (9)', 'Group checks don''t come up very often, and they''re most useful when all the characters succeed or fail as a group. For example, when adventurers are navigating a swamp, the GM might call for a group Wisdom (Survival) check to see if the characters can avoid the quicksand, sinkholes, and other natural hazards of the environment. If at least half the group succeeds, the successful characters are able to guide their companions out of danger. Otherwise, the group stumbles into one of these hazards.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-0', 'srd', NULL, 'Using Each Ability (1)', '## Using Each Ability

Every task that a character or monster might attempt in the game is covered by one of the six abilities. This section explains in more detail what those abilities mean and the ways they are used in the game.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-1', 'srd', NULL, 'Using Each Ability (2)', '### Strength

Strength measures bodily power, athletic training, and the extent to which you can exert raw physical force.

#### Strength Checks

A Strength check can model any attempt to lift, push, pull, or break something, to force your body through a space, or to otherwise apply brute force to a situation. The Athletics skill reflects aptitude in certain kinds of Strength checks.

***Athletics.*** Your Strength (Athletics) check covers difficult situations you encounter while climbing, jumping, or swimming. Examples include the following activities:
- You attempt to climb a sheer or slippery cliff, avoid hazards while scaling a wall, or cling to a surface while something is trying to knock you off.
- You try to jump an unusually long distance or pull off a stunt midjump.
- You struggle to swim or stay afloat in treacherous currents, storm-tossed waves, or areas of thick seaweed. Or another creature tries to push or pull you underwater or otherwise interfere with your swimming.

***Other Strength Checks.*** The GM might also call for a Strength check when you try to accomplish tasks like the following:
- Force open a stuck, locked, or barred door
- Break free of bonds
- Push through a tunnel that is too small
- Hang on to a wagon while being dragged behind it
- Tip over a statue
- Keep a boulder from rolling

#### Attack Rolls and Damage', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-2', 'srd', NULL, 'Using Each Ability (3)', 'You add your Strength modifier to your attack roll and your damage roll when attacking with a melee weapon such as a mace, a battleaxe, or a javelin. You use melee weapons to make melee attacks in hand-to-hand combat, and some of them can be thrown to make a ranged attack.

#### Lifting and Carrying

Your Strength score determines the amount of weight you can bear. The following terms define what you can lift or carry.

***Carrying Capacity.*** Your carrying capacity is your Strength score multiplied by 15. This is the weight (in pounds) that you can carry, which is high enough that most characters don''t usually have to worry about it.

***Push, Drag, or Lift.*** You can push, drag, or lift a weight in pounds up to twice your carrying capacity (or 30 times your Strength score). While pushing or dragging weight in excess of your carrying capacity, your speed drops to 5 feet.

***Size and Strength.*** Larger creatures can bear more weight, whereas Tiny creatures can carry less. For each size category above Medium, double the creature''s carrying capacity and the amount it can push, drag, or lift. For a Tiny creature, halve these weights.

##### Variant: Encumbrance', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-3', 'srd', NULL, 'Using Each Ability (4)', 'The rules for lifting and carrying are intentionally simple. Here is a variant if you are looking for more detailed rules for determining how a character is hindered by the weight of equipment. When you use this variant, ignore the Strength column of the Armor table.

If you carry weight in excess of 5 times your Strength score, you are **encumbered**, which means your speed drops by 10 feet.

If you carry weight in excess of 10 times your Strength score, up to your maximum carrying capacity, you are instead **heavily encumbered**, which means your speed drops by 20 feet and you have disadvantage on ability checks, attack rolls, and saving throws that use Strength, Dexterity, or Constitution.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-4', 'srd', NULL, 'Using Each Ability (5)', '### Dexterity

Dexterity measures agility, reflexes, and balance.

#### Dexterity Checks

A Dexterity check can model any attempt to move nimbly, quickly, or quietly, or to keep from falling on tricky footing. The Acrobatics, Sleight of Hand, and Stealth skills reflect aptitude in certain kinds of Dexterity checks.

***Acrobatics.*** Your Dexterity (Acrobatics) check covers your attempt to stay on your feet in a tricky situation, such as when you''re trying to run across a sheet of ice, balance on a tightrope, or stay upright on a rocking ship''s deck. The GM might also call for a Dexterity (Acrobatics) check to see if you can perform acrobatic stunts, including dives, rolls, somersaults, and flips.

***Sleight of Hand.*** Whenever you attempt an act of legerdemain or manual trickery, such as planting something on someone else or concealing an object on your person, make a Dexterity (Sleight of Hand) check. The GM might also call for a Dexterity (Sleight of Hand) check to determine whether you can lift a coin purse off another person or slip something out of another person''s pocket.

***Stealth.*** Make a Dexterity (Stealth) check when you attempt to conceal yourself from enemies, slink past guards, slip away without being noticed, or sneak up on someone without being seen or heard.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-5', 'srd', NULL, 'Using Each Ability (6)', '***Other Dexterity Checks.*** The GM might call for a Dexterity check when you try to accomplish tasks like the following:
- Control a heavily laden cart on a steep descent
- Steer a chariot around a tight turn
- Pick a lock
- Disable a trap
- Securely tie up a prisoner
- Wriggle free of bonds
- Play a stringed instrument
- Craft a small or detailed object

#### Attack Rolls and Damage

You add your Dexterity modifier to your attack roll and your damage roll when attacking with a ranged weapon, such as a sling or a longbow. You can also add your Dexterity modifier to your attack roll and your damage roll when attacking with a melee weapon that has the finesse property, such as a dagger or a rapier.

#### Armor Class

Depending on the armor you wear, you might add some or all of your Dexterity modifier to your Armor Class.

#### Initiative

At the beginning of every combat, you roll initiative by making a Dexterity check. Initiative determines the order of creatures'' turns in combat.

#### Hiding

The GM decides when circumstances are appropriate for hiding. When you try to hide, make a Dexterity (Stealth) check. Until you are discovered or you stop hiding, that check''s total is contested by the Wisdom (Perception) check of any creature that actively searches for signs of your presence.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-6', 'srd', NULL, 'Using Each Ability (7)', 'You can''t hide from a creature that can see you clearly, and you give away your position if you make noise, such as shouting a warning or knocking over a vase.

An invisible creature can always try to hide. Signs of its passage might still be noticed, and it does have to stay quiet.

In combat, most creatures stay alert for signs of danger all around, so if you come out of hiding and approach a creature, it usually sees you. However, under certain circumstances, the GM might allow you to stay hidden as you approach a creature that is distracted, allowing you to gain advantage on an attack roll before you are seen.

***Passive Perception.*** When you hide, there''s a chance someone will notice you even if they aren''t searching. To determine whether such a creature notices you, the GM compares your Dexterity (Stealth) check with that creature''s passive Wisdom (Perception) score, which equals 10 + the creature''s Wisdom modifier, as well as any other bonuses or penalties. If the creature has advantage, add 5. For disadvantage, subtract 5. For example, if a 1st-level character (with a proficiency bonus of +2) has a Wisdom of 15 (a +2 modifier) and proficiency in Perception, he or she has a passive Wisdom (Perception) of 14.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-7', 'srd', NULL, 'Using Each Ability (8)', '***What Can You See?*** One of the main factors in determining whether you can find a hidden creature or object is how well you can see in an area, which might be **lightly** or **heavily obscured**, as explained in chapter 8, "Adventuring."', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-8', 'srd', NULL, 'Using Each Ability (9)', '### Constitution

Constitution measures health, stamina, and vital force.

#### Constitution Checks

Constitution checks are uncommon, and no skills apply to Constitution checks, because the endurance this ability represents is largely passive rather than involving a specific effort on the part of a character or monster. A Constitution check can model your attempt to push beyond normal limits, however.

The GM might call for a Constitution check when you try to accomplish tasks like the following:
- Hold your breath
- March or labor for hours without rest
- Go without sleep
- Survive without food or water
- Quaff an entire stein of ale in one go

#### Hit Points

Your Constitution modifier contributes to your hit points. Typically, you add your Constitution modifier to each Hit Die you roll for your hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-9', 'srd', NULL, 'Using Each Ability (10)', 'If your Constitution modifier changes, your hit point maximum changes as well, as though you had the new modifier from 1st level. For example, if you raise your Constitution score when you reach 4th level and your Constitution modifier increases from +1 to +2, you adjust your hit point maximum as though the modifier had always been +2. So you add 3 hit points for your first three levels, and then roll your hit points for 4th level using your new modifier. Or if you''re 7th level and some effect lowers your Constitution score so as to reduce your Constitution modifier by 1, your hit point maximum is reduced by 7.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-10', 'srd', NULL, 'Using Each Ability (11)', '### Intelligence

Intelligence measures mental acuity, accuracy of recall, and the ability to reason.

#### Intelligence Checks

An Intelligence check comes into play when you need to draw on logic, education, memory, or deductive reasoning. The Arcana, History, Investigation, Nature, and Religion skills reflect aptitude in certain kinds of Intelligence checks.

***Arcana.*** Your Intelligence (Arcana) check measures your ability to recall lore about spells, magic items, eldritch symbols, magical traditions, the planes of existence, and the inhabitants of those planes.

***History.*** Your Intelligence (History) check measures your ability to recall lore about historical events, legendary people, ancient kingdoms, past disputes, recent wars, and lost civilizations.

***Investigation.*** When you look around for clues and make deductions based on those clues, you make an Intelligence (Investigation) check. You might deduce the location of a hidden object, discern from the appearance of a wound what kind of weapon dealt it, or determine the weakest point in a tunnel that could cause it to collapse. Poring through ancient scrolls in search of a hidden fragment of knowledge might also call for an Intelligence (Investigation) check.

***Nature.*** Your Intelligence (Nature) check measures your ability to recall lore about terrain, plants and animals, the weather, and natural cycles.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-11', 'srd', NULL, 'Using Each Ability (12)', '***Religion.*** Your Intelligence (Religion) check measures your ability to recall lore about deities, rites and prayers, religious hierarchies, holy symbols, and the practices of secret cults.

***Other Intelligence Checks.*** The GM might call for an Intelligence check when you try to accomplish tasks like the following:
- Communicate with a creature without using words
- Estimate the value of a precious item
- Pull together a disguise to pass as a city guard
- Forge a document
- Recall lore about a craft or trade
- Win a game of skill

#### Spellcasting Ability

Wizards use Intelligence as their spellcasting ability, which helps determine the saving throw DCs of spells they cast.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-12', 'srd', NULL, 'Using Each Ability (13)', '### Wisdom

Wisdom reflects how attuned you are to the world around you and represents perceptiveness and intuition.

#### Wisdom Checks

A Wisdom check might reflect an effort to read body language, understand someone''s feelings, notice things about the environment, or care for an injured person. The Animal Handling, Insight, Medicine, Perception, and Survival skills reflect aptitude in certain kinds of Wisdom checks.

***Animal Handling.*** When there is any question whether you can calm down a domesticated animal, keep a mount from getting spooked, or intuit an animal''s intentions, the GM might call for a Wisdom (Animal Handling) check. You also make a Wisdom (Animal Handling) check to control your mount when you attempt a risky maneuver.

***Insight.*** Your Wisdom (Insight) check decides whether you can determine the true intentions of a creature, such as when searching out a lie or predicting someone''s next move. Doing so involves gleaning clues from body language, speech habits, and changes in mannerisms.

***Medicine.*** A Wisdom (Medicine) check lets you try to stabilize a dying companion or diagnose an illness.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-13', 'srd', NULL, 'Using Each Ability (14)', '***Perception.*** Your Wisdom (Perception) check lets you spot, hear, or otherwise detect the presence of something. It measures your general awareness of your surroundings and the keenness of your senses. For example, you might try to hear a conversation through a closed door, eavesdrop under an open window, or hear monsters moving stealthily in the forest. Or you might try to spot things that are obscured or easy to miss, whether they are orcs lying in ambush on a road, thugs hiding in the shadows of an alley, or candlelight under a closed secret door.

***Survival.*** The GM might ask you to make a

Wisdom (Survival) check to follow tracks, hunt wild game, guide your group through frozen wastelands, identify signs that owlbears live nearby, predict the weather, or avoid quicksand and other natural hazards.

***Other Wisdom Checks.*** The GM might call for a

Wisdom check when you try to accomplish tasks like the following:
- Get a gut feeling about what course of action to follow
- Discern whether a seemingly dead or living creature is undead

#### Spellcasting Ability

Clerics, druids, and rangers use Wisdom as their spellcasting ability, which helps determine the saving throw DCs of spells they cast.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-14', 'srd', NULL, 'Using Each Ability (15)', '### Charisma

Charisma measures your ability to interact effectively with others. It includes such factors as confidence and eloquence, and it can represent a charming or commanding personality.

#### Charisma Checks

A Charisma check might arise when you try to influence or entertain others, when you try to make an impression or tell a convincing lie, or when you are navigating a tricky social situation. The Deception, Intimidation, Performance, and Persuasion skills reflect aptitude in certain kinds of Charisma checks.

***Deception.*** Your Charisma (Deception) check determines whether you can convincingly hide the truth, either verbally or through your actions. This deception can encompass everything from misleading others through ambiguity to telling outright lies. Typical situations include trying to fast- talk a guard, con a merchant, earn money through gambling, pass yourself off in a disguise, dull someone''s suspicions with false assurances, or maintain a straight face while telling a blatant lie.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-15', 'srd', NULL, 'Using Each Ability (16)', '***Intimidation.*** When you attempt to influence someone through overt threats, hostile actions, and physical violence, the GM might ask you to make a Charisma (Intimidation) check. Examples include trying to pry information out of a prisoner, convincing street thugs to back down from a confrontation, or using the edge of a broken bottle to convince a sneering vizier to reconsider a decision.

***Performance.*** Your Charisma (Performance) check determines how well you can delight an audience with music, dance, acting, storytelling, or some other form of entertainment.

***Persuasion.*** When you attempt to influence someone or a group of people with tact, social graces, or good nature, the GM might ask you to make a Charisma (Persuasion) check. Typically, you use persuasion when acting in good faith, to foster friendships, make cordial requests, or exhibit proper etiquette. Examples of persuading others include convincing a chamberlain to let your party see the king, negotiating peace between warring tribes, or inspiring a crowd of townsfolk.

***Other Charisma Checks.*** The GM might call for a Charisma check when you try to accomplish tasks like the following:
- Find the best person to talk to for news, rumors, and gossip
- Blend into a crowd to get the sense of key topics of conversation

#### Spellcasting Ability', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-16', 'srd', NULL, 'Using Each Ability (17)', 'Bards, paladins, sorcerers, and warlocks use Charisma as their spellcasting ability, which helps determine the saving throw DCs of spells they cast.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-saving-throws-0', 'srd', NULL, 'Saving Throws', '## Saving Throws

A saving throw-also called a save-represents an attempt to resist a spell, a trap, a poison, a disease, or a similar threat. You don''t normally decide to make a saving throw; you are forced to make one because your character or monster is at risk of harm.

To make a saving throw, roll a d20 and add the appropriate ability modifier. For example, you use your Dexterity modifier for a Dexterity saving throw.

A saving throw can be modified by a situational bonus or penalty and can be affected by advantage and disadvantage, as determined by the GM.

Each class gives proficiency in at least two saving throws. The wizard, for example, is proficient in Intelligence saves. As with skill proficiencies, proficiency in a saving throw lets a character add his or her proficiency bonus to saving throws made using a particular ability score. Some monsters have saving throw proficiencies as well.

The Difficulty Class for a saving throw is determined by the effect that causes it. For example, the DC for a saving throw allowed by a spell is determined by the caster''s spellcasting ability and proficiency bonus.

The result of a successful or failed saving throw is also detailed in the effect that allows the save. Usually, a successful save means that a creature suffers no harm, or reduced harm, from an effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-time-0', 'srd', NULL, 'Time', '## Time

In situations where keeping track of the passage of time is important, the GM determines the time a task requires. The GM might use a different time scale depending on the context of the situation at hand. In a dungeon environment, the adventurers'' movement happens on a scale of **minutes**. It takes them about a minute to creep down a long hallway, another minute to check for traps on the door at the end of the hall, and a good ten minutes to search the chamber beyond for anything interesting or valuable.

In a city or wilderness, a scale of **hours** is often more appropriate. Adventurers eager to reach the lonely tower at the heart of the forest hurry across those fifteen miles in just under four hours'' time.

For long journeys, a scale of **days** works best.

Following the road from Baldur''s Gate to Waterdeep, the adventurers spend four uneventful days before a goblin ambush interrupts their journey.

In combat and other fast-paced situations, the game relies on **rounds**, a 6-second span of time.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-0', 'srd', NULL, 'Movement (1)', '## Movement

Swimming across a rushing river, sneaking down a dungeon corridor, scaling a treacherous mountain slope-all sorts of movement play a key role in fantasy gaming adventures.

The GM can summarize the adventurers'' movement without calculating exact distances or travel times: "You travel through the forest and find the dungeon entrance late in the evening of the third day." Even in a dungeon, particularly a large dungeon or a cave network, the GM can summarize movement between encounters: "After killing the guardian at the entrance to the ancient dwarven stronghold, you consult your map, which leads you through miles of echoing corridors to a chasm bridged by a narrow stone arch."

Sometimes it''s important, though, to know how long it takes to get from one spot to another, whether the answer is in days, hours, or minutes. The rules for determining travel time depend on two factors: the speed and travel pace of the creatures moving and the terrain they''re moving over.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-1', 'srd', NULL, 'Movement (2)', '### Speed

Every character and monster has a speed, which is the distance in feet that the character or monster can walk in 1 round. This number assumes short bursts of energetic movement in the midst of a life-threatening situation.

The following rules determine how far a character or monster can move in a minute, an hour, or a day.

#### Travel Pace

While traveling, a group of adventurers can move at a normal, fast, or slow pace, as shown on the Travel Pace table. The table states how far the party can move in a period of time and whether the pace has any effect. A fast pace makes characters less perceptive, while a slow pace makes it possible to sneak around and to search an area more carefully.

***Forced March.*** The Travel Pace table assumes that characters travel for 8 hours in day. They can push on beyond that limit, at the risk of exhaustion.

For each additional hour of travel beyond 8 hours, the characters cover the distance shown in the Hour column for their pace, and each character must make a Constitution saving throw at the end of the hour. The DC is 10 + 1 for each hour past 8 hours. On a failed saving throw, a character suffers one level of exhaustion (see appendix PH-A).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-2', 'srd', NULL, 'Movement (3)', '***Mounts and Vehicles.*** For short spans of time (up to an hour), many animals move much faster than humanoids. A mounted character can ride at a gallop for about an hour, covering twice the usual distance for a fast pace. If fresh mounts are available every 8 to 10 miles, characters can cover larger distances at this pace, but this is very rare except in densely populated areas.

Characters in wagons, carriages, or other land vehicles choose a pace as normal. Characters in a waterborne vessel are limited to the speed of the vessel, and they don''t suffer penalties for a fast pace or gain benefits from a slow pace. Depending on the vessel and the size of the crew, ships might be able to travel for up to 24 hours per day.

Certain special mounts, such as a pegasus or griffon, or special vehicles, such as a *carpet of flying*, allow you to travel more swiftly.

##### Travel Pace', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-3', 'srd', NULL, 'Movement (4)', '| Pace   | Distance per: Minute | Hour    | Day      | Effect                                           |
|--------|----------------------|---------|----------|--------------------------------------------------|
| Fast   | 400 feet             | 4 miles | 30 miles | -5 penalty to passive Wisdom (Perception) scores |
| Normal | 300 feet             | 3 miles | 24 miles | -                                                |
| Slow   | 200 feet             | 2 miles | 18 miles | Able to use stealth                              |

#### Difficult Terrain

The travel speeds given in the Travel Pace table assume relatively simple terrain: roads, open plains, or clear dungeon corridors. But adventurers often face dense forests, deep swamps, rubble-filled ruins, steep mountains, and ice-covered ground-all considered difficult terrain.

You move at half speed in difficult terrain--moving 1 foot in difficult terrain costs 2 feet of speed-so you can cover only half the normal distance in a minute, an hour, or a day.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-4', 'srd', NULL, 'Movement (5)', '### Special Types of Movement

Movement through dangerous dungeons or wilderness areas often involves more than simply walking. Adventurers might have to climb, crawl, swim, or jump to get where they need to go.

#### Climbing, Swimming, and Crawling

While climbing or swimming, each foot of movement costs 1 extra foot (2 extra feet in difficult terrain), unless a creature has a climbing or swimming speed. At the GM''s option, climbing a slippery vertical surface or one with few handholds requires a successful Strength (Athletics) check. Similarly, gaining any distance in rough water might require a successful Strength (Athletics) check.

#### Jumping

Your Strength determines how far you can jump.

***Long Jump.*** When you make a long jump, you cover a number of feet up to your Strength score if you move at least 10 feet on foot immediately before the jump. When you make a standing long jump, you can leap only half that distance. Either way, each foot you clear on the jump costs a foot of movement.

This rule assumes that the height of your jump doesn''t matter, such as a jump across a stream or chasm. At your GM''s option, you must succeed on a DC 10 Strength (Athletics) check to clear a low obstacle (no taller than a quarter of the jump''s distance), such as a hedge or low wall. Otherwise, you hit it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-5', 'srd', NULL, 'Movement (6)', 'When you land in difficult terrain, you must succeed on a DC 10 Dexterity (Acrobatics) check to land on your feet. Otherwise, you land prone.

***High Jump.*** When you make a high jump, you leap into the air a number of feet equal to 3 + your Strength modifier if you move at least 10 feet on foot immediately before the jump. When you make a standing high jump, you can jump only half that distance. Either way, each foot you clear on the jump costs a foot of movement. In some circumstances, your GM might allow you to make a Strength (Athletics) check to jump higher than you normally can.

You can extend your arms half your height above yourself during the jump. Thus, you can reach above you a distance equal to the height of the jump plus 1.5 times your height.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-0', 'srd', NULL, 'The Environment (1)', '## The Environment

By its nature, adventuring involves delving into places that are dark, dangerous, and full of mysteries to be explored. The rules in this section cover some of the most important ways in which adventurers interact with the environment in such places.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-1', 'srd', NULL, 'The Environment (2)', '### Falling

A fall from a great height is one of the most common hazards facing an adventurer. At the end of a fall, a creature takes 1d6 bludgeoning damage for every 10 feet it fell, to a maximum of 20d6. The creature lands prone, unless it avoids taking damage from the fall.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-2', 'srd', NULL, 'The Environment (3)', '### Suffocating

A creature can hold its breath for a number of minutes equal to 1 + its Constitution modifier (minimum of 30 seconds).

When a creature runs out of breath or is choking, it can survive for a number of rounds equal to its Constitution modifier (minimum of 1 round). At the start of its next turn, it drops to 0 hit points and is dying, and it can''t regain hit points or be stabilized until it can breathe again.

For example, a creature with a Constitution of 14 can hold its breath for 3 minutes. If it starts suffocating, it has 2 rounds to reach air before it drops to 0 hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-3', 'srd', NULL, 'The Environment (4)', '### Vision and Light

The most fundamental tasks of adventuring--noticing danger, finding hidden objects, hitting an enemy in combat, and targeting a spell, to name just a few--rely heavily on a character''s ability to see. Darkness and other effects that obscure vision can prove a significant hindrance.

A given area might be lightly or heavily obscured. In a **lightly obscured** area, such as dim light, patchy fog, or moderate foliage, creatures have disadvantage on Wisdom (Perception) checks that rely on sight.

A **heavily obscured** area-such as darkness, opaque fog, or dense foliage-blocks vision entirely. A creature effectively suffers from the blinded condition (see appendix PH-A) when trying to see something in that area.

The presence or absence of light in an environment creates three categories of illumination: bright light, dim light, and darkness.

**Bright light** lets most creatures see normally.

Even gloomy days provide bright light, as do torches, lanterns, fires, and other sources of illumination within a specific radius.

**Dim light**, also called shadows, creates a lightly obscured area. An area of dim light is usually a boundary between a source of bright light, such as a torch, and surrounding darkness. The soft light of twilight and dawn also counts as dim light. A particularly brilliant full moon might bathe the land in dim light.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-4', 'srd', NULL, 'The Environment (5)', '**Darkness** creates a heavily obscured area.

Characters face darkness outdoors at night (even most moonlit nights), within the confines of an unlit dungeon or a subterranean vault, or in an area of magical darkness.

#### Blindsight

A creature with blindsight can perceive its surroundings without relying on sight, within a specific radius. Creatures without eyes, such as oozes, and creatures with echolocation or heightened senses, such as bats and true dragons, have this sense.

#### Darkvision

Many creatures in fantasy gaming worlds, especially those that dwell underground, have darkvision. Within a specified range, a creature with darkvision can see in darkness as if the darkness were dim light, so areas of darkness are only lightly obscured as far as that creature is concerned. However, the creature can''t discern color in darkness, only shades of gray.

#### Truesight

A creature with truesight can, out to a specific range, see in normal and magical darkness, see invisible creatures and objects, automatically detect visual illusions and succeed on saving throws against them, and perceives the original form of a shapechanger or a creature that is transformed by magic. Furthermore, the creature can see into the Ethereal Plane.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-5', 'srd', NULL, 'The Environment (6)', '### Food and Water

Characters who don''t eat or drink suffer the effects of exhaustion (see appendix PH-A). Exhaustion caused by lack of food or water can''t be removed until the character eats and drinks the full required amount.

#### Food

A character needs one pound of food per day and can make food last longer by subsisting on half rations. Eating half a pound of food in a day counts as half a day without food.

A character can go without food for a number of days equal to 3 + his or her Constitution modifier (minimum 1). At the end of each day beyond that limit, a character automatically suffers one level of exhaustion.

A normal day of eating resets the count of days without food to zero.

#### Water

A character needs one gallon of water per day, or two gallons per day if the weather is hot. A character who drinks only half that much water must succeed on a DC 15 Constitution saving throw or suffer one level of exhaustion at the end of the day. A character with access to even less water automatically suffers one level of exhaustion at the end of the day.

If the character already has one or more levels of exhaustion, the character takes two levels in either case.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-6', 'srd', NULL, 'The Environment (7)', '### Interacting with Objects

A character''s interaction with objects in an environment is often simple to resolve in the game. The player tells the GM that his or her character is doing something, such as moving a lever, and the GM describes what, if anything, happens.

For example, a character might decide to pull a lever, which might, in turn, raise a portcullis, cause a room to flood with water, or open a secret door in a nearby wall. If the lever is rusted in position, though, a character might need to force it. In such a situation, the GM might call for a Strength check to see whether the character can wrench the lever into place. The GM sets the DC for any such check based on the difficulty of the task.

Characters can also damage objects with their weapons and spells. Objects are immune to poison and psychic damage, but otherwise they can be affected by physical and magical attacks much like creatures can. The GM determines an object''s Armor Class and hit points, and might decide that certain objects have resistance or immunity to certain kinds of attacks. (It''s hard to cut a rope with a club, for example.) Objects always fail Strength and Dexterity saving throws, and they are immune to effects that require other saves. When an object drops to 0 hit points, it breaks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-7', 'srd', NULL, 'The Environment (8)', 'A character can also attempt a Strength check to break an object. The GM sets the DC for any such check.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-resting-0', 'srd', NULL, 'Resting (1)', '## Resting

Heroic though they might be, adventurers can''t spend every hour of the day in the thick of exploration, social interaction, and combat. They need rest-time to sleep and eat, tend their wounds, refresh their minds and spirits for spellcasting, and brace themselves for further adventure.

Adventurers can take short rests in the midst of an adventuring day and a long rest to end the day.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-resting-1', 'srd', NULL, 'Resting (2)', '### Short Rest

A short rest is a period of downtime, at least 1 hour long, during which a character does nothing more strenuous than eating, drinking, reading, and tending to wounds.

A character can spend one or more Hit Dice at the end of a short rest, up to the character''s maximum number of Hit Dice, which is equal to the character''s level. For each Hit Die spent in this way, the player rolls the die and adds the character''s Constitution modifier to it. The character regains hit points equal to the total. The player can decide to spend an additional Hit Die after each roll. A character regains some spent Hit Dice upon finishing a long rest, as explained below.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-resting-2', 'srd', NULL, 'Resting (3)', '### Long Rest

A long rest is a period of extended downtime, at least 8 hours long, during which a character sleeps or performs light activity: reading, talking, eating, or standing watch for no more than 2 hours. If the rest is interrupted by a period of strenuous activity-at least 1 hour of walking, fighting, casting spells, or similar adventuring activity-the characters must begin the rest again to gain any benefit from it.

At the end of a long rest, a character regains all lost hit points. The character also regains spent Hit Dice, up to a number of dice equal to half of the character''s total number of them (minimum of one die). For example, if a character has eight Hit Dice, he or she can regain four spent Hit Dice upon finishing a long rest.

A character can''t benefit from more than one long rest in a 24-hour period, and a character must have at least 1 hit point at the start of the rest to gain its benefits.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-0', 'srd', NULL, 'Between Adventures (1)', '## Between Adventures

Between trips to dungeons and battles against ancient evils, adventurers need time to rest, recuperate, and prepare for their next adventure. Many adventurers also use this time to perform other tasks, such as crafting arms and armor, performing research, or spending their hard-earned gold.

In some cases, the passage of time is something that occurs with little fanfare or description. When starting a new adventure, the GM might simply declare that a certain amount of time has passed and allow you to describe in general terms what your character has been doing. At other times, the GM might want to keep track of just how much time is passing as events beyond your perception stay in motion.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-1', 'srd', NULL, 'Between Adventures (2)', '### Lifestyle Expenses

Between adventures, you choose a particular quality of life and pay the cost of maintaining that lifestyle.

Living a particular lifestyle doesn''t have a huge effect on your character, but your lifestyle can affect the way other individuals and groups react to you. For example, when you lead an aristocratic lifestyle, it might be easier for you to influence the nobles of the city than if you live in poverty.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-2', 'srd', NULL, 'Between Adventures (3)', '### Downtime Activities

Between adventures, the GM might ask you what your character is doing during his or her downtime. Periods of downtime can vary in duration, but each downtime activity requires a certain number of days to complete before you gain any benefit, and at least 8 hours of each day must be spent on the downtime activity for the day to count. The days do not need to be consecutive. If you have more than the minimum amount of days to spend, you can keep doing the same thing for a longer period of time, or switch to a new downtime activity.

Downtime activities other than the ones presented below are possible. If you want your character to spend his or her downtime performing an activity not covered here, discuss it with your GM.

#### Crafting

You can craft nonmagical objects, including adventuring equipment and works of art. You must be proficient with tools related to the object you are trying to create (typically artisan''s tools). You might also need access to special materials or locations necessary to create it. For example, someone proficient with smith''s tools needs a forge in order to craft a sword or suit of armor.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-3', 'srd', NULL, 'Between Adventures (4)', 'For every day of downtime you spend crafting, you can craft one or more items with a total market value not exceeding 5 gp, and you must expend raw materials worth half the total market value. If something you want to craft has a market value greater than 5 gp, you make progress every day in 5-gp increments until you reach the market value of the item. For example, a suit of plate armor (market value 1,500 gp) takes 300 days to craft by yourself.

Multiple characters can combine their efforts toward the crafting of a single item, provided that the characters all have proficiency with the requisite tools and are working together in the same place. Each character contributes 5 gp worth of effort for every day spent helping to craft the item. For example, three characters with the requisite tool proficiency and the proper facilities can craft a suit of plate armor in 100 days, at a total cost of 750 gp.

While crafting, you can maintain a modest lifestyle without having to pay 1 gp per day, or a comfortable lifestyle at half the normal cost.

#### Practicing a Profession

You can work between adventures, allowing you to maintain a modest lifestyle without having to pay 1 gp per day. This benefit lasts as long you continue to practice your profession.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-4', 'srd', NULL, 'Between Adventures (5)', 'If you are a member of an organization that can provide gainful employment, such as a temple or a thieves'' guild, you earn enough to support a comfortable lifestyle instead.

If you have proficiency in the Performance skill and put your performance skill to use during your downtime, you earn enough to support a wealthy lifestyle instead.

#### Recuperating

You can use downtime between adventures to recover from a debilitating injury, disease, or poison.

After three days of downtime spent recuperating, you can make a DC 15 Constitution saving throw. On a successful save, you can choose one of the following results:
- End one effect on you that prevents you from regaining hit points.
- For the next 24 hours, gain advantage on saving throws against one disease or poison currently affecting you.

#### Researching

The time between adventures is a great chance to perform research, gaining insight into mysteries that have unfurled over the course of the campaign. Research can include poring over dusty tomes and crumbling scrolls in a library or buying drinks for the locals to pry rumors and gossip from their lips.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-5', 'srd', NULL, 'Between Adventures (6)', 'When you begin your research, the GM determines whether the information is available, how many days of downtime it will take to find it, and whether there are any restrictions on your research (such as needing to seek out a specific individual, tome, or location). The GM might also require you to make one or more ability checks, such as an Intelligence (Investigation) check to find clues pointing toward the information you seek, or a Charisma (Persuasion) check to secure someone''s aid. Once those conditions are met, you learn the information if it is available.

For each day of research, you must spend 1 gp to cover your expenses. This cost is in addition to your normal lifestyle expenses.

#### Training

You can spend time between adventures learning a new language or training with a set of tools. Your GM might allow additional training options.

First, you must find an instructor willing to teach you. The GM determines how long it takes, and whether one or more ability checks are required.

The training lasts for 250 days and costs 1 gp per day. After you spend the requisite amount of time and money, you learn the new language or gain proficiency with the new tool.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-0', 'srd', NULL, 'What Is a Spell? (1)', '## What Is a Spell?

A spell is a discrete magical effect, a single shaping of the magical energies that suffuse the multiverse into a specific, limited expression. In casting a spell, a character carefully plucks at the invisible strands of raw magic suffusing the world, pins them in place in a particular pattern, sets them vibrating in a specific way, and then releases them to unleash the desired effect-in most cases, all in the span of seconds.

Spells can be versatile tools, weapons, or protective wards. They can deal damage or undo it, impose or remove conditions (see appendix PH-A), drain life energy away, and restore life to the dead.

Uncounted thousands of spells have been created over the course of the multiverse''s history, and many of them are long forgotten. Some might yet lie recorded in crumbling spellbooks hidden in ancient ruins or trapped in the minds of dead gods. Or they might someday be reinvented by a character who has amassed enough power and wisdom to do so.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-1', 'srd', NULL, 'What Is a Spell? (2)', '### Spell Level

Every spell has a level from 0 to 9. A spell''s level is a general indicator of how powerful it is, with the lowly (but still impressive) *magic missile* at 1st level and the earth-shaking *wish* at 9th. Cantrips-simple but powerful spells that characters can cast almost by rote-are level 0. The higher a spell''s level, the higher level a spellcaster must be to use that spell.

Spell level and character level don''t correspond directly. Typically, a character has to be at least 17th level, not 9th level, to cast a 9th-level spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-2', 'srd', NULL, 'What Is a Spell? (3)', '### Known and Prepared Spells

Before a spellcaster can use a spell, he or she must have the spell firmly fixed in mind, or must have access to the spell in a magic item. Members of a few classes, including bards and sorcerers, have a limited list of spells they know that are always fixed in mind. The same thing is true of many magic-using monsters. Other spellcasters, such as clerics and wizards, undergo a process of preparing spells. This process varies for different classes, as detailed in their descriptions.

In every case, the number of spells a caster can have fixed in mind at any given time depends on the character''s level.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-3', 'srd', NULL, 'What Is a Spell? (4)', '### Spell Slots

Regardless of how many spells a caster knows or prepares, he or she can cast only a limited number of spells before resting. Manipulating the fabric of magic and channeling its energy into even a simple spell is physically and mentally taxing, and higher-level spells are even more so. Thus, each spellcasting class''s description (except that of the warlock) includes a table showing how many spell slots of each spell level a character can use at each character level. For example, the 3rd-level wizard Umara has four 1st-level spell slots and two 2nd-level slots.

When a character casts a spell, he or she expends a slot of that spell''s level or higher, effectively "filling" a slot with the spell. You can think of a spell slot as a groove of a certain size-small for a 1st-level slot, larger for a spell of higher level. A 1st-level spell fits into a slot of any size, but a 9th-level spell fits only in a 9th-level slot. So when Umara casts *magic missile,* a 1st-level spell, she spends one of her four 1st-level slots and has three remaining.

Finishing a long rest restores any expended spell slots.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-4', 'srd', NULL, 'What Is a Spell? (5)', 'Some characters and monsters have special abilities that let them cast spells without using spell slots. For example, a monk who follows the Way of the Four Elements, a warlock who chooses certain eldritch invocations, and a pit fiend from the Nine Hells can all cast spells in such a way.

#### Casting a Spell at a Higher Level

When a spellcaster casts a spell using a slot that is of a higher level than the spell, the spell assumes the higher level for that casting. For instance, if Umara casts *magic missile* using one of her 2nd-level slots, that *magic missile* is 2nd level. Effectively, the spell expands to fill the slot it is put into.

Some spells, such as *magic missile* and *cure wounds*, have more powerful effects when cast at a higher level, as detailed in a spell''s description.

#### Casting in Armor

Because of the mental focus and precise gestures required for spellcasting, you must be proficient with the armor you are wearing to cast a spell. You are otherwise too distracted and physically hampered by your armor for spellcasting.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-5', 'srd', NULL, 'What Is a Spell? (6)', '### Cantrips

A cantrip is a spell that can be cast at will, without using a spell slot and without being prepared in advance. Repeated practice has fixed the spell in the caster''s mind and infused the caster with the magic needed to produce the effect over and over. A cantrip''s spell level is 0.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-6', 'srd', NULL, 'What Is a Spell? (7)', '### Rituals

Certain spells have a special tag: ritual. Such a spell can be cast following the normal rules for spellcasting, or the spell can be cast as a ritual. The ritual version of a spell takes 10 minutes longer to cast than normal. It also doesn''t expend a spell slot, which means the ritual version of a spell can''t be cast at a higher level.

To cast a spell as a ritual, a spellcaster must have a feature that grants the ability to do so. The cleric and the druid, for example, have such a feature. The caster must also have the spell prepared or on his or her list of spells known, unless the character''s ritual feature specifies otherwise, as the wizard''s does.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-0', 'srd', NULL, 'Casting a Spell (1)', '## Casting a Spell

When a character casts any spell, the same basic rules are followed, regardless of the character''s class or the spell''s effects.

Each spell description begins with a block of information, including the spell''s name, level, school of magic, casting time, range, components, and duration. The rest of a spell entry describes the spell''s effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-1', 'srd', NULL, 'Casting a Spell (2)', '### Casting Time

Most spells require a single action to cast, but some spells require a bonus action, a reaction, or much more time to cast.

#### Bonus Action

A spell cast with a bonus action is especially swift. You must use a bonus action on your turn to cast the spell, provided that you haven''t already taken a bonus action this turn. You can''t cast another spell during the same turn, except for a cantrip with a casting time of 1 action.

#### Reactions

Some spells can be cast as reactions. These spells take a fraction of a second to bring about and are cast in response to some event. If a spell can be cast as a reaction, the spell description tells you exactly when you can do so.

#### Longer Casting Times

Certain spells (including spells cast as rituals) require more time to cast: minutes or even hours. When you cast a spell with a casting time longer than a single action or reaction, you must spend your action each turn casting the spell, and you must maintain your concentration while you do so (see "Concentration" below). If your concentration is broken, the spell fails, but you don''t expend a spell slot. If you want to try casting the spell again, you must start over.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-2', 'srd', NULL, 'Casting a Spell (3)', '### Spell Range

The target of a spell must be within the spell''s range. For a spell like *magic missile*, the target is a creature. For a spell like *fireball*, the target is the point in space where the ball of fire erupts.

Most spells have ranges expressed in feet. Some spells can target only a creature (including you) that you touch. Other spells, such as the *shield* spell, affect only you. These spells have a range of self.

Spells that create cones or lines of effect that originate from you also have a range of self, indicating that the origin point of the spell''s effect must be you (see "Areas of Effect" later in the this chapter).

Once a spell is cast, its effects aren''t limited by its range, unless the spell''s description says otherwise.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-3', 'srd', NULL, 'Casting a Spell (4)', '### Components

A spell''s components are the physical requirements you must meet in order to cast it. Each spell''s description indicates whether it requires verbal (V), somatic (S), or material (M) components. If you can''t provide one or more of a spell''s components, you are unable to cast the spell.

#### Verbal (V)

Most spells require the chanting of mystic words. The words themselves aren''t the source of the spell''s power; rather, the particular combination of sounds, with specific pitch and resonance, sets the threads of magic in motion. Thus, a character who is gagged or in an area of silence, such as one created by the *silence* spell, can''t cast a spell with a verbal component.

#### Somatic (S)

Spellcasting gestures might include a forceful gesticulation or an intricate set of gestures. If a spell requires a somatic component, the caster must have free use of at least one hand to perform these gestures.

#### Material (M)

Casting some spells requires particular objects, specified in parentheses in the component entry. A character can use a **component pouch** or a **spellcasting focus** (found in "Equipment") in place of the components specified for a spell. But if a cost is indicated for a component, a character must have that specific component before he or she can cast the spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-4', 'srd', NULL, 'Casting a Spell (5)', 'If a spell states that a material component is consumed by the spell, the caster must provide this component for each casting of the spell.

A spellcaster must have a hand free to access a spell''s material components-or to hold a spellcasting focus-but it can be the same hand that he or she uses to perform somatic components.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-5', 'srd', NULL, 'Casting a Spell (6)', '### Duration

A spell''s duration is the length of time the spell persists. A duration can be expressed in rounds, minutes, hours, or even years. Some spells specify that their effects last until the spells are dispelled or destroyed.

#### Instantaneous

Many spells are instantaneous. The spell harms, heals, creates, or alters a creature or an object in a way that can''t be dispelled, because its magic exists only for an instant.

#### Concentration

Some spells require you to maintain concentration in order to keep their magic active. If you lose concentration, such a spell ends.

If a spell must be maintained with concentration, that fact appears in its Duration entry, and the spell specifies how long you can concentrate on it. You can end concentration at any time (no action required).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-6', 'srd', NULL, 'Casting a Spell (7)', 'Normal activity, such as moving and attacking, doesn''t interfere with concentration. The following factors can break concentration:
- **Casting another spell that requires concentration.** You lose concentration on a spell if you cast another spell that requires concentration. You can''t concentrate on two spells at once.
- **Taking damage.** Whenever you take damage while you are concentrating on a spell, you must make a Constitution saving throw to maintain your concentration. The DC equals 10 or half the damage you take, whichever number is higher. If you take damage from multiple sources, such as an arrow and a dragon''s breath, you make a separate saving throw for each source of damage.
- **Being incapacitated or killed.** You lose concentration on a spell if you are incapacitated or if you die.

The GM might also decide that certain environmental phenomena, such as a wave crashing over you while you''re on a storm-tossed ship, require you to succeed on a DC 10 Constitution saving throw to maintain concentration on a spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-7', 'srd', NULL, 'Casting a Spell (8)', '### Targets

A typical spell requires you to pick one or more targets to be affected by the spell''s magic. A spell''s description tells you whether the spell targets creatures, objects, or a point of origin for an area of effect (described below).

Unless a spell has a perceptible effect, a creature might not know it was targeted by a spell at all. An effect like crackling lightning is obvious, but a more subtle effect, such as an attempt to read a creature''s thoughts, typically goes unnoticed, unless a spell says otherwise.

#### A Clear Path to the Target

To target something, you must have a clear path to it, so it can''t be behind total cover.

If you place an area of effect at a point that you can''t see and an obstruction, such as a wall, is between you and that point, the point of origin comes into being on the near side of that obstruction.

#### Targeting Yourself

If a spell targets a creature of your choice, you can choose yourself, unless the creature must be hostile or specifically a creature other than you. If you are in the area of effect of a spell you cast, you can target yourself.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-8', 'srd', NULL, 'Casting a Spell (9)', '### Areas of Effect

Spells such as *burning hands* and *cone of cold* cover an area, allowing them to affect multiple creatures at once.

A spell''s description specifies its area of effect, which typically has one of five different shapes: cone, cube, cylinder, line, or sphere. Every area of effect has a **point of origin**, a location from which the spell''s energy erupts. The rules for each shape specify how you position its point of origin. Typically, a point of origin is a point in space, but some spells have an area whose origin is a creature or an object.

A spell''s effect expands in straight lines from the point of origin. If no unblocked straight line extends from the point of origin to a location within the area of effect, that location isn''t included in the spell''s area. To block one of these imaginary lines, an obstruction must provide total cover.

#### Cone

A cone extends in a direction you choose from its point of origin. A cone''s width at a given point along its length is equal to that point''s distance from the point of origin. A cone''s area of effect specifies its maximum length.

A cone''s point of origin is not included in the cone''s area of effect, unless you decide otherwise.

#### Cube

You select a cube''s point of origin, which lies anywhere on a face of the cubic effect. The cube''s size is expressed as the length of each side.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-9', 'srd', NULL, 'Casting a Spell (10)', 'A cube''s point of origin is not included in the cube''s area of effect, unless you decide otherwise.

#### Cylinder

A cylinder''s point of origin is the center of a circle of a particular radius, as given in the spell description. The circle must either be on the ground or at the height of the spell effect. The energy in a cylinder expands in straight lines from the point of origin to the perimeter of the circle, forming the base of the cylinder. The spell''s effect then shoots up from the base or down from the top, to a distance equal to the height of the cylinder.

A cylinder''s point of origin is included in the cylinder''s area of effect.

#### Line

A line extends from its point of origin in a straight path up to its length and covers an area defined by its width.

A line''s point of origin is not included in the line''s area of effect, unless you decide otherwise.

#### Sphere

You select a sphere''s point of origin, and the sphere extends outward from that point. The sphere''s size is expressed as a radius in feet that extends from the point.

A sphere''s point of origin is included in the sphere''s area of effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-10', 'srd', NULL, 'Casting a Spell (11)', '### Spell Saving Throws

Many spells specify that a target can make a saving throw to avoid some or all of a spell''s effects. The spell specifies the ability that the target uses for the save and what happens on a success or failure.

The DC to resist one of your spells equals 8 + your spellcasting ability modifier + your proficiency bonus + any special modifiers.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-11', 'srd', NULL, 'Casting a Spell (12)', '### Spell Attack Rolls

Some spells require the caster to make an attack roll to determine whether the spell effect hits the intended target. Your attack bonus with a spell attack equals your spellcasting ability modifier + your proficiency bonus.

Most spells that require attack rolls involve ranged attacks. Remember that you have disadvantage on a ranged attack roll if you are within 5 feet of a hostile creature that can see you and that isn''t incapacitated.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-12', 'srd', NULL, 'Casting a Spell (13)', '### Combining Magical Effects

The effects of different spells add together while the durations of those spells overlap. The effects of the same spell cast multiple times don''t combine, however. Instead, the most potent effect-such as the highest bonus-from those castings applies while their durations overlap.

For example, if two clerics cast *bless* on the same target, that character gains the spell''s benefit only once; he or she doesn''t get to roll two bonus dice.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-13', 'srd', NULL, 'Casting a Spell (14)', '### The Schools of Magic

Academies of magic group spells into eight categories called schools of magic. Scholars, particularly wizards, apply these categories to all spells, believing that all magic functions in essentially the same way, whether it derives from rigorous study or is bestowed by a deity.

The schools of magic help describe spells; they have no rules of their own, although some rules refer to the schools.

**Abjuration** spells are protective in nature, though some of them have aggressive uses. They create magical barriers, negate harmful effects, harm trespassers, or banish creatures to other planes of existence.

**Conjuration** spells involve the transportation of objects and creatures from one location to another. Some spells summon creatures or objects to the caster''s side, whereas others allow the caster to teleport to another location. Some conjurations create objects or effects out of nothing.

**Divination** spells reveal information, whether in the form of secrets long forgotten, glimpses of the future, the locations of hidden things, the truth behind illusions, or visions of distant people or places.

**Enchantment** spells affect the minds of others, influencing or controlling their behavior. Such spells can make enemies see the caster as a friend, force creatures to take a course of action, or even control another creature like a puppet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-14', 'srd', NULL, 'Casting a Spell (15)', '**Evocation** spells manipulate magical energy to produce a desired effect. Some call up blasts of fire or lightning. Others channel positive energy to heal wounds.

**Illusion** spells deceive the senses or minds of others. They cause people to see things that are not there, to miss things that are there, to hear phantom noises, or to remember things that never happened. Some illusions create phantom images that any creature can see, but the most insidious illusions plant an image directly in the mind of a creature.

**Necromancy** spells manipulate the energies of life and death. Such spells can grant an extra reserve of life force, drain the life energy from another creature, create the undead, or even bring the dead back to life.

Creating the undead through the use of necromancy spells such as *animate dead* is not a good act, and only evil casters use such spells frequently.

**Transmutation** spells change the properties of a creature, object, or environment. They might turn an enemy into a harmless creature, bolster the strength of an ally, make an object move at the caster''s command, or enhance a creature''s innate healing abilities to rapidly recover from injury.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-standard-exchange-rates-0', 'srd', NULL, 'Standard Exchange Rates', '## Standard Exchange Rates
| Coin          | CP    | SP   | EP   | GP    | PP      |
|---------------|-------|------|------|-------|---------|
| Copper (cp)   | 1     | 1/10 | 1/50 | 1/100 | 1/1,000 |
| Silver (sp)   | 10    | 1    | 1/5  | 1/10  | 1/100   |
| Electrum (ep) | 50    | 5    | 1    | 1/2   | 1/20    |
| Gold (gp)     | 100   | 10   | 2    | 1     | 1/10    |
| Platinum (pp) | 1,000 | 100  | 20   | 10    | 1       |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-objects-0', 'srd', NULL, 'Objects (1)', '## Objects

When characters need to saw through ropes, shatter a window, or smash a vampire''s coffin, the only hard and fast rule is this: given enough time and the right tools, characters can destroy any destructible object. Use common sense when determining a character''s success at damaging an object. Can a fighter cut through a section of a stone wall with a sword? No, the sword is likely to break before the wall does.

For the purpose of these rules, an object is a discrete, inanimate item like a window, door, sword, book, table, chair, or stone, not a building or a vehicle that is composed of many other objects.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-objects-1', 'srd', NULL, 'Objects (2)', '### Statistics for Objects

When time is a factor, you can assign an Armor Class and hit points to a destructible object. You can also give it immunities, resistances, and vulnerabilities to specific types of damage.

***Armor Class.*** An object''s Armor Class is a measure of how difficult it is to deal damage to the object when striking it (because the object has no chance of dodging out of the way). The Object Armor Class table provides suggested AC values for various substances.

#### Object Armor Class

| Substance           | AC |
|---------------------|----|
| Cloth, paper, rope  | 11 |
| Crystal, glass, ice | 13 |
| Wood, bone          | 15 |
| Stone               | 17 |
| Iron, steel         | 19 |
| Mithral             | 21 |
| Adamantine          | 23 |

***Hit Points.*** An object''s hit points measure how much damage it can take before losing its structural integrity. Resilient objects have more hit points than fragile ones. Large objects also tend to have more hit points than small ones, unless breaking a small part of the object is just as effective as breaking the whole thing. The Object Hit Points table provides suggested hit points for fragile and resilient objects that are Large or smaller.

#### Object Hit Points', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-objects-2', 'srd', NULL, 'Objects (3)', '***Huge and Gargantuan Objects.*** Normal weapons are of little use against many Huge and Gargantuan objects, such as a colossal statue, towering column of stone, or massive boulder. That said, one torch can burn a Huge tapestry, and an *earthquake* spell can reduce a colossus to rubble. You can track a Huge or Gargantuan object''s hit points if you like, or you can simply decide how long the object can withstand whatever weapon or force is acting against it. If you track hit points for the object, divide it into Large or smaller sections, and track each section''s hit points separately. Destroying one of those sections could ruin the entire object. For example, a Gargantuan statue of a human might topple over when one of its Large legs is reduced to 0 hit points.

***Objects and Damage Types.*** Objects are immune to poison and psychic damage. You might decide that some damage types are more effective against a particular object or substance than others. For example, bludgeoning damage works well for smashing things but not for cutting through rope or leather. Paper or cloth objects might be vulnerable to fire and lightning damage. A pick can chip away stone but can''t effectively cut down a tree. As always, use your best judgment.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-objects-3', 'srd', NULL, 'Objects (4)', '***Damage Threshold.*** Big objects such as castle walls often have extra resilience represented by a damage threshold. An object with a damage threshold has immunity to all damage unless it takes an amount of damage from a single attack or effect equal to or greater than its damage threshold, in which case it takes damage as normal. Any damage that fails to meet or exceed the object''s damage threshold is considered superficial and doesn''t reduce the object''s hit points.

| Size                                  | Fragile  | Resilient |
|---------------------------------------|----------|-----------|
| Tiny (bottle, lock)                   | 2 (1d4)  | 5 (2d4)   |
| Small (chest, lute)                   | 3 (1d6)  | 10 (3d6)  |
| Medium (barrel, chandelier)           | 4 (1d8)  | 18 (4d8)  |
| Large (cart, 10-ft.-by-10-ft. window) | 5 (1d10) | 27 (5d10) |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-attunement-0', 'srd', NULL, 'Attunement (1)', '## Attunement

Some magic items require a creature to form a bond with them before their magical properties can be used. This bond is called attunement, and certain items have a prerequisite for it. If the prerequisite is a class, a creature must be a member of that class to attune to the item. (If the class is a spellcasting class, a monster qualifies if it has spell slots and uses that class''s spell list.) If the prerequisite is to be a spellcaster, a creature qualifies if it can cast at least one spell using its traits or features, not using a magic item or the like.

Without becoming attuned to an item that requires attunement, a creature gains only its nonmagical benefits, unless its description states otherwise. For example, a magic shield that requires attunement provides the benefits of a normal shield to a creature not attuned to it, but none of its magical properties.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-attunement-1', 'srd', NULL, 'Attunement (2)', 'Attuning to an item requires a creature to spend a short rest focused on only that item while being in physical contact with it (this can''t be the same short rest used to learn the item''s properties). This focus can take the form of weapon practice (for a weapon), meditation (for a wondrous item), or some other appropriate activity. If the short rest is interrupted, the attunement attempt fails. Otherwise, at the end of the short rest, the creature gains an intuitive understanding of how to activate any magical properties of the item, including any necessary command words.

An item can be attuned to only one creature at a time, and a creature can be attuned to no more than three magic items at a time. Any attempt to attune to a fourth item fails; the creature must end its attunement to an item first. Additionally, a creature can''t attune to more than one copy of an item. For example, a creature can''t attune to more than one *ring of protection* at a time.

A creature''s attunement to an item ends if the creature no longer satisfies the prerequisites for attunement, if the item has been more than 100 feet away for at least 24 hours, if the creature dies, or if another creature attunes to the item. A creature can also voluntarily end attunement by spending another short rest focused on the item, unless the item is cursed.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-wearing-and-wielding-items-0', 'srd', NULL, 'Wearing and Wielding Items (1)', '## Wearing and Wielding Items

Using a magic item''s properties might mean wearing or wielding it. A magic item meant to be worn must be donned in the intended fashion: boots go on the feet, gloves on the hands, hats and helmets on the head, and rings on the finger. Magic armor must be donned, a shield strapped to the arm, a cloak fastened about the shoulders. A weapon must be held.

In most cases, a magic item that''s meant to be worn can fit a creature regardless of size or build. Many magic garments are made to be easily adjustable, or they magically adjust themselves to the wearer. Rare exceptions exist. If the story suggests a good reason for an item to fit only creatures of a certain size or shape, you can rule that it doesn''t adjust. For example, drow-made armor might fit elves only. Dwarves might make items usable only by dwarf-sized and dwarf-shaped folk.

When a nonhumanoid tries to wear an item, use your discretion as to whether the item functions as intended. A ring placed on a tentacle might work, but a serpentfolk with a snakelike tail instead of legs can''t wear boots.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-wearing-and-wielding-items-1', 'srd', NULL, 'Wearing and Wielding Items (2)', '### Multiple Items of the Same Kind

Use common sense to determine whether more than one of a given kind of magic item can be worn. A character can''t normally wear more than one pair of footwear, one pair of gloves or gauntlets, one pair of bracers, one suit of armor, one item of headwear, and one cloak. You can make exceptions; a character might be able to wear a circlet under a helmet, for example, or to layer two cloaks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-wearing-and-wielding-items-2', 'srd', NULL, 'Wearing and Wielding Items (3)', '### Paired Items

Items that come in pairs—such as boots, bracers, gauntlets, and gloves—impart their benefits only if both items of the pair are worn. For example, a character wearing a boot of striding and springing on one foot and a boot of elvenkind on the other foot gains no benefit from either.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-activating-an-item-0', 'srd', NULL, 'Activating an Item (1)', '## Activating an Item

Activating some magic items requires a user to do something special, such as holding the item and uttering a command word. The description of each item category or individual item details how an item is activated. Certain items use the following rules for their activation.

If an item requires an action to activate, that action isn''t a function of the Use an Item action, so a feature such as the rogue''s Fast Hands can''t be used to activate the item.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-activating-an-item-1', 'srd', NULL, 'Activating an Item (2)', '### Command Word

A command word is a word or phrase that must be spoken for an item to work. A magic item that requires a command word can''t be activated in an area where sound is prevented, as in the area of the silence spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-activating-an-item-2', 'srd', NULL, 'Activating an Item (3)', '### Consumables

Some items are used up when they are activated. A potion or an elixir must be swallowed, or an oil applied to the body. The writing vanishes from a scroll when it is read. Once used, a consumable item loses its magic.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-activating-an-item-3', 'srd', NULL, 'Activating an Item (4)', '### Spells

Some magic items allow the user to cast a spell from the item. The spell is cast at the lowest possible spell level, doesn''t expend any of the user''s spell slots, and requires no components, unless the item''s description says otherwise. The spell uses its normal casting time, range, and duration, and the user of the item must concentrate if the spell requires concentration. Many items, such as potions, bypass the casting of a spell and confer the spell''s effects, with their usual duration. Certain items make exceptions to these rules, changing the casting time, duration, or other parts of a spell.

A magic item, such as certain staffs, may require you to use your own spellcasting ability when you cast a spell from the item. If you have more than one spellcasting ability, you choose which one to use with the item. If you don''t have a spellcasting ability--perhaps you''re a rogue with the Use Magic Device feature--your spellcasting ability modifier is +0 for the item, and your proficiency bonus does apply.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-activating-an-item-4', 'srd', NULL, 'Activating an Item (5)', '### Charges

Some magic items have charges that must be expended to activate their properties. The number of charges an item has remaining is revealed when an identify spell is cast on it, as well as when a creature attunes to it. Additionally, when an item regains charges, the creature attuned to it learns how many charges it regained.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-0', 'srd', NULL, 'Sentient Magic Items (1)', '## Sentient Magic Items

Some magic items possess sentience and personality. Such an item might be possessed, haunted by the spirit of a previous owner, or self-aware thanks to the magic used to create it. In any case, the item behaves like a character, complete with personality quirks, ideals, bonds, and sometimes flaws. A sentient item might be a cherished ally to its wielder or a continual thorn in the side.

Most sentient items are weapons. Other kinds of items can manifest sentience, but consumable items such as potions and scrolls are never sentient.

Sentient magic items function as NPCs under the GM''s control. Any activated property of the item is under the item''s control, not its wielder''s. As long as the wielder maintains a good relationship with the item, the wielder can access those properties normally. If the relationship is strained, the item can suppress its activated properties or even turn them against the wielder.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-1', 'srd', NULL, 'Sentient Magic Items (2)', '### Creating Sentient Magic Items

When you decide to make a magic item sentient, you create the item''s persona in the same way you would create an NPC, with a few exceptions described here.

#### Abilities

A sentient magic item has Intelligence, Wisdom, and Charisma scores. You can choose the item''s abilities or determine them randomly. To determine them randomly, roll 4d6 for each one, dropping the lowest roll and totaling the rest.

#### Communication

A sentient item has some ability to communicate, either by sharing its emotions, broadcasting its thoughts telepathically, or speaking aloud. You can choose how it communicates or roll on the following table.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-2', 'srd', NULL, 'Sentient Magic Items (3)', '| d100   | Communication                                                                                                                                                      |
|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 01-60  | The item communicates by transmitting emotion to the creature carrying or wielding it.                                                                             |
| 61-90  | The item can speak, read, and understand one or more languages.                                                                                                    |
| 91-100 | The item can speak, read, and understand one or more languages. In addition, the item can communicate telepathically with any character that carries or wields it. |

#### Senses

With sentience comes awareness. A sentient item can perceive its surroundings out to a limited range. You can choose its senses or roll on the following table.

| d4 | Senses                                     |
|----|--------------------------------------------|
| 1  | Hearing and normal vision out to 30 feet.  |
| 2  | Hearing and normal vision out to 60 feet   |
| 3  | Hearing and normal vision out to 120 feet. |
| 4  | Hearing and darkvision out to 120 feet.    |

#### Alignment', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-3', 'srd', NULL, 'Sentient Magic Items (4)', 'A sentient magic item has an alignment. Its creator or nature might suggest an alignment. If not, you can pick an alignment or roll on the following table.

| d100   | Alignment       |
|--------|-----------------|
| 01-15  | Lawful good     |
| 16-35  | Neutral good    |
| 36-50  | Chaotic good    |
| 51-63  | Lawful neutral  |
| 64-73  | Neutral         |
| 74-85  | Chaotic neutral |
| 86-89  | Lawful evil     |
| 90-96  | Neutral evil    |
| 97-100 | Chaotic evil    |

#### Special Purpose

You can give a sentient item an objective it pursues, perhaps to the exclusion of all else. As long as the wielder''s use of the item aligns with that special purpose, the item remains cooperative. Deviating from this course might cause conflict between the wielder and the item, and could even cause the item to prevent the use of its activated properties. You can pick a special purpose or roll on the following table.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-4', 'srd', NULL, 'Sentient Magic Items (5)', '| d10 | Purpose                                                                                                                                  |
|-----|------------------------------------------------------------------------------------------------------------------------------------------|
| 1   | *Aligned:* The item seeks to defeat or destroy those of a diametrically opposed alignment. (Such an item is never neutral.)              |
| 2   | *Bane:* The item seeks to defeat or destroy creatures of a particular kind, such as fiends, shapechangers, trolls, or wizards.           |
| 3   | *Protector:* The item seeks to defend a particular race or kind of creature, such as elves or druids.                                    |
| 4   | *Crusader:* The item seeks to defeat, weaken, or destroy the servants of a particular deity.                                             |
| 5   | *Templar*: The item seeks to defend the servants and interests of a particular deity.                                                    |
| 6   | *Destroyer:* The item craves destruction and goads its user to fight arbitrarily.                                                        |
| 7   | *Glory Seeker:* The item seeks renown as the greatest magic item in the world, by establishing its user as a famous or notorious figure. |
| 8   | *Lore Seeker:* The item craves knowledge or is determined to solve a', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-5', 'srd', NULL, 'Sentient Magic Items (6)', 'mystery, learn a secret, or unravel a cryptic prophecy.             |
| 9   | *Destiny Seeker:* The item is convinced that it and its wielder have key roles to play in future events.                                 |
| 10  | *Creator Seeker:* The item seeks its creator and wants to understand why it was created.                                                 |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-6', 'srd', NULL, 'Sentient Magic Items (7)', '### Conflict

A sentient item has a will of its own, shaped by its personality and alignment. If its wielder acts in a manner opposed to the item''s alignment or purpose, conflict can arise. When such a conflict occurs, the item makes a Charisma check contested by the wielder''s Charisma check. If the item wins the contest, it makes one or more of the following demands:
- The item insists on being carried or worn at all times.
- The item demands that its wielder dispose of anything the item finds repugnant.
- The item demands that its wielder pursue the item''s goals to the exclusion of all other goals.
- The item demands to be given to someone else. If its wielder refuses to comply with the item''s wishes, the item can do any or all of the following:
- Make it impossible for its wielder to attune to it.
- Suppress one or more of its activated properties.
- Attempt to take control of its wielder.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-sentient-magic-items-7', 'srd', NULL, 'Sentient Magic Items (8)', 'If a sentient item attempts to take control of its wielder, the wielder must make a Charisma saving throw, with a DC equal to 12 + the item''s Charisma modifier. On a failed save, the wielder is charmed by the item for 1d12 hours. While charmed, the wielder must try to follow the item''s commands. If the wielder takes damage, it can repeat the saving throw, ending the effect on a success. Whether the attempt to control its user succeeds or fails, the item can''t use this power again until the next dawn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-0', 'srd', NULL, 'Fantasy-Historical Pantheons (1)', '## Fantasy-Historical Pantheons

The Celtic, Egyptian, Greek, and Norse pantheons are fantasy interpretations of historical religions from our world''s ancient times. They include deities that are most appropriate for use in a game, divorced from their historical context in the real world and united into pantheons that serve the needs of the game.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-1', 'srd', NULL, 'Fantasy-Historical Pantheons (2)', '### The Celtic Pantheon

It''s said that something wild lurks in the heart of every soul, a space that thrills to the sound of geese calling at night, to the whispering wind through the pines, to the unexpected red of mistletoe on an oak-and it is in this space that the Celtic gods dwell. They sprang from the brook and stream, their might heightened by the strength of the oak and the beauty of the woodlands and open moor. When the first forester dared put a name to the face seen in the bole of a tree or the voice babbling in a brook, these gods forced themselves into being.

The Celtic gods are as often served by druids as by clerics, for they are closely aligned with the forces of nature that druids revere.

#### Celtic Deities', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-2', 'srd', NULL, 'Fantasy-Historical Pantheons (3)', '| Deity                                             | Alignment | Suggested Domains | Symbol                             |
|---------------------------------------------------|-----------|-------------------|------------------------------------|
| The Daghdha, god of weather and crops             | CG        | Nature, Trickery  | Bubbling cauldron or shield        |
| Arawn, god of life and death                      | NE        | Life, Death       | Black star on gray background      |
| Belenus, god of sun, light, and warmth            | NG        | Light             | Solar disk and standing stones     |
| Brigantia, goddess of rivers and livestock        | NG        | Life              | Footbridge                         |
| Diancecht, god of medicine and healing            | LG        | Life              | Crossed oak and mistletoe branches |
| Dunatis, god of mountains and peaks               | N         | Nature            | Red sun-capped mountain peak       |
| Goibhniu, god of smiths and healing               | NG        | Knowledge, Life   | Giant mallet over sword            |
| Lugh, god of arts, travel, and commerce           | CN        | Knowledge, Life   | Pair of long hands                 |
| Manannan mac Lir, god of oceans and sea creatures | LN        | Nature, Tempest   | Wave of white water on green       |
| Math Mathonwy, god of magic', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-3', 'srd', NULL, 'Fantasy-Historical Pantheons (4)', '| NE        | Knowledge         | Staff                              |
| Morrigan, goddess of battle                       | CE        | War               | Two crossed spears                 |
| Nuada, god of war and warriors                    | N         | War               | Silver hand on black background    |
| Oghma, god of speech and writing                  | NG        | Knowledge         | Unfurled scroll                    |
| Silvanus, god of nature and forests               | N         | Nature            | Summer oak tree                    |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-4', 'srd', NULL, 'Fantasy-Historical Pantheons (5)', '### The Greek Pantheon

The gods of Olympus make themselves known with the gentle lap of waves against the shores and the crash of the thunder among the cloud-enshrouded peaks. The thick boar-infested woods and the sere, olive-covered hillsides hold evidence of their passing. Every aspect of nature echoes with their presence, and they''ve made a place for themselves inside the human heart, too.

#### Greek Deities', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-5', 'srd', NULL, 'Fantasy-Historical Pantheons (6)', '| Deity                                      | Alignment | Suggested Domains      | Symbol                                |
|--------------------------------------------|-----------|------------------------|---------------------------------------|
| Zeus, god of the sky, ruler of the gods    | N         | Tempest                | Fist full of lightning bolts          |
| Aphrodite, goddess of love and beauty      | CG        | Light                  | Sea shell                             |
| Apollo, god of light, music, and healing   | CG        | Knowledge, Life, Light | Lyre                                  |
| Ares, god of war and strife                | CE        | War                    | Spear                                 |
| Artemis, goddess of hunting and childbirth | NG        | Life, Nature           | Bow and arrow on lunar disk           |
| Athena, goddess of wisdom and civilization | LG        | Knowledge, War         | Owl                                   |
| Demeter, goddess of agriculture            | NG        | Life                   | Mare''s head                           |
| Dionysus, god of mirth and wine            | CN        | Life                   | Thyrsus (staff tipped with pine cone) |
| Hades, god of the underworld               | LE        | Death                  | Black ram                             |
| Hecate, goddess of magic and the', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-6', 'srd', NULL, 'Fantasy-Historical Pantheons (7)', 'moon      | CE        | Knowledge, Trickery    | Setting moon                          |
| Hephaestus, god of smithing and craft      | NG        | Knowledge              | Hammer and anvil                      |
| Hera, goddess of marriage and intrigue     | CN        | Trickery               | Fan of peacock feathers               |
| Hercules, god of strength and adventure    | CG        | Tempest, War           | Lion''s head                           |
| Hermes, god of travel and commerce         | CG        | Trickery               | Caduceus (winged staff and serpents)  |
| Hestia, goddess of home and family         | NG        | Life                   | Hearth                                |
| Nike, goddess of victory                   | LN        | War                    | Winged woman                          |
| Pan, god of nature                         | CN        | Nature                 | Syrinx (pan pipes)                    |
| Poseidon, god of the sea and earthquakes   | CN        | Tempest                | Trident                               |
| Tyche, goddess of good fortune             | N         | Trickery               | Red pentagram                         |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-7', 'srd', NULL, 'Fantasy-Historical Pantheons (8)', '### The Egyptian Pantheon

These gods are a young dynasty of an ancient divine family, heirs to the rulership of the cosmos and the maintenance of the divine principle of Ma''at-the fundamental order of truth, justice, law, and order that puts gods, mortal pharaohs, and ordinary men and women in their logical and rightful place in the universe.

The Egyptian pantheon is unusual in having three gods responsible for death, each with different alignments. Anubis is the lawful neutral god of the afterlife, who judges the souls of the dead. Set is a chaotic evil god of murder, perhaps best known for killing his brother Osiris. And Nephthys is a chaotic good goddess of mourning.

#### Egyptian Deities', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-8', 'srd', NULL, 'Fantasy-Historical Pantheons (9)', '| Deity                                           | Alignment | Suggested Domains        | Symbol                               |
|-------------------------------------------------|-----------|--------------------------|--------------------------------------|
| Re-Horakhty, god of the sun, ruler of the gods  | LG        | Life, Light              | Solar disk encircled by serpent      |
| Anubis, god of judgment and death               | LN        | Death                    | Black jackal                         |
| Apep, god of evil, fire, and serpents           | NE        | Trickery                 | Flaming snake                        |
| Bast, goddess of cats and vengeance             | CG        | War                      | Cat                                  |
| Bes, god of luck and music                      | CN        | Trickery                 | Image of the misshapen deity         |
| Hathor, goddess of love, music, and motherhood  | NG        | Life, Light              | Horned cow''s head with lunar disk    |
| Imhotep, god of crafts and medicine             | NG        | Knowledge                | Step pyramid                         |
| Isis, goddess of fertility and magic            | NG        | Knowledge, Life          | Ankh and star                        |
| Nephthys, goddess of death and grief            | CG        | Death                    | Horns', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-9', 'srd', NULL, 'Fantasy-Historical Pantheons (10)', 'around a lunar disk            |
| Osiris, god of nature and the underworld        | LG        | Life, Nature             | Crook and flail                      |
| Ptah, god of crafts, knowledge, and secrets     | LN        | Knowledge                | Bull                                 |
| Set, god of darkness and desert storms          | CE        | Death, Tempest, Trickery | Coiled cobra                         |
| Sobek, god of water and crocodiles              | LE        | Nature, Tempest          | Crocodile head with horns and plumes |
| Thoth, god of knowledge and wisdom              | N         | Knowledge                | Ibis                                 |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-10', 'srd', NULL, 'Fantasy-Historical Pantheons (11)', '### The Norse Pantheon

Where the land plummets from the snowy hills into the icy fjords below, where the longboats draw up on to the beach, where the glaciers flow forward and retreat with every fall and spring-this is the land of the Vikings, the home of the Norse pantheon. It''s a brutal clime, and one that calls for brutal living. The warriors of the land have had to adapt to the harsh conditions in order to survive, but they haven''t been too twisted by the needs of their environment. Given the necessity of raiding for food and wealth, it''s surprising the mortals turned out as well as they did. Their powers reflect the need these warriors had for strong leadership and decisive action. Thus, they see their deities in every bend of a river, hear them in the crash of the thunder and the booming of the glaciers, and smell them in the smoke of a burning longhouse.

The Norse pantheon includes two main families, the Aesir (deities of war and destiny) and the Vanir (gods of fertility and prosperity). Once enemies, these two families are now closely allied against their common enemies, the giants (including the gods Surtur and Thrym).

#### Norse Deities', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-11', 'srd', NULL, 'Fantasy-Historical Pantheons (12)', '| Deity                                     | Alignment | Suggested Domains | Symbol                            |
|-------------------------------------------|-----------|-------------------|-----------------------------------|
| Odin, god of knowledge and war            | NG        | Knowledge, War    | Watching blue eye                 |
| Aegir, god of the sea and storms          | NE        | Tempest           | Rough ocean waves                 |
| Balder, god of beauty and poetry          | NG        | Life, Light       | Gem-encrusted silver chalice      |
| Forseti, god of justice and law           | N         | Light             | Head of a bearded man             |
| Frey, god of fertility and the sun        | NG        | Life, Light       | Ice-blue greatsword               |
| Freya, goddess of fertility and love      | NG        | Life              | Falcon                            |
| Frigga, goddess of birth and fertility    | N         | Life, Light       | Cat                               |
| Heimdall, god of watchfulness and loyalty | LG        | Light, War        | Curling musical horn              |
| Hel, goddess of the underworld            | NE        | Death             | Woman''s face, rotting on one side |
| Hermod, god of luck                       | CN        | Trickery          | Winged scroll                     |
| Loki, god of thieves and', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-fantasy-historical-pantheons-12', 'srd', NULL, 'Fantasy-Historical Pantheons (13)', 'trickery         | CE        | Trickery          | Flame                             |
| Njord, god of sea and wind                | NG        | Nature, Tempest   | Gold coin                         |
| Odur, god of light and the sun            | CG        | Light             | Solar disk                        |
| Sif, goddess of war                       | CG        | War               | Upraised sword                    |
| Skadi, god of earth and mountains         | N         | Nature            | Mountain peak                     |
| Surtur, god of fire giants and war        | LE        | War               | Flaming sword                     |
| Thor, god of storms and thunder           | CG        | Tempest, War      | Hammer                            |
| Thrym, god of frost giants and cold       | CE        | War               | White double-bladed axe           |
| Tyr, god of courage and strategy          | LN        | Knowledge, War    | Sword                             |
| Uller, god of hunting and winter          | CN        | Nature            | Longbow                           |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-0', 'srd', NULL, 'The Planes of Existence (1)', '## The Planes of Existence

The cosmos teems with a multitude of worlds as well as myriad alternate dimensions of reality, called the **planes of existence**. It encompasses every world where GMs run their adventures, all within the relatively mundane realm of the Material Plane. Beyond that plane are domains of raw elemental matter and energy, realms of pure thought and ethos, the homes of demons and angels, and the dominions of the gods.

Many spells and magic items can draw energy from these planes, summon the creatures that dwell there, communicate with their denizens, and allow adventurers to travel there. As your character achieves greater power and higher levels, you might walk on streets made of solid fire or test your mettle on a battlefield where the fallen are resurrected with each dawn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-1', 'srd', NULL, 'The Planes of Existence (2)', '## The Material Plane

The Material Plane is the nexus where the philosophical and elemental forces that define the other planes collide in the jumbled existence of mortal life and mundane matter. All fantasy gaming worlds exist within the Material Plane, making it the starting point for most campaigns and adventures. The rest of the multiverse is defined in relation to the Material Plane.

The worlds of the Material Plane are infinitely diverse, for they reflect the creative imagination of the GMs who set their games there, as well as the players whose heroes adventure there. They include magic-wasted desert planets and island-dotted water worlds, worlds where magic combines with advanced technology and others trapped in an endless Stone Age, worlds where the gods walk and places they have abandoned.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-2', 'srd', NULL, 'The Planes of Existence (3)', '## Beyond the Material

Beyond the Material Plane, the various planes of existence are realms of myth and mystery. They''re not simply other worlds, but different qualities of being, formed and governed by spiritual and elemental principles abstracted from the ordinary world.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-3', 'srd', NULL, 'The Planes of Existence (4)', '### Planar Travel

When adventurers travel into other planes of existence, they are undertaking a legendary journey across the thresholds of existence to a mythic destination where they strive to complete their quest. Such a journey is the stuff of legend. Braving the realms of the dead, seeking out the celestial servants of a deity, or bargaining with an efreeti in its home city will be the subject of song and story for years to come.

Travel to the planes beyond the Material Plane can be accomplished in two ways: by casting a spell or by using a planar portal.

***Spells.*** A number of spells allow direct or indirect access to other planes of existence. *Plane shift* and *gate* can transport adventurers directly to any other plane of existence, with different degrees of precision. *Etherealness* allows adventurers to enter the Ethereal Plane and travel from there to any of the planes it touches-such as the Elemental Planes. And the *astral projection* spell lets adventurers project themselves into the Astral Plane and travel to the Outer Planes.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-4', 'srd', NULL, 'The Planes of Existence (5)', '***Portals.*** A portal is a general term for a stationary interplanar connection that links a specific location on one plane to a specific location on another. Some portals are like doorways, a clear window, or a fog-shrouded passage, and simply stepping through it effects the interplanar travel. Others are locations--circles of standing stones, soaring towers, sailing ships, or even whole towns-that exist in multiple planes at once or flicker from one plane to another in turn. Some are vortices, typically joining an Elemental Plane with a very similar location on the Material Plane, such as the heart of a volcano (leading to the Plane of Fire) or the depths of the ocean (to the Plane of Water).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-5', 'srd', NULL, 'The Planes of Existence (6)', '### Transitive Planes

The Ethereal Plane and the Astral Plane are called the Transitive Planes. They are mostly featureless realms that serve primarily as ways to travel from one plane to another. Spells such as *etherealness* and *astral projection* allow characters to enter these planes and traverse them to reach the planes beyond.

The **Ethereal Plane** is a misty, fog-bound dimension that is sometimes described as a great ocean. Its shores, called the Border Ethereal, overlap the Material Plane and the Inner Planes, so that every location on those planes has a corresponding location on the Ethereal Plane. Certain creatures can see into the Border Ethereal, and the *see invisibility* and *true seeing* spell grant that ability. Some magical effects also extend from the Material Plane into the Border Ethereal, particularly effects that use force energy such as *forcecage* and *wall of force.* The depths of the plane, the Deep Ethereal, are a region of swirling mists and colorful fogs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-6', 'srd', NULL, 'The Planes of Existence (7)', 'The **Astral Plane** is the realm of thought and dream, where visitors travel as disembodied souls to reach the planes of the divine and demonic. It is a great, silvery sea, the same above and below, with swirling wisps of white and gray streaking among motes of light resembling distant stars. Erratic whirlpools of color flicker in midair like spinning coins. Occasional bits of solid matter can be found here, but most of the Astral Plane is an endless, open domain.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-7', 'srd', NULL, 'The Planes of Existence (8)', '### Inner Planes

The Inner Planes surround and enfold the Material Plane and its echoes, providing the raw elemental substance from which all the worlds were made. The four **Elemental Planes**-Air, Earth, Fire, and Water-form a ring around the Material Plane, suspended within the churning **Elemental Chaos**.

At their innermost edges, where they are closest to the Material Plane (in a conceptual if not a literal geographical sense), the four Elemental Planes resemble a world in the Material Plane. The four elements mingle together as they do in the Material Plane, forming land, sea, and sky. Farther from the Material Plane, though, the Elemental Planes are both alien and hostile. Here, the elements exist in their purest form-great expanses of solid earth, blazing fire, crystal-clear water, and unsullied air. These regions are little-known, so when discussing the Plane of Fire, for example, a speaker usually means just the border region. At the farthest extents of the Inner Planes, the pure elements dissolve and bleed together into an unending tumult of clashing energies and colliding substance, the Elemental Chaos.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-8', 'srd', NULL, 'The Planes of Existence (9)', '### Outer Planes

If the Inner Planes are the raw matter and energy that makes up the multiverse, the Outer Planes are the direction, thought and purpose for such construction. Accordingly, many sages refer to the Outer Planes as divine planes, spiritual planes, or godly planes, for the Outer Planes are best known as the homes of deities.

When discussing anything to do with deities, the language used must be highly metaphorical. Their actual homes are not literally "places" at all, but exemplify the idea that the Outer Planes are realms of thought and spirit. As with the Elemental Planes, one can imagine the perceptible part of the Outer Planes as a sort of border region, while extensive spiritual regions lie beyond ordinary sensory experience.

Even in those perceptible regions, appearances can be deceptive. Initially, many of the Outer Planes appear hospitable and familiar to natives of the Material Plane. But the landscape can change at the whims of the powerful forces that live on the Outer Planes. The desires of the mighty forces that dwell on these planes can remake them completely, effectively erasing and rebuilding existence itself to better fulfill their own needs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-9', 'srd', NULL, 'The Planes of Existence (10)', 'Distance is a virtually meaningless concept on the Outer Planes. The perceptible regions of the planes often seem quite small, but they can also stretch on to what seems like infinity. It might be possible to take a guided tour of the Nine Hells, from the first layer to the ninth, in a single day-if the powers of the Hells desire it. Or it could take weeks for travelers to make a grueling trek across a single layer.

The most well-known Outer Planes are a group of sixteen planes that correspond to the eight alignments (excluding neutrality) and the shades of distinction between them.

#### Outer Planes

The planes with some element of good in their nature are called the **Upper Planes**. Celestial creatures such as angels and pegasi dwell in the Upper Planes. Planes with some element of evil are the **Lower Planes**. Fiends such as demons and devils dwell in the Lower Planes. A plane''s alignment is its essence, and a character whose alignment doesn''t match the plane''s experiences a profound sense of dissonance there. When a good creature visits Elysium, for example (a neutral good Upper Plane), it feels in tune with the plane, but an evil creature feels out of tune and more than a little uncomfortable.

#### Demiplanes', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-planes-of-existence-10', 'srd', NULL, 'The Planes of Existence (11)', 'Demiplanes are small extradimensional spaces with their own unique rules. They are pieces of reality that don''t seem to fit anywhere else. Demiplanes come into being by a variety of means. Some are created by spells, such as *demiplane,* or generated at the desire of a powerful deity or other force. They may exist naturally, as a fold of existing reality that has been pinched off from the rest of the multiverse, or as a baby universe growing in power. A given demiplane can be entered through a single point where it touches another plane. Theoretically, a *plane shift* spell can also carry travelers to a demiplane, but the proper frequency required for the tuning fork is extremely hard to acquire. The *gate* spell is more reliable, assuming the caster knows of the demiplane.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-0', 'srd', NULL, 'Traps (1)', '## Traps

Traps can be found almost anywhere. One wrong step in an ancient tomb might trigger a series of scything blades, which cleave through armor and bone. The seemingly innocuous vines that hang over a cave entrance might grasp and choke anyone who pushes through them. A net hidden among the trees might drop on travelers who pass underneath. In a fantasy game, unwary adventurers can fall to their deaths, be burned alive, or fall under a fusillade of poisoned darts.

A trap can be either mechanical or magical in nature. **Mechanical traps** include pits, arrow traps, falling blocks, water-filled rooms, whirling blades, and anything else that depends on a mechanism to operate. **Magic traps** are either magical device traps or spell traps. Magical device traps initiate spell effects when activated. Spell traps are spells such as *glyph of warding* and *symbol* that function as traps.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-1', 'srd', NULL, 'Traps (2)', '### Traps in Play

When adventurers come across a trap, you need to know how the trap is triggered and what it does, as well as the possibility for the characters to detect the trap and to disable or avoid it.

#### Triggering a Trap

Most traps are triggered when a creature goes somewhere or touches something that the trap''s creator wanted to protect. Common triggers include stepping on a pressure plate or a false section of floor, pulling a trip wire, turning a doorknob, and using the wrong key in a lock. Magic traps are often set to go off when a creature enters an area or touches an object. Some magic traps (such as the *glyph of warding* spell) have more complicated trigger conditions, including a password that prevents the trap from activating.

#### Detecting and Disabling a Trap

Usually, some element of a trap is visible to careful inspection. Characters might notice an uneven flagstone that conceals a pressure plate, spot the gleam of light off a trip wire, notice small holes in the walls from which jets of flame will erupt, or otherwise detect something that points to a trap''s presence.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-2', 'srd', NULL, 'Traps (3)', 'A trap''s description specifies the checks and DCs needed to detect it, disable it, or both. A character actively looking for a trap can attempt a Wisdom (Perception) check against the trap''s DC. You can also compare the DC to detect the trap with each character''s passive Wisdom (Perception) score to determine whether anyone in the party notices the trap in passing. If the adventurers detect a trap before triggering it, they might be able to disarm it, either permanently or long enough to move past it. You might call for an Intelligence (Investigation) check for a character to deduce what needs to be done, followed by a Dexterity check using thieves'' tools to perform the necessary sabotage.

Any character can attempt an Intelligence (Arcana) check to detect or disarm a magic trap, in addition to any other checks noted in the trap''s description. The DCs are the same regardless of the check used. In addition, *dispel magic* has a chance of disabling most magic traps. A magic trap''s description provides the DC for the ability check made when you use *dispel magic*.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-3', 'srd', NULL, 'Traps (4)', 'In most cases, a trap''s description is clear enough that you can adjudicate whether a character''s actions locate or foil the trap. As with many situations, you shouldn''t allow die rolling to override clever play and good planning. Use your common sense, drawing on the trap''s description to determine what happens. No trap''s design can anticipate every possible action that the characters might attempt.

You should allow a character to discover a trap without making an ability check if an action would clearly reveal the trap''s presence. For example, if a character lifts a rug that conceals a pressure plate, the character has found the trigger and no check is required.

Foiling traps can be a little more complicated. Consider a trapped treasure chest. If the chest is opened without first pulling on the two handles set in its sides, a mechanism inside fires a hail of poison needles toward anyone in front of it. After inspecting the chest and making a few checks, the characters are still unsure if it''s trapped. Rather than simply open the chest, they prop a shield in front of it and push the chest open at a distance with an iron rod. In this case, the trap still triggers, but the hail of needles fires harmlessly into the shield.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-4', 'srd', NULL, 'Traps (5)', 'Traps are often designed with mechanisms that allow them to be disarmed or bypassed. Intelligent monsters that place traps in or around their lairs need ways to get past those traps without harming themselves. Such traps might have hidden levers that disable their triggers, or a secret door might conceal a passage that goes around the trap.

#### Trap Effects

The effects of traps can range from inconvenient to deadly, making use of elements such as arrows, spikes, blades, poison, toxic gas, blasts of fire, and deep pits. The deadliest traps combine multiple elements to kill, injure, contain, or drive off any creature unfortunate enough to trigger them. A trap''s description specifies what happens when it is triggered.

The attack bonus of a trap, the save DC to resist its effects, and the damage it deals can vary depending on the trap''s severity. Use the Trap Save DCs and Attack Bonuses table and the Damage Severity by Level table for suggestions based on three levels of trap severity.

A trap intended to be a **setback** is unlikely to kill or seriously harm characters of the indicated levels, whereas a **dangerous** trap is likely to seriously injure (and potentially kill) characters of the indicated levels. A **deadly** trap is likely to kill characters of the indicated levels.

##### Trap Save DCs and Attack Bonuses', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-5', 'srd', NULL, 'Traps (6)', '| Trap Danger | Save DC | Attack Bonus |
|-------------|---------|--------------|
| Setback     | 10-11   | +3 to +5     |
| Dangerous   | 12-15   | +6 to +8     |
| Deadly      | 16-20   | +9 to +12    |

##### Damage Severity by Level

| Character Level | Setback | Dangerous | Deadly |
|-----------------|---------|-----------|--------|
| 1st-4th         | 1d10    | 2d10      | 4d10   |
| 5th-10th        | 2d10    | 4d10      | 10d10  |
| 11th-16th       | 4d10    | 10d10     | 18d10  |
| 17th-20th       | 10d10   | 18d10     | 24d10  |

#### Complex Traps

Complex traps work like standard traps, except once activated they execute a series of actions each round. A complex trap turns the process of dealing with a trap into something more like a combat encounter.

When a complex trap activates, it rolls initiative. The trap''s description includes an initiative bonus. On its turn, the trap activates again, often taking an action. It might make successive attacks against intruders, create an effect that changes over time, or otherwise produce a dynamic challenge. Otherwise, the complex trap can be detected and disabled or bypassed in the usual ways.

For example, a trap that causes a room to slowly flood works best as a complex trap. On the trap''s turn, the water level rises. After several rounds, the room is completely flooded.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-6', 'srd', NULL, 'Traps (7)', '### Sample Traps

The magical and mechanical traps presented here vary in deadliness and are presented in alphabetical order.

#### Collapsing Roof

*Mechanical trap*

This trap uses a trip wire to collapse the supports keeping an unstable section of a ceiling in place.

The trip wire is 3 inches off the ground and stretches between two support beams. The DC to spot the trip wire is 10. A successful DC 15 Dexterity check using thieves'' tools disables the trip wire harmlessly. A character without thieves'' tools can attempt this check with disadvantage using any edged weapon or edged tool. On a failed check, the trap triggers.

Anyone who inspects the beams can easily determine that they are merely wedged in place. As an action, a character can knock over a beam, causing the trap to trigger.

The ceiling above the trip wire is in bad repair, and anyone who can see it can tell that it''s in danger of collapse.

When the trap is triggered, the unstable ceiling collapses. Any creature in the area beneath the unstable section must succeed on a DC 15 Dexterity saving throw, taking 22 (4d10) bludgeoning damage on a failed save, or half as much damage on a successful one. Once the trap is triggered, the floor of the area is filled with rubble and becomes difficult terrain.

#### Falling Net

*Mechanical trap*

This trap uses a trip wire to release a net suspended from the ceiling.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-7', 'srd', NULL, 'Traps (8)', 'The trip wire is 3 inches off the ground and stretches between two columns or trees. The net is hidden by cobwebs or foliage. The DC to spot the trip wire and net is 10. A successful DC 15 Dexterity check using thieves'' tools breaks the trip wire harmlessly. A character without thieves'' tools can attempt this check with disadvantage using any edged weapon or edged tool. On a failed check, the trap triggers.

When the trap is triggered, the net is released, covering a 10-foot-square area. Those in the area are trapped under the net and restrained, and those that fail a DC 10 Strength saving throw are also knocked prone. A creature can use its action to make a DC 10

Strength check, freeing itself or another creature within its reach on a success. The net has AC 10 and 20 hit points. Dealing 5 slashing damage to the net (AC 10) destroys a 5-foot-square section of it, freeing any creature trapped in that section.

#### Fire-Breathing Statue

*Magic trap*

This trap is activated when an intruder steps on a hidden pressure plate, releasing a magical gout of flame from a nearby statue. The statue can be of anything, including a dragon or a wizard casting a spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-8', 'srd', NULL, 'Traps (9)', 'The DC is 15 to spot the pressure plate, as well as faint scorch marks on the floor and walls. A spell or other effect that can sense the presence of magic, such as *detect magic*, reveals an aura of evocation magic around the statue.

The trap activates when more than 20 pounds of weight is placed on the pressure plate, causing the statue to release a 30-foot cone of fire. Each creature in the fire must make a DC 13 Dexterity saving throw, taking 22 (4d10) fire damage on a failed save, or half as much damage on a successful one.

Wedging an iron spike or other object under the pressure plate prevents the trap from activating. A successful *dispel magic* (DC 13) cast on the statue destroys the trap.

#### Pits

*Mechanical trap*

Four basic pit traps are presented here.

***Simple Pit.*** A simple pit trap is a hole dug in the ground. The hole is covered by a large cloth anchored on the pit''s edge and camouflaged with dirt and debris.

The DC to spot the pit is 10. Anyone stepping on the cloth falls through and pulls the cloth down into the pit, taking damage based on the pit''s depth (usually 10 feet, but some pits are deeper).

***Hidden Pit***. This pit has a cover constructed from material identical to the floor around it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-9', 'srd', NULL, 'Traps (10)', 'A successful DC 15 Wisdom (Perception) check discerns an absence of foot traffic over the section of floor that forms the pit''s cover. A successful DC 15 Intelligence (Investigation) check is necessary to confirm that the trapped section of floor is actually the cover of a pit.

When a creature steps on the cover, it swings open like a trapdoor, causing the intruder to spill into the pit below. The pit is usually 10 or 20 feet deep but can be deeper.

Once the pit trap is detected, an iron spike or similar object can be wedged between the pit''s cover and the surrounding floor in such a way as to prevent the cover from opening, thereby making it safe to cross. The cover can also be magically held shut using the *arcane lock* spell or similar magic.

***Locking Pit.*** This pit trap is identical to a hidden pit trap, with one key exception: the trap door that covers the pit is spring-loaded. After a creature falls into the pit, the cover snaps shut to trap its victim inside.

A successful DC 20 Strength check is necessary to pry the cover open. The cover can also be smashed open. A character in the pit can also attempt to disable the spring mechanism from the inside with a DC 15 Dexterity check using thieves'' tools, provided that the mechanism can be reached and the character can see. In some cases, a mechanism (usually hidden behind a secret door nearby) opens the pit.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-10', 'srd', NULL, 'Traps (11)', '***Spiked Pit.*** This pit trap is a simple, hidden, or locking pit trap with sharpened wooden or iron spikes at the bottom. A creature falling into the pit takes 11 (2d10) piercing damage from the spikes, in addition to any falling damage. Even nastier versions have poison smeared on the spikes. In that case, anyone taking piercing damage from the spikes must also make a DC 13 Constitution saving throw, taking an 22 (4d10) poison damage on a failed save, or half as much damage on a successful one.

#### Poison Darts

*Mechanical trap*

When a creature steps on a hidden pressure plate, poison-tipped darts shoot from spring-loaded or pressurized tubes cleverly embedded in the surrounding walls. An area might include multiple pressure plates, each one rigged to its own set of darts.

The tiny holes in the walls are obscured by dust and cobwebs, or cleverly hidden amid bas-reliefs, murals, or frescoes that adorn the walls. The DC to spot them is 15. With a successful DC 15 Intelligence (Investigation) check, a character can deduce the presence of the pressure plate from variations in the mortar and stone used to create it, compared to the surrounding floor. Wedging an iron spike or other object under the pressure plate prevents the trap from activating. Stuffing the holes with cloth or wax prevents the darts contained within from launching.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-11', 'srd', NULL, 'Traps (12)', 'The trap activates when more than 20 pounds of weight is placed on the pressure plate, releasing four darts. Each dart makes a ranged attack with a +8

bonus against a random target within 10 feet of the pressure plate (vision is irrelevant to this attack roll). (If there are no targets in the area, the darts don''t hit anything.) A target that is hit takes 2 (1d4) piercing damage and must succeed on a DC 15 Constitution saving throw, taking 11 (2d10) poison damage on a failed save, or half as much damage on a successful one.

#### Poison Needle

*Mechanical trap*

A poisoned needle is hidden within a treasure chest''s lock, or in something else that a creature might open. Opening the chest without the proper key causes the needle to spring out, delivering a dose of poison.

When the trap is triggered, the needle extends 3 inches straight out from the lock. A creature within range takes 1 piercing damage and 11
(2d10) poison damage, and must succeed on a DC 15 Constitution saving throw or be poisoned for 1 hour.

A successful DC 20 Intelligence (Investigation) check allows a character to deduce the trap''s presence from alterations made to the lock to accommodate the needle. A successful DC 15 Dexterity check using thieves'' tools disarms the trap, removing the needle from the lock. Unsuccessfully attempting to pick the lock triggers the trap.

#### Rolling Sphere', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-12', 'srd', NULL, 'Traps (13)', '*Mechanical trap*

When 20 or more pounds of pressure are placed on this trap''s pressure plate, a hidden trapdoor in the ceiling opens, releasing a 10-foot-diameter rolling sphere of solid stone.

With a successful DC 15 Wisdom (Perception) check, a character can spot the trapdoor and pressure plate. A search of the floor accompanied by a successful DC 15 Intelligence (Investigation) check reveals variations in the mortar and stone that betray the pressure plate''s presence. The same check made while inspecting the ceiling notes variations in the stonework that reveal the trapdoor. Wedging an iron spike or other object under the pressure plate prevents the trap from activating.

Activation of the sphere requires all creatures present to roll initiative. The sphere rolls initiative with a +8 bonus. On its turn, it moves 60 feet in a straight line. The sphere can move through creatures'' spaces, and creatures can move through its space, treating it as difficult terrain. Whenever the sphere enters a creature''s space or a creature enters its space while it''s rolling, that creature must succeed on a DC 15 Dexterity saving throw or take 55 (10d10) bludgeoning damage and be knocked prone.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-traps-13', 'srd', NULL, 'Traps (14)', 'The sphere stops when it hits a wall or similar barrier. It can''t go around corners, but smart dungeon builders incorporate gentle, curving turns into nearby passages that allow the sphere to keep moving.

As an action, a creature within 5 feet of the sphere can attempt to slow it down with a DC 20 Strength check. On a successful check, the sphere''s speed is reduced by 15 feet. If the sphere''s speed drops to 0, it stops moving and is no longer a threat.

#### Sphere of Annihilation

*Magic trap*

Magical, impenetrable darkness fills the gaping mouth of a stone face carved into a wall. The mouth is 2 feet in diameter and roughly circular. No sound issues from it, no light can illuminate the inside of it, and any matter that enters it is instantly obliterated.

A successful DC 20 Intelligence (Arcana) check reveals that the mouth contains a *sphere of annihilation* that can''t be controlled or moved. It is otherwise identical to a normal *sphere of annihilation*.

Some versions of the trap include an enchantment placed on the stone face, such that specified creatures feel an overwhelming urge to approach it and crawl inside its mouth. This effect is otherwise like the *sympathy* aspect of the *antipathy/sympathy* spell. A successful *dispel magic* (DC 18) removes this enchantment.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-blinded', 'srd', NULL, 'Condition: Blinded', '- A blinded creature can''t see and automatically fails any ability check that requires sight.,- Attack rolls against the creature have advantage, and the creature''s attack rolls have disadvantage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-charmed', 'srd', NULL, 'Condition: Charmed', '- A charmed creature can''t attack the charmer or target the charmer with harmful abilities or magical effects.,- The charmer has advantage on any ability check to interact socially with the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-deafened', 'srd', NULL, 'Condition: Deafened', '- A deafened creature can''t hear and automatically fails any ability check that requires hearing.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-frightened', 'srd', NULL, 'Condition: Frightened', '- A frightened creature has disadvantage on ability checks and attack rolls while the source of its fear is within line of sight.,- The creature can''t willingly move closer to the source of its fear.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-grappled', 'srd', NULL, 'Condition: Grappled', '- A grappled creature''s speed becomes 0, and it can''t benefit from any bonus to its speed.,- The condition ends if the grappler is incapacitated (see the condition).,- The condition also ends if an effect removes the grappled creature from the reach of the grappler or grappling effect, such as when a creature is hurled away by the thunderwave spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-incapacitated', 'srd', NULL, 'Condition: Incapacitated', '- An incapacitated creature can''t take actions or reactions.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-invisible', 'srd', NULL, 'Condition: Invisible', '- An invisible creature is impossible to see without the aid of magic or a special sense. For the purpose of hiding, the creature is heavily obscured. The creature''s location can be detected by any noise it makes or any tracks it leaves.,- Attack rolls against the creature have disadvantage, and the creature''s attack rolls have advantage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-paralyzed', 'srd', NULL, 'Condition: Paralyzed', '- A paralyzed creature is incapacitated (see the condition) and can''t move or speak.,- The creature automatically fails Strength and Dexterity saving throws.,- Attack rolls against the creature have advantage.,- Any attack that hits the creature is a critical hit if the attacker is within 5 feet of the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-petrified', 'srd', NULL, 'Condition: Petrified', '- A petrified creature is transformed, along with any nonmagical object it is wearing or carrying, into a solid inanimate substance (usually stone). Its weight increases by a factor of ten, and it ceases aging.,- The creature is incapacitated (see the condition), can''t move or speak, and is unaware of its surroundings.,- Attack rolls against the creature have advantage.,- The creature automatically fails Strength and Dexterity saving throws.,- The creature has resistance to all damage.,- The creature is immune to poison and disease, although a poison or disease already in its system is suspended, not neutralized.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-poisoned', 'srd', NULL, 'Condition: Poisoned', '- A poisoned creature has disadvantage on attack rolls and ability checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-prone', 'srd', NULL, 'Condition: Prone', '- A prone creature''s only movement option is to crawl, unless it stands up and thereby ends the condition.,- The creature has disadvantage on attack rolls.,- An attack roll against the creature has advantage if the attacker is within 5 feet of the creature. Otherwise, the attack roll has disadvantage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-restrained', 'srd', NULL, 'Condition: Restrained', '- A restrained creature''s speed becomes 0, and it can''t benefit from any bonus to its speed.,- Attack rolls against the creature have advantage, and the creature''s attack rolls have disadvantage.,- The creature has disadvantage on Dexterity saving throws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-stunned', 'srd', NULL, 'Condition: Stunned', '- A stunned creature is incapacitated (see the condition), can''t move, and can speak only falteringly.,- The creature automatically fails Strength and Dexterity saving throws.,- Attack rolls against the creature have advantage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-unconscious', 'srd', NULL, 'Condition: Unconscious', '- An unconscious creature is incapacitated (see the condition), can''t move or speak, and is unaware of its surroundings.,- The creature drops whatever it''s holding and falls prone.,- The creature automatically fails Strength and Dexterity saving throws.,- Attack rolls against the creature have advantage.,- Any attack that hits the creature is a critical hit if the attacker is within 5 feet of the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('condition-exhaustion', 'srd', NULL, 'Condition: Exhaustion', 'Some special abilities and environmental hazards, such as starvation and the long-term effects of freezing or scorching temperatures, can lead to a special condition called exhaustion. Exhaustion is measured in six levels. An effect can give a creature one or more levels of exhaustion, as specified in the effect''s description.,1 - Disadvantage on ability checks,2 - Speed halved,3 - Disadvantage on attack rolls and saving throws,4 - Hit point maximum halved,5 - Speed reduced to 0,6 - Death,If an already exhausted creature suffers another effect that causes exhaustion, its current level of exhaustion increases by the amount specified in the effect''s description.,A creature suffers the effect of its current level of exhaustion as well as all lower levels. For example, a creature suffering level 2 exhaustion has its speed halved and has disadvantage on ability checks.,An effect that removes exhaustion reduces its level as specified in the effect''s description, with all exhaustion effects ending if a creature''s exhaustion level is reduced below 1.,Finishing a long rest reduces a creature''s exhaustion level by 1, provided that the creature has also ingested some food and drink.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-acrobatics', 'srd', NULL, 'Skill: Acrobatics', 'Acrobatics (DEX). Your Dexterity (Acrobatics) check covers your attempt to stay on your feet in a tricky situation, such as when you''re trying to run across a sheet of ice, balance on a tightrope, or stay upright on a rocking ship''s deck. The GM might also call for a Dexterity (Acrobatics) check to see if you can perform acrobatic stunts, including dives, rolls, somersaults, and flips.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-animal-handling', 'srd', NULL, 'Skill: Animal Handling', 'Animal Handling (WIS). When there is any question whether you can calm down a domesticated animal, keep a mount from getting spooked, or intuit an animal''s intentions, the GM might call for a Wisdom (Animal Handling) check. You also make a Wisdom (Animal Handling) check to control your mount when you attempt a risky maneuver.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-arcana', 'srd', NULL, 'Skill: Arcana', 'Arcana (INT). Your Intelligence (Arcana) check measures your ability to recall lore about spells, magic items, eldritch symbols, magical traditions, the planes of existence, and the inhabitants of those planes.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-athletics', 'srd', NULL, 'Skill: Athletics', 'Athletics (STR). Your Strength (Athletics) check covers difficult situations you encounter while climbing, jumping, or swimming.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-deception', 'srd', NULL, 'Skill: Deception', 'Deception (CHA). Your Charisma (Deception) check determines whether you can convincingly hide the truth, either verbally or through your actions. This deception can encompass everything from misleading others through ambiguity to telling outright lies. Typical situations include trying to fast- talk a guard, con a merchant, earn money through gambling, pass yourself off in a disguise, dull someone''s suspicions with false assurances, or maintain a straight face while telling a blatant lie.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-history', 'srd', NULL, 'Skill: History', 'History (INT). Your Intelligence (History) check measures your ability to recall lore about historical events, legendary people, ancient kingdoms, past disputes, recent wars, and lost civilizations.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-insight', 'srd', NULL, 'Skill: Insight', 'Insight (WIS). Your Wisdom (Insight) check decides whether you can determine the true intentions of a creature, such as when searching out a lie or predicting someone''s next move. Doing so involves gleaning clues from body language, speech habits, and changes in mannerisms.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-intimidation', 'srd', NULL, 'Skill: Intimidation', 'Intimidation (CHA). When you attempt to influence someone through overt threats, hostile actions, and physical violence, the GM might ask you to make a Charisma (Intimidation) check. Examples include trying to pry information out of a prisoner, convincing street thugs to back down from a confrontation, or using the edge of a broken bottle to convince a sneering vizier to reconsider a decision.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-investigation', 'srd', NULL, 'Skill: Investigation', 'Investigation (INT). When you look around for clues and make deductions based on those clues, you make an Intelligence (Investigation) check. You might deduce the location of a hidden object, discern from the appearance of a wound what kind of weapon dealt it, or determine the weakest point in a tunnel that could cause it to collapse. Poring through ancient scrolls in search of a hidden fragment of knowledge might also call for an Intelligence (Investigation) check.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-medicine', 'srd', NULL, 'Skill: Medicine', 'Medicine (WIS). A Wisdom (Medicine) check lets you try to stabilize a dying companion or diagnose an illness.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-nature', 'srd', NULL, 'Skill: Nature', 'Nature (INT). Your Intelligence (Nature) check measures your ability to recall lore about terrain, plants and animals, the weather, and natural cycles.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-perception', 'srd', NULL, 'Skill: Perception', 'Perception (WIS). Your Wisdom (Perception) check lets you spot, hear, or otherwise detect the presence of something. It measures your general awareness of your surroundings and the keenness of your senses. For example, you might try to hear a conversation through a closed door, eavesdrop under an open window, or hear monsters moving stealthily in the forest. Or you might try to spot things that are obscured or easy to miss, whether they are orcs lying in ambush on a road, thugs hiding in the shadows of an alley, or candlelight under a closed secret door.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-performance', 'srd', NULL, 'Skill: Performance', 'Performance (CHA). Your Charisma (Performance) check determines how well you can delight an audience with music, dance, acting, storytelling, or some other form of entertainment.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-persuasion', 'srd', NULL, 'Skill: Persuasion', 'Persuasion (CHA). When you attempt to influence someone or a group of people with tact, social graces, or good nature, the GM might ask you to make a Charisma (Persuasion) check. Typically, you use persuasion when acting in good faith, to foster friendships, make cordial requests, or exhibit proper etiquette. Examples of persuading others include convincing a chamberlain to let your party see the king, negotiating peace between warring tribes, or inspiring a crowd of townsfolk.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-religion', 'srd', NULL, 'Skill: Religion', 'Religion (INT). Your Intelligence (Religion) check measures your ability to recall lore about deities, rites and prayers, religious hierarchies, holy symbols, and the practices of secret cults.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-sleight-of-hand', 'srd', NULL, 'Skill: Sleight of Hand', 'Sleight of Hand (DEX). Whenever you attempt an act of legerdemain or manual trickery, such as planting something on someone else or concealing an object on your person, make a Dexterity (Sleight of Hand) check. The GM might also call for a Dexterity (Sleight of Hand) check to determine whether you can lift a coin purse off another person or slip something out of another person''s pocket.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-stealth', 'srd', NULL, 'Skill: Stealth', 'Stealth (DEX). Make a Dexterity (Stealth) check when you attempt to conceal yourself from enemies, slink past guards, slip away without being noticed, or sneak up on someone without being seen or heard.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('skill-survival', 'srd', NULL, 'Skill: Survival', 'Survival (WIS). The GM might ask you to make a Wisdom (Survival) check to follow tracks, hunt wild game, guide your group through frozen wastelands, identify signs that owlbears live nearby, predict the weather, or avoid quicksand and other natural hazards.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('ability-str', 'srd', NULL, 'Ability: Strength', 'Strength. Strength measures bodily power, athletic training, and the extent to which you can exert raw physical force.,A Strength check can model any attempt to lift, push, pull, or break something, to force your body through a space, or to otherwise apply brute force to a situation. The Athletics skill reflects aptitude in certain kinds of Strength checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('ability-dex', 'srd', NULL, 'Ability: Dexterity', 'Dexterity. Dexterity measures agility, reflexes, and balance.,A Dexterity check can model any attempt to move nimbly, quickly, or quietly, or to keep from falling on tricky footing. The Acrobatics, Sleight of Hand, and Stealth skills reflect aptitude in certain kinds of Dexterity checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('ability-con', 'srd', NULL, 'Ability: Constitution', 'Constitution. Constitution measures health, stamina, and vital force.,Constitution checks are uncommon, and no skills apply to Constitution checks, because the endurance this ability represents is largely passive rather than involving a specific effort on the part of a character or monster.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('ability-int', 'srd', NULL, 'Ability: Intelligence', 'Intelligence. Intelligence measures mental acuity, accuracy of recall, and the ability to reason.,An Intelligence check comes into play when you need to draw on logic, education, memory, or deductive reasoning. The Arcana, History, Investigation, Nature, and Religion skills reflect aptitude in certain kinds of Intelligence checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('ability-wis', 'srd', NULL, 'Ability: Wisdom', 'Wisdom. Wisdom reflects how attuned you are to the world around you and represents perceptiveness and intuition.,A Wisdom check might reflect an effort to read body language, understand someone''s feelings, notice things about the environment, or care for an injured person. The Animal Handling, Insight, Medicine, Perception, and Survival skills reflect aptitude in certain kinds of Wisdom checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('ability-cha', 'srd', NULL, 'Ability: Charisma', 'Charisma. Charisma measures your ability to interact effectively with others. It includes such factors as confidence and eloquence, and it can represent a charming or commanding personality.,A Charisma check might arise when you try to influence or entertain others, when you try to make an impression or tell a convincing lie, or when you are navigating a tricky social situation. The Deception, Intimidation, Performance, and Persuasion skills reflect aptitude in certain kinds of Charisma checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-acid-arrow-0', 'srd', NULL, 'Spell: Acid Arrow', 'Acid Arrow. Level 2 Evocation. Casting time: 1 action. Range: 90 feet. Duration: Instantaneous. A shimmering green arrow streaks toward a target within range and bursts in a spray of acid. Make a ranged spell attack against the target. On a hit, the target takes 4d4 acid damage immediately and 2d4 acid damage at the end of its next turn. On a miss, the arrow splashes the target with acid for half as much of the initial damage and no damage at the end of its next turn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-acid-splash-0', 'srd', NULL, 'Spell: Acid Splash', 'Acid Splash. Cantrip Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succeed on a dexterity saving throw or take 1d6 acid damage.

This spell''s damage increases by 1d6 when you reach 5th level (2d6), 11th level (3d6), and 17th level (4d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-aid-0', 'srd', NULL, 'Spell: Aid', 'Aid. Level 2 Abjuration. Casting time: 1 action. Range: 30 feet. Duration: 8 hours. Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target''s hit point maximum and current hit points increase by 5 for the duration.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-alarm-0', 'srd', NULL, 'Spell: Alarm', 'Alarm. Level 1 Abjuration. Casting time: 1 minute. Range: 30 feet. Duration: 8 hours. You set an alarm against unwanted intrusion. Choose a door, a window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. When you cast the spell, you can designate creatures that won''t set off the alarm. You also choose whether the alarm is mental or audible.

A mental alarm alerts you with a ping in your mind if you are within 1 mile of the warded area. This ping awakens you if you are sleeping.

An audible alarm produces the sound of a hand bell for 10 seconds within 60 feet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-alter-self-0', 'srd', NULL, 'Spell: Alter Self (1)', 'Alter Self. Level 2 Transmutation. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. You assume a different form. When you cast the spell, choose one of the following options, the effects of which last for the duration of the spell. While the spell lasts, you can end one option as an action to gain the benefits of a different one.

***Aquatic Adaptation.*** You adapt your body to an aquatic environment, sprouting gills and growing webbing between your fingers. You can breathe underwater and gain a swimming speed equal to your walking speed.

***Change Appearance.*** You transform your appearance. You decide what you look like, including your height, weight, facial features, sound of your voice, hair length, coloration, and distinguishing characteristics, if any. You can make yourself appear as a member of another race, though none of your statistics change. You also can''t appear as a creature of a different size than you, and your basic shape stays the same; if you''re bipedal, you can''t use this spell to become quadrupedal, for instance. At any time for the duration of the spell, you can use your action to change your appearance in this way again.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-alter-self-1', 'srd', NULL, 'Spell: Alter Self (2)', '***Natural Weapons.*** You grow claws, fangs, spines, horns, or a different natural weapon of your choice. Your unarmed strikes deal 1d6 bludgeoning, piercing, or slashing damage, as appropriate to the natural weapon you chose, and you are proficient with your unarmed strikes. Finally, the natural weapon is magic and you have a +1 bonus to the attack and damage rolls you make using it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animal-friendship-0', 'srd', NULL, 'Spell: Animal Friendship', 'Animal Friendship. Level 1 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: 24 hours. This spell lets you convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast''s Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succeed on a wisdom saving throw or be charmed by you for the spell''s duration. If you or one of your companions harms the target, the spells ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animal-messenger-0', 'srd', NULL, 'Spell: Animal Messenger', 'Animal Messenger. Level 2 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: 24 hours. By means of this spell, you use an animal to deliver a message. Choose a Tiny beast you can see within range, such as a squirrel, a blue jay, or a bat. You specify a location, which you must have visited, and a recipient who matches a general description, such as "a man or woman dressed in the uniform of the town guard" or "a red-haired dwarf wearing a pointed hat." You also speak a message of up to twenty-five words. The target beast travels for the duration of the spell toward the specified location, covering about 50 miles per 24 hours for a flying messenger, or 25 miles for other animals.

When the messenger arrives, it delivers your message to the creature that you described, replicating the sound of your voice. The messenger speaks only to a creature matching the description you gave. If the messenger doesn''t reach its destination before the spell ends, the message is lost, and the beast makes its way back to where you cast this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animal-shapes-0', 'srd', NULL, 'Spell: Animal Shapes', 'Animal Shapes. Level 8 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Up to 24 hours. Your magic turns others into beasts. Choose any number of willing creatures that you can see within range. You transform each target into the form of a Large or smaller beast with a challenge rating of 4 or lower. On subsequent turns, you can use your action to transform affected creatures into new forms.

The transformation lasts for the duration for each target, or until the target drops to 0 hit points or dies. You can choose a different form for each target. A target''s game statistics are replaced by the statistics of the chosen beast, though the target retains its alignment and Intelligence, Wisdom, and Charisma scores. The target assumes the hit points of its new form, and when it reverts to its normal form, it returns to the number of hit points it had before it transformed. If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form. As long as the excess damage doesn''t reduce the creature''s normal form to 0 hit points, it isn''t knocked unconscious. The creature is limited in the actions it can perform by the nature of its new form, and it can''t speak or cast spells.

The target''s gear melds into the new form. The target can''t activate, wield, or otherwise benefit from any of its equipment.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animate-dead-0', 'srd', NULL, 'Spell: Animate Dead (1)', 'Animate Dead. Level 3 Necromancy. Casting time: 1 minute. Range: 10 feet. Duration: Instantaneous. This spell creates an undead servant. Choose a pile of bones or a corpse of a Medium or Small humanoid within range. Your spell imbues the target with a foul mimicry of life, raising it as an undead creature. The target becomes a skeleton if you chose bones or a zombie if you chose a corpse (the GM has the creature''s game statistics).

On each of your turns, you can use a bonus action to mentally command any creature you made with this spell if the creature is within 60 feet of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until its task is complete.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animate-dead-1', 'srd', NULL, 'Spell: Animate Dead (2)', 'The creature is under your control for 24 hours, after which it stops obeying any command you''ve given it. To maintain control of the creature for another 24 hours, you must cast this spell on the creature again before the current 24-hour period ends. This use of the spell reasserts your control over up to four creatures you have animated with this spell, rather than animating a new one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animate-objects-0', 'srd', NULL, 'Spell: Animate Objects (1)', 'Animate Objects. Level 5 Transmutation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. Objects come to life at your command. Choose up to ten nonmagical objects within range that are not being worn or carried. Medium targets count as two objects, Large targets count as four objects, Huge targets count as eight objects. You can''t animate any object larger than Huge. Each target animates and becomes a creature under your control until the spell ends or until reduced to 0 hit points.

As a bonus action, you can mentally command any creature you made with this spell if the creature is within 500 feet of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until its task is complete.

##### Animated Object Statistics

| Size | HP | AC | Attack | Str | Dex |

|---|---|---|---|---|---|

| Tiny | 20 | 18 | +8 to hit, 1d4 + 4 damage | 4 | 18 |

| Small | 25 | 16 | +6 to hit, 1d8 + 2 damage | 6 | 14 |

| Medium | 40 | 13 | +5 to hit, 2d6 + 1 damage | 10 | 12 |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-animate-objects-1', 'srd', NULL, 'Spell: Animate Objects (2)', '| Large | 50 | 10 | +6 to hit, 2d10 + 2 damage | 14 | 10 |

| Huge | 80 | 10 | +8 to hit, 2d12 + 4 damage | 18 | 6 |

An animated object is a construct with AC, hit points, attacks, Strength, and Dexterity determined by its size. Its Constitution is 10 and its Intelligence and Wisdom are 3, and its Charisma is 1. Its speed is 30 feet; if the object lacks legs or other appendages it can use for locomotion, it instead has a flying speed of 30 feet and can hover. If the object is securely attached to a surface or a larger object, such as a chain bolted to a wall, its speed is 0. It has blindsight with a radius of 30 feet and is blind beyond that distance. When the animated object drops to 0 hit points, it reverts to its original object form, and any remaining damage carries over to its original object form.

If you command an object to attack, it can make a single melee attack against a creature within 5 feet of it. It makes a slam attack with an attack bonus and bludgeoning damage determined by its size. The GM might rule that a specific object inflicts slashing or piercing damage based on its form.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-antilife-shell-0', 'srd', NULL, 'Spell: Antilife Shell', 'Antilife Shell. Level 5 Abjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. A shimmering barrier extends out from you in a 10-foot radius and moves with you, remaining centered on you and hedging out creatures other than undead and constructs. The barrier lasts for the duration.

The barrier prevents an affected creature from passing or reaching through. An affected creature can cast spells or make attacks with ranged or reach weapons through the barrier.

If you move so that an affected creature is forced to pass through the barrier, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-antimagic-field-0', 'srd', NULL, 'Spell: Antimagic Field (1)', 'Antimagic Field. Level 8 Abjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. A 10-foot-radius invisible sphere of antimagic surrounds you. This area is divorced from the magical energy that suffuses the multiverse. Within the sphere, spells can''t be cast, summoned creatures disappear, and even magic items become mundane. Until the spell ends, the sphere moves with you, centered on you.

Spells and other magical effects, except those created by an artifact or a deity, are suppressed in the sphere and can''t protrude into it. A slot expended to cast a suppressed spell is consumed. While an effect is suppressed, it doesn''t function, but the time it spends suppressed counts against its duration.

***Targeted Effects.*** Spells and other magical effects, such as magic missile and charm person, that target a creature or an object in the sphere have no effect on that target.

***Areas of Magic.*** The area of another spell or magical effect, such as fireball, can''t extend into the sphere. If the sphere overlaps an area of magic, the part of the area that is covered by the sphere is suppressed. For example, the flames created by a wall of fire are suppressed within the sphere, creating a gap in the wall if the overlap is large enough.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-antimagic-field-1', 'srd', NULL, 'Spell: Antimagic Field (2)', '***Spells.*** Any active spell or other magical effect on a creature or an object in the sphere is suppressed while the creature or object is in it.

***Magic Items.*** The properties and powers of magic items are suppressed in the sphere. For example, a +1 longsword in the sphere functions as a nonmagical longsword.

A magic weapon''s properties and powers are suppressed if it is used against a target in the sphere or wielded by an attacker in the sphere. If a magic weapon or a piece of magic ammunition fully leaves the sphere (for example, if you fire a magic arrow or throw a magic spear at a target outside the sphere), the magic of the item ceases to be suppressed as soon as it exits.

***Magical Travel.*** Teleportation and planar travel fail to work in the sphere, whether the sphere is the destination or the departure point for such magical travel. A portal to another location, world, or plane of existence, as well as an opening to an extradimensional space such as that created by the rope trick spell, temporarily closes while in the sphere.

***Creatures and Objects.*** A creature or object summoned or created by magic temporarily winks out of existence in the sphere. Such a creature instantly reappears once the space the creature occupied is no longer within the sphere.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-antimagic-field-2', 'srd', NULL, 'Spell: Antimagic Field (3)', '***Dispel Magic.*** Spells and magical effects such as dispel magic have no effect on the sphere. Likewise, the spheres created by different antimagic field spells don''t nullify each other.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-antipathy-sympathy-0', 'srd', NULL, 'Spell: Antipathy/Sympathy (1)', 'Antipathy/Sympathy. Level 8 Enchantment. Casting time: 1 hour. Range: 60 feet. Duration: 10 days. This spell attracts or repels creatures of your choice. You target something within range, either a Huge or smaller object or creature or an area that is no larger than a 200-foot cube. Then specify a kind of intelligent creature, such as red dragons, goblins, or vampires. You invest the target with an aura that either attracts or repels the specified creatures for the duration. Choose antipathy or sympathy as the aura''s effect.

***Antipathy.*** The enchantment causes creatures of the kind you designated to feel an intense urge to leave the area and avoid the target. When such a creature can see the target or comes within 60 feet of it, the creature must succeed on a wisdom saving throw or become frightened. The creature remains frightened while it can see the target or is within 60 feet of it. While frightened by the target, the creature must use its movement to move to the nearest safe spot from which it can''t see the target. If the creature moves more than 60 feet from the target and can''t see it, the creature is no longer frightened, but the creature becomes frightened again if it regains sight of the target or moves within 60 feet of it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-antipathy-sympathy-1', 'srd', NULL, 'Spell: Antipathy/Sympathy (2)', '***Sympathy.*** The enchantment causes the specified creatures to feel an intense urge to approach the target while within 60 feet of it or able to see it. When such a creature can see the target or comes within 60 feet of it, the creature must succeed on a wisdom saving throw or use its movement on each of its turns to enter the area or move within reach of the target. When the creature has done so, it can''t willingly move away from the target.

If the target damages or otherwise harms an affected creature, the affected creature can make a wisdom saving throw to end the effect, as described below.

***Ending the Effect.*** If an affected creature ends its turn while not within 60 feet of the target or able to see it, the creature makes a wisdom saving throw. On a successful save, the creature is no longer affected by the target and recognizes the feeling of repugnance or attraction as magical. In addition, a creature affected by the spell is allowed another wisdom saving throw every 24 hours while the spell persists.

A creature that successfully saves against this effect is immune to it for 1 minute, after which time it can be affected again.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-arcane-eye-0', 'srd', NULL, 'Spell: Arcane Eye', 'Arcane Eye. Level 4 Divination. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 hour. You create an invisible, magical eye within range that hovers in the air for the duration.

You mentally receive visual information from the eye, which has normal vision and darkvision out to 30 feet. The eye can look in every direction.

As an action, you can move the eye up to 30 feet in any direction. There is no limit to how far away from you the eye can move, but it can''t enter another plane of existence. A solid barrier blocks the eye''s movement, but the eye can pass through an opening as small as 1 inch in diameter.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-arcane-hand-0', 'srd', NULL, 'Spell: Arcane Hand (1)', 'Arcane Hand. Level 5 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. You create a Large hand of shimmering, translucent force in an unoccupied space that you can see within range. The hand lasts for the spell''s duration, and it moves at your command, mimicking the movements of your own hand.

The hand is an object that has AC 20 and hit points equal to your hit point maximum. If it drops to 0 hit points, the spell ends. It has a Strength of 26 (+8) and a Dexterity of 10 (+0). The hand doesn''t fill its space.

When you cast the spell and as a bonus action on your subsequent turns, you can move the hand up to 60 feet and then cause one of the following effects with it.

***Clenched Fist.*** The hand strikes one creature or object within 5 feet of it. Make a melee spell attack for the hand using your game statistics. On a hit, the target takes 4d8 force damage.

***Forceful Hand.*** The hand attempts to push a creature within 5 feet of it in a direction you choose. Make a check with the hand''s Strength contested by the Strength (Athletics) check of the target. If the target is Medium or smaller, you have advantage on the check. If you succeed, the hand pushes the target up to 5 feet plus a number of feet equal to five times your spellcasting ability modifier. The hand moves with the target to remain within 5 feet of it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-arcane-hand-1', 'srd', NULL, 'Spell: Arcane Hand (2)', '***Grasping Hand.*** The hand attempts to grapple a Huge or smaller creature within 5 feet of it. You use the hand''s Strength score to resolve the grapple. If the target is Medium or smaller, you have advantage on the check. While the hand is grappling the target, you can use a bonus action to have the hand crush it. When you do so, the target takes bludgeoning damage equal to 2d6 + your spellcasting ability modifier.

***Interposing Hand.*** The hand interposes itself between you and a creature you choose until you give the hand a different command. The hand moves to stay between you and the target, providing you with half cover against the target. The target can''t move through the hand''s space if its Strength score is less than or equal to the hand''s Strength score. If its Strength score is higher than the hand''s Strength score, the target can move toward you through the hand''s space, but that space is difficult terrain for the target.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-arcane-lock-0', 'srd', NULL, 'Spell: Arcane Lock', 'Arcane Lock. Level 2 Abjuration. Casting time: 1 action. Range: Touch. Duration: Until dispelled. You touch a closed door, window, gate, chest, or other entryway, and it becomes locked for the duration. You and the creatures you designate when you cast this spell can open the object normally. You can also set a password that, when spoken within 5 feet of the object, suppresses this spell for 1 minute. Otherwise, it is impassable until it is broken or the spell is dispelled or suppressed. Casting knock on the object suppresses arcane lock for 10 minutes.

While affected by this spell, the object is more difficult to break or force open; the DC to break it or pick any locks on it increases by 10.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-arcane-sword-0', 'srd', NULL, 'Spell: Arcane Sword', 'Arcane Sword. Level 7 Evocation. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You create a sword-shaped plane of force that hovers within range. It lasts for the duration.

When the sword appears, you make a melee spell attack against a target of your choice within 5 feet of the sword. On a hit, the target takes 3d10 force damage. Until the spell ends, you can use a bonus action on each of your turns to move the sword up to 20 feet to a spot you can see and repeat this attack against the same target or a different one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-arcanists-magic-aura-0', 'srd', NULL, 'Spell: Arcanist''s Magic Aura', 'Arcanist''s Magic Aura. Level 2 Illusion. Casting time: 1 action. Range: Touch. Duration: 24 hours. You place an illusion on a creature or an object you touch so that divination spells reveal false information about it. The target can be a willing creature or an object that isn''t being carried or worn by another creature.

When you cast the spell, choose one or both of the following effects. The effect lasts for the duration. If you cast this spell on the same creature or object every day for 30 days, placing the same effect on it each time, the illusion lasts until it is dispelled.

***False Aura.*** You change the way the target appears to spells and magical effects, such as detect magic, that detect magical auras. You can make a nonmagical object appear magical, a magical object appear nonmagical, or change the object''s magical aura so that it appears to belong to a specific school of magic that you choose. When you use this effect on an object, you can make the false magic apparent to any creature that handles the item.

***Mask.*** You change the way the target appears to spells and magical effects that detect creature types, such as a paladin''s Divine Sense or the trigger of a symbol spell. You choose a creature type and other spells and magical effects treat the target as if it were a creature of that type or of that alignment.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-astral-projection-0', 'srd', NULL, 'Spell: Astral Projection (1)', 'Astral Projection. Level 9 Necromancy. Casting time: 1 hour. Range: 10 feet. Duration: Special. You and up to eight willing creatures within range project your astral bodies into the Astral Plane (the spell fails and the casting is wasted if you are already on that plane). The material body you leave behind is unconscious and in a state of suspended animation; it doesn''t need food or air and doesn''t age.

Your astral body resembles your mortal form in almost every way, replicating your game statistics and possessions. The principal difference is the addition of a silvery cord that extends from between your shoulder blades and trails behind you, fading to invisibility after 1 foot. This cord is your tether to your material body. As long as the tether remains intact, you can find your way home. If the cord is cut--something that can happen only when an effect specifically states that it does--your soul and body are separated, killing you instantly.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-astral-projection-1', 'srd', NULL, 'Spell: Astral Projection (2)', 'Your astral form can freely travel through the Astral Plane and can pass through portals there leading to any other plane. If you enter a new plane or return to the plane you were on when casting this spell, your body and possessions are transported along the silver cord, allowing you to re-enter your body as you enter the new plane. Your astral form is a separate incarnation. Any damage or other effects that apply to it have no effect on your physical body, nor do they persist when you return to it.

The spell ends for you and your companions when you use your action to dismiss it. When the spell ends, the affected creature returns to its physical body, and it awakens.

The spell might also end early for you or one of your companions. A successful dispel magic spell used against an astral or physical body ends the spell for that creature. If a creature''s original body or its astral form drops to 0 hit points, the spell ends for that creature. If the spell ends and the silver cord is intact, the cord pulls the creature''s astral form back to its body, ending its state of suspended animation.

If you are returned to your body prematurely, your companions remain in their astral forms and must find their own way back to their bodies, usually by dropping to 0 hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-augury-0', 'srd', NULL, 'Spell: Augury', 'Augury. Level 2 Divination. Casting time: 1 minute. Range: Self. Duration: Instantaneous. By casting gem-inlaid sticks, rolling dragon bones, laying out ornate cards, or employing some other divining tool, you receive an omen from an otherworldly entity about the results of a specific course of action that you plan to take within the next 30 minutes. The GM chooses from the following possible omens:

- Weal, for good results

- Woe, for bad results

- Weal and woe, for both good and bad results

- Nothing, for results that aren''t especially good or bad

The spell doesn''t take into account any possible circumstances that might change the outcome, such as the casting of additional spells or the loss or gain of a companion.

If you cast the spell two or more times before completing your next long rest, there is a cumulative 25 percent chance for each casting after the first that you get a random reading. The GM makes this roll in secret.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-awaken-0', 'srd', NULL, 'Spell: Awaken', 'Awaken. Level 5 Transmutation. Casting time: 8 hours. Range: Touch. Duration: Instantaneous. After spending the casting time tracing magical pathways within a precious gemstone, you touch a Huge or smaller beast or plant. The target must have either no Intelligence score or an Intelligence of 3 or less. The target gains an Intelligence of 10. The target also gains the ability to speak one language you know. If the target is a plant, it gains the ability to move its limbs, roots, vines, creepers, and so forth, and it gains senses similar to a human''s. Your GM chooses statistics appropriate for the awakened plant, such as the statistics for the awakened shrub or the awakened tree.

The awakened beast or plant is charmed by you for 30 days or until you or your companions do anything harmful to it. When the charmed condition ends, the awakened creature chooses whether to remain friendly to you, based on how you treated it while it was charmed.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-bane-0', 'srd', NULL, 'Spell: Bane', 'Bane. Level 1 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. Up to three creatures of your choice that you can see within range must make charisma saving throws. Whenever a target that fails this saving throw makes an attack roll or a saving throw before the spell ends, the target must roll a d4 and subtract the number rolled from the attack roll or saving throw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-banishment-0', 'srd', NULL, 'Spell: Banishment', 'Banishment. Level 4 Abjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a charisma saving throw or be banished.

If the target is native to the plane of existence you''re on, you banish the target to a harmless demiplane. While there, the target is incapacitated. The target remains there until the spell ends, at which point the target reappears in the space it left or in the nearest unoccupied space if that space is occupied.

If the target is native to a different plane of existence than the one you''re on, the target is banished with a faint popping noise, returning to its home plane. If the spell ends before 1 minute has passed, the target reappears in the space it left or in the nearest unoccupied space if that space is occupied. Otherwise, the target doesn''t return.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-barkskin-0', 'srd', NULL, 'Spell: Barkskin', 'Barkskin. Level 2 Transmutation. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. You touch a willing creature. Until the spell ends, the target''s skin has a rough, bark-like appearance, and the target''s AC can''t be less than 16, regardless of what kind of armor it is wearing.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-beacon-of-hope-0', 'srd', NULL, 'Spell: Beacon of Hope', 'Beacon of Hope. Level 3 Abjuration. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. This spell bestows hope and vitality. Choose any number of creatures within range. For the duration, each target has advantage on wisdom saving throws and death saving throws, and regains the maximum number of hit points possible from any healing.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-bestow-curse-0', 'srd', NULL, 'Spell: Bestow Curse', 'Bestow Curse. Level 3 Necromancy. Casting time: 1 action. Range: Touch. Duration: Up to 1 minute. You touch a creature, and that creature must succeed on a wisdom saving throw or become cursed for the duration of the spell. When you cast this spell, choose the nature of the curse from the following options:

- Choose one ability score. While cursed, the target has disadvantage on ability checks and saving throws made with that ability score.

- While cursed, the target has disadvantage on attack rolls against you.

- While cursed, the target must make a wisdom saving throw at the start of each of its turns. If it fails, it wastes its action that turn doing nothing.

- While the target is cursed, your attacks and spells deal an extra 1d8 necrotic damage to the target.

A remove curse spell ends this effect. At the GM''s option, you may choose an alternative curse effect, but it should be no more powerful than those described above. The GM has final say on such a curse''s effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-black-tentacles-0', 'srd', NULL, 'Spell: Black Tentacles', 'Black Tentacles. Level 4 Conjuration. Casting time: 1 action. Range: 90 feet. Duration: Up to 1 minute. Squirming, ebony tentacles fill a 20-foot square on ground that you can see within range. For the duration, these tentacles turn the ground in the area into difficult terrain.

When a creature enters the affected area for the first time on a turn or starts its turn there, the creature must succeed on a Dexterity saving throw or take 3d6 bludgeoning damage and be restrained by the tentacles until the spell ends. A creature that starts its turn in the area and is already restrained by the tentacles takes 3d6 bludgeoning damage.

A creature restrained by the tentacles can use its action to make a Strength or Dexterity check (its choice) against your spell save DC. On a success, it frees itself.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-blade-barrier-0', 'srd', NULL, 'Spell: Blade Barrier', 'Blade Barrier. Level 6 Evocation. Casting time: 1 action. Range: 90 feet. Duration: Up to 10 minutes. You create a vertical wall of whirling, razor-sharp blades made of magical energy. The wall appears within range and lasts for the duration. You can make a straight wall up to 100 feet long, 20 feet high, and 5 feet thick, or a ringed wall up to 60 feet in diameter, 20 feet high, and 5 feet thick. The wall provides three-quarters cover to creatures behind it, and its space is difficult terrain.

When a creature enters the wall''s area for the first time on a turn or starts its turn there, the creature must make a dexterity saving throw. On a failed save, the creature takes 6d10 slashing damage. On a successful save, the creature takes half as much damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-bless-0', 'srd', NULL, 'Spell: Bless', 'Bless. Level 1 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-blight-0', 'srd', NULL, 'Spell: Blight', 'Blight. Level 4 Necromancy. Casting time: 1 action. Range: 30 feet. Duration: Instantaneous. Necromantic energy washes over a creature of your choice that you can see within range, draining moisture and vitality from it. The target must make a constitution saving throw. The target takes 8d8 necrotic damage on a failed save, or half as much damage on a successful one. The spell has no effect on undead or constructs.

If you target a plant creature or a magical plant, it makes the saving throw with disadvantage, and the spell deals maximum damage to it.

If you target a nonmagical plant that isn''t a creature, such as a tree or shrub, it doesn''t make a saving throw; it simply withers and dies.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-blindness-deafness-0', 'srd', NULL, 'Spell: Blindness/Deafness', 'Blindness/Deafness. Level 2 Necromancy. Casting time: 1 action. Range: 30 feet. Duration: 1 minute. You can blind or deafen a foe. Choose one creature that you can see within range to make a constitution saving throw. If it fails, the target is either blinded or deafened (your choice) for the duration. At the end of each of its turns, the target can make a constitution saving throw. On a success, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-blink-0', 'srd', NULL, 'Spell: Blink', 'Blink. Level 3 Transmutation. Casting time: 1 action. Range: Self. Duration: 1 minute. Roll a d20 at the end of each of your turns for the duration of the spell. On a roll of 11 or higher, you vanish from your current plane of existence and appear in the Ethereal Plane (the spell fails and the casting is wasted if you were already on that plane). At the start of your next turn, and when the spell ends if you are on the Ethereal Plane, you return to an unoccupied space of your choice that you can see within 10 feet of the space you vanished from. If no unoccupied space is available within that range, you appear in the nearest unoccupied space (chosen at random if more than one space is equally near). You can dismiss this spell as an action.

While on the Ethereal Plane, you can see and hear the plane you originated from, which is cast in shades of gray, and you can''t see anything there more than 60 feet away. You can only affect and be affected by other creatures on the Ethereal Plane. Creatures that aren''t there can''t perceive you or interact with you, unless they have the ability to do so.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-blur-0', 'srd', NULL, 'Spell: Blur', 'Blur. Level 2 Illusion. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. Your body becomes blurred, shifting and wavering to all who can see you. For the duration, any creature has disadvantage on attack rolls against you. An attacker is immune to this effect if it doesn''t rely on sight, as with blindsight, or can see through illusions, as with truesight.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-branding-smite-0', 'srd', NULL, 'Spell: Branding Smite', 'Branding Smite. Level 2 Evocation. Casting time: 1 bonus action. Range: Self. Duration: Up to 1 minute. The next time you hit a creature with a weapon attack before this spell ends, the weapon gleams with astral radiance as you strike. The attack deals an extra 2d6 radiant damage to the target, which becomes visible if it''s invisible, and the target sheds dim light in a 5-foot radius and can''t become invisible until the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-burning-hands-0', 'srd', NULL, 'Spell: Burning Hands', 'Burning Hands. Level 1 Evocation. Casting time: 1 action. Range: Self. Duration: Instantaneous. As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one.

The fire ignites any flammable objects in the area that aren''t being worn or carried.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-call-lightning-0', 'srd', NULL, 'Spell: Call Lightning', 'Call Lightning. Level 3 Conjuration. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. A storm cloud appears in the shape of a cylinder that is 10 feet tall with a 60-foot radius, centered on a point you can see 100 feet directly above you. The spell fails if you can''t see a point in the air where the storm cloud could appear (for example, if you are in a room that can''t accommodate the cloud).

When you cast the spell, choose a point you can see within range. A bolt of lightning flashes down from the cloud to that point. Each creature within 5 feet of that point must make a dexterity saving throw. A creature takes 3d10 lightning damage on a failed save, or half as much damage on a successful one. On each of your turns until the spell ends, you can use your action to call down lightning in this way again, targeting the same point or a different one.

If you are outdoors in stormy conditions when you cast this spell, the spell gives you control over the existing storm instead of creating a new one. Under such conditions, the spell''s damage increases by 1d10.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-calm-emotions-0', 'srd', NULL, 'Spell: Calm Emotions', 'Calm Emotions. Level 2 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You attempt to suppress strong emotions in a group of people. Each humanoid in a 20-foot-radius sphere centered on a point you choose within range must make a charisma saving throw; a creature can choose to fail this saving throw if it wishes. If a creature fails its saving throw, choose one of the following two effects. You can suppress any effect causing a target to be charmed or frightened. When this spell ends, any suppressed effect resumes, provided that its duration has not expired in the meantime.

Alternatively, you can make a target indifferent about creatures of your choice that it is hostile toward. This indifference ends if the target is attacked or harmed by a spell or if it witnesses any of its friends being harmed. When the spell ends, the creature becomes hostile again, unless the GM rules otherwise.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-chain-lightning-0', 'srd', NULL, 'Spell: Chain Lightning', 'Chain Lightning. Level 6 Evocation. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. You create a bolt of lightning that arcs toward a target of your choice that you can see within range. Three bolts then leap from that target to as many as three other targets, each of which must be within 30 feet of the first target. A target can be a creature or an object and can be targeted by only one of the bolts.

A target must make a dexterity saving throw. The target takes 10d8 lightning damage on a failed save, or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-charm-person-0', 'srd', NULL, 'Spell: Charm Person', 'Charm Person. Level 1 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: 1 hour. You attempt to charm a humanoid you can see within range. It must make a wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-chill-touch-0', 'srd', NULL, 'Spell: Chill Touch', 'Chill Touch. Cantrip Necromancy. Casting time: 1 action. Range: 120 feet. Duration: 1 round. You create a ghostly, skeletal hand in the space of a creature within range. Make a ranged spell attack against the creature to assail it with the chill of the grave. On a hit, the target takes 1d8 necrotic damage, and it can''t regain hit points until the start of your next turn. Until then, the hand clings to the target.

If you hit an undead target, it also has disadvantage on attack rolls against you until the end of your next turn.

This spell''s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-circle-of-death-0', 'srd', NULL, 'Spell: Circle of Death', 'Circle of Death. Level 6 Necromancy. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. A sphere of negative energy ripples out in a 60-foot radius sphere from a point within range. Each creature in that area must make a constitution saving throw. A target takes 8d6 necrotic damage on a failed save, or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-clairvoyance-0', 'srd', NULL, 'Spell: Clairvoyance', 'Clairvoyance. Level 3 Divination. Casting time: 10 minutes. Range: 1 mile. Duration: Up to 10 minutes. You create an invisible sensor within range in a location familiar to you (a place you have visited or seen before) or in an obvious location that is unfamiliar to you (such as behind a door, around a corner, or in a grove of trees). The sensor remains in place for the duration, and it can''t be attacked or otherwise interacted with.

When you cast the spell, you choose seeing or hearing. You can use the chosen sense through the sensor as if you were in its space. As your action, you can switch between seeing and hearing.

A creature that can see the sensor (such as a creature benefiting from see invisibility or truesight) sees a luminous, intangible orb about the size of your fist.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-clone-0', 'srd', NULL, 'Spell: Clone', 'Clone. Level 8 Necromancy. Casting time: 1 hour. Range: Touch. Duration: Instantaneous. This spell grows an inert duplicate of a living creature as a safeguard against death. This clone forms inside a sealed vessel and grows to full size and maturity after 120 days; you can also choose to have the clone be a younger version of the same creature. It remains inert and endures indefinitely, as long as its vessel remains undisturbed.

At any time after the clone matures, if the original creature dies, its soul transfers to the clone, provided that the soul is free and willing to return. The clone is physically identical to the original and has the same personality, memories, and abilities, but none of the original''s equipment. The original creature''s physical remains, if they still exist, become inert and can''t thereafter be restored to life, since the creature''s soul is elsewhere.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-cloudkill-0', 'srd', NULL, 'Spell: Cloudkill', 'Cloudkill. Level 5 Conjuration. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. You create a 20-foot-radius sphere of poisonous, yellow-green fog centered on a point you choose within range. The fog spreads around corners. It lasts for the duration or until strong wind disperses the fog, ending the spell. Its area is heavily obscured.

When a creature enters the spell''s area for the first time on a turn or starts its turn there, that creature must make a constitution saving throw. The creature takes 5d8 poison damage on a failed save, or half as much damage on a successful one. Creatures are affected even if they hold their breath or don''t need to breathe.

The fog moves 10 feet away from you at the start of each of your turns, rolling along the surface of the ground. The vapors, being heavier than air, sink to the lowest level of the land, even pouring down openings.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-color-spray-0', 'srd', NULL, 'Spell: Color Spray', 'Color Spray. Level 1 Illusion. Casting time: 1 action. Range: Self. Duration: 1 round. A dazzling array of flashing, colored light springs from your hand. Roll 6d10; the total is how many hit points of creatures this spell can effect. Creatures in a 15-foot cone originating from you are affected in ascending order of their current hit points (ignoring unconscious creatures and creatures that can''t see).

Starting with the creature that has the lowest current hit points, each creature affected by this spell is blinded until the spell ends. Subtract each creature''s hit points from the total before moving on to the creature with the next lowest hit points. A creature''s hit points must be equal to or less than the remaining total for that creature to be affected.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-command-0', 'srd', NULL, 'Spell: Command', 'Command. Level 1 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: 1 round. You speak a one-word command to a creature you can see within range. The target must succeed on a wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn''t understand your language, or if your command is directly harmful to it.

Some typical commands and their effects follow. You might issue a command other than one described here. If you do so, the GM determines how the target behaves. If the target can''t follow your command, the spell ends.

***Approach.*** The target moves toward you by the shortest and most direct route, ending its turn if it moves within 5 feet of you.

***Drop.*** The target drops whatever it is holding and then ends its turn.

***Flee.*** The target spends its turn moving away from you by the fastest available means.

***Grovel.*** The target falls prone and then ends its turn.

***Halt.*** The target doesn''t move and takes no actions. A flying creature stays aloft, provided that it is able to do so. If it must move to stay aloft, it flies the minimum distance needed to remain in the air.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-commune-0', 'srd', NULL, 'Spell: Commune', 'Commune. Level 5 Divination. Casting time: 1 minute. Range: Self. Duration: 1 minute. You contact your deity or a divine proxy and ask up to three questions that can be answered with a yes or no. You must ask your questions before the spell ends. You receive a correct answer for each question.

Divine beings aren''t necessarily omniscient, so you might receive "unclear" as an answer if a question pertains to information that lies beyond the deity''s knowledge. In a case where a one-word answer could be misleading or contrary to the deity''s interests, the GM might offer a short phrase as an answer instead.

If you cast the spell two or more times before finishing your next long rest, there is a cumulative 25 percent chance for each casting after the first that you get no answer. The GM makes this roll in secret.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-commune-with-nature-0', 'srd', NULL, 'Spell: Commune With Nature', 'Commune With Nature. Level 5 Divination. Casting time: 1 minute. Range: Self. Duration: Instantaneous. You briefly become one with nature and gain knowledge of the surrounding territory. In the outdoors, the spell gives you knowledge of the land within 3 miles of you. In caves and other natural underground settings, the radius is limited to 300 feet. The spell doesn''t function where nature has been replaced by construction, such as in dungeons and towns.

You instantly gain knowledge of up to three facts of your choice about any of the following subjects as they relate to the area:

- terrain and bodies of water

- prevalent plants, minerals, animals, or peoples

- powerful celestials, fey, fiends, elementals, or undead

- influence from other planes of existence

- buildings

For example, you could determine the location of powerful undead in the area, the location of major sources of safe drinking water, and the location of any nearby towns.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-comprehend-languages-0', 'srd', NULL, 'Spell: Comprehend Languages', 'Comprehend Languages. Level 1 Divination. Casting time: 1 action. Range: Self. Duration: 1 hour. For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text.

This spell doesn''t decode secret messages in a text or a glyph, such as an arcane sigil, that isn''t part of a written language.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-compulsion-0', 'srd', NULL, 'Spell: Compulsion', 'Compulsion. Level 4 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. Creatures of your choice that you can see within range and that can hear you must make a wisdom saving throw. A target automatically succeeds on this saving throw if it can''t be charmed. On a failed save, a target is affected by this spell. Until the spell ends, you can use a bonus action on each of your turns to designate a direction that is horizontal to you. Each affected target must use as much of its movement as possible to move in that direction on its next turn. It can take any action before it moves. After moving in this way, it can make another Wisdom save to try to end the effect.

A target isn''t compelled to move into an obviously deadly hazard, such as a fire or a pit, but it will provoke opportunity attacks to move in the designated direction.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-cone-of-cold-0', 'srd', NULL, 'Spell: Cone of Cold', 'Cone of Cold. Level 5 Evocation. Casting time: 1 action. Range: Self. Duration: Instantaneous. A blast of cold air erupts from your hands. Each creature in a 60-foot cone must make a constitution saving throw. A creature takes 8d8 cold damage on a failed save, or half as much damage on a successful one.

A creature killed by this spell becomes a frozen statue until it thaws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-confusion-0', 'srd', NULL, 'Spell: Confusion', 'Confusion. Level 4 Enchantment. Casting time: 1 action. Range: 90 feet. Duration: Up to 1 minute. This spell assaults and twists creatures'' minds, spawning delusions and provoking uncontrolled action. Each creature in a 10-foot-radius sphere centered on a point you choose within range must succeed on a Wisdom saving throw when you cast this spell or be affected by it.

An affected target can''t take reactions and must roll a d10 at the start of each of its turns to determine its behavior for that turn.

| d10 | Behavior |

|---|---|

| 1 | The creature uses all its movement to move in a random direction. To determine the direction, roll a d8 and assign a direction to each die face. The creature doesn''t take an action this turn. |

| 2-6 | The creature doesn''t move or take actions this turn. |

| 7-8 | The creature uses its action to make a melee attack against a randomly determined creature within its reach. If there is no creature within its reach, the creature does nothing this turn. |

| 9-10 | The creature can act and move normally. |

At the end of each of its turns, an affected target can make a Wisdom saving throw. If it succeeds, this effect ends for that target.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-conjure-animals-0', 'srd', NULL, 'Spell: Conjure Animals', 'Conjure Animals. Level 3 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 hour. You summon fey spirits that take the form of beasts and appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:

- One beast of challenge rating 2 or lower

- Two beasts of challenge rating 1 or lower

- Four beasts of challenge rating 1/2 or lower

- Eight beasts of challenge rating 1/4 or lower

- Each beast is also considered fey, and it disappears when it drops to 0 hit points or when the spell ends.

The summoned creatures are friendly to you and your companions. Roll initiative for the summoned creatures as a group, which has its own turns. They obey any verbal commands that you issue to them (no action required by you). If you don''t issue any commands to them, they defend themselves from hostile creatures, but otherwise take no actions.

The GM has the creatures'' statistics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-conjure-celestial-0', 'srd', NULL, 'Spell: Conjure Celestial', 'Conjure Celestial. Level 7 Conjuration. Casting time: 1 minute. Range: 90 feet. Duration: Up to 1 hour. You summon a celestial of challenge rating 4 or lower, which appears in an unoccupied space that you can see within range. The celestial disappears when it drops to 0 hit points or when the spell ends.

The celestial is friendly to you and your companions for the duration. Roll initiative for the celestial, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you), as long as they don''t violate its alignment. If you don''t issue any commands to the celestial, it defends itself from hostile creatures but otherwise takes no actions.

The GM has the celestial''s statistics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-conjure-elemental-0', 'srd', NULL, 'Spell: Conjure Elemental', 'Conjure Elemental. Level 5 Conjuration. Casting time: 1 minute. Range: 90 feet. Duration: Up to 1 hour. You call forth an elemental servant. Choose an area of air, earth, fire, or water that fills a 10-foot cube within range. An elemental of challenge rating 5 or lower appropriate to the area you chose appears in an unoccupied space within 10 feet of it. For example, a fire elemental emerges from a bonfire, and an earth elemental rises up from the ground. The elemental disappears when it drops to 0 hit points or when the spell ends.

The elemental is friendly to you and your companions for the duration. Roll initiative for the elemental, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you). If you don''t issue any commands to the elemental, it defends itself from hostile creatures but otherwise takes no actions.

If your concentration is broken, the elemental doesn''t disappear. Instead, you lose control of the elemental, it becomes hostile toward you and your companions, and it might attack. An uncontrolled elemental can''t be dismissed by you, and it disappears 1 hour after you summoned it.

The GM has the elemental''s statistics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-conjure-fey-0', 'srd', NULL, 'Spell: Conjure Fey', 'Conjure Fey. Level 6 Conjuration. Casting time: 1 minute. Range: 90 feet. Duration: Up to 1 hour. You summon a fey creature of challenge rating 6 or lower, or a fey spirit that takes the form of a beast of challenge rating 6 or lower. It appears in an unoccupied space that you can see within range. The fey creature disappears when it drops to 0 hit points or when the spell ends.

The fey creature is friendly to you and your companions for the duration. Roll initiative for the creature, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you), as long as they don''t violate its alignment. If you don''t issue any commands to the fey creature, it defends itself from hostile creatures but otherwise takes no actions.

If your concentration is broken, the fey creature doesn''t disappear. Instead, you lose control of the fey creature, it becomes hostile toward you and your companions, and it might attack. An uncontrolled fey creature can''t be dismissed by you, and it disappears 1 hour after you summoned it.

The GM has the fey creature''s statistics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-conjure-minor-elementals-0', 'srd', NULL, 'Spell: Conjure Minor Elementals', 'Conjure Minor Elementals. Level 4 Conjuration. Casting time: 1 minute. Range: 90 feet. Duration: Up to 1 hour. You summon elementals that appear in unoccupied spaces that you can see within range. You choose one the following options for what appears:

- One elemental of challenge rating 2 or lower

- Two elementals of challenge rating 1 or lower

- Four elementals of challenge rating 1/2 or lower

- Eight elementals of challenge rating 1/4 or lower.

An elemental summoned by this spell disappears when it drops to 0 hit points or when the spell ends.

The summoned creatures are friendly to you and your companions. Roll initiative for the summoned creatures as a group, which has its own turns. They obey any verbal commands that you issue to them (no action required by you). If you don''t issue any commands to them, they defend themselves from hostile creatures, but otherwise take no actions.

The GM has the creatures'' statistics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-conjure-woodland-beings-0', 'srd', NULL, 'Spell: Conjure Woodland Beings', 'Conjure Woodland Beings. Level 4 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 hour. You summon fey creatures that appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:

- One fey creature of challenge rating 2 or lower

- Two fey creatures of challenge rating 1 or lower

- Four fey creatures of challenge rating 1/2 or lower

- Eight fey creatures of challenge rating 1/4 or lower

A summoned creature disappears when it drops to 0 hit points or when the spell ends.

The summoned creatures are friendly to you and your companions. Roll initiative for the summoned creatures as a group, which have their own turns. They obey any verbal commands that you issue to them (no action required by you). If you don''t issue any commands to them, they defend themselves from hostile creatures, but otherwise take no actions.

The GM has the creatures'' statistics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-contact-other-plane-0', 'srd', NULL, 'Spell: Contact Other Plane', 'Contact Other Plane. Level 5 Divination. Casting time: 1 minute. Range: Self. Duration: 1 minute. You mentally contact a demigod, the spirit of a long-dead sage, or some other mysterious entity from another plane. Contacting this extraplanar intelligence can strain or even break your mind. When you cast this spell, make a DC 15 intelligence saving throw. On a failure, you take 6d6 psychic damage and are insane until you finish a long rest. While insane, you can''t take actions, can''t understand what other creatures say, can''t read, and speak only in gibberish. A greater restoration spell cast on you ends this effect.

On a successful save, you can ask the entity up to five questions. You must ask your questions before the spell ends. The GM answers each question with one word, such as "yes," "no," "maybe," "never," "irrelevant," or "unclear" (if the entity doesn''t know the answer to the question). If a one-word answer would be misleading, the GM might instead offer a short phrase as an answer.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-contagion-0', 'srd', NULL, 'Spell: Contagion (1)', 'Contagion. Level 5 Necromancy. Casting time: 1 action. Range: Touch. Duration: 7 days. Your touch inflicts disease. Make a melee spell attack against a creature within your reach. On a hit, you afflict the creature with a disease of your choice from any of the ones described below.

At the end of each of the target''s turns, it must make a constitution saving throw. After failing three of these saving throws, the disease''s effects last for the duration, and the creature stops making these saves. After succeeding on three of these saving throws, the creature recovers from the disease, and the spell ends.

Since this spell induces a natural disease in its target, any effect that removes a disease or otherwise ameliorates a disease''s effects apply to it.

***Blinding Sickness.*** Pain grips the creature''s mind, and its eyes turn milky white. The creature has disadvantage on wisdom checks and wisdom saving throws and is blinded.

***Filth Fever.*** A raging fever sweeps through the creature''s body. The creature has disadvantage on strength checks, strength saving throws, and attack rolls that use Strength.

***Flesh Rot.*** The creature''s flesh decays. The creature has disadvantage on Charisma checks and vulnerability to all damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-contagion-1', 'srd', NULL, 'Spell: Contagion (2)', '***Mindfire.*** The creature''s mind becomes feverish. The creature has disadvantage on intelligence checks and intelligence saving throws, and the creature behaves as if under the effects of the confusion spell during combat.

***Seizure.*** The creature is overcome with shaking. The creature has disadvantage on dexterity checks, dexterity saving throws, and attack rolls that use Dexterity.

***Slimy Doom.*** The creature begins to bleed uncontrollably. The creature has disadvantage on constitution checks and constitution saving throws. In addition, whenever the creature takes damage, it is stunned until the end of its next turn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-contingency-0', 'srd', NULL, 'Spell: Contingency', 'Contingency. Level 6 Evocation. Casting time: 10 minutes. Range: Self. Duration: 10 days. Choose a spell of 5th level or lower that you can cast, that has a casting time of 1 action, and that can target you. You cast that spell--called the contingent spell--as part of casting contingency, expending spell slots for both, but the contingent spell doesn''t come into effect. Instead, it takes effect when a certain circumstance occurs. You describe that circumstance when you cast the two spells. For example, a contingency cast with water breathing might stipulate that water breathing comes into effect when you are engulfed in water or a similar liquid.

The contingent spell takes effect immediately after the circumstance is met for the first time, whether or not you want it to. and then contingency ends.

The contingent spell takes effect only on you, even if it can normally target others. You can use only one contingency spell at a time. If you cast this spell again, the effect of another contingency spell on you ends. Also, contingency ends on you if its material component is ever not on your person.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-continual-flame-0', 'srd', NULL, 'Spell: Continual Flame', 'Continual Flame. Level 2 Evocation. Casting time: 1 action. Range: Touch. Duration: Until dispelled. A flame, equivalent in brightness to a torch, springs forth from an object that you touch. The effect looks like a regular flame, but it creates no heat and doesn''t use oxygen. A continual flame can be covered or hidden but not smothered or quenched.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-control-water-0', 'srd', NULL, 'Spell: Control Water (1)', 'Control Water. Level 4 Transmutation. Casting time: 1 action. Range: 300 feet. Duration: Up to 10 minutes. Until the spell ends, you control any freestanding water inside an area you choose that is a cube up to 100 feet on a side. You can choose from any of the following effects when you cast this spell. As an action on your turn, you can repeat the same effect or choose a different one.

***Flood.*** You cause the water level of all standing water in the area to rise by as much as 20 feet. If the area includes a shore, the flooding water spills over onto dry land.

If you choose an area in a large body of water, you instead create a 20-foot tall wave that travels from one side of the area to the other and then crashes down. Any Huge or smaller vehicles in the wave''s path are carried with it to the other side. Any Huge or smaller vehicles struck by the wave have a 25 percent chance of capsizing.

The water level remains elevated until the spell ends or you choose a different effect. If this effect produced a wave, the wave repeats on the start of your next turn while the flood effect lasts.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-control-water-1', 'srd', NULL, 'Spell: Control Water (2)', '***Part Water.*** You cause water in the area to move apart and create a trench. The trench extends across the spell''s area, and the separated water forms a wall to either side. The trench remains until the spell ends or you choose a different effect. The water then slowly fills in the trench over the course of the next round until the normal water level is restored.

***Redirect Flow.*** You cause flowing water in the area to move in a direction you choose, even if the water has to flow over obstacles, up walls, or in other unlikely directions. The water in the area moves as you direct it, but once it moves beyond the spell''s area, it resumes its flow based on the terrain conditions. The water continues to move in the direction you chose until the spell ends or you choose a different effect.

***Whirlpool.*** This effect requires a body of water at least 50 feet square and 25 feet deep. You cause a whirlpool to form in the center of the area. The whirlpool forms a vortex that is 5 feet wide at the base, up to 50 feet wide at the top, and 25 feet tall. Any creature or object in the water and within 25 feet of the vortex is pulled 10 feet toward it. A creature can swim away from the vortex by making a Strength (Athletics) check against your spell save DC.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-control-water-2', 'srd', NULL, 'Spell: Control Water (3)', 'When a creature enters the vortex for the first time on a turn or starts its turn there, it must make a strength saving throw. On a failed save, the creature takes 2d8 bludgeoning damage and is caught in the vortex until the spell ends. On a successful save, the creature takes half damage, and isn''t caught in the vortex. A creature caught in the vortex can use its action to try to swim away from the vortex as described above, but has disadvantage on the Strength (Athletics) check to do so.

The first time each turn that an object enters the vortex, the object takes 2d8 bludgeoning damage; this damage occurs each round it remains in the vortex.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-control-weather-0', 'srd', NULL, 'Spell: Control Weather', 'Control Weather. Level 8 Transmutation. Casting time: 10 minutes. Range: Self. Duration: Up to 8 hours. You take control of the weather within 5 miles of you for the duration. You must be outdoors to cast this spell. Moving to a place where you don''t have a clear path to the sky ends the spell early.

When you cast the spell, you change the current weather conditions, which are determined by the GM based on the climate and season. You can change precipitation, temperature, and wind. It takes 1d4 x 10 minutes for the new conditions to take effect. Once they do so, you can change the conditions again. When the spell ends, the weather gradually returns to normal.

When you change the weather conditions, find a current condition on the following tables and change its stage by one, up or down. When changing the wind, you can change its direction.

##### Precipitation

| Stage | Condition |

|---|---|

| 1 | Clear |

| 2 | Light clouds |

| 3 | Overcast or ground fog |

| 4 | Rain, hail, or snow |

| 5 | Torrential rain, driving hail, or blizzard |

##### Temperature

| Stage | Condition |

|---|---|

| 1 | Unbearable heat |

| 2 | Hot |

| 3 | Warm |

| 4 | Cool |

| 5 | Cold |

| 6 | Arctic cold |

##### Wind

| Stage | Condition |

|---|---|

| 1 | Calm |

| 2 | Moderate wind |

| 3 | Strong wind |

| 4 | Gale |

| 5 | Storm |', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-counterspell-0', 'srd', NULL, 'Spell: Counterspell', 'Counterspell. Level 3 Abjuration. Casting time: 1 reaction. Range: 60 feet. Duration: Instantaneous. You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spell''s level. On a success, the creature''s spell fails and has no effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-create-food-and-water-0', 'srd', NULL, 'Spell: Create Food and Water', 'Create Food and Water. Level 3 Conjuration. Casting time: 1 action. Range: 30 feet. Duration: Instantaneous. You create 45 pounds of food and 30 gallons of water on the ground or in containers within range, enough to sustain up to fifteen humanoids or five steeds for 24 hours. The food is bland but nourishing, and spoils if uneaten after 24 hours. The water is clean and doesn''t go bad.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-create-undead-0', 'srd', NULL, 'Spell: Create Undead', 'Create Undead. Level 6 Necromancy. Casting time: 1 minute. Range: 10 feet. Duration: Instantaneous. You can cast this spell only at night. Choose up to three corpses of Medium or Small humanoids within range. Each corpse becomes a ghoul under your control. (The GM has game statistics for these creatures.)

As a bonus action on each of your turns, you can mentally command any creature you animated with this spell if the creature is within 120 feet of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until its task is complete.

The creature is under your control for 24 hours, after which it stops obeying any command you have given it. To maintain control of the creature for another 24 hours, you must cast this spell on the creature before the current 24-hour period ends. This use of the spell reasserts your control over up to three creatures you have animated with this spell, rather than animating new ones.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-create-or-destroy-water-0', 'srd', NULL, 'Spell: Create or Destroy Water', 'Create or Destroy Water. Level 1 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Instantaneous. You either create or destroy water.

***Create Water.*** You create up to 10 gallons of clean water within range in an open container. Alternatively, the water falls as rain in a 30-foot cube within range.

***Destroy Water.*** You destroy up to 10 gallons of water in an open container within range. Alternatively, you destroy fog in a 30-foot cube within range.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-creation-0', 'srd', NULL, 'Spell: Creation', 'Creation. Level 5 Illusion. Casting time: 1 minute. Range: 30 feet. Duration: Special. You pull wisps of shadow material from the Shadowfell to create a nonliving object of vegetable matter within range: soft goods, rope, wood, or something similar. You can also use this spell to create mineral objects such as stone, crystal, or metal. The object created must be no larger than a 5-foot cube, and the object must be of a form and material that you have seen before.

The duration depends on the object''s material. If the object is composed of multiple materials, use the shortest duration.

| Material | Duration |

|---|---|

| Vegetable matter | 1 day |

| Stone or crystal | 12 hours |

| Precious metals | 1 hour |

| Gems | 10 minutes |

| Adamantine or mithral | 1 minute |

Using any material created by this spell as another spell''s material component causes that spell to fail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-cure-wounds-0', 'srd', NULL, 'Spell: Cure Wounds', 'Cure Wounds. Level 1 Evocation. Casting time: 1 action. Range: Touch. Duration: Instantaneous. A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dancing-lights-0', 'srd', NULL, 'Spell: Dancing Lights', 'Dancing Lights. Cantrip Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. You create up to four torch-sized lights within range, making them appear as torches, lanterns, or glowing orbs that hover in the air for the duration. You can also combine the four lights into one glowing vaguely humanoid form of Medium size. Whichever form you choose, each light sheds dim light in a 10-foot radius.

As a bonus action on your turn, you can move the lights up to 60 feet to a new spot within range. A light must be within 20 feet of another light created by this spell, and a light winks out if it exceeds the spell''s range.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-darkness-0', 'srd', NULL, 'Spell: Darkness', 'Darkness. Level 2 Evocation. Casting time: 1 action. Range: 60 feet. Duration: Up to 10 minutes. Magical darkness spreads from a point you choose within range to fill a 15-foot-radius sphere for the duration. The darkness spreads around corners. A creature with darkvision can''t see through this darkness, and nonmagical light can''t illuminate it.

If the point you choose is on an object you are holding or one that isn''t being worn or carried, the darkness emanates from the object and moves with it. Completely covering the source of the darkness with an opaque object, such as a bowl or a helm, blocks the darkness.

If any of this spell''s area overlaps with an area of light created by a spell of 2nd level or lower, the spell that created the light is dispelled.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-darkvision-0', 'srd', NULL, 'Spell: Darkvision', 'Darkvision. Level 2 Transmutation. Casting time: 1 action. Range: Touch. Duration: 8 hours. You touch a willing creature to grant it the ability to see in the dark. For the duration, that creature has darkvision out to a range of 60 feet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-daylight-0', 'srd', NULL, 'Spell: Daylight', 'Daylight. Level 3 Evocation. Casting time: 1 action. Range: 60 feet. Duration: 1 hour. A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet.

If you chose a point on an object you are holding or one that isn''t being worn or carried, the light shines from the object and moves with it. Completely covering the affected object with an opaque object, such as a bowl or a helm, blocks the light.

If any of this spell''s area overlaps with an area of darkness created by a spell of 3rd level or lower, the spell that created the darkness is dispelled.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-death-ward-0', 'srd', NULL, 'Spell: Death Ward', 'Death Ward. Level 4 Abjuration. Casting time: 1 action. Range: Touch. Duration: 8 hours. You touch a creature and grant it a measure of protection from death.

The first time the target would drop to 0 hit points as a result of taking damage, the target instead drops to 1 hit point, and the spell ends.

If the spell is still in effect when the target is subjected to an effect that would kill it instantaneously without dealing damage, that effect is instead negated against the target, and the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-delayed-blast-fireball-0', 'srd', NULL, 'Spell: Delayed Blast Fireball', 'Delayed Blast Fireball. Level 7 Evocation. Casting time: 1 action. Range: 150 feet. Duration: Up to 1 minute. A beam of yellow light flashes from your pointing finger, then condenses to linger at a chosen point within range as a glowing bead for the duration. When the spell ends, either because your concentration is broken or because you decide to end it, the bead blossoms with a low roar into an explosion of flame that spreads around corners. Each creature in a 20-foot-radius sphere centered on that point must make a dexterity saving throw. A creature takes fire damage equal to the total accumulated damage on a failed save, or half as much damage on a successful one.

The spell''s base damage is 12d6. If at the end of your turn the bead has not yet detonated, the damage increases by 1d6.

If the glowing bead is touched before the interval has expired, the creature touching it must make a dexterity saving throw. On a failed save, the spell ends immediately, causing the bead to erupt in flame. On a successful save, the creature can throw the bead up to 40 feet. When it strikes a creature or a solid object, the spell ends, and the bead explodes.

The fire damages objects in the area and ignites flammable objects that aren''t being worn or carried.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-demiplane-0', 'srd', NULL, 'Spell: Demiplane', 'Demiplane. Level 8 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: 1 hour. You create a shadowy door on a flat solid surface that you can see within range. The door is large enough to allow Medium creatures to pass through unhindered. When opened, the door leads to a demiplane that appears to be an empty room 30 feet in each dimension, made of wood or stone. When the spell ends, the door disappears, and any creatures or objects inside the demiplane remain trapped there, as the door also disappears from the other side.

Each time you cast this spell, you can create a new demiplane, or have the shadowy door connect to a demiplane you created with a previous casting of this spell. Additionally, if you know the nature and contents of a demiplane created by a casting of this spell by another creature, you can have the shadowy door connect to its demiplane instead.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-detect-evil-and-good-0', 'srd', NULL, 'Spell: Detect Evil and Good', 'Detect Evil and Good. Level 1 Divination. Casting time: 1 action. Range: Self. Duration: Up to 10 minutes. For the duration, you know if there is an aberration, celestial, elemental, fey, fiend, or undead within 30 feet of you, as well as where the creature is located. Similarly, you know if there is a place or object within 30 feet of you that has been magically consecrated or desecrated.

The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-detect-magic-0', 'srd', NULL, 'Spell: Detect Magic', 'Detect Magic. Level 1 Divination. Casting time: 1 action. Range: Self. Duration: Up to 10 minutes. For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.

The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-detect-poison-and-disease-0', 'srd', NULL, 'Spell: Detect Poison and Disease', 'Detect Poison and Disease. Level 1 Divination. Casting time: 1 action. Range: Self. Duration: Up to 10 minutes. For the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. You also identify the kind of poison, poisonous creature, or disease in each case.

The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-detect-thoughts-0', 'srd', NULL, 'Spell: Detect Thoughts (1)', 'Detect Thoughts. Level 2 Divination. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. For the duration, you can read the thoughts of certain creatures. When you cast the spell and as your action on each turn until the spell ends, you can focus your mind on any one creature that you can see within 30 feet of you. If the creature you choose has an Intelligence of 3 or lower or doesn''t speak any language, the creature is unaffected.

You initially learn the surface thoughts of the creature - what is most on its mind in that moment. As an action, you can either shift your attention to another creature''s thoughts or attempt to probe deeper into the same creature''s mind. If you probe deeper, the target must make a Wisdom saving throw. If it fails, you gain insight into its reasoning (if any), its emotional state, and something that looms large in its mind (such as something it worries over, loves, or hates). If it succeeds, the spell ends. Either way, the target knows that you are probing into its mind, and unless you shift your attention to another creature''s thoughts, the creature can use its action on its turn to make an Intelligence check contested by your Intelligence check; if it succeeds, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-detect-thoughts-1', 'srd', NULL, 'Spell: Detect Thoughts (2)', 'Questions verbally directed at the target creature naturally shape the course of its thoughts, so this spell is particularly effective as part of an interrogation.

You can also use this spell to detect the presence of thinking creatures you can''t see. When you cast the spell or as your action during the duration, you can search for thoughts within 30 feet of you. The spell can penetrate barriers, but 2 feet of rock, 2 inches of any metal other than lead, or a thin sheet of lead blocks you. You can''t detect a creature with an Intelligence of 3 or lower or one that doesn''t speak any language.

Once you detect the presence of a creature in this way, you can read its thoughts for the rest of the duration as described above, even if you can''t see it, but it must still be within range.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dimension-door-0', 'srd', NULL, 'Spell: Dimension Door', 'Dimension Door. Level 4 Conjuration. Casting time: 1 action. Range: 500 feet. Duration: Instantaneous. You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as "200 feet straight downward" or "upward to the northwest at a 45-degree angle, 300 feet."

You can bring along objects as long as their weight doesn''t exceed what you can carry. You can also bring one willing creature of your size or smaller who is carrying gear up to its carrying capacity. The creature must be within 5 feet of you when you cast this spell.

If you would arrive in a place already occupied by an object or a creature, you and any creature traveling with you each take 4d6 force damage, and the spell fails to teleport you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-disguise-self-0', 'srd', NULL, 'Spell: Disguise Self', 'Disguise Self. Level 1 Illusion. Casting time: 1 action. Range: Self. Duration: 1 hour. You make yourself--including your clothing, armor, weapons, and other belongings on your person--look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can''t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you.

The changes wrought by this spell fail to hold up to physical inspection. For example, if you use this spell to add a hat to your outfit, objects pass through the hat, and anyone who touches it would feel nothing or would feel your head and hair. If you use this spell to appear thinner than you are, the hand of someone who reaches out to touch you would bump into you while it was seemingly still in midair.

To discern that you are disguised, a creature can use its action to inspect your appearance and must succeed on an Intelligence (Investigation) check against your spell save DC.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-disintegrate-0', 'srd', NULL, 'Spell: Disintegrate', 'Disintegrate. Level 6 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. A thin green ray springs from your pointing finger to a target that you can see within range. The target can be a creature, an object, or a creation of magical force, such as the wall created by wall of force.

A creature targeted by this spell must make a dexterity saving throw. On a failed save, the target takes 10d6 + 40 force damage. If this damage reduces the target to 0 hit points, it is disintegrated.

A disintegrated creature and everything it is wearing and carrying, except magic items, are reduced to a pile of fine gray dust. The creature can be restored to life only by means of a true resurrection or a wish spell.

This spell automatically disintegrates a Large or smaller nonmagical object or a creation of magical force. If the target is a Huge or larger object or creation of force, this spell disintegrates a 10-foot-cube portion of it. A magic item is unaffected by this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dispel-evil-and-good-0', 'srd', NULL, 'Spell: Dispel Evil and Good', 'Dispel Evil and Good. Level 5 Abjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. Shimmering energy surrounds and protects you from fey, undead, and creatures originating from beyond the Material Plane. For the duration, celestials, elementals, fey, fiends, and undead have disadvantage on attack rolls against you.

You can end the spell early by using either of the following special functions.

***Break Enchantment.*** As your action, you touch a creature you can reach that is charmed, frightened, or possessed by a celestial, an elemental, a fey, a fiend, or an undead. The creature you touch is no longer charmed, frightened, or possessed by such creatures.

***Dismissal.*** As your action, make a melee spell attack against a celestial, an elemental, a fey, a fiend, or an undead you can reach. On a hit, you attempt to drive the creature back to its home plane. The creature must succeed on a charisma saving throw or be sent back to its home plane (if it isn''t there already). If they aren''t on their home plane, undead are sent to the Shadowfell, and fey are sent to the Feywild.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dispel-magic-0', 'srd', NULL, 'Spell: Dispel Magic', 'Dispel Magic. Level 3 Abjuration. Casting time: 1 action. Range: 120 feet. Duration: Instantaneous. Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell''s level. On a successful check, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-divination-0', 'srd', NULL, 'Spell: Divination', 'Divination. Level 4 Divination. Casting time: 1 action. Range: Self. Duration: Instantaneous. Your magic and an offering put you in contact with a god or a god''s servants. You ask a single question concerning a specific goal, event, or activity to occur within 7 days. The GM offers a truthful reply. The reply might be a short phrase, a cryptic rhyme, or an omen.

The spell doesn''t take into account any possible circumstances that might change the outcome, such as the casting of additional spells or the loss or gain of a companion.

If you cast the spell two or more times before finishing your next long rest, there is a cumulative 25 percent chance for each casting after the first that you get a random reading. The GM makes this roll in secret.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-divine-favor-0', 'srd', NULL, 'Spell: Divine Favor', 'Divine Favor. Level 1 Evocation. Casting time: 1 bonus action. Range: Self. Duration: Up to 1 minute. Your prayer empowers you with divine radiance. Until the spell ends, your weapon attacks deal an extra 1d4 radiant damage on a hit.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-divine-word-0', 'srd', NULL, 'Spell: Divine Word', 'Divine Word. Level 7 Evocation. Casting time: 1 bonus action. Range: 30 feet. Duration: Instantaneous. You utter a divine word, imbued with the power that shaped the world at the dawn of creation. Choose any number of creatures you can see within range. Each creature that can hear you must make a Charisma saving throw. On a failed save, a creature suffers an effect based on its current hit points:

- 50 hit points or fewer: deafened for 1 minute

- 40 hit points or fewer: deafened and blinded for 10 minutes

- 30 hit points or fewer: blinded, deafened, and stunned for 1 hour

- 20 hit points or fewer: killed instantly

Regardless of its current hit points, a celestial, an elemental, a fey, or a fiend that fails its save is forced back to its plane of origin (if it isn''t there already) and can''t return to your current plane for 24 hours by any means short of a wish spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dominate-beast-0', 'srd', NULL, 'Spell: Dominate Beast', 'Dominate Beast. Level 4 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You attempt to beguile a creature that you can see within range. It must succeed on a wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.

While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as "Attack that creature," "Run over there," or "Fetch that object." If the creature completes the order and doesn''t receive further direction from you, it defends and preserves itself to the best of its ability.

You can use your action to take total and precise control of the target. Until the end of your next turn, the creature takes only the actions you choose, and doesn''t do anything that you don''t allow it to do. During this time, you can also cause the creature to use a reaction, but this requires you to use your own reaction as well. Each time the target takes damage, it makes a new wisdom saving throw against the spell. If the saving throw succeeds, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dominate-monster-0', 'srd', NULL, 'Spell: Dominate Monster', 'Dominate Monster. Level 8 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 hour. You attempt to beguile a creature that you can see within range. It must succeed on a wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.

While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as "Attack that creature," "Run over there," or "Fetch that object." If the creature completes the order and doesn''t receive further direction from you, it defends and preserves itself to the best of its ability.

You can use your action to take total and precise control of the target. Until the end of your next turn, the creature takes only the actions you choose, and doesn''t do anything that you don''t allow it to do. During this time, you can also cause the creature to use a reaction, but this requires you to use your own reaction as well.

Each time the target takes damage, it makes a new wisdom saving throw against the spell. If the saving throw succeeds, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dominate-person-0', 'srd', NULL, 'Spell: Dominate Person', 'Dominate Person. Level 5 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You attempt to beguile a humanoid that you can see within range. It must succeed on a wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.

While the target is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as "Attack that creature," "Run over there," or "Fetch that object." If the creature completes the order and doesn''t receive further direction from you, it defends and preserves itself to the best of its ability.

You can use your action to take total and precise control of the target. Until the end of your next turn, the creature takes only the actions you choose, and doesn''t do anything that you don''t allow it to do. During this time you can also cause the creature to use a reaction, but this requires you to use your own reaction as well.

Each time the target takes damage, it makes a new wisdom saving throw against the spell. If the saving throw succeeds, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dream-0', 'srd', NULL, 'Spell: Dream (1)', 'Dream. Level 5 Illusion. Casting time: 1 minute. Range: Special. Duration: 8 hours. This spell shapes a creature''s dreams. Choose a creature known to you as the target of this spell. The target must be on the same plane of existence as you. Creatures that don''t sleep, such as elves, can''t be contacted by this spell. You, or a willing creature you touch, enters a trance state, acting as a messenger.

While in the trance, the messenger is aware of his or her surroundings, but can''t take actions or move.

If the target is asleep, the messenger appears in the target''s dreams and can converse with the target as long as it remains asleep, through the duration of the spell. The messenger can also shape the environment of the dream, creating landscapes, objects, and other images. The messenger can emerge from the trance at any time, ending the effect of the spell early. The target recalls the dream perfectly upon waking. If the target is awake when you cast the spell, the messenger knows it, and can either end the trance (and the spell) or wait for the target to fall asleep, at which point the messenger appears in the target''s dreams.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-dream-1', 'srd', NULL, 'Spell: Dream (2)', 'You can make the messenger appear monstrous and terrifying to the target. If you do, the messenger can deliver a message of no more than ten words and then the target must make a wisdom saving throw. On a failed save, echoes of the phantasmal monstrosity spawn a nightmare that lasts the duration of the target''s sleep and prevents the target from gaining any benefit from that rest. In addition, when the target wakes up, it takes 3d6 psychic damage.

If you have a body part, lock of hair, clipping from a nail, or similar portion of the target''s body, the target makes its saving throw with disadvantage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-druidcraft-0', 'srd', NULL, 'Spell: Druidcraft', 'Druidcraft. Cantrip Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Instantaneous. Whispering to the spirits of nature, you create one of the following effects within ''range'':

- You create a tiny, harmless sensory effect that predicts what the weather will be at your location for the next 24 hours. The effect might manifest as a golden orb for clear skies, a cloud for rain, falling snowflakes for snow, and so on. This effect persists for 1 round.

- You instantly make a flower bloom, a seed pod open, or a leaf bud bloom.

- You create an instantaneous, harmless sensory effect, such as falling leaves, a puff of wind, the sound of a small animal, or the faint order of skunk. The effect must fit in a 5-foot cube.

- You instantly light or snuff out a candle, a torch, or a small campfire.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-earthquake-0', 'srd', NULL, 'Spell: Earthquake (1)', 'Earthquake. Level 8 Evocation. Casting time: 1 action. Range: 500 feet. Duration: Up to 1 minute. You create a seismic disturbance at a point on the ground that you can see within range. For the duration, an intense tremor rips through the ground in a 100-foot-radius circle centered on that point and shakes creatures and structures in contact with the ground in that area.

The ground in the area becomes difficult terrain. Each creature on the ground that is concentrating must make a constitution saving throw. On a failed save, the creature''s concentration is broken.

When you cast this spell and at the end of each turn you spend concentrating on it, each creature on the ground in the area must make a dexterity saving throw. On a failed save, the creature is knocked prone.

This spell can have additional effects depending on the terrain in the area, as determined by the GM.

Fissures. Fissures open throughout the spell''s area at the start of your next turn after you cast the spell. A total of 1d6 such fissures open in locations chosen by the GM. Each is 1d10 x 10 feet deep, 10 feet wide, and extends from one edge of the spell''s area to the opposite side. A creature standing on a spot where a fissure opens must succeed on a dexterity saving throw or fall in. A creature that successfully saves moves with the fissure''s edge as it opens.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-earthquake-1', 'srd', NULL, 'Spell: Earthquake (2)', 'A fissure that opens beneath a structure causes it to automatically collapse (see below).

Structures. The tremor deals 50 bludgeoning damage to any structure in contact with the ground in the area when you cast the spell and at the start of each of your turns until the spell ends. If a structure drops to 0 hit points, it collapses and potentially damages nearby creatures. A creature within half the distance of a structure''s height must make a dexterity saving throw. On a failed save, the creature takes 5d6 bludgeoning damage, is knocked prone, and is buried in the rubble, requiring a DC 20 Strength (Athletics) check as an action to escape. The GM can adjust the DC higher or lower, depending on the nature of the rubble. On a successful save, the creature takes half as much damage and doesn''t fall prone or become buried.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-eldritch-blast-0', 'srd', NULL, 'Spell: Eldritch Blast', 'Eldritch Blast. Cantrip Evocation. Casting time: 1 action. Range: 120 feet. Duration: Instantaneous. A beam of crackling energy streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 force damage. The spell creates more than one beam when you reach higher levels: two beams at 5th level, three beams at 11th level, and four beams at 17th level. You can direct the beams at the same target or at different ones. Make a separate attack roll for each beam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-enhance-ability-0', 'srd', NULL, 'Spell: Enhance Ability', 'Enhance Ability. Level 2 Transmutation. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. You touch a creature and bestow upon it a magical enhancement. Choose one of the following effects; the target gains that effect until the spell ends.

***Bear''s Endurance.*** The target has advantage on constitution checks. It also gains 2d6 temporary hit points, which are lost when the spell ends.

***Bull''s Strength.*** The target has advantage on strength checks, and his or her carrying capacity doubles.

***Cat''s Grace.*** The target has advantage on dexterity checks. It also doesn''t take damage from falling 20 feet or less if it isn''t incapacitated.

***Eagle''s Splendor.*** The target has advantage on Charisma checks.

***Fox''s Cunning.*** The target has advantage on intelligence checks.

***Owl''s Wisdom.*** The target has advantage on wisdom checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-enlarge-reduce-0', 'srd', NULL, 'Spell: Enlarge/Reduce (1)', 'Enlarge/Reduce. Level 2 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. You cause a creature or an object you can see within range to grow larger or smaller for the duration. Choose either a creature or an object that is neither worn nor carried. If the target is unwilling, it can make a Constitution saving throw. On a success, the spell has no effect.

If the target is a creature, everything it is wearing and carrying changes size with it. Any item dropped by an affected creature returns to normal size at once.

***Enlarge.*** The target''s size doubles in all dimensions, and its weight is multiplied by eight. This growth increases its size by one category-from Medium to Large, for example. If there isn''t enough room for the target to double its size, the creature or object attains the maximum possible size in the space available. Until the spell ends, the target also has advantage on Strength checks and Strength saving throws. The target''s weapons also grow to match its new size. While these weapons are enlarged, the target''s attacks with them deal 1d4 extra damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-enlarge-reduce-1', 'srd', NULL, 'Spell: Enlarge/Reduce (2)', '***Reduce.*** The target''s size is halved in all dimensions, and its weight is reduced to one-eighth of normal. This reduction decreases its size by one category-from Medium to Small, for example. Until the spell ends, the target also has disadvantage on Strength checks and Strength saving throws. The target''s weapons also shrink to match its new size. While these weapons are reduced, the target''s attacks with them deal 1d4 less damage (this can''t reduce the damage below 1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-entangle-0', 'srd', NULL, 'Spell: Entangle', 'Entangle. Level 1 Conjuration. Casting time: 1 action. Range: 90 feet. Duration: Up to 1 minute. Grasping weeds and vines sprout from the ground in a 20-foot square starting form a point within range. For the duration, these plants turn the ground in the area into difficult terrain.

A creature in the area when you cast the spell must succeed on a strength saving throw or be restrained by the entangling plants until the spell ends. A creature restrained by the plants can use its action to make a Strength check against your spell save DC. On a success, it frees itself.

When the spell ends, the conjured plants wilt away.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-enthrall-0', 'srd', NULL, 'Spell: Enthrall', 'Enthrall. Level 2 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: 1 minute. You weave a distracting string of words, causing creatures of your choice that you can see within range and that can hear you to make a wisdom saving throw. Any creature that can''t be charmed succeeds on this saving throw automatically, and if you or your companions are fighting a creature, it has advantage on the save. On a failed save, the target has disadvantage on Wisdom (Perception) checks made to perceive any creature other than you until the spell ends or until the target can no longer hear you. The spell ends if you are incapacitated or can no longer speak.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-etherealness-0', 'srd', NULL, 'Spell: Etherealness (1)', 'Etherealness. Level 7 Transmutation. Casting time: 1 action. Range: Self. Duration: 8 hours. You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can''t see anything more than 60 feet away.

While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren''t on the Ethereal Plane can''t perceive you and can''t interact with you, unless a special ability or magic has given them the ability to do so.

You ignore all objects and effects that aren''t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from.

When the spell ends, you immediately return to the plane you originated from in the spot you currently occupy. If you occupy the same spot as a solid object or creature when this happens, you are immediately shunted to the nearest unoccupied space that you can occupy and take force damage equal to twice the number of feet you are moved.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-etherealness-1', 'srd', NULL, 'Spell: Etherealness (2)', 'This spell has no effect if you cast it while you are on the Ethereal Plane or a plane that doesn''t border it, such as one of the Outer Planes.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-expeditious-retreat-0', 'srd', NULL, 'Spell: Expeditious Retreat', 'Expeditious Retreat. Level 1 Transmutation. Casting time: 1 bonus action. Range: Self. Duration: Up to 10 minutes. This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-eyebite-0', 'srd', NULL, 'Spell: Eyebite', 'Eyebite. Level 6 Necromancy. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. For the spell''s duration, your eyes become an inky void imbued with dread power. One creature of your choice within 60 feet of you that you can see must succeed on a wisdom saving throw or be affected by one of the following effects of your choice for the duration. On each of your turns until the spell ends, you can use your action to target another creature but can''t target a creature again if it has succeeded on a saving throw against this casting of eyebite.

***Asleep.*** The target falls unconscious. It wakes up if it takes any damage or if another creature uses its action to shake the sleeper awake.

***Panicked.*** The target is frightened of you. On each of its turns, the frightened creature must take the Dash action and move away from you by the safest and shortest available route, unless there is nowhere to move. If the target moves to a place at least 60 feet away from you where it can no longer see you, this effect ends.

***Sickened.*** The target has disadvantage on attack rolls and ability checks. At the end of each of its turns, it can make another wisdom saving throw. If it succeeds, the effect ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fabricate-0', 'srd', NULL, 'Spell: Fabricate', 'Fabricate. Level 4 Transmutation. Casting time: 10 minutes. Range: 120 feet. Duration: Instantaneous. You convert raw materials into products of the same material. For example, you can fabricate a wooden bridge from a clump of trees, a rope from a patch of hemp, and clothes from flax or wool.

Choose raw materials that you can see within range. You can fabricate a Large or smaller object (contained within a 10-foot cube, or eight connected 5-foot cubes), given a sufficient quantity of raw material. If you are working with metal, stone, or another mineral substance, however, the fabricated object can be no larger than Medium (contained within a single 5-foot cube). The quality of objects made by the spell is commensurate with the quality of the raw materials.

Creatures or magic items can''t be created or transmuted by this spell. You also can''t use it to create items that ordinarily require a high degree of craftsmanship, such as jewelry, weapons, glass, or armor, unless you have proficiency with the type of artisan''s tools used to craft such objects.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-faerie-fire-0', 'srd', NULL, 'Spell: Faerie Fire', 'Faerie Fire. Level 1 Evocation. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. Each object in a 20-foot cube within range is outlined in blue, green, or violet light (your choice). Any creature in the area when the spell is cast is also outlined in light if it fails a dexterity saving throw. For the duration, objects and affected creatures shed dim light in a 10-foot radius.

Any attack roll against an affected creature or object has advantage if the attacker can see it, and the affected creature or object can''t benefit from being invisible.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-faithful-hound-0', 'srd', NULL, 'Spell: Faithful Hound', 'Faithful Hound. Level 4 Conjuration. Casting time: 1 action. Range: 30 feet. Duration: 8 hours. You conjure a phantom watchdog in an unoccupied space that you can see within range, where it remains for the duration, until you dismiss it as an action, or until you move more than 100 feet away from it.

The hound is invisible to all creatures except you and can''t be harmed. When a Small or larger creature comes within 30 feet of it without first speaking the password that you specify when you cast this spell, the hound starts barking loudly. The hound sees invisible creatures and can see into the Ethereal Plane. It ignores illusions.

At the start of each of your turns, the hound attempts to bite one creature within 5 feet of it that is hostile to you. The hound''s attack bonus is equal to your spellcasting ability modifier + your proficiency bonus. On a hit, it deals 4d8 piercing damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-false-life-0', 'srd', NULL, 'Spell: False Life', 'False Life. Level 1 Necromancy. Casting time: 1 action. Range: Self. Duration: 1 hour. Bolstering yourself with a necromantic facsimile of life, you gain 1d4 + 4 temporary hit points for the duration.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fear-0', 'srd', NULL, 'Spell: Fear', 'Fear. Level 3 Illusion. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. You project a phantasmal image of a creature''s worst fears. Each creature in a 30-foot cone must succeed on a wisdom saving throw or drop whatever it is holding and become frightened for the duration.

While frightened by this spell, a creature must take the Dash action and move away from you by the safest available route on each of its turns, unless there is nowhere to move. If the creature ends its turn in a location where it doesn''t have line of sight to you, the creature can make a wisdom saving throw. On a successful save, the spell ends for that creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-feather-fall-0', 'srd', NULL, 'Spell: Feather Fall', 'Feather Fall. Level 1 Transmutation. Casting time: 1 reaction. Range: 60 feet. Duration: 1 minute. Choose up to five falling creatures within range. A falling creature''s rate of descent slows to 60 feet per round until the spell ends. If the creature lands before the spell ends, it takes no falling damage and can land on its feet, and the spell ends for that creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-feeblemind-0', 'srd', NULL, 'Spell: Feeblemind', 'Feeblemind. Level 8 Enchantment. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. You blast the mind of a creature that you can see within range, attempting to shatter its intellect and personality. The target takes 4d6 psychic damage and must make an intelligence saving throw.

On a failed save, the creature''s Intelligence and Charisma scores become 1. The creature can''t cast spells, activate magic items, understand language, or communicate in any intelligible way. The creature can, however, identify its friends, follow them, and even protect them.

At the end of every 30 days, the creature can repeat its saving throw against this spell. If it succeeds on its saving throw, the spell ends.

The spell can also be ended by greater restoration, heal, or wish.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-find-familiar-0', 'srd', NULL, 'Spell: Find Familiar (1)', 'Find Familiar. Level 1 Conjuration. Casting time: 1 hour. Range: 10 feet. Duration: Instantaneous. You gain the service of a familiar, a spirit that takes an animal form you choose: bat, cat, crab, frog (toad), hawk, lizard, octopus, owl, poisonous snake, fish (quipper), rat, raven, sea horse, spider, or weasel. Appearing in an unoccupied space within range, the familiar has the statistics of the chosen form, though it is a celestial, fey, or fiend (your choice) instead of a beast.

Your familiar acts independently of you, but it always obeys your commands. In combat, it rolls its own initiative and acts on its own turn. A familiar can''t attack, but it can take other actions as normal.

When the familiar drops to 0 hit points, it disappears, leaving behind no physical form. It reappears after you cast this spell again.

While your familiar is within 100 feet of you, you can communicate with it telepathically. Additionally, as an action, you can see through your familiar''s eyes and hear what it hears until the start of your next turn, gaining the benefits of any special senses that the familiar has. During this time, you are deaf and blind with regard to your own senses.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-find-familiar-1', 'srd', NULL, 'Spell: Find Familiar (2)', 'As an action, you can temporarily dismiss your familiar. It disappears into a pocket dimension where it awaits your summons. Alternatively, you can dismiss it forever. As an action while it is temporarily dismissed, you can cause it to reappear in any unoccupied space within 30 feet of you.

You can''t have more than one familiar at a time. If you cast this spell while you already have a familiar, you instead cause it to adopt a new form. Choose one of the forms from the above list. Your familiar transforms into the chosen creature.

Finally, when you cast a spell with a range of touch, your familiar can deliver the spell as if it had cast the spell. Your familiar must be within 100 feet of you, and it must use its reaction to deliver the spell when you cast it. If the spell requires an attack roll, you use your action modifier for the roll.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-find-steed-0', 'srd', NULL, 'Spell: Find Steed (1)', 'Find Steed. Level 2 Conjuration. Casting time: 10 minutes. Range: 30 feet. Duration: Instantaneous. You summon a spirit that assumes the form of an unusually intelligent, strong, and loyal steed, creating a long-lasting bond with it. Appearing in an unoccupied space within range, the steed takes on a form that you choose, such as a warhorse, a pony, a camel, an elk, or a mastiff. (Your GM might allow other animals to be summoned as steeds.) The steed has the statistics of the chosen form, though it is a celestial, fey, or fiend (your choice) instead of its normal type. Additionally, if your steed has an Intelligence of 5 or less, its Intelligence becomes 6, and it gains the ability to understand one language of your choice that you speak.

Your steed serves you as a mount, both in combat and out, and you have an instinctive bond with it that allows you to fight as a seamless unit. While mounted on your steed, you can make any spell you cast that targets only you also target your steed.

When the steed drops to 0 hit points, it disappears, leaving behind no physical form. You can also dismiss your steed at any time as an action, causing it to disappear. In either case, casting this spell again summons the same steed, restored to its hit point maximum.

While your steed is within 1 mile of you, you can communicate with it telepathically.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-find-steed-1', 'srd', NULL, 'Spell: Find Steed (2)', 'You can''t have more than one steed bonded by this spell at a time. As an action, you can release the steed from its bond at any time, causing it to disappear.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-find-traps-0', 'srd', NULL, 'Spell: Find Traps', 'Find Traps. Level 2 Divination. Casting time: 1 action. Range: 120 feet. Duration: Instantaneous. You sense the presence of any trap within range that is within line of sight. A trap, for the purpose of this spell, includes anything that would inflict a sudden or unexpected effect you consider harmful or undesirable, which was specifically intended as such by its creator. Thus, the spell would sense an area affected by the alarm spell, a glyph of warding, or a mechanical pit trap, but it would not reveal a natural weakness in the floor, an unstable ceiling, or a hidden sinkhole.

This spell merely reveals that a trap is present. You don''t learn the location of each trap, but you do learn the general nature of the danger posed by a trap you sense.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-find-the-path-0', 'srd', NULL, 'Spell: Find the Path', 'Find the Path. Level 6 Divination. Casting time: 1 minute. Range: Self. Duration: Up to 24 hours. This spell allows you to find the shortest, most direct physical route to a specific fixed location that you are familiar with on the same plane of existence. If you name a destination on another plane of existence, a destination that moves (such as a mobile fortress), or a destination that isn''t specific (such as "a green dragon''s lair"), the spell fails.

For the duration, as long as you are on the same plane of existence as the destination, you know how far it is and in what direction it lies. While you are traveling there, whenever you are presented with a choice of paths along the way, you automatically determine which path is the shortest and most direct route (but not necessarily the safest route) to the destination.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-finger-of-death-0', 'srd', NULL, 'Spell: Finger of Death', 'Finger of Death. Level 7 Necromancy. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. You send negative energy coursing through a creature that you can see within range, causing it searing pain. The target must make a constitution saving throw. It takes 7d8 + 30 necrotic damage on a failed save, or half as much damage on a successful one.

A humanoid killed by this spell rises at the start of your next turn as a zombie that is permanently under your command, following your verbal orders to the best of its ability.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fire-bolt-0', 'srd', NULL, 'Spell: Fire Bolt', 'Fire Bolt. Cantrip Evocation. Casting time: 1 action. Range: 120 feet. Duration: Instantaneous. You hurl a mote of fire at a creature or object within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 fire damage. A flammable object hit by this spell ignites if it isn''t being worn or carried.

This spell''s damage increases by 1d10 when you reach 5th level (2d10), 11th level (3d10), and 17th level (4d10).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fire-shield-0', 'srd', NULL, 'Spell: Fire Shield', 'Fire Shield. Level 4 Evocation. Casting time: 1 action. Range: Self. Duration: 10 minutes. Thin and vaporous flame surround your body for the duration of the spell, radiating a bright light bright light in a 10-foot radius and dim light for an additional 10 feet. You can end the spell using an action to make it disappear.

The flames are around you a heat shield or cold, your choice. The heat shield gives you cold damage resistance and the cold resistance to fire damage.

In addition, whenever a creature within 5 feet of you hits you with a melee attack, flames spring from the shield. The attacker then suffers 2d8 points of fire damage or cold, depending on the model.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fire-storm-0', 'srd', NULL, 'Spell: Fire Storm', 'Fire Storm. Level 7 Evocation. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. A storm made up of sheets of roaring flame appears in a location you choose within range. The area of the storm consists of up to ten 10-foot cubes, which you can arrange as you wish. Each cube must have at least one face adjacent to the face of another cube. Each creature in the area must make a dexterity saving throw. It takes 7d10 fire damage on a failed save, or half as much damage on a successful one.

The fire damages objects in the area and ignites flammable objects that aren''t being worn or carried. If you choose, plant life in the area is unaffected by this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fireball-0', 'srd', NULL, 'Spell: Fireball', 'Fireball. Level 3 Evocation. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame. Each creature in a 20-foot-radius sphere centered on that point must make a dexterity saving throw. A target takes 8d6 fire damage on a failed save, or half as much damage on a successful one.

The fire spreads around corners. It ignites flammable objects in the area that aren''t being worn or carried.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-flame-blade-0', 'srd', NULL, 'Spell: Flame Blade', 'Flame Blade. Level 2 Evocation. Casting time: 1 bonus action. Range: Self. Duration: Up to 10 minutes. You evoke a fiery blade in your free hand. The blade is similar in size and shape to a scimitar, and it lasts for the duration. If you let go of the blade, it disappears, but you can evoke the blade again as a bonus action.

You can use your action to make a melee spell attack with the fiery blade. On a hit, the target takes 3d6 fire damage.

The flaming blade sheds bright light in a 10-foot radius and dim light for an additional 10 feet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-flame-strike-0', 'srd', NULL, 'Spell: Flame Strike', 'Flame Strike. Level 5 Evocation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. A vertical column of divine fire roars down from the heavens in a location you specify. Each creature in a 10-foot-radius, 40-foot-high cylinder centered on a point within range must make a dexterity saving throw. A creature takes 4d6 fire damage and 4d6 radiant damage on a failed save, or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-flaming-sphere-0', 'srd', NULL, 'Spell: Flaming Sphere', 'Flaming Sphere. Level 2 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. A 5-foot-diameter sphere of fire appears in an unoccupied space of your choice within range and lasts for the duration. Any creature that ends its turn within 5 feet of the sphere must make a dexterity saving throw. The creature takes 2d6 fire damage on a failed save, or half as much damage on a successful one.

As a bonus action, you can move the sphere up to 30 feet. If you ram the sphere into a creature, that creature must make the saving throw against the sphere''s damage, and the sphere stops moving this turn.

When you move the sphere, you can direct it over barriers up to 5 feet tall and jump it across pits up to 10 feet wide. The sphere ignites flammable objects not being worn or carried, and it sheds bright light in a 20-foot radius and dim light for an additional 20 feet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-flesh-to-stone-0', 'srd', NULL, 'Spell: Flesh to Stone', 'Flesh to Stone. Level 6 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You attempt to turn one creature that you can see within range into stone. If the target''s body is made of flesh, the creature must make a constitution saving throw. On a failed save, it is restrained as its flesh begins to harden. On a successful save, the creature isn''t affected.

A creature restrained by this spell must make another constitution saving throw at the end of each of its turns. If it successfully saves against this spell three times, the spell ends. If it fails its saves three times, it is turned to stone and subjected to the petrified condition for the duration. The successes and failures don''t need to be consecutive; keep track of both until the target collects three of a kind.

If the creature is physically broken while petrified, it suffers from similar deformities if it reverts to its original state.

If you maintain your concentration on this spell for the entire possible duration, the creature is turned to stone until the effect is removed.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-floating-disk-0', 'srd', NULL, 'Spell: Floating Disk', 'Floating Disk. Level 1 Conjuration. Casting time: 1 action. Range: 30 feet. Duration: 1 hour. This spell creates a circular, horizontal plane of force, 3 feet in diameter and 1 inch thick, that floats 3 feet above the ground in an unoccupied space of your choice that you can see within range. The disk remains for the duration, and can hold up to 500 pounds. If more weight is placed on it, the spell ends, and everything on the disk falls to the ground.

The disk is immobile while you are within 20 feet of it. If you move more than 20 feet away from it, the disk follows you so that it remains within 20 feet of you. If can move across uneven terrain, up or down stairs, slopes and the like, but it can''t cross an elevation change of 10 feet or more. For example, the disk can''t move across a 10-foot-deep pit, nor could it leave such a pit if it was created at the bottom.

If you move more than 100 feet away from the disk (typically because it can''t move around an obstacle to follow you), the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fly-0', 'srd', NULL, 'Spell: Fly', 'Fly. Level 3 Transmutation. Casting time: 1 action. Range: Touch. Duration: Up to 10 minutes. You touch a willing creature. The target gains a flying speed of 60 feet for the duration. When the spell ends, the target falls if it is still aloft, unless it can stop the fall.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-fog-cloud-0', 'srd', NULL, 'Spell: Fog Cloud', 'Fog Cloud. Level 1 Conjuration. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 hour. You create a 20-foot-radius sphere of fog centered on a point within range. The sphere spreads around corners, and its area is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-forbiddance-0', 'srd', NULL, 'Spell: Forbiddance', 'Forbiddance. Level 6 Abjuration. Casting time: 10 minutes. Range: Touch. Duration: 24 hours. You create a ward against magical travel that protects up to 40,000 square feet of floor space to a height of 30 feet above the floor. For the duration, creatures can''t teleport into the area or use portals, such as those created by the gate spell, to enter the area. The spell proofs the area against planar travel, and therefore prevents creatures from accessing the area by way of the Astral Plane, Ethereal Plane, Feywild, Shadowfell, or the plane shift spell.

In addition, the spell damages types of creatures that you choose when you cast it. Choose one or more of the following: celestials, elementals, fey, fiends, and undead. When a chosen creature enters the spell''s area for the first time on a turn or starts its turn there, the creature takes 5d10 radiant or necrotic damage (your choice when you cast this spell).

When you cast this spell, you can designate a password. A creature that speaks the password as it enters the area takes no damage from the spell.

The spell''s area can''t overlap with the area of another forbiddance spell. If you cast forbiddance every day for 30 days in the same location, the spell lasts until it is dispelled, and the material components are consumed on the last casting.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-forcecage-0', 'srd', NULL, 'Spell: Forcecage', 'Forcecage. Level 7 Evocation. Casting time: 1 action. Range: 100 feet. Duration: 1 hour. An immobile, invisible, cube-shaped prison composed of magical force springs into existence around an area you choose within range. The prison can be a cage or a solid box, as you choose.

A prison in the shape of a cage can be up to 20 feet on a side and is made from 1/2-inch diameter bars spaced 1/2 inch apart.

A prison in the shape of a box can be up to 10 feet on a side, creating a solid barrier that prevents any matter from passing through it and blocking any spells cast into or out from the area.

When you cast the spell, any creature that is completely inside the cage''s area is trapped. Creatures only partially within the area, or those too large to fit inside the area, are pushed away from the center of the area until they are completely outside the area.

A creature inside the cage can''t leave it by nonmagical means. If the creature tries to use teleportation or interplanar travel to leave the cage, it must first make a charisma saving throw. On a success, the creature can use that magic to exit the cage. On a failure, the creature can''t exit the cage and wastes the use of the spell or effect. The cage also extends into the Ethereal Plane, blocking ethereal travel.

This spell can''t be dispelled by dispel magic.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-foresight-0', 'srd', NULL, 'Spell: Foresight', 'Foresight. Level 9 Divination. Casting time: 1 minute. Range: Touch. Duration: 8 hours. You touch a willing creature and bestow a limited ability to see into the immediate future. For the duration, the target can''t be surprised and has advantage on attack rolls, ability checks, and saving throws. Additionally, other creatures have disadvantage on attack rolls against the target for the duration.

This spell immediately ends if you cast it again before its duration ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-freedom-of-movement-0', 'srd', NULL, 'Spell: Freedom of Movement', 'Freedom of Movement. Level 4 Abjuration. Casting time: 1 action. Range: Touch. Duration: 1 hour. You touch a willing creature. For the duration, the target''s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target''s speed nor cause the target to be paralyzed or restrained.

The target can also spend 5 feet of movement to automatically escape from nonmagical restraints, such as manacles or a creature that has it grappled. Finally, being underwater imposes no penalties on the target''s movement or attacks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-freezing-sphere-0', 'srd', NULL, 'Spell: Freezing Sphere', 'Freezing Sphere. Level 6 Evocation. Casting time: 1 action. Range: 300 feet. Duration: Instantaneous. A frigid globe of cold energy streaks from your fingertips to a point of your choice within range, where it explodes in a 60-foot-radius sphere. Each creature within the area must make a constitution saving throw. On a failed save, a creature takes 10d6 cold damage. On a successful save, it takes half as much damage.

If the globe strikes a body of water or a liquid that is principally water (not including water-based creatures), it freezes the liquid to a depth of 6 inches over an area 30 feet square. This ice lasts for 1 minute. Creatures that were swimming on the surface of frozen water are trapped in the ice. A trapped creature can use an action to make a Strength check against your spell save DC to break free.

You can refrain from firing the globe after completing the spell, if you wish. A small globe about the size of a sling stone, cool to the touch, appears in your hand. At any time, you or a creature you give the globe to can throw the globe (to a range of 40 feet) or hurl it with a sling (to the sling''s normal range). It shatters on impact, with the same effect as the normal casting of the spell. You can also set the globe down without shattering it. After 1 minute, if the globe hasn''t already shattered, it explodes.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-gaseous-form-0', 'srd', NULL, 'Spell: Gaseous Form', 'Gaseous Form. Level 3 Transmutation. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. You transform a willing creature you touch, along with everything it''s wearing and carrying, into a misty cloud for the duration. The spell ends if the creature drops to 0 hit points. An incorporeal creature isn''t affected.

While in this form, the target''s only method of movement is a flying speed of 10 feet. The target can enter and occupy the space of another creature. The target has resistance to nonmagical damage, and it has advantage on Strength, Dexterity, and constitution saving throws. The target can pass through small holes, narrow openings, and even mere cracks, though it treats liquids as though they were solid surfaces. The target can''t fall and remains hovering in the air even when stunned or otherwise incapacitated.

While in the form of a misty cloud, the target can''t talk or manipulate objects, and any objects it was carrying or holding can''t be dropped, used, or otherwise interacted with. The target can''t attack or cast spells.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-gate-0', 'srd', NULL, 'Spell: Gate', 'Gate. Level 9 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. You conjure a portal linking an unoccupied space you can see within range to a precise location on a different plane of existence. The portal is a circular opening, which you can make 5 to 20 feet in diameter. You can orient the portal in any direction you choose. The portal lasts for the duration.

The portal has a front and a back on each plane where it appears. Travel through the portal is possible only by moving through its front. Anything that does so is instantly transported to the other plane, appearing in the unoccupied space nearest to the portal.

Deities and other planar rulers can prevent portals created by this spell from opening in their presence or anywhere within their domains.

When you cast this spell, you can speak the name of a specific creature (a pseudonym, title, or nickname doesn''t work). If that creature is on a plane other than the one you are on, the portal opens in the named creature''s immediate vicinity and draws the creature through it to the nearest unoccupied space on your side of the portal. You gain no special power over the creature, and it is free to act as the GM deems appropriate. It might leave, attack you, or help you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-geas-0', 'srd', NULL, 'Spell: Geas', 'Geas. Level 5 Enchantment. Casting time: 1 minute. Range: 60 feet. Duration: 30 days. You place a magical command on a creature that you can see within range, forcing it to carry out some service or refrain from some action or course of activity as you decide. If the creature can understand you, it must succeed on a wisdom saving throw or become charmed by you for the duration. While the creature is charmed by you, it takes 5d10 psychic damage each time it acts in a manner directly counter to your instructions, but no more than once each day. A creature that can''t understand you is unaffected by the spell.

You can issue any command you choose, short of an activity that would result in certain death. Should you issue a suicidal command, the spell ends.

You can end the spell early by using an action to dismiss it. A remove curse, greater restoration, or wish spell also ends it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-gentle-repose-0', 'srd', NULL, 'Spell: Gentle Repose', 'Gentle Repose. Level 2 Necromancy. Casting time: 1 action. Range: Touch. Duration: 10 days. You touch a corpse or other remains. For the duration, the target is protected from decay and can''t become undead.

The spell also effectively extends the time limit on raising the target from the dead, since days spent under the influence of this spell don''t count against the time limit of spells such as raise dead.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-giant-insect-0', 'srd', NULL, 'Spell: Giant Insect', 'Giant Insect. Level 4 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Up to 10 minutes. You transform up to ten centipedes, three spiders, five wasps, or one scorpion within range into giant versions of their natural forms for the duration. A centipede becomes a giant centipede, a spider becomes a giant spider, a wasp becomes a giant wasp, and a scorpion becomes a giant scorpion.

Each creature obeys your verbal commands, and in combat, they act on your turn each round. The GM has the statistics for these creatures and resolves their actions and movement.

A creature remains in its giant size for the duration, until it drops to 0 hit points, or until you use an action to dismiss the effect on it.

The GM might allow you to choose different targets. For example, if you transform a bee, its giant version might have the same statistics as a giant wasp.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-glibness-0', 'srd', NULL, 'Spell: Glibness', 'Glibness. Level 8 Transmutation. Casting time: 1 action. Range: Self. Duration: 1 hour. Until the spell ends, when you make a Charisma check, you can replace the number you roll with a 15. Additionally, no matter what you say, magic that would determine if you are telling the truth indicates that you are being truthful.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-globe-of-invulnerability-0', 'srd', NULL, 'Spell: Globe of Invulnerability', 'Globe of Invulnerability. Level 6 Abjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. An immobile, faintly shimmering barrier springs into existence in a 10-foot radius around you and remains for the duration.

Any spell of 5th level or lower cast from outside the barrier can''t affect creatures or objects within it, even if the spell is cast using a higher level spell slot. Such a spell can target creatures and objects within the barrier, but the spell has no effect on them. Similarly, the area within the barrier is excluded from the areas affected by such spells.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-glyph-of-warding-0', 'srd', NULL, 'Spell: Glyph of Warding (1)', 'Glyph of Warding. Level 3 Abjuration. Casting time: 1 hour. Range: Touch. Duration: Until dispelled. When you cast this spell, you inscribe a glyph that harms other creatures, either upon a surface (such as a table or a section of floor or wall) or within an object that can be closed (such as a book, a scroll, or a treasure chest) to conceal the glyph. If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered.

The glyph is nearly invisible and requires a successful Intelligence (Investigation) check against your spell save DC to be found.

You decide what triggers the glyph when you cast the spell. For glyphs inscribed on a surface, the most typical triggers include touching or standing on the glyph, removing another object covering the glyph, approaching within a certain distance of the glyph, or manipulating the object on which the glyph is inscribed. For glyphs inscribed within an object, the most common triggers include opening that object, approaching within a certain distance of the object, or seeing or reading the glyph. Once a glyph is triggered, this spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-glyph-of-warding-1', 'srd', NULL, 'Spell: Glyph of Warding (2)', 'You can further refine the trigger so the spell activates only under certain circumstances or according to physical characteristics (such as height or weight), creature kind (for example, the ward could be set to affect aberrations or drow), or alignment. You can also set conditions for creatures that don''t trigger the glyph, such as those who say a certain password.

When you inscribe the glyph, choose *explosive runes* or a *spell glyph*.

***Explosive Runes.*** When triggered, the glyph erupts with magical energy in a 20-foot-radius sphere centered on the glyph. The sphere spreads around corners. Each creature in the area must make a Dexterity saving throw. A creature takes 5d8 acid, cold, fire, lightning, or thunder damage on a failed saving throw (your choice when you create the glyph), or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-glyph-of-warding-2', 'srd', NULL, 'Spell: Glyph of Warding (3)', '***Spell Glyph.*** You can store a prepared spell of 3rd level or lower in the glyph by casting it as part of creating the glyph. The spell must target a single creature or an area. The spell being stored has no immediate effect when cast in this way. When the glyph is triggered, the stored spell is cast. If the spell has a target, it targets the creature that triggered the glyph. If the spell affects an area, the area is centered on that creature. If the spell summons hostile creatures or creates harmful objects or traps, they appear as close as possible to the intruder and attack it. If the spell requires concentration, it lasts until the end of its full duration.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-goodberry-0', 'srd', NULL, 'Spell: Goodberry', 'Goodberry. Level 1 Transmutation. Casting time: 1 action. Range: Touch. Duration: Instantaneous. Up to ten berries appear in your hand and are infused with magic for the duration. A creature can use its action to eat one berry. Eating a berry restores 1 hit point, and the berry provides enough nourishment to sustain a creature for a day.

The berries lose their potency if they have not been consumed within 24 hours of the casting of this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-grease-0', 'srd', NULL, 'Spell: Grease', 'Grease. Level 1 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: 1 minute. Slick grease covers the ground in a 10-foot square centered on a point within range and turns it into difficult terrain for the duration.

When the grease appears, each creature standing in its area must succeed on a dexterity saving throw or fall prone. A creature that enters the area or ends its turn there must also succeed on a dexterity saving throw or fall prone.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-greater-invisibility-0', 'srd', NULL, 'Spell: Greater Invisibility', 'Greater Invisibility. Level 4 Illusion. Casting time: 1 action. Range: Touch. Duration: Up to 1 minute. You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target''s person.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-greater-restoration-0', 'srd', NULL, 'Spell: Greater Restoration', 'Greater Restoration. Level 5 Abjuration. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You imbue a creature you touch with positive energy to undo a debilitating effect. You can reduce the target''s exhaustion level by one, or end one of the following effects on the target:

- One effect that charmed or petrified the target

- One curse, including the target''s attunement to a cursed magic item

- Any reduction to one of the target''s ability scores

- One effect reducing the target''s hit point maximum', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-guardian-of-faith-0', 'srd', NULL, 'Spell: Guardian of Faith', 'Guardian of Faith. Level 4 Conjuration. Casting time: 1 action. Range: 30 feet. Duration: 8 hours. A Large spectral guardian appears and hovers for the duration in an unoccupied space of your choice that you can see within range. The guardian occupies that space and is indistinct except for a gleaming sword and shield emblazoned with the symbol of your deity.

Any creature hostile to you that moves to a space within 10 feet of the guardian for the first time on a turn must succeed on a dexterity saving throw. The creature takes 20 radiant damage on a failed save, or half as much damage on a successful one. The guardian vanishes when it has dealt a total of 60 damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-guards-and-wards-0', 'srd', NULL, 'Spell: Guards and Wards (1)', 'Guards and Wards. Level 6 Abjuration. Casting time: 10 minutes. Range: Touch. Duration: 24 hours. You create a ward that protects up to 2,500 square feet of floor space (an area 50 feet square, or one hundred 5-foot squares or twenty-five 10-foot squares). The warded area can be up to 20 feet tall, and shaped as you desire. You can ward several stories of a stronghold by dividing the area among them, as long as you can walk into each contiguous area while you are casting the spell.

When you cast this spell, you can specify individuals that are unaffected by any or all of the effects that you choose. You can also specify a password that, when spoken aloud, makes the speaker immune to these effects.

Guards and wards creates the following effects within the warded area.

***Corridors.*** Fog fills all the warded corridors, making them heavily obscured. In addition, at each intersection or branching passage offering a choice of direction, there is a 50 percent chance that a creature other than you will believe it is going in the opposite direction from the one it chooses.

***Doors.*** All doors in the warded area are magically locked, as if sealed by an arcane lock spell. In addition, you can cover up to ten doors with an illusion (equivalent to the illusory object function of the minor illusion spell) to make them appear as plain sections of wall.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-guards-and-wards-1', 'srd', NULL, 'Spell: Guards and Wards (2)', '***Stairs.*** Webs fill all stairs in the warded area from top to bottom, as the web spell. These strands regrow in 10 minutes if they are burned or torn away while guards and wards lasts.

***Other Spell Effect.*** You can place your choice of one of the following magical effects within the warded area of the stronghold.

- Place dancing lights in four corridors. You can designate a simple program that the lights repeat as long as guards and wards lasts.

- Place magic mouth in two locations.

- Place stinking cloud in two locations. The vapors appear in the places you designate; they return within 10 minutes if dispersed by wind while guards and wards lasts.

- Place a constant gust of wind in one corridor or room.

- Place a suggestion in one location. You select an area of up to 5 feet square, and any creature that enters or passes through the area receives the suggestion mentally.

The whole warded area radiates magic. A dispel magic cast on a specific effect, if successful, removes only that effect.

You can create a permanently guarded and warded structure by casting this spell there every day for one year.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-guidance-0', 'srd', NULL, 'Spell: Guidance', 'Guidance. Cantrip Divination. Casting time: 1 action. Range: Touch. Duration: Up to 1 minute. You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one ability check of its choice. It can roll the die before or after making the ability check. The spell then ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-guiding-bolt-0', 'srd', NULL, 'Spell: Guiding Bolt', 'Guiding Bolt. Level 1 Evocation. Casting time: 1 action. Range: 120 feet. Duration: 1 round. A flash of light streaks toward a creature of your choice within range. Make a ranged spell attack against the target. On a hit, the target takes 4d6 radiant damage, and the next attack roll made against this target before the end of your next turn has advantage, thanks to the mystical dim light glittering on the target until then.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-gust-of-wind-0', 'srd', NULL, 'Spell: Gust of Wind', 'Gust of Wind. Level 2 Evocation. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. A line of strong wind 60 feet long and 10 feet wide blasts from you in a direction you choose for the spell''s duration. Each creature that starts its turn in the line must succeed on a strength saving throw or be pushed 15 feet away from you in a direction following the line.

Any creature in the line must spend 2 feet of movement for every 1 foot it moves when moving closer to you.

The gust disperses gas or vapor, and it extinguishes candles, torches, and similar unprotected flames in the area. It causes protected flames, such as those of lanterns, to dance wildly and has a 50 percent chance to extinguish them.

As a bonus action on each of your turns before the spell ends, you can change the direction in which the line blasts from you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hallow-0', 'srd', NULL, 'Spell: Hallow (1)', 'Hallow. Level 5 Evocation. Casting time: 24 hours. Range: Touch. Duration: Until dispelled. You touch a point and infuse an area around it with holy (or unholy) power. The area can have a radius up to 60 feet, and the spell fails if the radius includes an area already under the effect a hallow spell. The affected area is subject to the following effects.

First, celestials, elementals, fey, fiends, and undead can''t enter the area, nor can such creatures charm, frighten, or possess creatures within it. Any creature charmed, frightened, or possessed by such a creature is no longer charmed, frightened, or possessed upon entering the area. You can exclude one or more of those types of creatures from this effect.

Second, you can bind an extra effect to the area. Choose the effect from the following list, or choose an effect offered by the GM. Some of these effects apply to creatures in the area; you can designate whether the effect applies to all creatures, creatures that follow a specific deity or leader, or creatures of a specific sort, such as ores or trolls. When a creature that would be affected enters the spell''s area for the first time on a turn or starts its turn there, it can make a charisma saving throw. On a success, the creature ignores the extra effect until it leaves the area.

***Courage.*** Affected creatures can''t be frightened while in the area.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hallow-1', 'srd', NULL, 'Spell: Hallow (2)', '***Darkness.*** Darkness fills the area. Normal light, as well as magical light created by spells of a lower level than the slot you used to cast this spell, can''t illuminate the area.

***Daylight.*** Bright light fills the area. Magical darkness created by spells of a lower level than the slot you used to cast this spell can''t extinguish the light.

***Energy Protection.*** Affected creatures in the area have resistance to one damage type of your choice, except for bludgeoning, piercing, or slashing.

***Energy Vulnerability.*** Affected creatures in the area have vulnerability to one damage type of your choice, except for bludgeoning, piercing, or slashing.

***Everlasting Rest.*** Dead bodies interred in the area can''t be turned into undead.

***Extradimensional Interference.*** Affected creatures can''t move or travel using teleportation or by extradimensional or interplanar means.

***Fear.*** Affected creatures are frightened while in the area.

***Silence.*** No sound can emanate from within the area, and no sound can reach into it.

***Tongues.*** Affected creatures can communicate with any other creature in the area, even if they don''t share a common language.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hallucinatory-terrain-0', 'srd', NULL, 'Spell: Hallucinatory Terrain', 'Hallucinatory Terrain. Level 4 Illusion. Casting time: 10 minutes. Range: 300 feet. Duration: 24 hours. You make natural terrain in a 150-foot cube in range look, sound, and smell like some other sort of natural terrain. Thus, open fields or a road can be made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Manufactured structures, equipment, and creatures within the area aren''t changed in appearance.

The tactile characteristics of the terrain are unchanged, so creatures entering the area are likely to see through the illusion. If the difference isn''t obvious by touch, a creature carefully examining the illusion can attempt an Intelligence (Investigation) check against your spell save DC to disbelieve it. A creature who discerns the illusion for what it is, sees it as a vague image superimposed on the terrain.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-harm-0', 'srd', NULL, 'Spell: Harm', 'Harm. Level 6 Necromancy. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. You unleash a virulent disease on a creature that you can see within range. The target must make a constitution saving throw. On a failed save, it takes 14d6 necrotic damage, or half as much damage on a successful save. The damage can''t reduce the target''s hit points below 1. If the target fails the saving throw, its hit point maximum is reduced for 1 hour by an amount equal to the necrotic damage it took. Any effect that removes a disease allows a creature''s hit point maximum to return to normal before that time passes.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-haste-0', 'srd', NULL, 'Spell: Haste', 'Haste. Level 3 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. Choose a willing creature that you can see within range. Until the spell ends, the target''s speed is doubled, it gains a +2 bonus to AC, it has advantage on dexterity saving throws, and it gains an additional action on each of its turns. That action can be used only to take the Attack (one weapon attack only), Dash, Disengage, Hide, or Use an Object action.

When the spell ends, the target can''t move or take actions until after its next turn, as a wave of lethargy sweeps over it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-heal-0', 'srd', NULL, 'Spell: Heal', 'Heal. Level 6 Evocation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. Choose a creature that you can see within range. A surge of positive energy washes through the creature, causing it to regain 70 hit points. This spell also ends blindness, deafness, and any diseases affecting the target. This spell has no effect on constructs or undead.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-healing-word-0', 'srd', NULL, 'Spell: Healing Word', 'Healing Word. Level 1 Evocation. Casting time: 1 bonus action. Range: 60 feet. Duration: Instantaneous. A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-heat-metal-0', 'srd', NULL, 'Spell: Heat Metal', 'Heat Metal. Level 2 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. Choose a manufactured metal object, such as a metal weapon or a suit of heavy or medium metal armor, that you can see within range. You cause the object to glow red-hot. Any creature in physical contact with the object takes 2d8 fire damage when you cast the spell. Until the spell ends, you can use a bonus action on each of your subsequent turns to cause this damage again.

If a creature is holding or wearing the object and takes the damage from it, the creature must succeed on a constitution saving throw or drop the object if it can. If it doesn''t drop the object, it has disadvantage on attack rolls and ability checks until the start of your next turn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hellish-rebuke-0', 'srd', NULL, 'Spell: Hellish Rebuke', 'Hellish Rebuke. Level 1 Evocation. Casting time: 1 reaction. Range: 60 feet. Duration: Instantaneous. You point your finger, and the creature that damaged you is momentarily surrounded by hellish flames. The creature must make a dexterity saving throw. It takes 2d10 fire damage on a failed save, or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-heroes-feast-0', 'srd', NULL, 'Spell: Heroes'' Feast', 'Heroes'' Feast. Level 6 Conjuration. Casting time: 10 minutes. Range: 30 feet. Duration: Instantaneous. You bring forth a great feast, including magnificent food and drink. The feast takes 1 hour to consume and disappears at the end of that time, and the beneficial effects don''t set in until this hour is over. Up to twelve other creatures can partake of the feast.

A creature that partakes of the feast gains several benefits. The creature is cured of all diseases and poison, becomes immune to poison and being frightened, and makes all wisdom saving throws with advantage. Its hit point maximum also increases by 2d10, and it gains the same number of hit points. These benefits last for 24 hours.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-heroism-0', 'srd', NULL, 'Spell: Heroism', 'Heroism. Level 1 Enchantment. Casting time: 1 action. Range: Touch. Duration: Up to 1 minute. A willing creature you touch is imbued with bravery. Until the spell ends, the creature is immune to being frightened and gains temporary hit points equal to your spellcasting ability modifier at the start of each of its turns. When the spell ends, the target loses any remaining temporary hit points from this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hideous-laughter-0', 'srd', NULL, 'Spell: Hideous Laughter', 'Hideous Laughter. Level 1 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. A creature of your choice that you can see within range perceives everything as hilariously funny and falls into fits of laughter if this spell affects it. The target must succeed on a wisdom saving throw or fall prone, becoming incapacitated and unable to stand up for the duration. A creature with an Intelligence score of 4 or less isn''t affected.

At the end of each of its turns, and each time it takes damage, the target can make another wisdom saving throw. The target had advantage on the saving throw if it''s triggered by damage. On a success, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hold-monster-0', 'srd', NULL, 'Spell: Hold Monster', 'Hold Monster. Level 5 Enchantment. Casting time: 1 action. Range: 90 feet. Duration: Up to 1 minute. Choose a creature you can see and reach. The target must make a saving throw of Wisdom or be paralyzed for the duration of the spell. This spell has no effect against the undead. At the end of each round, the target can make a new saving throw of Wisdom. If successful, the spell ends for the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hold-person-0', 'srd', NULL, 'Spell: Hold Person', 'Hold Person. Level 2 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. Choose a humanoid that you can see within range. The target must succeed on a wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another wisdom saving throw. On a success, the spell ends on the target.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-holy-aura-0', 'srd', NULL, 'Spell: Holy Aura', 'Holy Aura. Level 8 Abjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. Divine light washes out from you and coalesces in a soft radiance in a 30-foot radius around you. Creatures of your choice in that radius when you cast this spell shed dim light in a 5-foot radius and have advantage on all saving throws, and other creatures have disadvantage on attack rolls against them until the spell ends. In addition, when a fiend or an undead hits an affected creature with a melee attack, the aura flashes with brilliant light. The attacker must succeed on a constitution saving throw or be blinded until the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hunters-mark-0', 'srd', NULL, 'Spell: Hunter''s Mark', 'Hunter''s Mark. Level 1 Divination. Casting time: 1 bonus action. Range: 90 feet. Duration: Up to 1 hour. You choose a creature you can see within range and mystically mark it as your quarry. Until the spell ends, you deal an extra 1d6 damage to the target whenever you hit it with a weapon attack, and you have advantage on any Wisdom (Perception) or Wisdom (Survival) check you make to find it. If the target drops to 0 hit points before this spell ends, you can use a bonus action on a subsequent turn of yours to mark a new creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-hypnotic-pattern-0', 'srd', NULL, 'Spell: Hypnotic Pattern', 'Hypnotic Pattern. Level 3 Illusion. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. You create a twisting pattern of colors that weaves through the air inside a 30-foot cube within range. The pattern appears for a moment and vanishes. Each creature in the area who sees the pattern must make a wisdom saving throw. On a failed save, the creature becomes charmed for the duration. While charmed by this spell, the creature is incapacitated and has a speed of 0.

The spell ends for an affected creature if it takes any damage or if someone else uses an action to shake the creature out of its stupor.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-ice-storm-0', 'srd', NULL, 'Spell: Ice Storm', 'Ice Storm. Level 4 Evocation. Casting time: 1 action. Range: 300 feet. Duration: Instantaneous. A hail of rock-hard ice pounds to the ground in a 20-foot-radius, 40-foot-high cylinder centered on a point within range. Each creature in the cylinder must make a dexterity saving throw. A creature takes 2d8 bludgeoning damage and 4d6 cold damage on a failed save, or half as much damage on a successful one.

Hailstones turn the storm''s area of effect into difficult terrain until the end of your next turn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-identify-0', 'srd', NULL, 'Spell: Identify', 'Identify. Level 1 Divination. Casting time: 1 minute. Range: Touch. Duration: Instantaneous. You choose one object that you must touch throughout the casting of the spell. If it is a magic item or some other magic-imbued object, you learn its properties and how to use them, whether it requires attunement to use, and how many charges it has, if any. You learn whether any spells are affecting the item and what they are. If the item was created by a spell, you learn which spell created it.

If you instead touch a creature throughout the casting, you learn what spells, if any, are currently affecting it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-illusory-script-0', 'srd', NULL, 'Spell: Illusory Script', 'Illusory Script. Level 1 Illusion. Casting time: 1 minute. Range: Touch. Duration: 10 days. You write on parchment, paper, or some other suitable writing material and imbue it with a potent illusion that lasts for the duration.

To you and any creatures you designate when you cast the spell, the writing appears normal, written in your hand, and conveys whatever meaning you intended when you wrote the text. To all others, the writing appears as if it were written in an unknown or magical script that is unintelligible. Alternatively, you can cause the writing to appear to be an entirely different message, written in a different hand and language, though the language must be one you know.

Should the spell be dispelled, the original script and the illusion both disappear.

A creature with truesight can read the hidden message.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-imprisonment-0', 'srd', NULL, 'Spell: Imprisonment (1)', 'Imprisonment. Level 9 Abjuration. Casting time: 1 minute. Range: 30 feet. Duration: Until dispelled. You create a magical restraint to hold a creature that you can see within range. The target must succeed on a wisdom saving throw or be bound by the spell; if it succeeds, it is immune to this spell if you cast it again. While affected by this spell, the creature doesn''t need to breathe, eat, or drink, and it doesn''t age. Divination spells can''t locate or perceive the target.

When you cast the spell, you choose one of the following forms of imprisonment.

***Burial.*** The target is entombed far beneath the earth in a sphere of magical force that is just large enough to contain the target. Nothing can pass through the sphere, nor can any creature teleport or use planar travel to get into or out of it.

The special component for this version of the spell is a small mithral orb.

***Chaining.*** Heavy chains, firmly rooted in the ground, hold the target in place. The target is restrained until the spell ends, and it can''t move or be moved by any means until then.

The special component for this version of the spell is a fine chain of precious metal.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-imprisonment-1', 'srd', NULL, 'Spell: Imprisonment (2)', '***Hedged Prison.*** The spell transports the target into a tiny demiplane that is warded against teleportation and planar travel. The demiplane can be a labyrinth, a cage, a tower, or any similar confined structure or area of your choice.

The special component for this version of the spell is a miniature representation of the prison made from jade.

***Minimus Containment.*** The target shrinks to a height of 1 inch and is imprisoned inside a gemstone or similar object. Light can pass through the gemstone normally (allowing the target to see out and other creatures to see in), but nothing else can pass through, even by means of teleportation or planar travel. The gemstone can''t be cut or broken while the spell remains in effect.

The special component for this version of the spell is a large, transparent gemstone, such as a corundum, diamond, or ruby.

***Slumber.*** The target falls asleep and can''t be awoken.

The special component for this version of the spell consists of rare soporific herbs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-imprisonment-2', 'srd', NULL, 'Spell: Imprisonment (3)', '***Ending the Spell.*** During the casting of the spell, in any of its versions, you can specify a condition that will cause the spell to end and release the target. The condition can be as specific or as elaborate as you choose, but the GM must agree that the condition is reasonable and has a likelihood of coming to pass. The conditions can be based on a creature''s name, identity, or deity but otherwise must be based on observable actions or qualities and not based on intangibles such as level, class, or hit points.

A dispel magic spell can end the spell only if it is cast as a 9th-level spell, targeting either the prison or the special component used to create it.

You can use a particular special component to create only one prison at a time. If you cast the spell again using the same component, the target of the first casting is immediately freed from its binding.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-incendiary-cloud-0', 'srd', NULL, 'Spell: Incendiary Cloud', 'Incendiary Cloud. Level 8 Conjuration. Casting time: 1 action. Range: 150 feet. Duration: Up to 1 minute. A swirling cloud of smoke shot through with white-hot embers appears in a 20-foot-radius sphere centered on a point within range. The cloud spreads around corners and is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.

When the cloud appears, each creature in it must make a dexterity saving throw. A creature takes 10d8 fire damage on a failed save, or half as much damage on a successful one. A creature must also make this saving throw when it enters the spell''s area for the first time on a turn or ends its turn there.

The cloud moves 10 feet directly away from you in a direction that you choose at the start of each of your turns.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-inflict-wounds-0', 'srd', NULL, 'Spell: Inflict Wounds', 'Inflict Wounds. Level 1 Necromancy. Casting time: 1 action. Range: Touch. Duration: Instantaneous. Make a melee spell attack against a creature you can reach. On a hit, the target takes 3d10 necrotic damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-insect-plague-0', 'srd', NULL, 'Spell: Insect Plague', 'Insect Plague. Level 5 Conjuration. Casting time: 1 action. Range: 300 feet. Duration: Up to 10 minutes. Swarming, biting locusts fill a 20-foot-radius sphere centered on a point you choose within range. The sphere spreads around corners. The sphere remains for the duration, and its area is lightly obscured. The sphere''s area is difficult terrain.

When the area appears, each creature in it must make a constitution saving throw. A creature takes 4d10 piercing damage on a failed save, or half as much damage on a successful one. A creature must also make this saving throw when it enters the spell''s area for the first time on a turn or ends its turn there.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-instant-summons-0', 'srd', NULL, 'Spell: Instant Summons', 'Instant Summons. Level 6 Conjuration. Casting time: 1 minute. Range: Touch. Duration: Until dispelled. You touch an object weighing 10 pounds or less whose longest dimension is 6 feet or less. The spell leaves an invisible mark on its surface and invisibly inscribes the name of the item on the sapphire you use as the material component. Each time you cast this spell, you must use a different sapphire.

At any time thereafter, you can use your action to speak the item''s name and crush the sapphire. The item instantly appears in your hand regardless of physical or planar distances, and the spell ends.

If another creature is holding or carrying the item, crushing the sapphire doesn''t transport the item to you, but instead you learn who the creature possessing the object is and roughly where that creature is located at that moment.

Dispel magic or a similar effect successfully applied to the sapphire ends this spell''s effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-invisibility-0', 'srd', NULL, 'Spell: Invisibility', 'Invisibility. Level 2 Illusion. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target''s person. The spell ends for a target that attacks or casts a spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-irresistible-dance-0', 'srd', NULL, 'Spell: Irresistible Dance', 'Irresistible Dance. Level 6 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. Choose one creature that you can see within range. The target begins a comic dance in place: shuffling, tapping its feet, and capering for the duration. Creatures that can''t be charmed are immune to this spell.

A dancing creature must use all its movement to dance without leaving its space and has disadvantage on dexterity saving throws and attack rolls. While the target is affected by this spell, other creatures have advantage on attack rolls against it. As an action, a dancing creature makes a wisdom saving throw to regain control of itself. On a successful save, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-jump-0', 'srd', NULL, 'Spell: Jump', 'Jump. Level 1 Transmutation. Casting time: 1 action. Range: Touch. Duration: 1 minute. You touch a creature. The creature''s jump distance is tripled until the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-knock-0', 'srd', NULL, 'Spell: Knock', 'Knock. Level 2 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. Choose an object that you can see within range. The object can be a door, a box, a chest, a set of manacles, a padlock, or another object that contains a mundane or magical means that prevents access.

A target that is held shut by a mundane lock or that is stuck or barred becomes unlocked, unstuck, or unbarred. If the object has multiple locks, only one of them is unlocked.

If you choose a target that is held shut with arcane lock, that spell is suppressed for 10 minutes, during which time the target can be opened and shut normally.

When you cast the spell, a loud knock, audible from as far away as 300 feet, emanates from the target object.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-legend-lore-0', 'srd', NULL, 'Spell: Legend Lore', 'Legend Lore. Level 5 Divination. Casting time: 10 minutes. Range: Self. Duration: Instantaneous. Name or describe a person, place, or object. The spell brings to your mind a brief summary of the significant lore about the thing you named. The lore might consist of current tales, forgotten stories, or even secret lore that has never been widely known. If the thing you named isn''t of legendary importance, you gain no information. The more information you already have about the thing, the more precise and detailed the information you receive is.

The information you learn is accurate but might be couched in figurative language. For example, if you have a mysterious magic axe on hand the spell might yield this information: "Woe to the evildoer whose hand touches the axe, for even the haft slices the hand of the evil ones. Only a true Child of Stone, lover and beloved of Moradin, may awaken the true powers of the axe, and only with the sacred word *Rudnogg* on the lips."', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-lesser-restoration-0', 'srd', NULL, 'Spell: Lesser Restoration', 'Lesser Restoration. Level 2 Abjuration. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-levitate-0', 'srd', NULL, 'Spell: Levitate', 'Levitate. Level 2 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Up to 10 minutes. One creature or object of your choice that you can see within range rises vertically, up to 20 feet, and remains suspended there for the duration. The spell can levitate a target that weighs up to 500 pounds. An unwilling creature that succeeds on a constitution saving throw is unaffected.

The target can move only by pushing or pulling against a fixed object or surface within reach (such as a wall or a ceiling), which allows it to move as if it were climbing. You can change the target''s altitude by up to 20 feet in either direction on your turn. If you are the target, you can move up or down as part of your move. Otherwise, you can use your action to move the target, which must remain within the spell''s range.

When the spell ends, the target floats gently to the ground if it is still aloft.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-light-0', 'srd', NULL, 'Spell: Light', 'Light. Cantrip Evocation. Casting time: 1 action. Range: Touch. Duration: 1 hour. You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. Completely covering the object with something opaque blocks the light. The spell ends if you cast it again or dismiss it as an action.

If you target an object held or worn by a hostile creature, that creature must succeed on a dexterity saving throw to avoid the spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-lightning-bolt-0', 'srd', NULL, 'Spell: Lightning Bolt', 'Lightning Bolt. Level 3 Evocation. Casting time: 1 action. Range: Self. Duration: Instantaneous. A stroke of lightning forming a line 100 feet long and 5 feet wide blasts out from you in a direction you choose. Each creature in the line must make a dexterity saving throw. A creature takes 8d6 lightning damage on a failed save, or half as much damage on a successful one.

The lightning ignites flammable objects in the area that aren''t being worn or carried.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-locate-animals-or-plants-0', 'srd', NULL, 'Spell: Locate Animals or Plants', 'Locate Animals or Plants. Level 2 Divination. Casting time: 1 action. Range: Self. Duration: Instantaneous. Describe or name a specific kind of beast or plant. Concentrating on the voice of nature in your surroundings, you learn the direction and distance to the closest creature or plant of that kind within 5 miles, if any are present.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-locate-creature-0', 'srd', NULL, 'Spell: Locate Creature', 'Locate Creature. Level 4 Divination. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. Describe or name a creature that is familiar to you. You sense the direction to the creature''s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement.

The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close--within 30 feet--at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn''t locate the creature.

This spell can''t locate a creature if running water at least 10 feet wide blocks a direct path between you and the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-locate-object-0', 'srd', NULL, 'Spell: Locate Object', 'Locate Object. Level 2 Divination. Casting time: 1 action. Range: Self. Duration: Up to 10 minutes. Describe or name an object that is familiar to you. You sense the direction to the object''s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement.

The spell can locate a specific object known to you, as long as you have seen it up close--within 30 feet--at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon.

This spell can''t locate an object if any thickness of lead, even a thin sheet, blocks a direct path between you and the object.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-longstrider-0', 'srd', NULL, 'Spell: Longstrider', 'Longstrider. Level 1 Transmutation. Casting time: 1 action. Range: Touch. Duration: 1 hour. You touch a creature. The target''s speed increases by 10 feet until the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mage-armor-0', 'srd', NULL, 'Spell: Mage Armor', 'Mage Armor. Level 1 Abjuration. Casting time: 1 action. Range: Touch. Duration: 8 hours. You touch a willing creature who isn''t wearing armor, and a protective magical force surrounds it until the spell ends. The target''s base AC becomes 13 + its Dexterity modifier. The spell ends if the target dons armor or if you dismiss the spell as an action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mage-hand-0', 'srd', NULL, 'Spell: Mage Hand', 'Mage Hand. Cantrip Conjuration. Casting time: 1 action. Range: 30 feet. Duration: 1 minute. A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again.

You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.

The hand can''t attack, activate magic items, or carry more than 10 pounds.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magic-circle-0', 'srd', NULL, 'Spell: Magic Circle', 'Magic Circle. Level 3 Abjuration. Casting time: 1 minute. Range: 10 feet. Duration: 1 hour. You create a 10-foot radius, 20-foot-tall cylinder of magical energy centered on a point on the ground that you can see within range. Glowing runes appear whenever the cylinder intersects with the floor or other surface.

Choose one or more of the following types of creatures: celestials, elementals, fey, fiends, or undead. The circle affects a creature of the chosen type in the following ways:

- The creature can''t willingly enter the cylinder by nonmagical means. If the creature tries to use teleportation or interplanar travel to do so, it must first succeed on a charisma saving throw.

- The creature has disadvantage on attack rolls against targets within the cylinder.

- Targets within the cylinder can''t be charmed, frightened, or possessed by the creature.

When you cast this spell, you can elect to cause its magic to operate in the reverse direction, preventing a creature of the specified type from leaving the cylinder and protecting targets outside it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magic-jar-0', 'srd', NULL, 'Spell: Magic Jar (1)', 'Magic Jar. Level 6 Necromancy. Casting time: 1 minute. Range: Self. Duration: Until dispelled. Your body falls into a catatonic state as your soul leaves it and enters the container you used for the spell''s material component. While your soul inhabits the container, you are aware of your surroundings as if you were in the container''s space. You can''t move or use reactions. The only action you can take is to project your soul up to 100 feet out of the container, either returning to your living body (and ending the spell) or attempting to possess a humanoids body.

You can attempt to possess any humanoid within 100 feet of you that you can see (creatures warded by a protection from evil and good or magic circle spell can''t be possessed). The target must make a charisma saving throw. On a failure, your soul moves into the target''s body, and the target''s soul becomes trapped in the container. On a success, the target resists your efforts to possess it, and you can''t attempt to possess it again for 24 hours.

Once you possess a creature''s body, you control it. Your game statistics are replaced by the statistics of the creature, though you retain your alignment and your Intelligence, Wisdom, and Charisma scores. You retain the benefit of your own class features. If the target has any class levels, you can''t use any of its class features.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magic-jar-1', 'srd', NULL, 'Spell: Magic Jar (2)', 'Meanwhile, the possessed creature''s soul can perceive from the container using its own senses, but it can''t move or take actions at all.

While possessing a body, you can use your action to return from the host body to the container if it is within 100 feet of you, returning the host creature''s soul to its body. If the host body dies while you''re in it, the creature dies, and you must make a charisma saving throw against your own spellcasting DC. On a success, you return to the container if it is within 100 feet of you. Otherwise, you die.

If the container is destroyed or the spell ends, your soul immediately returns to your body. If your body is more than 100 feet away from you or if your body is dead when you attempt to return to it, you die. If another creature''s soul is in the container when it is destroyed, the creature''s soul returns to its body if the body is alive and within 100 feet. Otherwise, that creature dies.

When the spell ends, the container is destroyed.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magic-missile-0', 'srd', NULL, 'Spell: Magic Missile', 'Magic Missile. Level 1 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Instantaneous. You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magic-mouth-0', 'srd', NULL, 'Spell: Magic Mouth', 'Magic Mouth. Level 2 Illusion. Casting time: 1 minute. Range: 30 feet. Duration: Until dispelled. You plant a message to an object in the range of the spell. The message is verbalized when the trigger conditions are met. Choose an object that you see, and that is not worn or carried by another creature. Then say the message, which should not exceed 25 words but listening can take up to 10 minutes. Finally, establish the circumstances that trigger the spell to deliver your message.

When these conditions are satisfied, a magical mouth appears on the object and it articulates the message imitating your voice, the same tone used during implantation of the message. If the selected object has a mouth or something that approaches such as the mouth of a statue, the magic mouth come alive at this point, giving the illusion that the words come from the mouth of the object.

When you cast this spell, you may decide that the spell ends when the message is delivered or it can persist and repeat the message whenever circumstances occur.

The triggering circumstance can be as general or as detailed as you like, though it must be based on visual or audible conditions that occur within 30 feet of the object. For example, you could instruct the mouth to speak when any creature moves within 30 feet of the object or when a silver bell rings within 30 feet of it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magic-weapon-0', 'srd', NULL, 'Spell: Magic Weapon', 'Magic Weapon. Level 2 Transmutation. Casting time: 1 bonus action. Range: Touch. Duration: Up to 1 hour. You touch a nonmagical weapon. Until the spell ends, that weapon becomes a magic weapon with a +1 bonus to attack rolls and damage rolls.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magnificent-mansion-0', 'srd', NULL, 'Spell: Magnificent Mansion (1)', 'Magnificent Mansion. Level 7 Conjuration. Casting time: 1 minute. Range: 300 feet. Duration: 24 hours. You conjure an extradimensional dwelling in range that lasts for the duration. You choose where its one entrance is located. The entrance shimmers faintly and is 5 feet wide and 10 feet tall. You and any creature you designate when you cast the spell can enter the extradimensional dwelling as long as the portal remains open. You can open or close the portal if you are within 30 feet of it. While closed, the portal is invisible.

Beyond the portal is a magnificent foyer with numerous chambers beyond. The atmosphere is clean, fresh, and warm.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-magnificent-mansion-1', 'srd', NULL, 'Spell: Magnificent Mansion (2)', 'You can create any floor plan you like, but the space can''t exceed 50 cubes, each cube being 10 feet on each side. The place is furnished and decorated as you choose. It contains sufficient food to serve a nine course banquet for up to 100 people. A staff of 100 near-transparent servants attends all who enter. You decide the visual appearance of these servants and their attire. They are completely obedient to your orders. Each servant can perform any task a normal human servant could perform, but they can''t attack or take any action that would directly harm another creature. Thus the servants can fetch things, clean, mend, fold clothes, light fires, serve food, pour wine, and so on. The servants can go anywhere in the mansion but can''t leave it. Furnishings and other objects created by this spell dissipate into smoke if removed from the mansion. When the spell ends, any creatures inside the extradimensional space are expelled into the open spaces nearest to the entrance.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-major-image-0', 'srd', NULL, 'Spell: Major Image (1)', 'Major Image. Level 3 Illusion. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can''t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage or deafen a creature, or a smell that might sicken a creature (like a troglodyte''s stench).

As long as you are within range of the illusion, you can use your action to cause the image to move to any other spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. For example, if you create an image of a creature and move it, you can alter the image so that it appears to be walking. Similarly, you can cause the illusion to make different sounds at different times, even making it carry on a conversation, for example.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-major-image-1', 'srd', NULL, 'Spell: Major Image (2)', 'Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image, and its other sensory qualities become faint to the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mass-cure-wounds-0', 'srd', NULL, 'Spell: Mass Cure Wounds', 'Mass Cure Wounds. Level 5 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. A wave of healing energy washes out from a point of your choice within range. Choose up to six creatures in a 30-foot-radius sphere centered on that point. Each target regains hit points equal to 3d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mass-heal-0', 'srd', NULL, 'Spell: Mass Heal', 'Mass Heal. Level 9 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. A flood of healing energy flows from you into injured creatures around you. You restore up to 700 hit points, divided as you choose among any number of creatures that you can see within range. Creatures healed by this spell are also cured of all diseases and any effect making them blinded or deafened. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mass-healing-word-0', 'srd', NULL, 'Spell: Mass Healing Word', 'Mass Healing Word. Level 3 Evocation. Casting time: 1 bonus action. Range: 60 feet. Duration: Instantaneous. As you call out words of restoration, up to six creatures of your choice that you can see within range regain hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mass-suggestion-0', 'srd', NULL, 'Spell: Mass Suggestion', 'Mass Suggestion. Level 6 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: 24 hours. You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can''t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell.

Each target must make a wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.

You can also specify conditions that will trigger a special activity during the duration. For example, you might suggest that a group of soldiers give all their money to the first beggar they meet. If the condition isn''t met before the spell ends, the activity isn''t performed.

If you or any of your companions damage a creature affected by this spell, the spell ends for that creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-maze-0', 'srd', NULL, 'Spell: Maze', 'Maze. Level 8 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 10 minutes. You banish a creature that you can see within range into a labyrinthine demiplane. The target remains there for the duration or until it escapes the maze.

The target can use its action to attempt to escape. When it does so, it makes a DC 20 Intelligence check. If it succeeds, it escapes, and the spell ends (a minotaur or goristro demon automatically succeeds).

When the spell ends, the target reappears in the space it left or, if that space is occupied, in the nearest unoccupied space.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-meld-into-stone-0', 'srd', NULL, 'Spell: Meld Into Stone', 'Meld Into Stone. Level 3 Transmutation. Casting time: 1 action. Range: Touch. Duration: 8 hours. You step into a stone object or surface large enough to fully contain your body, melding yourself and all the equipment you carry with the stone for the duration. Using your movement, you step into the stone at a point you can touch. Nothing of your presence remains visible or otherwise detectable by nonmagical senses.

While merged with the stone, you can''t see what occurs outside it, and any Wisdom (Perception) checks you make to hear sounds outside it are made with disadvantage. You remain aware of the passage of time and can cast spells on yourself while merged in the stone. You can use your movement to leave the stone where you entered it, which ends the spell. You otherwise can''t move.

Minor physical damage to the stone doesn''t harm you, but its partial destruction or a change in its shape (to the extent that you no longer fit within it) expels you and deals 6d6 bludgeoning damage to you. The stone''s complete destruction (or transmutation into a different substance) expels you and deals 50 bludgeoning damage to you. If expelled, you fall prone in an unoccupied space closest to where you first entered.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mending-0', 'srd', NULL, 'Spell: Mending', 'Mending. Cantrip Transmutation. Casting time: 1 minute. Range: Touch. Duration: Instantaneous. This spell repairs a single break or tear in an object you touch, such as a broken key, a torn cloak, or a leaking wineskin. As long as the break or tear is no longer than 1 foot in any dimension, you mend it, leaving no trace of the former damage.

This spell can physically repair a magic item or construct, but the spell can''t restore magic to such an object.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-message-0', 'srd', NULL, 'Spell: Message', 'Message. Cantrip Transmutation. Casting time: 1 action. Range: 120 feet. Duration: 1 round. You point your finger toward a creature within range and whisper a message. The target (and only the target) hears the message and can reply in a whisper that only you can hear.

You can cast this spell through solid objects if you are familiar with the target and know it is beyond the barrier. Magical silence, 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood blocks the spell. The spell doesn''t have to follow a straight line and can travel freely around corners or through openings.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-meteor-swarm-0', 'srd', NULL, 'Spell: Meteor Swarm', 'Meteor Swarm. Level 9 Evocation. Casting time: 1 action. Range: 1 mile. Duration: Instantaneous. Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.

The spell damages objects in the area and ignites flammable objects that aren''t being worn or carried.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mind-blank-0', 'srd', NULL, 'Spell: Mind Blank', 'Mind Blank. Level 8 Abjuration. Casting time: 1 action. Range: Touch. Duration: 24 hours. Until the spell ends, one willing creature you touch is immune to psychic damage, any effect that would sense its emotions or read its thoughts, divination spells, and the charmed condition. The spell even foils wish spells and spells or effects of similar power used to affect the target''s mind or to gain information about the target.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-minor-illusion-0', 'srd', NULL, 'Spell: Minor Illusion', 'Minor Illusion. Cantrip Illusion. Casting time: 1 action. Range: 30 feet. Duration: 1 minute. You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again.

If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else''s voice, a lion''s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends.

If you create an image of an object--such as a chair, muddy footprints, or a small chest--it must be no larger than a 5-foot cube. The image can''t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it.

If a creature uses its action to examine the sound or image, the creature can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the illusion becomes faint to the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mirage-arcane-0', 'srd', NULL, 'Spell: Mirage Arcane', 'Mirage Arcane. Level 7 Illusion. Casting time: 10 minutes. Range: Sight. Duration: 10 days. You make terrain in an area up to 1 mile square look, sound, smell, and even feel like some other sort of terrain. The terrain''s general shape remains the same, however. Open fields or a road could be made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road.

Similarly, you can alter the appearance of structures, or add them where none are present. The spell doesn''t disguise, conceal, or add creatures.

The illusion includes audible, visual, tactile, and olfactory elements, so it can turn clear ground into difficult terrain (or vice versa) or otherwise impede movement through the area. Any piece of the illusory terrain (such as a rock or stick) that is removed from the spell''s area disappears immediately.

Creatures with truesight can see through the illusion to the terrain''s true form; however, all other elements of the illusion remain, so while the creature is aware of the illusion''s presence, the creature can still physically interact with the illusion.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mirror-image-0', 'srd', NULL, 'Spell: Mirror Image', 'Mirror Image. Level 2 Illusion. Casting time: 1 action. Range: Self. Duration: 1 minute. Three illusory duplicates of yourself appear in your space. Until the spell ends, the duplicates move with you and mimic your actions, shifting position so it''s impossible to track which image is real. You can use your action to dismiss the illusory duplicates.

Each time a creature targets you with an attack during the spell''s duration, roll a d20 to determine whether the attack instead targets one of your duplicates.

If you have three duplicates, you must roll a 6 or higher to change the attack''s target to a duplicate. With two duplicates, you must roll an 8 or higher. With one duplicate, you must roll an 11 or higher.

A duplicate''s AC equals 10 + your Dexterity modifier. If an attack hits a duplicate, the duplicate is destroyed. A duplicate can be destroyed only by an attack that hits it. It ignores all other damage and effects. The spell ends when all three duplicates are destroyed.

A creature is unaffected by this spell if it can''t see, if it relies on senses other than sight, such as blindsight, or if it can perceive illusions as false, as with truesight.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-mislead-0', 'srd', NULL, 'Spell: Mislead', 'Mislead. Level 5 Illusion. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. You become invisible at the same time that an illusory double of you appears where you are standing. The double lasts for the duration, but the invisibility ends if you attack or cast a spell.

You can use your action to move your illusory double up to twice your speed and make it gesture, speak, and behave in whatever way you choose.

You can see through its eyes and hear through its ears as if you were located where it is. On each of your turns as a bonus action, you can switch from using its senses to using your own, or back again. While you are using its senses, you are blinded and deafened in regard to your own surroundings.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-misty-step-0', 'srd', NULL, 'Spell: Misty Step', 'Misty Step. Level 2 Conjuration. Casting time: 1 bonus action. Range: Self. Duration: Instantaneous. Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-modify-memory-0', 'srd', NULL, 'Spell: Modify Memory (1)', 'Modify Memory. Level 5 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. You attempt to reshape another creature''s memories. One creature that you can see must make a wisdom saving throw. If you are fighting the creature, it has advantage on the saving throw. On a failed save, the target becomes charmed by you for the duration. The charmed target is incapacitated and unaware of its surroundings, though it can still hear you. If it takes any damage or is targeted by another spell, this spell ends, and none of the target''s memories are modified.

While this charm lasts, you can affect the target''s memory of an event that it experienced within the last 24 hours and that lasted no more than 10 minutes. You can permanently eliminate all memory of the event, allow the target to recall the event with perfect clarity and exacting detail, change its memory of the details of the event, or create a memory of some other event.

You must speak to the target to describe how its memories are affected, and it must be able to understand your language for the modified memories to take root. Its mind fills in any gaps in the details of your description. If the spell ends before you have finished describing the modified memories, the creature''s memory isn''t altered. Otherwise, the modified memories take hold when the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-modify-memory-1', 'srd', NULL, 'Spell: Modify Memory (2)', 'A modified memory doesn''t necessarily affect how a creature behaves, particularly if the memory contradicts the creature''s natural inclinations, alignment, or beliefs. An illogical modified memory, such as implanting a memory of how much the creature enjoyed dousing itself in acid, is dismissed, perhaps as a bad dream. The GM might deem a modified memory too nonsensical to affect a creature in a significant manner.

A remove curse or greater restoration spell cast on the target restores the creature''s true memory.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-moonbeam-0', 'srd', NULL, 'Spell: Moonbeam', 'Moonbeam. Level 2 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. A silvery beam of pale light shines down in a 5-foot radius, 40-foot-high cylinder centered on a point within range. Until the spell ends, dim light fills the cylinder.

When a creature enters the spell''s area for the first time on a turn or starts its turn there, it is engulfed in ghostly flames that cause searing pain, and it must make a constitution saving throw. It takes 2d10 radiant damage on a failed save, or half as much damage on a successful one.

A shapechanger makes its saving throw with disadvantage. If it fails, it also instantly reverts to its original form and can''t assume a different form until it leaves the spell''s light.

On each of your turns after you cast this spell, you can use an action to move the beam 60 feet in any direction.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-move-earth-0', 'srd', NULL, 'Spell: Move Earth', 'Move Earth. Level 6 Transmutation. Casting time: 1 action. Range: 120 feet. Duration: Up to 2 hours. Choose an area of terrain no larger than 40 feet on a side within range. You can reshape dirt, sand, or clay in the area in any manner you choose for the duration. You can raise or lower the area''s elevation, create or fill in a trench, erect or flatten a wall, or form a pillar. The extent of any such changes can''t exceed half the area''s largest dimension. So, if you affect a 40-foot square, you can create a pillar up to 20 feet high, raise or lower the square''s elevation by up to 20 feet, dig a trench up to 20 feet deep, and so on. It takes 10 minutes for these changes to complete.

At the end of every 10 minutes you spend concentrating on the spell, you can choose a new area of terrain to affect.

Because the terrain''s transformation occurs slowly, creatures in the area can''t usually be trapped or injured by the ground''s movement.

This spell can''t manipulate natural stone or stone construction. Rocks and structures shift to accommodate the new terrain. If the way you shape the terrain would make a structure unstable, it might collapse.

Similarly, this spell doesn''t directly affect plant growth. The moved earth carries any plants along with it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-nondetection-0', 'srd', NULL, 'Spell: Nondetection', 'Nondetection. Level 3 Abjuration. Casting time: 1 action. Range: Touch. Duration: 8 hours. For the duration, you hide a target that you touch from divination magic. The target can be a willing creature or a place or an object no larger than 10 feet in any dimension. The target can''t be targeted by any divination magic or perceived through magical scrying sensors.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-pass-without-trace-0', 'srd', NULL, 'Spell: Pass Without Trace', 'Pass Without Trace. Level 2 Abjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. A veil of shadows and silence radiates from you, masking you and your companions from detection. For the duration, each creature you choose within 30 feet of you (including you) has a +10 bonus to Dexterity (Stealth) checks and can''t be tracked except by magical means. A creature that receives this bonus leaves behind no tracks or other traces of its passage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-passwall-0', 'srd', NULL, 'Spell: Passwall', 'Passwall. Level 5 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: 1 hour. A passage appears at a point of your choice that you can see on a wooden, plaster, or stone surface (such as a wall, a ceiling, or a floor) within range, and lasts for the duration. You choose the opening''s dimensions: up to 5 feet wide, 8 feet tall, and 20 feet deep. The passage creates no instability in a structure surrounding it.

When the opening disappears, any creatures or objects still in the passage created by the spell are safely ejected to an unoccupied space nearest to the surface on which you cast the spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-phantasmal-killer-0', 'srd', NULL, 'Spell: Phantasmal Killer', 'Phantasmal Killer. Level 4 Illusion. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. You tap into the nightmares of a creature you can see within range and create an illusory manifestation of its deepest fears, visible only to that creature. The target must make a wisdom saving throw. On a failed save, the target becomes frightened for the duration. At the start of each of the target''s turns before the spell ends, the target must succeed on a wisdom saving throw or take 4d10 psychic damage. On a successful save, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-phantom-steed-0', 'srd', NULL, 'Spell: Phantom Steed', 'Phantom Steed. Level 3 Illusion. Casting time: 1 minute. Range: 30 feet. Duration: 1 hour. A Large quasi-real, horselike creature appears on the ground in an unoccupied space of your choice within range. You decide the creature''s appearance, but it is equipped with a saddle, bit, and bridle. Any of the equipment created by the spell vanishes in a puff of smoke if it is carried more than 10 feet away from the steed.

For the duration, you or a creature you choose can ride the steed. The creature uses the statistics for a riding horse, except it has a speed of 100 feet and can travel 10 miles in an hour, or 13 miles at a fast pace. When the spell ends, the steed gradually fades, giving the rider 1 minute to dismount. The spell ends if you use an action to dismiss it or if the steed takes any damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-planar-ally-0', 'srd', NULL, 'Spell: Planar Ally (1)', 'Planar Ally. Level 6 Conjuration. Casting time: 10 minutes. Range: 60 feet. Duration: Instantaneous. You beseech an otherworldly entity for aid. The being must be known to you: a god, a primordial, a demon prince, or some other being of cosmic power. That entity sends a celestial, an elemental, or a fiend loyal to it to aid you, making the creature appear in an unoccupied space within range. If you know a specific creature''s name, you can speak that name when you cast this spell to request that creature, though you might get a different creature anyway (GM''s choice).

When the creature appears, it is under no compulsion to behave in any particular way. You can ask the creature to perform a service in exchange for payment, but it isn''t obliged to do so. The requested task could range from simple (fly us across the chasm, or help us fight a battle) to complex (spy on our enemies, or protect us during our foray into the dungeon). You must be able to communicate with the creature to bargain for its services.

Payment can take a variety of forms. A celestial might require a sizable donation of gold or magic items to an allied temple, while a fiend might demand a living sacrifice or a gift of treasure. Some creatures might exchange their service for a quest undertaken by you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-planar-ally-1', 'srd', NULL, 'Spell: Planar Ally (2)', 'As a rule of thumb, a task that can be measured in minutes requires a payment worth 100 gp per minute. A task measured in hours requires 1,000 gp per hour. And a task measured in days (up to 10 days) requires 10,000 gp per day. The GM can adjust these payments based on the circumstances under which you cast the spell. If the task is aligned with the creature''s ethos, the payment might be halved or even waived. Nonhazardous tasks typically require only half the suggested payment, while especially dangerous tasks might require a greater gift. Creatures rarely accept tasks that seem suicidal.

After the creature completes the task, or when the agreed-upon duration of service expires, the creature returns to its home plane after reporting back to you, if appropriate to the task and if possible. If you are unable to agree on a price for the creature''s service, the creature immediately returns to its home plane.

A creature enlisted to join your group counts as a member of it, receiving a full share of experience points awarded.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-planar-binding-0', 'srd', NULL, 'Spell: Planar Binding', 'Planar Binding. Level 5 Abjuration. Casting time: 1 hour. Range: 60 feet. Duration: 24 hours. With this spell, you attempt to bind a celestial, an elemental, a fey, or a fiend to your service. The creature must be within range for the entire casting of the spell. (Typically, the creature is first summoned into the center of an inverted magic circle in order to keep it trapped while this spell is cast.) At the completion of the casting, the target must make a charisma saving throw. On a failed save, it is bound to serve you for the duration. If the creature was summoned or created by another spell, that spell''s duration is extended to match the duration of this spell.

A bound creature must follow your instructions to the best of its ability. You might command the creature to accompany you on an adventure, to guard a location, or to deliver a message. The creature obeys the letter of your instructions, but if the creature is hostile to you, it strives to twist your words to achieve its own objectives. If the creature carries out your instructions completely before the spell ends, it travels to you to report this fact if you are on the same plane of existence. If you are on a different plane of existence, it returns to the place where you bound it and remains there until the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-plane-shift-0', 'srd', NULL, 'Spell: Plane Shift', 'Plane Shift. Level 7 Conjuration. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You and up to eight willing creatures who link hands in a circle are transported to a different plane of existence. You can specify a target destination in general terms, such as the City of Brass on the Elemental Plane of Fire or the palace of Dispater on the second level of the Nine Hells, and you appear in or near that destination. If you are trying to reach the City of Brass, for example, you might arrive in its Street of Steel, before its Gate of Ashes, or looking at the city from across the Sea of Fire, at the GM''s discretion.

Alternatively, if you know the sigil sequence of a teleportation circle on another plane of existence, this spell can take you to that circle. If the teleportation circle is too small to hold all the creatures you transported, they appear in the closest unoccupied spaces next to the circle.

You can use this spell to banish an unwilling creature to another plane. Choose a creature within your reach and make a melee spell attack against it. On a hit, the creature must make a charisma saving throw. If the creature fails this save, it is transported to a random location on the plane of existence you specify. A creature so transported must find its own way back to your current plane of existence.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-plant-growth-0', 'srd', NULL, 'Spell: Plant Growth', 'Plant Growth. Level 3 Transmutation. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. This spell channels vitality into plants within a specific area. There are two possible uses for the spell, granting either immediate or long-term benefits.

If you cast this spell using 1 action, choose a point within range. All normal plants in a 100-foot radius centered on that point become thick and overgrown. A creature moving through the area must spend 4 feet of movement for every 1 foot it moves.

You can exclude one or more areas of any size within the spell''s area from being affected.

If you cast this spell over 8 hours, you enrich the land. All plants in a half-mile radius centered on a point within range become enriched for 1 year. The plants yield twice the normal amount of food when harvested.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-poison-spray-0', 'srd', NULL, 'Spell: Poison Spray', 'Poison Spray. Cantrip Conjuration. Casting time: 1 action. Range: 10 feet. Duration: Instantaneous. You extend your hand toward a creature you can see within range and project a puff of noxious gas from your palm. The creature must succeed on a constitution saving throw or take 1d12 poison damage.

This spell''s damage increases by 1d12 when you reach 5th level (2d12), 11th level (3d12), and 17th level (4d12).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-polymorph-0', 'srd', NULL, 'Spell: Polymorph (1)', 'Polymorph. Level 4 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 hour. This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a wisdom saving throw to avoid the effect. A shapechanger automatically succeeds on this saving throw.

The transformation lasts for the duration, or until the target drops to 0 hit points or dies. The new form can be any beast whose challenge rating is equal to or less than the target''s (or the target''s level, if it doesn''t have a challenge rating). The target''s game statistics, including mental ability scores, are replaced by the statistics of the chosen beast. It retains its alignment and personality.

The target assumes the hit points of its new form. When it reverts to its normal form, the creature returns to the number of hit points it had before it transformed. If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form. As long as the excess damage doesn''t reduce the creature''s normal form to 0 hit points, it isn''t knocked unconscious.

The creature is limited in the actions it can perform by the nature of its new form, and it can''t speak, cast spells, or take any other action that requires hands or speech.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-polymorph-1', 'srd', NULL, 'Spell: Polymorph (2)', 'The target''s gear melds into the new form. The creature can''t activate, use, wield, or otherwise benefit from any of its equipment.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-power-word-kill-0', 'srd', NULL, 'Spell: Power Word Kill', 'Power Word Kill. Level 9 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. You utter a word of power that can compel one creature you can see within range to die instantly. If the creature you choose has 100 hit points or fewer, it dies. Otherwise, the spell has no effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-power-word-stun-0', 'srd', NULL, 'Spell: Power Word Stun', 'Power Word Stun. Level 8 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. You speak a word of power that can overwhelm the mind of one creature you can see within range, leaving it dumbfounded. If the target has 150 hit points or fewer, it is stunned. Otherwise, the spell has no effect.

The stunned target must make a constitution saving throw at the end of each of its turns. On a successful save, this stunning effect ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prayer-of-healing-0', 'srd', NULL, 'Spell: Prayer of Healing', 'Prayer of Healing. Level 2 Evocation. Casting time: 10 minutes. Range: 30 feet. Duration: Instantaneous. Up to six creatures of your choice that you can see within range each regain hit points equal to 2d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prestidigitation-0', 'srd', NULL, 'Spell: Prestidigitation', 'Prestidigitation. Cantrip Transmutation. Casting time: 1 action. Range: 10 feet. Duration: 1 hour. This spell is a minor magical trick that novice spellcasters use for practice. You create one of the following magical effects within ''range'':

You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor.

You instantaneously light or snuff out a candle, a torch, or a small campfire.

You instantaneously clean or soil an object no larger than 1 cubic foot.

You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour.

You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour.

You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.

If you cast this spell multiple times, you can have up to three of its non-instantaneous effects active at a time, and you can dismiss such an effect as an action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prismatic-spray-0', 'srd', NULL, 'Spell: Prismatic Spray (1)', 'Prismatic Spray. Level 7 Evocation. Casting time: 1 action. Range: Self. Duration: Instantaneous. Eight multicolored rays of light flash from your hand. Each ray is a different color and has a different power and purpose. Each creature in a 60-foot cone must make a dexterity saving throw. For each target, roll a d8 to determine which color ray affects it.

***1. Red.*** The target takes 10d6 fire damage on a failed save, or half as much damage on a successful one.

***2. Orange.*** The target takes 10d6 acid damage on a failed save, or half as much damage on a successful one.

***3. Yellow.*** The target takes 10d6 lightning damage on a failed save, or half as much damage on a successful one.

***4. Green.*** The target takes 10d6 poison damage on a failed save, or half as much damage on a successful one.

***5. Blue.*** The target takes 10d6 cold damage on a failed save, or half as much damage on a successful one.

***6. Indigo.*** On a failed save, the target is restrained. It must then make a constitution saving throw at the end of each of its turns. If it successfully saves three times, the spell ends. If it fails its save three times, it permanently turns to stone and is subjected to the petrified condition. The successes and failures don''t need to be consecutive; keep track of both until the target collects three of a kind.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prismatic-spray-1', 'srd', NULL, 'Spell: Prismatic Spray (2)', '***7. Violet.*** On a failed save, the target is blinded. It must then make a wisdom saving throw at the start of your next turn. A successful save ends the blindness. If it fails that save, the creature is transported to another plane of existence of the GM''s choosing and is no longer blinded. (Typically, a creature that is on a plane that isn''t its home plane is banished home, while other creatures are usually cast into the Astral or Ethereal planes.)

***8. Special.*** The target is struck by two rays. Roll twice more, rerolling any 8.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prismatic-wall-0', 'srd', NULL, 'Spell: Prismatic Wall (1)', 'Prismatic Wall. Level 9 Abjuration. Casting time: 1 action. Range: 60 feet. Duration: 10 minutes. A shimmering, multicolored plane of light forms a vertical opaque wall--up to 90 feet long, 30 feet high, and 1 inch thick--centered on a point you can see within range. Alternatively, you can shape the wall into a sphere up to 30 feet in diameter centered on a point you choose within range. The wall remains in place for the duration. If you position the wall so that it passes through a space occupied by a creature, the spell fails, and your action and the spell slot are wasted.

The wall sheds bright light out to a range of 100 feet and dim light for an additional 100 feet. You and creatures you designate at the time you cast the spell can pass through and remain near the wall without harm. If another creature that can see the wall moves to within 20 feet of it or starts its turn there, the creature must succeed on a constitution saving throw or become blinded for 1 minute.

The wall consists of seven layers, each with a different color. When a creature attempts to reach into or pass through the wall, it does so one layer at a time through all the wall''s layers. As it passes or reaches through each layer, the creature must make a dexterity saving throw or be affected by that layer''s properties as described below.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prismatic-wall-1', 'srd', NULL, 'Spell: Prismatic Wall (2)', 'The wall can be destroyed, also one layer at a time, in order from red to violet, by means specific to each layer. Once a layer is destroyed, it remains so for the duration of the spell. A rod of cancellation destroys a prismatic wall, but an antimagic field has no effect on it.

***1. Red.*** The creature takes 10d6 fire damage on a failed save, or half as much damage on a successful one. While this layer is in place, nonmagical ranged attacks can''t pass through the wall. The layer can be destroyed by dealing at least 25 cold damage to it.

***2. Orange.*** The creature takes 10d6 acid damage on a failed save, or half as much damage on a successful one. While this layer is in place, magical ranged attacks can''t pass through the wall. The layer is destroyed by a strong wind.

***3. Yellow.*** The creature takes 10d6 lightning damage on a failed save, or half as much damage on a successful one. This layer can be destroyed by dealing at least 60 force damage to it.

***4. Green.*** The creature takes 10d6 poison damage on a failed save, or half as much damage on a successful one. A passwall spell, or another spell of equal or greater level that can open a portal on a solid surface, destroys this layer.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-prismatic-wall-2', 'srd', NULL, 'Spell: Prismatic Wall (3)', '***5. Blue.*** The creature takes 10d6 cold damage on a failed save, or half as much damage on a successful one. This layer can be destroyed by dealing at least 25 fire damage to it.

***6. Indigo.*** On a failed save, the creature is restrained. It must then make a constitution saving throw at the end of each of its turns. If it successfully saves three times, the spell ends. If it fails its save three times, it permanently turns to stone and is subjected to the petrified condition. The successes and failures don''t need to be consecutive; keep track of both until the creature collects three of a kind.

While this layer is in place, spells can''t be cast through the wall. The layer is destroyed by bright light shed by a daylight spell or a similar spell of equal or higher level.

***7. Violet.*** On a failed save, the creature is blinded. It must then make a wisdom saving throw at the start of your next turn. A successful save ends the blindness. If it fails that save, the creature is transported to another plane of the GM''s choosing and is no longer blinded. (Typically, a creature that is on a plane that isn''t its home plane is banished home, while other creatures are usually cast into the Astral or Ethereal planes.) This layer is destroyed by a dispel magic spell or a similar spell of equal or higher level that can end spells and magical effects.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-private-sanctum-0', 'srd', NULL, 'Spell: Private Sanctum', 'Private Sanctum. Level 4 Abjuration. Casting time: 10 minutes. Range: 120 feet. Duration: 24 hours. You make an area within range magically secure. The area is a cube that can be as small as 5 feet to as large as 100 feet on each side. The spell lasts for the duration or until you use an action to dismiss it.

When you cast the spell, you decide what sort of security the spell provides, choosing any or all of the following properties:

- Sound can''t pass through the barrier at the edge of the warded area.

- The barrier of the warded area appears dark and foggy, preventing vision (including darkvision) through it.

- Sensors created by divination spells can''t appear inside the protected area or pass through the barrier at its perimeter.

- Creatures in the area can''t be targeted by divination spells.

- Nothing can teleport into or out of the warded area.

- Planar travel is blocked within the warded area.

Casting this spell on the same spot every day for a year makes this effect permanent.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-produce-flame-0', 'srd', NULL, 'Spell: Produce Flame', 'Produce Flame. Cantrip Conjuration. Casting time: 1 action. Range: Self. Duration: 10 minutes. A flickering flame appears in your hand. The flame remains there for the duration and harms neither you nor your equipment. The flame sheds bright light in a 10-foot radius and dim light for an additional 10 feet. The spell ends if you dismiss it as an action or if you cast it again.

You can also attack with the flame, although doing so ends the spell. When you cast this spell, or as an action on a later turn, you can hurl the flame at a creature within 30 feet of you. Make a ranged spell attack. On a hit, the target takes 1d8 fire damage.

This spell''s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-programmed-illusion-0', 'srd', NULL, 'Spell: Programmed Illusion (1)', 'Programmed Illusion. Level 6 Illusion. Casting time: 1 action. Range: 120 feet. Duration: Until dispelled. You create an illusion of an object, a creature, or some other visible phenomenon within range that activates when a specific condition occurs. The illusion is imperceptible until then. It must be no larger than a 30-foot cube, and you decide when you cast the spell how the illusion behaves and what sounds it makes. This scripted performance can last up to 5 minutes.

When the condition you specify occurs, the illusion springs into existence and performs in the manner you described. Once the illusion finishes performing, it disappears and remains dormant for 10 minutes. After this time, the illusion can be activated again.

The triggering condition can be as general or as detailed as you like, though it must be based on visual or audible conditions that occur within 30 feet of the area. For example, you could create an illusion of yourself to appear and warn off others who attempt to open a trapped door, or you could set the illusion to trigger only when a creature says the correct word or phrase.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-programmed-illusion-1', 'srd', NULL, 'Spell: Programmed Illusion (2)', 'Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image, and any noise it makes sounds hollow to the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-project-image-0', 'srd', NULL, 'Spell: Project Image', 'Project Image. Level 7 Illusion. Casting time: 1 action. Range: 500 miles. Duration: Up to 24 hours. You create an illusory copy of yourself that lasts for the duration. The copy can appear at any location within range that you have seen before, regardless of intervening obstacles. The illusion looks and sounds like you but is intangible. If the illusion takes any damage, it disappears, and the spell ends.

You can use your action to move this illusion up to twice your speed, and make it gesture, speak, and behave in whatever way you choose. It mimics your mannerisms perfectly.

You can see through its eyes and hear through its ears as if you were in its space. On your turn as a bonus action, you can switch from using its senses to using your own, or back again. While you are using its senses, you are blinded and deafened in regard to your own surroundings.

Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image, and any noise it makes sounds hollow to the creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-protection-from-energy-0', 'srd', NULL, 'Spell: Protection From Energy', 'Protection From Energy. Level 3 Abjuration. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-protection-from-evil-and-good-0', 'srd', NULL, 'Spell: Protection from Evil and Good', 'Protection from Evil and Good. Level 1 Abjuration. Casting time: 1 action. Range: Touch. Duration: Up to 10 minutes. Until the spell ends, one willing creature you touch is protected against certain types of creatures: aberrations, celestials, elementals, fey, fiends, and undead.

The protection grants several benefits. Creatures of those types have disadvantage on attack rolls against the target. The target also can''t be charmed, frightened, or possessed by them. If the target is already charmed, frightened, or possessed by such a creature, the target has advantage on any new saving throw against the relevant effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-protection-from-poison-0', 'srd', NULL, 'Spell: Protection from Poison', 'Protection from Poison. Level 2 Abjuration. Casting time: 1 action. Range: Touch. Duration: 1 hour. You touch a creature. If it is poisoned, you neutralize the poison. If more than one poison afflicts the target, you neutralize one poison that you know is present, or you neutralize one at random.

For the duration, the target has advantage on saving throws against being poisoned, and it has resistance to poison damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-purify-food-and-drink-0', 'srd', NULL, 'Spell: Purify Food and Drink', 'Purify Food and Drink. Level 1 Transmutation. Casting time: 1 action. Range: 10 feet. Duration: Instantaneous. All nonmagical food and drink within a 5-foot radius sphere centered on a point of your choice within range is purified and rendered free of poison and disease.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-raise-dead-0', 'srd', NULL, 'Spell: Raise Dead', 'Raise Dead. Level 5 Necromancy. Casting time: 1 hour. Range: Touch. Duration: Instantaneous. You return a dead creature you touch to life, provided that it has been dead no longer than 10 days. If the creature''s soul is both willing and at liberty to rejoin the body, the creature returns to life with 1 hit point.

This spell also neutralizes any poisons and cures nonmagical diseases that affected the creature at the time it died. This spell doesn''t, however, remove magical diseases, curses, or similar effects; if these aren''t first removed prior to casting the spell, they take effect when the creature returns to life. The spell can''t return an undead creature to life.

This spell closes all mortal wounds, but it doesn''t restore missing body parts. If the creature is lacking body parts or organs integral for its survival--its head, for instance--the spell automatically fails.

Coming back from the dead is an ordeal. The target takes a -4 penalty to all attack rolls, saving throws, and ability checks. Every time the target finishes a long rest, the penalty is reduced by 1 until it disappears.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-ray-of-enfeeblement-0', 'srd', NULL, 'Spell: Ray of Enfeeblement', 'Ray of Enfeeblement. Level 2 Necromancy. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 minute. A black beam of enervating energy springs from your finger toward a creature within range. Make a ranged spell attack against the target. On a hit, the target deals only half damage with weapon attacks that use Strength until the spell ends.

At the end of each of the target''s turns, it can make a constitution saving throw against the spell. On a success, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-ray-of-frost-0', 'srd', NULL, 'Spell: Ray of Frost', 'Ray of Frost. Cantrip Evocation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. A frigid beam of blue-white light streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, it takes 1d8 cold damage, and its speed is reduced by 10 feet until the start of your next turn.

The spell''s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-regenerate-0', 'srd', NULL, 'Spell: Regenerate', 'Regenerate. Level 7 Transmutation. Casting time: 1 minute. Range: Touch. Duration: 1 hour. You touch a creature and stimulate its natural healing ability. The target regains 4d8 + 15 hit points. For the duration of the spell, the target regains 1 hit point at the start of each of its turns (10 hit points each minute).

The target''s severed body members (fingers, legs, tails, and so on), if any, are restored after 2 minutes. If you have the severed part and hold it to the stump, the spell instantaneously causes the limb to knit to the stump.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-reincarnate-0', 'srd', NULL, 'Spell: Reincarnate', 'Reincarnate. Level 5 Transmutation. Casting time: 1 hour. Range: Touch. Duration: Instantaneous. You touch a dead humanoid or a piece of a dead humanoid. Provided that the creature has been dead no longer than 10 days, the spell forms a new adult body for it and then calls the soul to enter that body. If the target''s soul isn''t free or willing to do so, the spell fails.

The magic fashions a new body for the creature to inhabit, which likely causes the creature''s race to change. The GM rolls a d 100 and consults the following table to determine what form the creature takes when restored to life, or the GM chooses a form.

| d100 | Race |

|---|---|

| 01-04 | Dragonborn |

| 05-13 | Dwarf, hill |

| 14-21 | Dwarf, mountain |

| 22-25 | Elf, dark |

| 26-34 | Elf, high |

| 35-42 | Elf, wood |

| 43-46 | Gnome, forest |

| 47-52 | Gnome, rock |

| 53-56 | Half-elf |

| 57-60 | Half-orc |

| 61-68 | Halfling, lightfoot |

| 69-76 | Halfling, stout |

| 77-96 | Human |

| 97-00 | Tiefling |

The reincarnated creature recalls its former life and experiences. It retains the capabilities it had in its original form, except it exchanges its original race for the new one and changes its racial traits accordingly.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-remove-curse-0', 'srd', NULL, 'Spell: Remove Curse', 'Remove Curse. Level 3 Abjuration. Casting time: 1 action. Range: Touch. Duration: Instantaneous. At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner''s attunement to the object so it can be removed or discarded.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-resilient-sphere-0', 'srd', NULL, 'Spell: Resilient Sphere', 'Resilient Sphere. Level 4 Evocation. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 minute. A sphere of shimmering force encloses a creature or object of Large size or smaller within range. An unwilling creature must make a dexterity saving throw. On a failed save, the creature is enclosed for the duration.

Nothing--not physical objects, energy, or other spell effects--can pass through the barrier, in or out, though a creature in the sphere can breathe there. The sphere is immune to all damage, and a creature or object inside can''t be damaged by attacks or effects originating from outside, nor can a creature inside the sphere damage anything outside it.

The sphere is weightless and just large enough to contain the creature or object inside. An enclosed creature can use its action to push against the sphere''s walls and thus roll the sphere at up to half the creature''s speed. Similarly, the globe can be picked up and moved by other creatures.

A disintegrate spell targeting the globe destroys it without harming anything inside it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-resistance-0', 'srd', NULL, 'Spell: Resistance', 'Resistance. Cantrip Abjuration. Casting time: 1 action. Range: Touch. Duration: Up to 1 minute. You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one saving throw of its choice. It can roll the die before or after making the saving throw. The spell then ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-resurrection-0', 'srd', NULL, 'Spell: Resurrection', 'Resurrection. Level 7 Necromancy. Casting time: 1 hour. Range: Touch. Duration: Instantaneous. You touch a dead creature that has been dead for no more than a century, that didn''t die of old age, and that isn''t undead. If its soul is free and willing, the target returns to life with all its hit points.

This spell neutralizes any poisons and cures normal diseases afflicting the creature when it died. It doesn''t, however, remove magical diseases, curses, and the like; if such effects aren''t removed prior to casting the spell, they afflict the target on its return to life.

This spell closes all mortal wounds and restores any missing body parts.

Coming back from the dead is an ordeal. The target takes a -4 penalty to all attack rolls, saving throws, and ability checks. Every time the target finishes a long rest, the penalty is reduced by 1 until it disappears.

Casting this spell to restore life to a creature that has been dead for one year or longer taxes you greatly. Until you finish a long rest, you can''t cast spells again, and you have disadvantage on all attack rolls, ability checks, and saving throws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-reverse-gravity-0', 'srd', NULL, 'Spell: Reverse Gravity', 'Reverse Gravity. Level 7 Transmutation. Casting time: 1 action. Range: 100 feet. Duration: Up to 1 minute. This spell reverses gravity in a 50-foot-radius, 100-foot high cylinder centered on a point within range. All creatures and objects that aren''t somehow anchored to the ground in the area fall upward and reach the top of the area when you cast this spell. A creature can make a dexterity saving throw to grab onto a fixed object it can reach, thus avoiding the fall.

If some solid object (such as a ceiling) is encountered in this fall, falling objects and creatures strike it just as they would during a normal downward fall. If an object or creature reaches the top of the area without striking anything, it remains there, oscillating slightly, for the duration.

At the end of the duration, affected objects and creatures fall back down.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-revivify-0', 'srd', NULL, 'Spell: Revivify', 'Revivify. Level 3 Conjuration. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You touch a creature that has died within the last minute. That creature returns to life with 1 hit point. This spell can''t return to life a creature that has died of old age, nor can it restore any missing body parts.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-rope-trick-0', 'srd', NULL, 'Spell: Rope Trick', 'Rope Trick. Level 2 Transmutation. Casting time: 1 action. Range: Touch. Duration: 1 hour. You touch a length of rope that is up to 60 feet long. One end of the rope then rises into the air until the whole rope hangs perpendicular to the ground. At the upper end of the rope, an invisible entrance opens to an extradimensional space that lasts until the spell ends.

The extradimensional space can be reached by climbing to the top of the rope. The space can hold as many as eight Medium or smaller creatures. The rope can be pulled into the space, making the rope disappear from view outside the space.

Attacks and spells can''t cross through the entrance into or out of the extradimensional space, but those inside can see out of it as if through a 3-foot-by-5-foot window centered on the rope.

Anything inside the extradimensional space drops out when the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sacred-flame-0', 'srd', NULL, 'Spell: Sacred Flame', 'Sacred Flame. Cantrip Evocation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. Flame-like radiance descends on a creature that you can see within range. The target must succeed on a dexterity saving throw or take 1d8 radiant damage. The target gains no benefit from cover for this saving throw.

The spell''s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sanctuary-0', 'srd', NULL, 'Spell: Sanctuary', 'Sanctuary. Level 1 Abjuration. Casting time: 1 bonus action. Range: 30 feet. Duration: 1 minute. You ward a creature within range against attack. Until the spell ends, any creature who targets the warded creature with an attack or a harmful spell must first make a wisdom saving throw. On a failed save, the creature must choose a new target or lose the attack or spell. This spell doesn''t protect the warded creature from area effects, such as the explosion of a fireball.

If the warded creature makes an attack or casts a spell that affects an enemy creature, this spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-scorching-ray-0', 'srd', NULL, 'Spell: Scorching Ray', 'Scorching Ray. Level 2 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Instantaneous. You create three rays of fire and hurl them at targets within range. You can hurl them at one target or several.

Make a ranged spell attack for each ray. On a hit, the target takes 2d6 fire damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-scrying-0', 'srd', NULL, 'Spell: Scrying (1)', 'Scrying. Level 5 Divination. Casting time: 10 minutes. Range: Self. Duration: Up to 10 minutes. You can see and hear a particular creature you choose that is on the same plane of existence as you. The target must make a wisdom saving throw, which is modified by how well you know the target and the sort of physical connection you have to it. If a target knows you''re casting this spell, it can fail the saving throw voluntarily if it wants to be observed.

| Knowledge | Save Modifier |

|---|---|

| Secondhand (you have heard of the target) | +5 |

| Firsthand (you have met the target) | +0 |

| Familiar (you know the target well) | -5 |



| Connection | Save Modifier |

|---|---|

| Likeness or picture | -2 |

| Possession or garment | -4 |

| Body part, lock of hair, bit of nail, or the like | -10 |

On a successful save, the target isn''t affected, and you can''t use this spell against it again for 24 hours.

On a failed save, the spell creates an invisible sensor within 10 feet of the target. You can see and hear through the sensor as if you were there. The sensor moves with the target, remaining within 10 feet of it for the duration. A creature that can see invisible objects sees the sensor as a luminous orb about the size of your fist.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-scrying-1', 'srd', NULL, 'Spell: Scrying (2)', 'Instead of targeting a creature, you can choose a location you have seen before as the target of this spell. When you do, the sensor appears at that location and doesn''t move.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-secret-chest-0', 'srd', NULL, 'Spell: Secret Chest', 'Secret Chest. Level 4 Conjuration. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You hide a chest, and all its contents, on the Ethereal Plane. You must touch the chest and the miniature replica that serves as a material component for the spell. The chest can contain up to 12 cubic feet of nonliving material (3 feet by 2 feet by 2 feet).

While the chest remains on the Ethereal Plane, you can use an action and touch the replica to recall the chest. It appears in an unoccupied space on the ground within 5 feet of you. You can send the chest back to the Ethereal Plane by using an action and touching both the chest and the replica.

After 60 days, there is a cumulative 5 percent chance per day that the spell''s effect ends. This effect ends if you cast this spell again, if the smaller replica chest is destroyed, or if you choose to end the spell as an action. If the spell ends and the larger chest is on the Ethereal Plane, it is irretrievably lost.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-see-invisibility-0', 'srd', NULL, 'Spell: See Invisibility', 'See Invisibility. Level 2 Divination. Casting time: 1 action. Range: Self. Duration: 1 hour. For the duration of the spell, you see invisible creatures and objects as if they were visible, and you can see through Ethereal. The ethereal objects and creatures appear ghostly translucent.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-seeming-0', 'srd', NULL, 'Spell: Seeming (1)', 'Seeming. Level 5 Illusion. Casting time: 1 action. Range: 30 feet. Duration: 8 hours. This spell allows you to change the appearance of any number of creatures that you can see within range. You give each target you choose a new, illusory appearance. An unwilling target can make a charisma saving throw, and if it succeeds, it is unaffected by this spell.

The spell disguises physical appearance as well as clothing, armor, weapons, and equipment. You can make each creature seem 1 foot shorter or taller and appear thin, fat, or in between. You can''t change a target''s body type, so you must choose a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you. The spell lasts for the duration, unless you use your action to dismiss it sooner.

The changes wrought by this spell fail to hold up to physical inspection. For example, if you use this spell to add a hat to a creature''s outfit, objects pass through the hat, and anyone who touches it would feel nothing or would feel the creature''s head and hair. If you use this spell to appear thinner than you are, the hand of someone who reaches out to touch you would bump into you while it was seemingly still in midair.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-seeming-1', 'srd', NULL, 'Spell: Seeming (2)', 'A creature can use its action to inspect a target and make an Intelligence (Investigation) check against your spell save DC. If it succeeds, it becomes aware that the target is disguised.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sending-0', 'srd', NULL, 'Spell: Sending', 'Sending. Level 3 Evocation. Casting time: 1 action. Range: Unlimited. Duration: 1 round. You send a short message of twenty-five words or less to a creature with which you are familiar. The creature hears the message in its mind, recognizes you as the sender if it knows you, and can answer in a like manner immediately. The spell enables creatures with Intelligence scores of at least 1 to understand the meaning of your message.

You can send the message across any distance and even to other planes of existence, but if the target is on a different plane than you, there is a 5 percent chance that the message doesn''t arrive.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sequester-0', 'srd', NULL, 'Spell: Sequester', 'Sequester. Level 7 Transmutation. Casting time: 1 action. Range: Touch. Duration: Until dispelled. By means of this spell, a willing creature or an object can be hidden away, safe from detection for the duration. When you cast the spell and touch the target, it becomes invisible and can''t be targeted by divination spells or perceived through scrying sensors created by divination spells.

If the target is a creature, it falls into a state of suspended animation. Time ceases to flow for it, and it doesn''t grow older.

You can set a condition for the spell to end early. The condition can be anything you choose, but it must occur or be visible within 1 mile of the target. Examples include "after 1,000 years" or "when the tarrasque awakens." This spell also ends if the target takes any damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shapechange-0', 'srd', NULL, 'Spell: Shapechange (1)', 'Shapechange. Level 9 Transmutation. Casting time: 1 action. Range: Self. Duration: Up to 1 hour. You assume the form of a different creature for the duration. The new form can be of any creature with a challenge rating equal to your level or lower. The creature can''t be a construct or an undead, and you must have seen the sort of creature at least once. You transform into an average example of that creature, one without any class levels or the Spellcasting trait.

Your game statistics are replaced by the statistics of the chosen creature, though you retain your alignment and Intelligence, Wisdom, and Charisma scores. You also retain all of your skill and saving throw proficiencies, in addition to gaining those of the creature. If the creature has the same proficiency as you and the bonus listed in its statistics is higher than yours, use the creature''s bonus in place of yours. You can''t use any legendary actions or lair actions of the new form.

You assume the hit points and Hit Dice of the new form. When you revert to your normal form, you return to the number of hit points you had before you transformed. If you revert as a result of dropping to 0 hit points, any excess damage carries over to your normal form. As long as the excess damage doesn''t reduce your normal form to 0 hit points, you aren''t knocked unconscious.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shapechange-1', 'srd', NULL, 'Spell: Shapechange (2)', 'You retain the benefit of any features from your class, race, or other source and can use them, provided that your new form is physically capable of doing so. You can''t use any special senses you have (for example, darkvision) unless your new form also has that sense. You can only speak if the creature can normally speak.

When you transform, you choose whether your equipment falls to the ground, merges into the new form, or is worn by it. Worn equipment functions as normal. The GM determines whether it is practical for the new form to wear a piece of equipment, based on the creature''s shape and size. Your equipment doesn''t change shape or size to match the new form, and any equipment that the new form can''t wear must either fall to the ground or merge into your new form. Equipment that merges has no effect in that state.

During this spell''s duration, you can use your action to assume a different form following the same restrictions and rules for the original form, with one exception: if your new form has more hit points than your current one, your hit points remain at their current value.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shatter-0', 'srd', NULL, 'Spell: Shatter', 'Shatter. Level 2 Evocation. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw.

A non-magical item that is not worn or carried also suffers damage if it is in the area of the spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shield-0', 'srd', NULL, 'Spell: Shield', 'Shield. Level 1 Abjuration. Casting time: 1 reaction. Range: Self. Duration: 1 round. An invisible barrier of magical force appears and protects you. Until the start of your next turn, you have a +5 bonus to AC, including against the triggering attack, and you take no damage from magic missile.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shield-of-faith-0', 'srd', NULL, 'Spell: Shield of Faith', 'Shield of Faith. Level 1 Abjuration. Casting time: 1 bonus action. Range: 60 feet. Duration: Up to 10 minutes. A shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to AC for the duration.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shillelagh-0', 'srd', NULL, 'Spell: Shillelagh', 'Shillelagh. Cantrip Transmutation. Casting time: 1 bonus action. Range: Touch. Duration: 1 minute. The wood of a club or a quarterstaff you are holding is imbued with nature''s power. For the duration, you can use your spellcasting ability instead of Strength for the attack and damage rolls of melee attacks using that weapon, and the weapon''s damage die becomes a d8. The weapon also becomes magical, if it isn''t already. The spell ends if you cast it again or if you let go of the weapon.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-shocking-grasp-0', 'srd', NULL, 'Spell: Shocking Grasp', 'Shocking Grasp. Cantrip Evocation. Casting time: 1 action. Range: Touch. Duration: Instantaneous. Lightning springs from your hand to deliver a shock to a creature you try to touch. Make a melee spell attack against the target. You have advantage on the attack roll if the target is wearing armor made of metal. On a hit, the target takes 1d8 lightning damage, and it can''t take reactions until the start of its next turn.

The spell''s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-silence-0', 'srd', NULL, 'Spell: Silence', 'Silence. Level 2 Illusion. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. For the duration, no sound can be created within or pass through a 20-foot-radius sphere centered on a point you choose within range. Any creature or object entirely inside the sphere is immune to thunder damage, and creatures are deafened while entirely inside it.

Casting a spell that includes a verbal component is impossible there.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-silent-image-0', 'srd', NULL, 'Spell: Silent Image', 'Silent Image. Level 1 Illusion. Casting time: 1 action. Range: 60 feet. Duration: Up to 10 minutes. You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn''t accompanied by sound, smell, or other sensory effects.

You can use your action to cause the image to move to any spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. For example, if you create an image of a creature and move it, you can alter the image so that it appears to be walking.

Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-simulacrum-0', 'srd', NULL, 'Spell: Simulacrum', 'Simulacrum. Level 7 Illusion. Casting time: 12 hours. Range: Touch. Duration: Until dispelled. You shape an illusory duplicate of one beast or humanoid that is within range for the entire casting time of the spell. The duplicate is a creature, partially real and formed from ice or snow, and it can take actions and otherwise be affected as a normal creature. It appears to be the same as the original, but it has half the creature''s hit point maximum and is formed without any equipment. Otherwise, the illusion uses all the statistics of the creature it duplicates.

The simulacrum is friendly to you and creatures you designate. It obeys your spoken commands, moving and acting in accordance with your wishes and acting on your turn in combat. The simulacrum lacks the ability to learn or become more powerful, so it never increases its level or other abilities, nor can it regain expended spell slots.

If the simulacrum is damaged, you can repair it in an alchemical laboratory, using rare herbs and minerals worth 100 gp per hit point it regains. The simulacrum lasts until it drops to 0 hit points, at which point it reverts to snow and melts instantly.

If you cast this spell again, any currently active duplicates you created with this spell are instantly destroyed.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sleep-0', 'srd', NULL, 'Spell: Sleep', 'Sleep. Level 1 Enchantment. Casting time: 1 action. Range: 90 feet. Duration: 1 minute. This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points (ignoring unconscious creatures).

Starting with the creature that has the lowest current hit points, each creature affected by this spell falls unconscious until the spell ends, the sleeper takes damage, or someone uses an action to shake or slap the sleeper awake. Subtract each creature''s hit points from the total before moving on to the creature with the next lowest hit points. A creature''s hit points must be equal to or less than the remaining total for that creature to be affected.

Undead and creatures immune to being charmed aren''t affected by this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sleet-storm-0', 'srd', NULL, 'Spell: Sleet Storm', 'Sleet Storm. Level 3 Conjuration. Casting time: 1 action. Range: 150 feet. Duration: Up to 1 minute. Until the spell ends, freezing rain and sleet fall in a 20-foot-tall cylinder with a 40-foot radius centered on a point you choose within range. The area is heavily obscured, and exposed flames in the area are doused.

The ground in the area is covered with slick ice, making it difficult terrain. When a creature enters the spell''s area for the first time on a turn or starts its turn there, it must make a dexterity saving throw. On a failed save, it falls prone.

If a creature is concentrating in the spell''s area, the creature must make a successful constitution saving throw against your spell save DC or lose concentration.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-slow-0', 'srd', NULL, 'Spell: Slow', 'Slow. Level 3 Transmutation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. You alter time around up to six creatures of your choice in a 40-foot cube within range. Each target must succeed on a wisdom saving throw or be affected by this spell for the duration.

An affected target''s speed is halved, it takes a -2 penalty to AC and dexterity saving throws, and it can''t use reactions. On its turn, it can use either an action or a bonus action, not both. Regardless of the creature''s abilities or magic items, it can''t make more than one melee or ranged attack during its turn.

If the creature attempts to cast a spell with a casting time of 1 action, roll a d20. On an 11 or higher, the spell doesn''t take effect until the creature''s next turn, and the creature must use its action on that turn to complete the spell. If it can''t, the spell is wasted.

A creature affected by this spell makes another wisdom saving throw at the end of its turn. On a successful save, the effect ends for it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-spare-the-dying-0', 'srd', NULL, 'Spell: Spare the Dying', 'Spare the Dying. Cantrip Necromancy. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You touch a living creature that has 0 hit points. The creature becomes stable. This spell has no effect on undead or constructs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-speak-with-animals-0', 'srd', NULL, 'Spell: Speak with Animals', 'Speak with Animals. Level 1 Divination. Casting time: 1 action. Range: Self. Duration: 10 minutes. You gain the ability to comprehend and verbally communicate with beasts for the duration. The knowledge and awareness of many beasts is limited by their intelligence, but at a minimum, beasts can give you information about nearby locations and monsters, including whatever they can perceive or have perceived within the past day. You might be able to persuade a beast to perform a small favor for you, at the GM''s discretion.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-speak-with-dead-0', 'srd', NULL, 'Spell: Speak with Dead', 'Speak with Dead. Level 3 Necromancy. Casting time: 1 action. Range: 10 feet. Duration: 10 minutes. You grant the semblance of life and intelligence to a corpse of your choice within range, allowing it to answer the questions you pose. The corpse must still have a mouth and can''t be undead. The spell fails if the corpse was the target of this spell within the last 10 days.

Until the spell ends, you can ask the corpse up to five questions. The corpse knows only what it knew in life, including the languages it knew. Answers are usually brief, cryptic, or repetitive, and the corpse is under no compulsion to offer a truthful answer if you are hostile to it or it recognizes you as an enemy. This spell doesn''t return the creature''s soul to its body, only its animating spirit. Thus, the corpse can''t learn new information, doesn''t comprehend anything that has happened since it died, and can''t speculate about future events.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-speak-with-plants-0', 'srd', NULL, 'Spell: Speak with Plants', 'Speak with Plants. Level 3 Transmutation. Casting time: 1 action. Range: Self. Duration: 10 minutes. You imbue plants within 30 feet of you with limited sentience and animation, giving them the ability to communicate with you and follow your simple commands. You can question plants about events in the spell''s area within the past day, gaining information about creatures that have passed, weather, and other circumstances.

You can also turn difficult terrain caused by plant growth (such as thickets and undergrowth) into ordinary terrain that lasts for the duration. Or you can turn ordinary terrain where plants are present into difficult terrain that lasts for the duration, causing vines and branches to hinder pursuers, for example.

Plants might be able to perform other tasks on your behalf, at the GM''s discretion. The spell doesn''t enable plants to uproot themselves and move about, but they can freely move branches, tendrils, and stalks.

If a plant creature is in the area, you can communicate with it as if you shared a common language, but you gain no magical ability to influence it.

This spell can cause the plants created by the entangle spell to release a restrained creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-spider-climb-0', 'srd', NULL, 'Spell: Spider Climb', 'Spider Climb. Level 2 Transmutation. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. Until the spell ends, one willing creature you touch gains the ability to move up, down, and across vertical surfaces and upside down along ceilings, while leaving its hands free. The target also gains a climbing speed equal to its walking speed.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-spike-growth-0', 'srd', NULL, 'Spell: Spike Growth', 'Spike Growth. Level 2 Transmutation. Casting time: 1 action. Range: 150 feet. Duration: Up to 10 minutes. The ground in a 20-foot radius centered on a point within range twists and sprouts hard spikes and thorns. The area becomes difficult terrain for the duration. When a creature moves into or within the area, it takes 2d4 piercing damage for every 5 feet it travels.

The transformation of the ground is camouflaged to look natural. Any creature that can''t see the area at the time the spell is cast can make a Wisdom (Perception) check against your spell save DC to recognize the terrain as hazardous before entering it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-spirit-guardians-0', 'srd', NULL, 'Spell: Spirit Guardians', 'Spirit Guardians. Level 3 Conjuration. Casting time: 1 action. Range: Self. Duration: Up to 10 minutes. You call forth spirits to protect you. They flit around you to a distance of 15 feet for the duration. If you are good or neutral, their spectral form appears angelic or fey (your choice). If you are evil, they appear fiendish.

When you cast this spell, you can designate any number of creatures you can see to be unaffected by it. An affected creature''s speed is halved in the area, and when the creature enters the area for the first time on a turn or starts its turn there, it must make a wisdom saving throw. On a failed save, the creature takes 3d8 radiant damage (if you are good or neutral) or 3d8 necrotic damage (if you are evil). On a successful save, the creature takes half as much damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-spiritual-weapon-0', 'srd', NULL, 'Spell: Spiritual Weapon', 'Spiritual Weapon. Level 2 Evocation. Casting time: 1 bonus action. Range: 60 feet. Duration: 1 minute. You create a floating, spectral weapon within range that lasts for the duration or until you cast this spell again. When you cast the spell, you can make a melee spell attack against a creature within 5 feet of the weapon. On a hit, the target takes force damage equal to 1d8 + your spellcasting ability modifier.

As a bonus action on your turn, you can move the weapon up to 20 feet and repeat the attack against a creature within 5 feet of it.

The weapon can take whatever form you choose. Clerics of deities who are associated with a particular weapon (as St. Cuthbert is known for his mace and Thor for his hammer) make this spell''s effect resemble that weapon.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-stinking-cloud-0', 'srd', NULL, 'Spell: Stinking Cloud', 'Stinking Cloud. Level 3 Conjuration. Casting time: 1 action. Range: 90 feet. Duration: Up to 1 minute. You create a 20-foot-radius sphere of yellow, nauseating gas centered on a point within range. The cloud spreads around corners, and its area is heavily obscured. The cloud lingers in the air for the duration.

Each creature that is completely within the cloud at the start of its turn must make a constitution saving throw against poison. On a failed save, the creature spends its action that turn retching and reeling. Creatures that don''t need to breathe or are immune to poison automatically succeed on this saving throw.

A moderate wind (at least 10 miles per hour) disperses the cloud after 4 rounds. A strong wind (at least 20 miles per hour) disperses it after 1 round.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-stone-shape-0', 'srd', NULL, 'Spell: Stone Shape', 'Stone Shape. Level 4 Transmutation. Casting time: 1 action. Range: Touch. Duration: Instantaneous. You touch a stone object of Medium size or smaller or a section of stone no more than 5 feet in any dimension and form it into any shape that suits your purpose. So, for example, you could shape a large rock into a weapon, idol, or coffer, or make a small passage through a wall, as long as the wall is less than 5 feet thick. You could also shape a stone door or its frame to seal the door shut. The object you create can have up to two hinges and a latch, but finer mechanical detail isn''t possible.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-stoneskin-0', 'srd', NULL, 'Spell: Stoneskin', 'Stoneskin. Level 4 Abjuration. Casting time: 1 action. Range: Touch. Duration: Up to 1 hour. This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-storm-of-vengeance-0', 'srd', NULL, 'Spell: Storm of Vengeance (1)', 'Storm of Vengeance. Level 9 Conjuration. Casting time: 1 action. Range: Sight. Duration: Up to 1 minute. A churning storm cloud forms, centered on a point you can see and spreading to a radius of 360 feet. Lightning flashes in the area, thunder booms, and strong winds roar. Each creature under the cloud (no more than 5,000 feet beneath the cloud) when it appears must make a constitution saving throw. On a failed save, a creature takes 2d6 thunder damage and becomes deafened for 5 minutes.

Each round you maintain concentration on this spell, the storm produces additional effects on your turn.

***Round 2.*** Acidic rain falls from the cloud. Each creature and object under the cloud takes 1d6 acid damage.

***Round 3.*** You call six bolts of lightning from the cloud to strike six creatures or objects of your choice beneath the cloud. A given creature or object can''t be struck by more than one bolt. A struck creature must make a dexterity saving throw. The creature takes 10d6 lightning damage on a failed save, or half as much damage on a successful one.

***Round 4.*** Hailstones rain down from the cloud. Each creature under the cloud takes 2d6 bludgeoning damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-storm-of-vengeance-1', 'srd', NULL, 'Spell: Storm of Vengeance (2)', '***Round 5-10.*** Gusts and freezing rain assail the area under the cloud. The area becomes difficult terrain and is heavily obscured. Each creature there takes 1d6 cold damage. Ranged weapon attacks in the area are impossible. The wind and rain count as a severe distraction for the purposes of maintaining concentration on spells. Finally, gusts of strong wind (ranging from 20 to 50 miles per hour) automatically disperse fog, mists, and similar phenomena in the area, whether mundane or magical.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-suggestion-0', 'srd', NULL, 'Spell: Suggestion', 'Suggestion. Level 2 Enchantment. Casting time: 1 action. Range: 30 feet. Duration: Up to 8 hours. You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can''t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act ends the spell.

The target must make a wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.

You can also specify conditions that will trigger a special activity during the duration. For example, you might suggest that a knight give her warhorse to the first beggar she meets. If the condition isn''t met before the spell expires, the activity isn''t performed.

If you or any of your companions damage the target, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sunbeam-0', 'srd', NULL, 'Spell: Sunbeam', 'Sunbeam. Level 6 Evocation. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. A beam of brilliant light flashes out from your hand in a 5-foot-wide, 60-foot-long line. Each creature in the line must make a constitution saving throw. On a failed save, a creature takes 6d8 radiant damage and is blinded until your next turn. On a successful save, it takes half as much damage and isn''t blinded by this spell. Undead and oozes have disadvantage on this saving throw.

You can create a new line of radiance as your action on any turn until the spell ends.

For the duration, a mote of brilliant radiance shines in your hand. It sheds bright light in a 30-foot radius and dim light for an additional 30 feet. This light is sunlight.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-sunburst-0', 'srd', NULL, 'Spell: Sunburst', 'Sunburst. Level 8 Evocation. Casting time: 1 action. Range: 150 feet. Duration: Instantaneous. Brilliant sunlight flashes in a 60-foot radius centered on a point you choose within range. Each creature in that light must make a constitution saving throw. On a failed save, a creature takes 12d6 radiant damage and is blinded for 1 minute. On a successful save, it takes half as much damage and isn''t blinded by this spell. Undead and oozes have disadvantage on this saving throw.

A creature blinded by this spell makes another constitution saving throw at the end of each of its turns. On a successful save, it is no longer blinded.

This spell dispels any darkness in its area that was created by a spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-symbol-0', 'srd', NULL, 'Spell: Symbol (1)', 'Symbol. Level 7 Abjuration. Casting time: 1 minute. Range: Touch. Duration: Until dispelled. When you cast this spell, you inscribe a harmful glyph either on a surface (such as a section of floor, a wall, or a table) or within an object that can be closed to conceal the glyph (such as a book, a scroll, or a treasure chest). If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered.

The glyph is nearly invisible, requiring an Intelligence (Investigation) check against your spell save DC to find it.

You decide what triggers the glyph when you cast the spell. For glyphs inscribed on a surface, the most typical triggers include touching or stepping on the glyph, removing another object covering it, approaching within a certain distance of it, or manipulating the object that holds it. For glyphs inscribed within an object, the most common triggers are opening the object, approaching within a certain distance of it, or seeing or reading the glyph.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-symbol-1', 'srd', NULL, 'Spell: Symbol (2)', 'You can further refine the trigger so the spell is activated only under certain circumstances or according to a creature''s physical characteristics (such as height or weight), or physical kind (for example, the ward could be set to affect hags or shapechangers). You can also specify creatures that don''t trigger the glyph, such as those who say a certain password.

When you inscribe the glyph, choose one of the options below for its effect. Once triggered, the glyph glows, filling a 60-foot-radius sphere with dim light for 10 minutes, after which time the spell ends. Each creature in the sphere when the glyph activates is targeted by its effect, as is a creature that enters the sphere for the first time on a turn or ends its turn there.

***Death.*** Each target must make a constitution saving throw, taking 10d 10 necrotic damage on a failed save, or half as much damage on a successful save.

***Discord.*** Each target must make a constitution saving throw. On a failed save, a target bickers and argues with other creatures for 1 minute. During this time, it is incapable of meaningful communication and has disadvantage on attack rolls and ability checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-symbol-2', 'srd', NULL, 'Spell: Symbol (3)', '***Fear.*** Each target must make a wisdom saving throw and becomes frightened for 1 minute on a failed save. While frightened, the target drops whatever it is holding and must move at least 30 feet away from the glyph on each of its turns, if able.

***Hopelessness.*** Each target must make a charisma saving throw. On a failed save, the target is overwhelmed with despair for 1 minute. During this time, it can''t attack or target any creature with harmful abilities, spells, or other magical effects.

***Insanity.*** Each target must make an intelligence saving throw. On a failed save, the target is driven insane for 1 minute. An insane creature can''t take actions, can''t understand what other creatures say, can''t read, and speaks only in gibberish. The GM controls its movement, which is erratic.

***Pain.*** Each target must make a constitution saving throw and becomes incapacitated with excruciating pain for 1 minute on a failed save.

***Sleep.*** Each target must make a wisdom saving throw and falls unconscious for 10 minutes on a failed save. A creature awakens if it takes damage or if someone uses an action to shake or slap it awake.

***Stunning.*** Each target must make a wisdom saving throw and becomes stunned for 1 minute on a failed save.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-telekinesis-0', 'srd', NULL, 'Spell: Telekinesis (1)', 'Telekinesis. Level 5 Transmutation. Casting time: 1 action. Range: 60 feet. Duration: Up to 10 minutes. You gain the ability to move or manipulate creatures or objects by thought. When you cast the spell, and as your action each round for the duration, you can exert your will on one creature or object that you can see within range, causing the appropriate effect below. You can affect the same target round after round, or choose a new one at any time. If you switch targets, the prior target is no longer affected by the spell.

***Creature.*** You can try to move a Huge or smaller creature. Make an ability check with your spellcasting ability contested by the creature''s Strength check. If you win the contest, you move the creature up to 30 feet in any direction, including upward but not beyond the range of this spell. Until the end of your next turn, the creature is restrained in your telekinetic grip. A creature lifted upward is suspended in mid-air.

On subsequent rounds, you can use your action to attempt to maintain your telekinetic grip on the creature by repeating the contest.

***Object.*** You can try to move an object that weighs up to 1,000 pounds. If the object isn''t being worn or carried, you automatically move it up to 30 feet in any direction, but not beyond the range of this spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-telekinesis-1', 'srd', NULL, 'Spell: Telekinesis (2)', 'If the object is worn or carried by a creature, you must make an ability check with your spellcasting ability contested by that creature''s Strength check. If you succeed, you pull the object away from that creature and can move it up to 30 feet in any direction but not beyond the range of this spell.

You can exert fine control on objects with your telekinetic grip, such as manipulating a simple tool, opening a door or a container, stowing or retrieving an item from an open container, or pouring the contents from a vial.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-telepathic-bond-0', 'srd', NULL, 'Spell: Telepathic Bond', 'Telepathic Bond. Level 5 Divination. Casting time: 1 action. Range: 30 feet. Duration: 1 hour. You forge a telepathic link among up to eight willing creatures of your choice within range, psychically linking each creature to all the others for the duration. Creatures with Intelligence scores of 2 or less aren''t affected by this spell.

Until the spell ends, the targets can communicate telepathically through the bond whether or not they have a common language. The communication is possible over any distance, though it can''t extend to other planes of existence.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-teleport-0', 'srd', NULL, 'Spell: Teleport (1)', 'Teleport. Level 7 Conjuration. Casting time: 1 action. Range: 10 feet. Duration: Instantaneous. This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can''t be held or carried by an unwilling creature.

The destination you choose must be known to you, and it must be on the same plane of existence as you. Your familiarity with the destination determines whether you arrive there successfully. The GM rolls d100 and consults the table.

| Familiarity | Mishap | Similar Area | Off Target | On Target |

|---|---|---|---|---|

| Permanent circle | -- | -- | -- | 01-100 |

| Associated object | -- | -- | -- | 01-100 |

| Very familiar | 01-05 | 06-13 | 14-24 | 25-100 |

| Seen casually | 01-33 | 34-43 | 44-53 | 54-100 |

| Viewed once | 01-43 | 44-53 | 54-73 | 74-100 |

| Description | 01-43 | 44-53 | 54-73 | 74-100 |

| False destination | 01-50 | 51-100 | -- | -- |

***Familiarity.*** "Permanent circle" means a permanent teleportation circle whose sigil sequence you know.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-teleport-1', 'srd', NULL, 'Spell: Teleport (2)', '"Associated object" means that you possess an object taken from the desired destination within the last six months, such as a book from a wizard''s library, bed linen from a royal suite, or a chunk of marble from a lich''s secret tomb.

"Very familiar" is a place you have been very often, a place you have carefully studied, or a place you can see when you cast the spell.

"Seen casually" is someplace you have seen more than once but with which you aren''t very familiar.

"Viewed once" is a place you have seen once, possibly using magic.

"Description" is a place whose location and appearance you know through someone else''s description, perhaps from a map.

"False destination" is a place that doesn''t exist. Perhaps you tried to scry an enemy''s sanctum but instead viewed an illusion, or you are attempting to teleport to a familiar location that no longer exists.

***On Target.*** You and your group (or the target object) appear where you want to.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-teleport-2', 'srd', NULL, 'Spell: Teleport (3)', '***Off Target.*** You and your group (or the target object) appear a random distance away from the destination in a random direction. Distance off target is 1d10 x 1d10 percent of the distance that was to be traveled. For example, if you tried to travel 120 miles, landed off target, and rolled a 5 and 3 on the two d10s, then you would be off target by 15 percent, or 18 miles. The GM determines the direction off target randomly by rolling a d8 and designating 1 as north, 2 as northeast, 3 as east, and so on around the points of the compass.  If you were teleporting to a coastal city and wound up 18 miles out at sea, you could be in trouble.

***Similar Area.*** You and your group (or the target object) wind up in a different area that''s visually or thematically similar to the target area. If you are heading for your home laboratory, for example, you might wind up in another wizard''s laboratory or in an alchemical supply shop that has many of the same tools and implements as your laboratory. Generally, you appear in the closest similar place, but since the spell has no range limit, you could conceivably wind up anywhere on the plane.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-teleport-3', 'srd', NULL, 'Spell: Teleport (4)', '***Mishap.*** The spell''s unpredictable magic results in a difficult journey. Each teleporting creature (or the target object) takes 3d10 force damage, and the GM rerolls on the table to see where you wind up (multiple mishaps can occur, dealing damage each time).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-teleportation-circle-0', 'srd', NULL, 'Spell: Teleportation Circle', 'Teleportation Circle. Level 5 Conjuration. Casting time: 1 minute. Range: 10 feet. Duration: 1 round. As you cast the spell, you draw a 10-foot-diameter circle on the ground inscribed with sigils that link your location to a permanent teleportation circle of your choice whose sigil sequence you know and that is on the same plane of existence as you. A shimmering portal opens within the circle you drew and remains open until the end of your next turn. Any creature that enters the portal instantly appears within 5 feet of the destination circle or in the nearest unoccupied space if that space is occupied.

Many major temples, guilds, and other important places have permanent teleportation circles inscribed somewhere within their confines. Each such circle includes a unique sigil sequence--a string of magical runes arranged in a particular pattern. When you first gain the ability to cast this spell, you learn the sigil sequences for two destinations on the Material Plane, determined by the GM. You can learn additional sigil sequences during your adventures. You can commit a new sigil sequence to memory after studying it for 1 minute.

You can create a permanent teleportation circle by casting this spell in the same location every day for one year. You need not use the circle to teleport when you cast the spell in this way.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-thaumaturgy-0', 'srd', NULL, 'Spell: Thaumaturgy', 'Thaumaturgy. Cantrip Transmutation. Casting time: 1 action. Range: 30 feet. Duration: 1 minute. You manifest a minor wonder, a sign of supernatural power, within range. You create one of the following magical effects within range.

- Your voice booms up to three times as loud as normal for 1 minute.

- You cause flames to flicker, brighten, dim, or change color for 1 minute.

- You cause harmless tremors in the ground for 1 minute.

- You create an instantaneous sound that originates from a point of your choice within range, such as a rumble of thunder, the cry of a raven, or ominous whispers.

- You instantaneously cause an unlocked door or window to fly open or slam shut.

- You alter the appearance of your eyes for 1 minute.

If you cast this spell multiple times, you can have up to three of its 1-minute effects active at a time, and you can dismiss such an effect as an action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-thunderwave-0', 'srd', NULL, 'Spell: Thunderwave', 'Thunderwave. Level 1 Evocation. Casting time: 1 action. Range: Self. Duration: Instantaneous. A wave of thunderous force sweeps out from you. Each creature in a 15-foot cube originating from you must make a constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn''t pushed.

In addition, unsecured objects that are completely within the area of effect are automatically pushed 10 feet away from you by the spell''s effect, and the spell emits a thunderous boom audible out to 300 feet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-time-stop-0', 'srd', NULL, 'Spell: Time Stop', 'Time Stop. Level 9 Transmutation. Casting time: 1 action. Range: Self. Duration: Instantaneous. You briefly stop the flow of time for everyone but yourself. No time passes for other creatures, while you take 1d4 + 1 turns in a row, during which you can use actions and move as normal.

This spell ends if one of the actions you use during this period, or any effects that you create during this period, affects a creature other than you or an object being worn or carried by someone other than you. In addition, the spell ends if you move to a place more than 1,000 feet from the location where you cast it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-tiny-hut-0', 'srd', NULL, 'Spell: Tiny Hut', 'Tiny Hut. Level 3 Evocation. Casting time: 1 minute. Range: Self. Duration: 8 hours. A 10-foot-radius immobile dome of force springs into existence around and above you and remains stationary for the duration. The spell ends if you leave its area.

Nine creatures of Medium size or smaller can fit inside the dome with you. The spell fails if its area includes a larger creature or more than nine creatures. Creatures and objects within the dome when you cast this spell can move through it freely. All other creatures and objects are barred from passing through it. Spells and other magical effects can''t extend through the dome or be cast through it. The atmosphere inside the space is comfortable and dry, regardless of the weather outside.

Until the spell ends, you can command the interior to become dimly lit or dark. The dome is opaque from the outside, of any color you choose, but it is transparent from the inside.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-tongues-0', 'srd', NULL, 'Spell: Tongues', 'Tongues. Level 3 Divination. Casting time: 1 action. Range: Touch. Duration: 1 hour. This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-transport-via-plants-0', 'srd', NULL, 'Spell: Transport via Plants', 'Transport via Plants. Level 6 Conjuration. Casting time: 1 action. Range: 10 feet. Duration: 1 round. This spell creates a magical link between a Large or larger inanimate plant within range and another plant, at any distance, on the same plane of existence. You must have seen or touched the destination plant at least once before. For the duration, any creature can step into the target plant and exit from the destination plant by using 5 feet of movement.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-tree-stride-0', 'srd', NULL, 'Spell: Tree Stride', 'Tree Stride. Level 5 Conjuration. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. You gain the ability to enter a tree and move from inside it to inside another tree of the same kind within 500 feet. Both trees must be living and at least the same size as you. You must use 5 feet of movement to enter a tree. You instantly know the location of all other trees of the same kind within 500 feet and, as part of the move used to enter the tree, can either pass into one of those trees or step out of the tree you''re in. You appear in a spot of your choice within 5 feet of the destination tree, using another 5 feet of movement. If you have no movement left, you appear within 5 feet of the tree you entered.

You can use this transportation ability once per round for the duration. You must end each turn outside a tree.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-true-polymorph-0', 'srd', NULL, 'Spell: True Polymorph (1)', 'True Polymorph. Level 9 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 hour. Choose one creature or nonmagical object that you can see within range. You transform the creature into a different creature, the creature into an object, or the object into a creature (the object must be neither worn nor carried by another creature). The transformation lasts for the duration, or until the target drops to 0 hit points or dies. If you concentrate on this spell for the full duration, the transformation becomes permanent.

Shapechangers aren''t affected by this spell. An unwilling creature can make a wisdom saving throw, and if it succeeds, it isn''t affected by this spell.

***Creature into Creature.*** If you turn a creature into another kind of creature, the new form can be any kind you choose whose challenge rating is equal to or less than the target''s (or its level, if the target doesn''t have a challenge rating). The target''s game statistics, including mental ability scores, are replaced by the statistics of the new form. It retains its alignment and personality.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-true-polymorph-1', 'srd', NULL, 'Spell: True Polymorph (2)', 'The target assumes the hit points of its new form, and when it reverts to its normal form, the creature returns to the number of hit points it had before it transformed. If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form. As long as the excess damage doesn''t reduce the creature''s normal form to 0 hit points, it isn''t knocked unconscious.

The creature is limited in the actions it can perform by the nature of its new form, and it can''t speak, cast spells, or take any other action that requires hands or speech unless its new form is capable of such actions.

The target''s gear melds into the new form. The creature can''t activate, use, wield, or otherwise benefit from any of its equipment.

***Object into Creature.*** You can turn an object into any kind of creature, as long as the creature''s size is no larger than the object''s size and the creature''s challenge rating is 9 or lower. The creature is friendly to you and your companions. It acts on each of your turns. You decide what action it takes and how it moves. The GM has the creature''s statistics and resolves all of its actions and movement.

If the spell becomes permanent, you no longer control the creature. It might remain friendly to you, depending on how you have treated it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-true-polymorph-2', 'srd', NULL, 'Spell: True Polymorph (3)', '***Creature into Object.*** If you turn a creature into an object, it transforms along with whatever it is wearing and carrying into that form. The creature''s statistics become those of the object, and the creature has no memory of time spent in this form, after the spell ends and it returns to its normal form.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-true-resurrection-0', 'srd', NULL, 'Spell: True Resurrection', 'True Resurrection. Level 9 Necromancy. Casting time: 1 hour. Range: Touch. Duration: Instantaneous. You touch a creature that has been dead for no longer than 200 years and that died for any reason except old age. If the creature''s soul is free and willing, the creature is restored to life with all its hit points.

This spell closes all wounds, neutralizes any poison, cures all diseases, and lifts any curses affecting the creature when it died. The spell replaces damaged or missing organs and limbs.

The spell can even provide a new body if the original no longer exists, in which case you must speak the creature''s name. The creature then appears in an unoccupied space you choose within 10 feet of you.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-true-seeing-0', 'srd', NULL, 'Spell: True Seeing', 'True Seeing. Level 6 Divination. Casting time: 1 action. Range: Touch. Duration: 1 hour. This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-true-strike-0', 'srd', NULL, 'Spell: True Strike', 'True Strike. Cantrip Divination. Casting time: 1 action. Range: 30 feet. Duration: Up to 1 round. You extend your hand and point a finger at a target in range. Your magic grants you a brief insight into the target''s defenses. On your next turn, you gain advantage on your first attack roll against the target, provided that this spell hasn''t ended.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-unseen-servant-0', 'srd', NULL, 'Spell: Unseen Servant', 'Unseen Servant. Level 1 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: 1 hour. This spell creates an invisible, mindless, shapeless force that performs simple tasks at your command until the spell ends. The servant springs into existence in an unoccupied space on the ground within range. It has AC 10, 1 hit point, and a Strength of 2, and it can''t attack. If it drops to 0 hit points, the spell ends.

Once on each of your turns as a bonus action, you can mentally command the servant to move up to 15 feet and interact with an object. The servant can perform simple tasks that a human servant could do, such as fetching things, cleaning, mending, folding clothes, lighting fires, serving food, and pouring wine. Once you give the command, the servant performs the task to the best of its ability until it completes the task, then waits for your next command.

If you command the servant to perform a task that would move it more than 60 feet away from you, the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-vampiric-touch-0', 'srd', NULL, 'Spell: Vampiric Touch', 'Vampiric Touch. Level 3 Necromancy. Casting time: 1 action. Range: Self. Duration: Up to 1 minute. The touch of your shadow-wreathed hand can siphon life force from others to heal your wounds. Make a melee spell attack against a creature within your reach. On a hit, the target takes 3d6 necrotic damage, and you regain hit points equal to half the amount of necrotic damage dealt. Until the spell ends, you can make the attack again on each of your turns as an action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-vicious-mockery-0', 'srd', NULL, 'Spell: Vicious Mockery', 'Vicious Mockery. Cantrip Enchantment. Casting time: 1 action. Range: 60 feet. Duration: Instantaneous. You unleash a string of insults laced with subtle enchantments at a creature you can see within range. If the target can hear you (though it need not understand you), it must succeed on a wisdom saving throw or take 1d4 psychic damage and have disadvantage on the next attack roll it makes before the end of its next turn.

This spell''s damage increases by 1d4 when you reach 5th level (2d4), 11th level (3d4), and 17th level (4d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wall-of-fire-0', 'srd', NULL, 'Spell: Wall of Fire', 'Wall of Fire. Level 4 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. You create a wall of fire on a solid surface within range. You can make the wall up to 60 feet long, 20 feet high, and 1 foot thick, or a ringed wall up to 20 feet in diameter, 20 feet high, and 1 foot thick. The wall is opaque and lasts for the duration.

When the wall appears, each creature within its area must make a Dexterity saving throw. On a failed save, a creature takes 5d8 fire damage, or half as much damage on a successful save.

One side of the wall, selected by you when you cast this spell, deals 5d8 fire damage to each creature that ends its turn within 10 feet o f that side or inside the wall. A creature takes the same damage when it enters the wall for the first time on a turn or ends its turn there. The other side of the wall deals no damage.

The other side of the wall deals no damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wall-of-force-0', 'srd', NULL, 'Spell: Wall of Force', 'Wall of Force. Level 5 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. An invisible wall of force springs into existence at a point you choose within range. The wall appears in any orientation you choose, as a horizontal or vertical barrier or at an angle. It can be free floating or resting on a solid surface. You can form it into a hemispherical dome or a sphere with a radius of up to 10 feet, or you can shape a flat surface made up of ten 10-foot-by-10-foot panels. Each panel must be contiguous with another panel. In any form, the wall is 1/4 inch thick. It lasts for the duration. If the wall cuts through a creature''s space when it appears, the creature is pushed to one side of the wall (your choice which side).

Nothing can physically pass through the wall. It is immune to all damage and can''t be dispelled by dispel magic. A disintegrate spell destroys the wall instantly, however. The wall also extends into the Ethereal Plane, blocking ethereal travel through the wall.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wall-of-ice-0', 'srd', NULL, 'Spell: Wall of Ice', 'Wall of Ice. Level 6 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. You create a wall of ice on a solid surface within range. You can form it into a hemispherical dome or a sphere with a radius of up to 10 feet, or you can shape a flat surface made up of ten 10-foot-square panels. Each panel must be contiguous with another panel. In any form, the wall is 1 foot thick and lasts for the duration.

If the wall cuts through a creature''s space when it appears, the creature within its area is pushed to one side of the wall and must make a dexterity saving throw. On a failed save, the creature takes 10d6 cold damage, or half as much damage on a successful save.

The wall is an object that can be damaged and thus breached. It has AC 12 and 30 hit points per 10-foot section, and it is vulnerable to fire damage. Reducing a 10-foot section of wall to 0 hit points destroys it and leaves behind a sheet of frigid air in the space the wall occupied. A creature moving through the sheet of frigid air for the first time on a turn must make a constitution saving throw. That creature takes 5d6 cold damage on a failed save, or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wall-of-stone-0', 'srd', NULL, 'Spell: Wall of Stone (1)', 'Wall of Stone. Level 5 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. A nonmagical wall of solid stone springs into existence at a point you choose within range. The wall is 6 inches thick and is composed of ten 10-foot-by-10-foot panels. Each panel must be contiguous with at least one other panel. Alternatively, you can create 10-foot-by-20-foot panels that are only 3 inches thick.

If the wall cuts through a creature''s space when it appears, the creature is pushed to one side of the wall (your choice). If a creature would be surrounded on all sides by the wall (or the wall and another solid surface), that creature can make a dexterity saving throw. On a success, it can use its reaction to move up to its speed so that it is no longer enclosed by the wall.

The wall can have any shape you desire, though it can''t occupy the same space as a creature or object. The wall doesn''t need to be vertical or rest on any firm foundation. It must, however, merge with and be solidly supported by existing stone. Thus, you can use this spell to bridge a chasm or create a ramp.

If you create a span greater than 20 feet in length, you must halve the size of each panel to create supports. You can crudely shape the wall to create crenellations, battlements, and so on.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wall-of-stone-1', 'srd', NULL, 'Spell: Wall of Stone (2)', 'The wall is an object made of stone that can be damaged and thus breached. Each panel has AC 15 and 30 hit points per inch of thickness. Reducing a panel to 0 hit points destroys it and might cause connected panels to collapse at the GM''s discretion.

If you maintain your concentration on this spell for its whole duration, the wall becomes permanent and can''t be dispelled. Otherwise, the wall disappears when the spell ends.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wall-of-thorns-0', 'srd', NULL, 'Spell: Wall of Thorns', 'Wall of Thorns. Level 6 Conjuration. Casting time: 1 action. Range: 120 feet. Duration: Up to 10 minutes. You create a wall of tough, pliable, tangled brush bristling with needle-sharp thorns. The wall appears within range on a solid surface and lasts for the duration. You choose to make the wall up to 60 feet long, 10 feet high, and 5 feet thick or a circle that has a 20-foot diameter and is up to 20 feet high and 5 feet thick. The wall blocks line of sight.

When the wall appears, each creature within its area must make a dexterity saving throw. On a failed save, a creature takes 7d8 piercing damage, or half as much damage on a successful save.

A creature can move through the wall, albeit slowly and painfully. For every 1 foot a creature moves through the wall, it must spend 4 feet of movement. Furthermore, the first time a creature enters the wall on a turn or ends its turn there, the creature must make a dexterity saving throw. It takes 7d8 slashing damage on a failed save, or half as much damage on a successful one.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-warding-bond-0', 'srd', NULL, 'Spell: Warding Bond', 'Warding Bond. Level 2 Abjuration. Casting time: 1 action. Range: Touch. Duration: 1 hour. This spell wards a willing creature you touch and creates a mystic connection between you and the target until the spell ends. While the target is within 60 feet of you, it gains a +1 bonus to AC and saving throws, and it has resistance to all damage. Also, each time it takes damage, you take the same amount of damage.

The spell ends if you drop to 0 hit points or if you and the target become separated by more than 60 feet.

It also ends if the spell is cast again on either of the connected creatures. You can also dismiss the spell as an action.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-water-breathing-0', 'srd', NULL, 'Spell: Water Breathing', 'Water Breathing. Level 3 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: 24 hours. This spell gives a maximum of ten willing creatures within range and you can see, the ability to breathe underwater until the end of its term. Affected creatures also retain their normal breathing pattern.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-water-walk-0', 'srd', NULL, 'Spell: Water Walk', 'Water Walk. Level 3 Transmutation. Casting time: 1 action. Range: 30 feet. Duration: 1 hour. This spell grants the ability to move across any liquid surface--such as water, acid, mud, snow, quicksand, or lava--as if it were harmless solid ground (creatures crossing molten lava can still take damage from the heat). Up to ten willing creatures you can see within range gain this ability for the duration.

If you target a creature submerged in a liquid, the spell carries the target to the surface of the liquid at a rate of 60 feet per round.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-web-0', 'srd', NULL, 'Spell: Web', 'Web. Level 2 Conjuration. Casting time: 1 action. Range: 60 feet. Duration: Up to 1 hour. You conjure a mass of thick, sticky webbing at a point of your choice within range. The webs fill a 20-foot cube from that point for the duration. The webs are difficult terrain and lightly obscure their area.

If the webs aren''t anchored between two solid masses (such as walls or trees) or layered across a floor, wall, or ceiling, the conjured web collapses on itself, and the spell ends at the start of your next turn. Webs layered over a flat surface have a depth of 5 feet.

Each creature that starts its turn in the webs or that enters them during its turn must make a dexterity saving throw. On a failed save, the creature is restrained as long as it remains in the webs or until it breaks free.

A creature restrained by the webs can use its action to make a Strength check against your spell save DC. If it succeeds, it is no longer restrained.

The webs are flammable. Any 5-foot cube of webs exposed to fire burns away in 1 round, dealing 2d4 fire damage to any creature that starts its turn in the fire.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-weird-0', 'srd', NULL, 'Spell: Weird', 'Weird. Level 9 Illusion. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. Drawing on the deepest fears of a group of creatures, you create illusory creatures in their minds, visible only to them. Each creature in a 30-foot-radius sphere centered on a point of your choice within range must make a wisdom saving throw. On a failed save, a creature becomes frightened for the duration. The illusion calls on the creature''s deepest fears, manifesting its worst nightmares as an implacable threat. At the start of each of the frightened creature''s turns, it must succeed on a wisdom saving throw or take 4d10 psychic damage. On a successful save, the spell ends for that creature.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wind-walk-0', 'srd', NULL, 'Spell: Wind Walk', 'Wind Walk. Level 6 Transmutation. Casting time: 1 minute. Range: 30 feet. Duration: 8 hours. You and up to ten willing creatures you can see within range assume a gaseous form for the duration, appearing as wisps of cloud. While in this cloud form, a creature has a flying speed of 300 feet and has resistance to damage from nonmagical weapons. The only actions a creature can take in this form are the Dash action or to revert to its normal form. Reverting takes 1 minute, during which time a creature is incapacitated and can''t move. Until the spell ends, a creature can revert to cloud form, which also requires the 1-minute transformation.

If a creature is in cloud form and flying when the effect ends, the creature descends 60 feet per round for 1 minute until it lands, which it does safely. If it can''t land after 1 minute, the creature falls the remaining distance.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wind-wall-0', 'srd', NULL, 'Spell: Wind Wall', 'Wind Wall. Level 3 Evocation. Casting time: 1 action. Range: 120 feet. Duration: Up to 1 minute. A wall of strong wind rises from the ground at a point you choose within range. You can make the wall up to 50 feet long, 15 feet high, and 1 foot thick. You can shape the wall in any way you choose so long as it makes one continuous path along the ground. The wall lasts for the duration.

When the wall appears, each creature within its area must make a strength saving throw. A creature takes 3d8 bludgeoning damage on a failed save, or half as much damage on a successful one.

The strong wind keeps fog, smoke, and other gases at bay. Small or smaller flying creatures or objects can''t pass through the wall. Loose, lightweight materials brought into the wall fly upward. Arrows, bolts, and other ordinary projectiles launched at targets behind the wall are deflected upward and automatically miss. (Boulders hurled by giants or siege engines, and similar projectiles, are unaffected.) Creatures in gaseous form can''t pass through it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wish-0', 'srd', NULL, 'Spell: Wish (1)', 'Wish. Level 9 Conjuration. Casting time: 1 action. Range: Self. Duration: Instantaneous. Wish is the mightiest spell a mortal creature can cast. By simply speaking aloud, you can alter the very foundations of reality in accord with your desires.

The basic use of this spell is to duplicate any other spell of 8th level or lower. You don''t need to meet any requirements in that spell, including costly components. The spell simply takes effect.

Alternatively, you can create one of the following effects of your choice:

- You create one object of up to 25,000 gp in value that isn''t a magic item. The object can be no more than 300 feet in any dimension, and it appears in an unoccupied space you can see on the ground.

- You allow up to twenty creatures that you can see to regain all hit points, and you end all effects on them described in the greater restoration spell.

- You grant up to ten creatures that you can see resistance to a damage type you choose.

- You grant up to ten creatures you can see immunity to a single spell or other magical effect for 8 hours. For instance, you could make yourself and all your companions immune to a lich''s life drain attack.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wish-1', 'srd', NULL, 'Spell: Wish (2)', '- You undo a single recent event by forcing a reroll of any roll made within the last round (including your last turn). Reality reshapes itself to accommodate the new result. For example, a wish spell could undo an opponent''s successful save, a foe''s critical hit, or a friend''s failed save. You can force the reroll to be made with advantage or disadvantage, and you can choose whether to use the reroll or the original roll.

You might be able to achieve something beyond the scope of the above examples. State your wish to the GM as precisely as possible. The GM has great latitude in ruling what occurs in such an instance; the greater the wish, the greater the likelihood that something goes wrong. This spell might simply fail, the effect you desire might only be partly achieved, or you might suffer some unforeseen consequence as a result of how you worded the wish. For example, wishing that a villain were dead might propel you forward in time to a period when that villain is no longer alive, effectively removing you from the game. Similarly, wishing for a legendary magic item or artifact might instantly transport you to the presence of the item''s current owner.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-wish-2', 'srd', NULL, 'Spell: Wish (3)', 'The stress of casting this spell to produce any effect other than duplicating another spell weakens you. After enduring that stress, each time you cast a spell until you finish a long rest, you take 1d10 necrotic damage per level of that spell. This damage can''t be reduced or prevented in any way. In addition, your Strength drops to 3, if it isn''t 3 or lower already, for 2d4 days. For each of those days that you spend resting and doing nothing more than light activity, your remaining recovery time decreases by 2 days. Finally, there is a 33 percent chance that you are unable to cast wish ever again if you suffer this stress.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-word-of-recall-0', 'srd', NULL, 'Spell: Word of Recall', 'Word of Recall. Level 6 Conjuration. Casting time: 1 action. Range: 5 feet. Duration: Instantaneous. You and up to five willing creatures within 5 feet of you instantly teleport to a previously designated sanctuary. You and any creatures that teleport with you appear in the nearest unoccupied space to the spot you designated when you prepared your sanctuary (see below). If you cast this spell without first preparing a sanctuary, the spell has no effect.

You must designate a sanctuary by casting this spell within a location, such as a temple, dedicated to or strongly linked to your deity. If you attempt to cast the spell in this manner in an area that isn''t dedicated to your deity, the spell has no effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('spell-zone-of-truth-0', 'srd', NULL, 'Spell: Zone of Truth', 'Zone of Truth. Level 2 Enchantment. Casting time: 1 action. Range: 60 feet. Duration: 10 minutes. You create a magical zone that guards against deception in a 15-foot-radius sphere centered on a point of your choice within range. Until the spell ends, a creature that enters the spell''s area for the first time on a turn or starts its turn there must make a Charisma saving throw. On a failed save, a creature can''t speak a deliberate lie while in the radius. You know whether each creature succeeds or fails on its saving throw.

An affected creature is aware of the spell and can thus avoid answering questions to which it would normally respond with a lie. Such a creature can remain evasive in its answers as long as it remains within the boundaries of the truth.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-aboleth', 'srd', NULL, 'Monster: Aboleth', 'Aboleth. Large aberration, CR 10, AC 17, HP 135 (18d10), Dex 9. Attacks: Tentacle +9 (2d6+5 + 1d12); Tail +9 (3d6+5). Multiattack: Tentacle, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-acolyte', 'srd', NULL, 'Monster: Acolyte', 'Acolyte. Medium humanoid, CR 1/4, AC 10, HP 9 (2d8), Dex 10. Attacks: Club +2 (1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-black-dragon', 'srd', NULL, 'Monster: Adult Black Dragon', 'Adult Black Dragon. Huge dragon, CR 14, AC 19, HP 195 (17d12), Dex 14. Attacks: Bite +11 (2d10+6 + 1d8); Claw +11 (2d6+6); Tail +11 (2d8+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-blue-dragon', 'srd', NULL, 'Monster: Adult Blue Dragon', 'Adult Blue Dragon. Huge dragon, CR 16, AC 19, HP 225 (18d12), Dex 10. Attacks: Bite +12 (2d10+7 + 1d10); Claw +12 (2d6+7); Tail +12 (2d8+7). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-brass-dragon', 'srd', NULL, 'Monster: Adult Brass Dragon', 'Adult Brass Dragon. Huge dragon, CR 13, AC 18, HP 172 (15d12), Dex 10. Attacks: Bite +11 (2d10+6); Claw +11 (2d6+6); Tail +11 (2d8+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-bronze-dragon', 'srd', NULL, 'Monster: Adult Bronze Dragon', 'Adult Bronze Dragon. Huge dragon, CR 15, AC 19, HP 212 (17d12), Dex 10. Attacks: Bite +12 (2d10+7); Claw +12 (2d6+7); Tail +12 (2d8+7). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-copper-dragon', 'srd', NULL, 'Monster: Adult Copper Dragon', 'Adult Copper Dragon. Huge dragon, CR 14, AC 18, HP 184 (16d12), Dex 12. Attacks: Bite +11 (2d10+6); Claw +11 (2d6+6); Tail +11 (2d8+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-gold-dragon', 'srd', NULL, 'Monster: Adult Gold Dragon', 'Adult Gold Dragon. Huge dragon, CR 17, AC 19, HP 256 (19d12), Dex 14. Attacks: Bite +14 (2d10+8); Claw +14 (2d6+8); Tail +14 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-green-dragon', 'srd', NULL, 'Monster: Adult Green Dragon', 'Adult Green Dragon. Huge dragon, CR 15, AC 19, HP 207 (18d12), Dex 12. Attacks: Bite +11 (2d10+6 + 2d6); Claw +11 (2d6+6); Tail +11 (2d8+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-red-dragon', 'srd', NULL, 'Monster: Adult Red Dragon', 'Adult Red Dragon. Huge dragon, CR 17, AC 19, HP 256 (19d12), Dex 10. Attacks: Bite +14 (2d10+8 + 2d6); Claw +14 (2d6+8); Tail +14 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-silver-dragon', 'srd', NULL, 'Monster: Adult Silver Dragon', 'Adult Silver Dragon. Huge dragon, CR 16, AC 19, HP 243 (18d12), Dex 10. Attacks: Bite +13 (2d10+8); Claw +13 (2d6+8); Tail +13 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-adult-white-dragon', 'srd', NULL, 'Monster: Adult White Dragon', 'Adult White Dragon. Huge dragon, CR 13, AC 18, HP 200 (16d12), Dex 10. Attacks: Bite +11 (2d10+6 + 1d8); Claw +11 (2d6+6); Tail +11 (2d8+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-air-elemental', 'srd', NULL, 'Monster: Air Elemental', 'Air Elemental. Large elemental, CR 5, AC 15, HP 90 (12d10), Dex 20. Attacks: Slam +8 (2d8+5). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-black-dragon', 'srd', NULL, 'Monster: Ancient Black Dragon', 'Ancient Black Dragon. Gargantuan dragon, CR 21, AC 22, HP 367 (21d20), Dex 14. Attacks: Bite +15 (2d10+8 + 2d8); Claw +15 (2d6+8); Tail +15 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-blue-dragon', 'srd', NULL, 'Monster: Ancient Blue Dragon', 'Ancient Blue Dragon. Gargantuan dragon, CR 23, AC 22, HP 481 (26d20), Dex 10. Attacks: Bite +16 (2d10+9 + 2d10); Claw +16 (2d6+9); Tail +16 (2d8+9). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-brass-dragon', 'srd', NULL, 'Monster: Ancient Brass Dragon', 'Ancient Brass Dragon. Gargantuan dragon, CR 20, AC 20, HP 297 (17d20), Dex 10. Attacks: Bite +14 (2d10+8); Claw +14 (2d6+8); Tail +14 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-bronze-dragon', 'srd', NULL, 'Monster: Ancient Bronze Dragon', 'Ancient Bronze Dragon. Gargantuan dragon, CR 22, AC 22, HP 444 (24d20), Dex 10. Attacks: Bite +16 (2d10+9); Claw +16 (2d6+9); Tail +16 (2d8+9). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-copper-dragon', 'srd', NULL, 'Monster: Ancient Copper Dragon', 'Ancient Copper Dragon. Gargantuan dragon, CR 21, AC 21, HP 350 (20d20), Dex 12. Attacks: Bite +15 (2d10+8); Claw +15 (2d6+8); Tail +15 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-gold-dragon', 'srd', NULL, 'Monster: Ancient Gold Dragon', 'Ancient Gold Dragon. Gargantuan dragon, CR 24, AC 22, HP 546 (28d20), Dex 14. Attacks: Bite +17 (2d10+10); Claw +17 (2d6+10); Tail +17 (2d8+10). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-green-dragon', 'srd', NULL, 'Monster: Ancient Green Dragon', 'Ancient Green Dragon. Gargantuan dragon, CR 22, AC 21, HP 385 (22d20), Dex 12. Attacks: Bite +15 (2d10+8 + 3d6); Claw +15 (4d6+8); Tail +15 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-red-dragon', 'srd', NULL, 'Monster: Ancient Red Dragon', 'Ancient Red Dragon. Gargantuan dragon, CR 24, AC 22, HP 546 (28d20), Dex 10. Attacks: Bite +17 (2d10+10 + 4d6); Claw +17 (2d6+10); Tail +17 (2d8+10). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-silver-dragon', 'srd', NULL, 'Monster: Ancient Silver Dragon', 'Ancient Silver Dragon. Gargantuan dragon, CR 23, AC 22, HP 487 (25d20), Dex 10. Attacks: Bite +17 (2d10+10); Claw +17 (2d6+10); Tail +17 (2d8+10). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ancient-white-dragon', 'srd', NULL, 'Monster: Ancient White Dragon', 'Ancient White Dragon. Gargantuan dragon, CR 20, AC 20, HP 333 (18d20), Dex 10. Attacks: Bite +14 (2d10+8 + 2d8); Claw +14 (2d6+8); Tail +14 (2d8+8). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-androsphinx', 'srd', NULL, 'Monster: Androsphinx', 'Androsphinx. Large monstrosity, CR 17, AC 17, HP 199 (19d10), Dex 10. Attacks: Claw +12 (2d10+6). Multiattack: Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-animated-armor', 'srd', NULL, 'Monster: Animated Armor', 'Animated Armor. Medium construct, CR 1, AC 18, HP 33 (6d8), Dex 11. Attacks: Slam +4 (1d6+2). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ankheg', 'srd', NULL, 'Monster: Ankheg', 'Ankheg. Large monstrosity, CR 2, AC 14, HP 39 (6d10), Dex 11. Attacks: Bite +5 (2d6+3 + 1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ape', 'srd', NULL, 'Monster: Ape', 'Ape. Medium beast, CR 1/2, AC 12, HP 19 (3d8), Dex 14. Attacks: Fist +5 (1d6+3); Rock +5 (1d6+3). Multiattack: Fist, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-archmage', 'srd', NULL, 'Monster: Archmage', 'Archmage. Medium humanoid, CR 12, AC 12, HP 99 (18d8), Dex 14. Attacks: Dagger +6 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-assassin', 'srd', NULL, 'Monster: Assassin', 'Assassin. Medium humanoid, CR 8, AC 15, HP 78 (12d8), Dex 16. Attacks: Shortsword +6 (1d6+3 + 7d6); Light Crossbow +6 (1d8+3 + 7d6). Multiattack: Shortsword, Light Crossbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-awakened-shrub', 'srd', NULL, 'Monster: Awakened Shrub', 'Awakened Shrub. Small plant, CR 0, AC 9, HP 10 (3d6), Dex 8. Attacks: Rake +1 (1d4-1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-awakened-tree', 'srd', NULL, 'Monster: Awakened Tree', 'Awakened Tree. Huge plant, CR 2, AC 13, HP 59 (7d12), Dex 6. Attacks: Slam +6 (3d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-axe-beak', 'srd', NULL, 'Monster: Axe Beak', 'Axe Beak. Large beast, CR 1/4, AC 11, HP 19 (3d10), Dex 12. Attacks: Beak +4 (1d8+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-azer', 'srd', NULL, 'Monster: Azer', 'Azer. Medium elemental, CR 2, AC 15, HP 39 (6d8), Dex 12. Attacks: Warhammer +5 (1d8+3 + 1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-baboon', 'srd', NULL, 'Monster: Baboon', 'Baboon. Small beast, CR 0, AC 12, HP 3 (1d6), Dex 14. Attacks: Bite +1 (1d4-1). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-badger', 'srd', NULL, 'Monster: Badger', 'Badger. Tiny beast, CR 0, AC 10, HP 3 (1d4), Dex 11. Attacks: Bite +2 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-balor', 'srd', NULL, 'Monster: Balor', 'Balor. Huge fiend, CR 19, AC 19, HP 262 (21d12), Dex 15. Attacks: Longsword +14 (3d8+8 + 3d8); Whip +14 (2d6+8 + 3d6). Multiattack: Longsword, Whip.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bandit', 'srd', NULL, 'Monster: Bandit', 'Bandit. Medium humanoid, CR 1/8, AC 12, HP 11 (2d8), Dex 12. Attacks: Scimitar +3 (1d6+1); Light Crossbow +3 (1d8+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bandit-captain', 'srd', NULL, 'Monster: Bandit Captain', 'Bandit Captain. Medium humanoid, CR 2, AC 15, HP 65 (10d8), Dex 16. Attacks: Scimitar +5 (1d6+3); Dagger +5 (1d4+3). Multiattack: Scimitar, Scimitar, Dagger.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-barbed-devil', 'srd', NULL, 'Monster: Barbed Devil', 'Barbed Devil. Medium fiend, CR 5, AC 15, HP 110 (13d8), Dex 17. Attacks: Claw +6 (1d6+3); Tail +6 (2d6+3); Hurl Flame +5 (3d6). Multiattack: Tail, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-basilisk', 'srd', NULL, 'Monster: Basilisk', 'Basilisk. Medium monstrosity, CR 3, AC 12, HP 52 (8d8), Dex 8. Attacks: Bite +5 (2d6+3 + 2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bat', 'srd', NULL, 'Monster: Bat', 'Bat. Tiny beast, CR 0, AC 12, HP 1 (1d4), Dex 15. Attacks: Bite +0 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bearded-devil', 'srd', NULL, 'Monster: Bearded Devil', 'Bearded Devil. Medium fiend, CR 3, AC 13, HP 52 (8d8), Dex 15. Attacks: Beard +5 (1d8+2); Glaive +5 (1d10+3). Multiattack: Beard, Glaive.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-behir', 'srd', NULL, 'Monster: Behir', 'Behir. Huge monstrosity, CR 11, AC 17, HP 168 (16d12), Dex 16. Attacks: Bite +10 (3d10+6); Constrict +10 (2d10+6 + 2d10+6). Multiattack: Bite.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-berserker', 'srd', NULL, 'Monster: Berserker', 'Berserker. Medium humanoid, CR 2, AC 13, HP 67 (9d8), Dex 12. Attacks: Greataxe +5 (1d12+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-black-bear', 'srd', NULL, 'Monster: Black Bear', 'Black Bear. Medium beast, CR 1/2, AC 11, HP 19 (3d8), Dex 10. Attacks: Bite +3 (1d6+2); Claws +3 (2d4+2). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-black-dragon-wyrmling', 'srd', NULL, 'Monster: Black Dragon Wyrmling', 'Black Dragon Wyrmling. Medium dragon, CR 2, AC 17, HP 33 (6d8), Dex 14. Attacks: Bite +4 (1d10+2 + 1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-black-pudding', 'srd', NULL, 'Monster: Black Pudding', 'Black Pudding. Large ooze, CR 4, AC 7, HP 85 (10d10), Dex 5. Attacks: Pseudopod +5 (1d6+3 + 4d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-blink-dog', 'srd', NULL, 'Monster: Blink Dog', 'Blink Dog. Medium fey, CR 1/4, AC 13, HP 22 (4d8), Dex 17. Attacks: Bite +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-blood-hawk', 'srd', NULL, 'Monster: Blood Hawk', 'Blood Hawk. Small beast, CR 1/8, AC 12, HP 7 (2d6), Dex 14. Attacks: Beak +4 (1d4+2). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-blue-dragon-wyrmling', 'srd', NULL, 'Monster: Blue Dragon Wyrmling', 'Blue Dragon Wyrmling. Medium dragon, CR 3, AC 17, HP 52 (8d8), Dex 10. Attacks: Bite +5 (1d10+3 + 1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-boar', 'srd', NULL, 'Monster: Boar', 'Boar. Medium beast, CR 1/4, AC 11, HP 11 (2d8), Dex 11. Attacks: Tusk +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bone-devil', 'srd', NULL, 'Monster: Bone Devil', 'Bone Devil. Large fiend, CR 9, AC 19, HP 142 (15d10), Dex 16. Attacks: Claw +8 (1d8+4); Sting +8 (2d8+4 + 5d6). Multiattack: Claw, Claw, Sting.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-brass-dragon-wyrmling', 'srd', NULL, 'Monster: Brass Dragon Wyrmling', 'Brass Dragon Wyrmling. Medium dragon, CR 1, AC 16, HP 16 (3d8), Dex 10. Attacks: Bite +4 (1d10+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bronze-dragon-wyrmling', 'srd', NULL, 'Monster: Bronze Dragon Wyrmling', 'Bronze Dragon Wyrmling. Medium dragon, CR 2, AC 17, HP 32 (5d8), Dex 10. Attacks: Bite +5 (1d10+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-brown-bear', 'srd', NULL, 'Monster: Brown Bear', 'Brown Bear. Large beast, CR 1, AC 11, HP 34 (4d10), Dex 10. Attacks: Bite +5 (1d8+4); Claws +5 (2d6+4). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bugbear', 'srd', NULL, 'Monster: Bugbear', 'Bugbear. Medium humanoid, CR 1, AC 16, HP 27 (5d8), Dex 14. Attacks: Morningstar +4 (2d8+2); Javelin +4 (2d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-bulette', 'srd', NULL, 'Monster: Bulette', 'Bulette. Large monstrosity, CR 5, AC 17, HP 94 (9d10), Dex 11. Attacks: Bite +7 (4d12+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-camel', 'srd', NULL, 'Monster: Camel', 'Camel. Large beast, CR 1/8, AC 9, HP 15 (2d10), Dex 8. Attacks: Bite +5 (1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-cat', 'srd', NULL, 'Monster: Cat', 'Cat. Tiny beast, CR 0, AC 12, HP 2 (1d4), Dex 15. Attacks: Claws +0 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-centaur', 'srd', NULL, 'Monster: Centaur', 'Centaur. Large monstrosity, CR 2, AC 12, HP 45 (6d10), Dex 14. Attacks: Pike +6 (1d10+4); Hooves +6 (2d6+4); Longbow +4 (1d8+2). Multiattack: Pike, Hooves, Longbow, Longbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-chain-devil', 'srd', NULL, 'Monster: Chain Devil', 'Chain Devil. Medium fiend, CR 8, AC 16, HP 85 (10d8), Dex 15. Attacks: Chain +8 (2d6+4). Multiattack: Chain, Chain.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-chimera', 'srd', NULL, 'Monster: Chimera', 'Chimera. Large monstrosity, CR 6, AC 14, HP 114 (12d10), Dex 11. Attacks: Bite +7 (2d6+4); Horns +7 (1d12+4); Claws +7 (2d6+4). Multiattack: Bite, Horns, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-chuul', 'srd', NULL, 'Monster: Chuul', 'Chuul. Large aberration, CR 4, AC 16, HP 93 (11d10), Dex 10. Attacks: Pincer +6 (2d6+4). Multiattack: Pincer.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-clay-golem', 'srd', NULL, 'Monster: Clay Golem', 'Clay Golem. Large construct, CR 9, AC 14, HP 133 (14d10), Dex 9. Attacks: Slam +8 (2d10+5). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-cloaker', 'srd', NULL, 'Monster: Cloaker', 'Cloaker. Large aberration, CR 8, AC 14, HP 78 (12d10), Dex 15. Attacks: Bite +6 (2d6+3); Tail +6 (1d8+3). Multiattack: Bite, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-cloud-giant', 'srd', NULL, 'Monster: Cloud Giant', 'Cloud Giant. Huge giant, CR 9, AC 14, HP 200 (16d12), Dex 10. Attacks: Morningstar +12 (3d8+8); Rock +12 (4d10+8). Multiattack: Morningstar, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-cockatrice', 'srd', NULL, 'Monster: Cockatrice', 'Cockatrice. Small monstrosity, CR 1/2, AC 11, HP 27 (6d6), Dex 12. Attacks: Bite +3 (1d4+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-commoner', 'srd', NULL, 'Monster: Commoner', 'Commoner. Medium humanoid, CR 0, AC 10, HP 4 (1d8), Dex 10. Attacks: Club +2 (1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-constrictor-snake', 'srd', NULL, 'Monster: Constrictor Snake', 'Constrictor Snake. Large beast, CR 1/4, AC 12, HP 13 (2d10), Dex 14. Attacks: Bite +4 (1d6+2); Constrict +4 (1d8+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-copper-dragon-wyrmling', 'srd', NULL, 'Monster: Copper Dragon Wyrmling', 'Copper Dragon Wyrmling. Medium dragon, CR 1, AC 16, HP 22 (4d8), Dex 12. Attacks: Bite +4 (1d10+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-couatl', 'srd', NULL, 'Monster: Couatl', 'Couatl. Medium celestial, CR 4, AC 19, HP 97 (13d8), Dex 20. Attacks: Bite +8 (1d6+5); Constrict +6 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-crab', 'srd', NULL, 'Monster: Crab', 'Crab. Tiny beast, CR 0, AC 11, HP 2 (1d4), Dex 11. Attacks: Claw +0 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-crocodile', 'srd', NULL, 'Monster: Crocodile', 'Crocodile. Large beast, CR 1/2, AC 12, HP 19 (3d10), Dex 10. Attacks: Bite +4 (1d10+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-cult-fanatic', 'srd', NULL, 'Monster: Cult Fanatic', 'Cult Fanatic. Medium humanoid, CR 2, AC 13, HP 22 (6d8), Dex 14. Attacks: Dagger +4 (1d4+2). Multiattack: Dagger.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-cultist', 'srd', NULL, 'Monster: Cultist', 'Cultist. Medium humanoid, CR 1/8, AC 12, HP 9 (2d8), Dex 12. Attacks: Scimitar +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-darkmantle', 'srd', NULL, 'Monster: Darkmantle', 'Darkmantle. Small monstrosity, CR 1/2, AC 11, HP 22 (5d6), Dex 12. Attacks: Crush +5 (1d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-death-dog', 'srd', NULL, 'Monster: Death Dog', 'Death Dog. Medium monstrosity, CR 1, AC 12, HP 39 (6d8), Dex 14. Attacks: Bite +4 (1d6+2). Multiattack: Bite.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-deep-gnome-svirfneblin', 'srd', NULL, 'Monster: Deep Gnome (Svirfneblin)', 'Deep Gnome (Svirfneblin). Small humanoid, CR 1/2, AC 15, HP 16 (3d6), Dex 14. Attacks: War Pick +4 (1d8+2); Poisoned Dart +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-deer', 'srd', NULL, 'Monster: Deer', 'Deer. Medium beast, CR 0, AC 13, HP 4 (1d8), Dex 16. Attacks: Bite +2 (1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-deva', 'srd', NULL, 'Monster: Deva', 'Deva. Medium celestial, CR 10, AC 17, HP 136 (16d8), Dex 18. Attacks: Mace +8 (1d6+4 + 4d8). Multiattack: Mace.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-dire-wolf', 'srd', NULL, 'Monster: Dire Wolf', 'Dire Wolf. Large beast, CR 1, AC 14, HP 37 (5d10), Dex 15. Attacks: Bite +5 (2d6+3). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-djinni', 'srd', NULL, 'Monster: Djinni', 'Djinni. Large elemental, CR 11, AC 17, HP 161 (14d10), Dex 15. Attacks: Scimitar +9 (2d6+5). Multiattack: Scimitar.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-doppelganger', 'srd', NULL, 'Monster: Doppelganger', 'Doppelganger. Medium monstrosity, CR 3, AC 14, HP 52 (8d8), Dex 18. Attacks: Slam +6 (1d6+4). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-draft-horse', 'srd', NULL, 'Monster: Draft Horse', 'Draft Horse. Large beast, CR 1/4, AC 10, HP 19 (3d10), Dex 10. Attacks: Hooves +6 (2d4+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-dragon-turtle', 'srd', NULL, 'Monster: Dragon Turtle', 'Dragon Turtle. Gargantuan dragon, CR 17, AC 20, HP 341 (22d20), Dex 10. Attacks: Bite +13 (3d12+7); Claw +13 (2d8+7); Tail +13 (3d12+7). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-dretch', 'srd', NULL, 'Monster: Dretch', 'Dretch. Small fiend, CR 1/4, AC 11, HP 18 (4d6), Dex 11. Attacks: Bite +2 (1d6); Claws +2 (2d4). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-drider', 'srd', NULL, 'Monster: Drider', 'Drider. Large monstrosity, CR 6, AC 19, HP 123 (13d10), Dex 16. Attacks: Bite +6 (1d4 + 2d8); Longsword +6 (no hit point damage); Longbow +6 (1d8+3 + 1d8). Multiattack: Bite, Longsword, Longbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-drow', 'srd', NULL, 'Monster: Drow', 'Drow. Medium humanoid, CR 1/4, AC 15, HP 13 (3d8), Dex 14. Attacks: Shortsword +4 (1d6+2); Hand Crossbow +4 (1d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-druid', 'srd', NULL, 'Monster: Druid', 'Druid. Medium humanoid, CR 2, AC 11, HP 27 (5d8), Dex 12. Attacks: Quarterstaff +2 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-dryad', 'srd', NULL, 'Monster: Dryad', 'Dryad. Medium fey, CR 1, AC 11, HP 22 (5d8), Dex 12. Attacks: Club +2 (1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-duergar', 'srd', NULL, 'Monster: Duergar', 'Duergar. Medium humanoid, CR 1, AC 16, HP 26 (4d8), Dex 11. Attacks: War Pick +4 (1d8+2); Javelin +4 (1d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-dust-mephit', 'srd', NULL, 'Monster: Dust Mephit', 'Dust Mephit. Small elemental, CR 1/2, AC 12, HP 17 (5d6), Dex 14. Attacks: Claws +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-eagle', 'srd', NULL, 'Monster: Eagle', 'Eagle. Small beast, CR 0, AC 12, HP 3 (1d6), Dex 15. Attacks: Talons +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-earth-elemental', 'srd', NULL, 'Monster: Earth Elemental', 'Earth Elemental. Large elemental, CR 5, AC 17, HP 126 (12d10), Dex 8. Attacks: Slam +8 (2d8+5). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-efreeti', 'srd', NULL, 'Monster: Efreeti', 'Efreeti. Large elemental, CR 11, AC 17, HP 200 (16d10), Dex 12. Attacks: Scimitar +10 (2d6+6 + 2d6); Hurl Flame +7 (5d6). Multiattack: Scimitar, Hurl Flame.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-elephant', 'srd', NULL, 'Monster: Elephant', 'Elephant. Huge beast, CR 4, AC 12, HP 76 (8d12), Dex 9. Attacks: Gore +8 (3d8+6); Stomp +8 (3d10+6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-elk', 'srd', NULL, 'Monster: Elk', 'Elk. Large beast, CR 1/4, AC 10, HP 13 (2d10), Dex 10. Attacks: Ram +5 (1d6+3); Hooves +5 (2d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-erinyes', 'srd', NULL, 'Monster: Erinyes', 'Erinyes. Medium fiend, CR 12, AC 18, HP 153 (18d8), Dex 16. Attacks: Longsword +8 (3d8); Longbow +7 (1d8+3 + 3d8). Multiattack: Longsword, Longbow, Longsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ettercap', 'srd', NULL, 'Monster: Ettercap', 'Ettercap. Medium monstrosity, CR 2, AC 13, HP 44 (8d8), Dex 15. Attacks: Bite +4 (1d8+2 + 1d8); Claws +4 (2d4+2); Web +4 (no hit point damage). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ettin', 'srd', NULL, 'Monster: Ettin', 'Ettin. Large giant, CR 4, AC 12, HP 85 (10d10), Dex 8. Attacks: Battleaxe +7 (2d8+5); Morningstar +7 (2d8+5). Multiattack: Battleaxe, Morningstar.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-fire-elemental', 'srd', NULL, 'Monster: Fire Elemental', 'Fire Elemental. Large elemental, CR 5, AC 13, HP 102 (12d10), Dex 17. Attacks: Touch +6 (2d6+3). Multiattack: Touch.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-fire-giant', 'srd', NULL, 'Monster: Fire Giant', 'Fire Giant. Huge giant, CR 9, AC 18, HP 162 (13d12), Dex 9. Attacks: Greatsword +11 (6d6+7); Rock +11 (4d10+7). Multiattack: Greatsword, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-flesh-golem', 'srd', NULL, 'Monster: Flesh Golem', 'Flesh Golem. Medium construct, CR 5, AC 9, HP 93 (11d8), Dex 9. Attacks: Slam +7 (2d8+4). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-flying-snake', 'srd', NULL, 'Monster: Flying Snake', 'Flying Snake. Tiny beast, CR 1/8, AC 14, HP 5 (2d4), Dex 18. Attacks: Bite +6 (1 + 3d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-flying-sword', 'srd', NULL, 'Monster: Flying Sword', 'Flying Sword. Small construct, CR 1/4, AC 17, HP 17 (5d6), Dex 15. Attacks: Longsword +3 (1d8+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-frog', 'srd', NULL, 'Monster: Frog', 'Frog. Tiny beast, CR 0, AC 11, HP 1 (1d4), Dex 13. Attacks: No weapon attack in the SRD stat block..', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-frost-giant', 'srd', NULL, 'Monster: Frost Giant', 'Frost Giant. Huge giant, CR 8, AC 15, HP 138 (12d12), Dex 9. Attacks: Greataxe +9 (3d12+6); Rock +9 (4d10+6). Multiattack: Greataxe, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gargoyle', 'srd', NULL, 'Monster: Gargoyle', 'Gargoyle. Medium elemental, CR 2, AC 15, HP 52 (7d8), Dex 11. Attacks: Bite +4 (1d6+2); Claws +4 (1d6+2). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gelatinous-cube', 'srd', NULL, 'Monster: Gelatinous Cube', 'Gelatinous Cube. Large ooze, CR 2, AC 6, HP 84 (8d10), Dex 3. Attacks: Pseudopod +4 (3d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ghast', 'srd', NULL, 'Monster: Ghast', 'Ghast. Medium undead, CR 2, AC 13, HP 36 (8d8), Dex 17. Attacks: Bite +3 (2d8+3); Claws +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ghost', 'srd', NULL, 'Monster: Ghost', 'Ghost. Medium undead, CR 4, AC 11, HP 45 (10d8), Dex 13. Attacks: Withering Touch +5 (4d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ghoul', 'srd', NULL, 'Monster: Ghoul', 'Ghoul. Medium undead, CR 1, AC 12, HP 22 (5d8), Dex 15. Attacks: Bite +2 (2d6+2); Claws +4 (2d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-ape', 'srd', NULL, 'Monster: Giant Ape', 'Giant Ape. Huge beast, CR 7, AC 12, HP 157 (15d12), Dex 14. Attacks: Fist +9 (3d10+6); Rock +9 (7d6+6). Multiattack: Fist, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-badger', 'srd', NULL, 'Monster: Giant Badger', 'Giant Badger. Medium beast, CR 1/4, AC 10, HP 13 (2d8), Dex 10. Attacks: Bite +3 (1d6+1); Claws +3 (2d4+1). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-bat', 'srd', NULL, 'Monster: Giant Bat', 'Giant Bat. Large beast, CR 1/4, AC 13, HP 22 (4d10), Dex 16. Attacks: Bite +4 (1d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-boar', 'srd', NULL, 'Monster: Giant Boar', 'Giant Boar. Large beast, CR 2, AC 12, HP 42 (5d10), Dex 10. Attacks: Tusk +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-centipede', 'srd', NULL, 'Monster: Giant Centipede', 'Giant Centipede. Small beast, CR 1/4, AC 13, HP 4 (1d6), Dex 14. Attacks: Bite +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-constrictor-snake', 'srd', NULL, 'Monster: Giant Constrictor Snake', 'Giant Constrictor Snake. Huge beast, CR 2, AC 12, HP 60 (8d12), Dex 14. Attacks: Bite +6 (2d6+4); Constrict +6 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-crab', 'srd', NULL, 'Monster: Giant Crab', 'Giant Crab. Medium beast, CR 1/8, AC 15, HP 13 (3d8), Dex 15. Attacks: Claw +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-crocodile', 'srd', NULL, 'Monster: Giant Crocodile', 'Giant Crocodile. Huge beast, CR 5, AC 14, HP 85 (9d12), Dex 9. Attacks: Bite +8 (3d10+5); Tail +8 (2d8+5). Multiattack: Bite, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-eagle', 'srd', NULL, 'Monster: Giant Eagle', 'Giant Eagle. Large beast, CR 1, AC 13, HP 26 (4d10), Dex 17. Attacks: Beak +5 (1d6+3); Talons +5 (2d6+3). Multiattack: Beak, Talons.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-elk', 'srd', NULL, 'Monster: Giant Elk', 'Giant Elk. Huge beast, CR 2, AC 14, HP 42 (5d12), Dex 16. Attacks: Ram +6 (2d6+4); Hooves +6 (4d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-fire-beetle', 'srd', NULL, 'Monster: Giant Fire Beetle', 'Giant Fire Beetle. Small beast, CR 0, AC 13, HP 4 (1d6), Dex 10. Attacks: Bite +1 (1d6-1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-frog', 'srd', NULL, 'Monster: Giant Frog', 'Giant Frog. Medium beast, CR 1/4, AC 11, HP 18 (4d8), Dex 13. Attacks: Bite +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-goat', 'srd', NULL, 'Monster: Giant Goat', 'Giant Goat. Large beast, CR 1/2, AC 11, HP 19 (3d10), Dex 11. Attacks: Ram +5 (2d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-hyena', 'srd', NULL, 'Monster: Giant Hyena', 'Giant Hyena. Large beast, CR 1, AC 12, HP 45 (6d10), Dex 14. Attacks: Bite +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-lizard', 'srd', NULL, 'Monster: Giant Lizard', 'Giant Lizard. Large beast, CR 1/4, AC 12, HP 19 (3d10), Dex 12. Attacks: Bite +4 (1d8+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-octopus', 'srd', NULL, 'Monster: Giant Octopus', 'Giant Octopus. Large beast, CR 1, AC 11, HP 52 (8d10), Dex 13. Attacks: Tentacles +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-owl', 'srd', NULL, 'Monster: Giant Owl', 'Giant Owl. Large beast, CR 1/4, AC 12, HP 19 (3d10), Dex 15. Attacks: Talons +3 (2d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-poisonous-snake', 'srd', NULL, 'Monster: Giant Poisonous Snake', 'Giant Poisonous Snake. Medium beast, CR 1/4, AC 14, HP 11 (2d8), Dex 18. Attacks: Bite +6 (1d4+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-rat', 'srd', NULL, 'Monster: Giant Rat', 'Giant Rat. Small beast, CR 1/8, AC 12, HP 7 (2d6), Dex 15. Attacks: Bite +4 (1d4+2). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-rat-diseased', 'srd', NULL, 'Monster: Giant Rat (Diseased)', 'Giant Rat (Diseased). Small beast, CR 1/8, AC 12, HP 7 (2d6), Dex 15. Attacks: Bite +4 (1d4+2). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-scorpion', 'srd', NULL, 'Monster: Giant Scorpion', 'Giant Scorpion. Large beast, CR 3, AC 15, HP 52 (7d10), Dex 13. Attacks: Claw +4 (1d8+2); Sting +4 (1d10+2). Multiattack: Claw, Claw, Sting.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-sea-horse', 'srd', NULL, 'Monster: Giant Sea Horse', 'Giant Sea Horse. Large beast, CR 1/2, AC 13, HP 16 (3d10), Dex 15. Attacks: Ram +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-shark', 'srd', NULL, 'Monster: Giant Shark', 'Giant Shark. Huge beast, CR 5, AC 13, HP 126 (11d12), Dex 11. Attacks: Bite +9 (3d10+6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-spider', 'srd', NULL, 'Monster: Giant Spider', 'Giant Spider. Large beast, CR 1, AC 14, HP 26 (4d10), Dex 16. Attacks: Bite +5 (1d8+3); Web +5 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-toad', 'srd', NULL, 'Monster: Giant Toad', 'Giant Toad. Large beast, CR 1, AC 11, HP 39 (6d10), Dex 13. Attacks: Bite +4 (1d10+2 + 1d10).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-vulture', 'srd', NULL, 'Monster: Giant Vulture', 'Giant Vulture. Large beast, CR 1, AC 10, HP 22 (3d10), Dex 10. Attacks: Beak +4 (2d4+2); Talons +4 (2d6+2). Multiattack: Beak, Talons. Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-wasp', 'srd', NULL, 'Monster: Giant Wasp', 'Giant Wasp. Medium beast, CR 1/2, AC 12, HP 13 (3d8), Dex 14. Attacks: Sting +4 (1d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-weasel', 'srd', NULL, 'Monster: Giant Weasel', 'Giant Weasel. Medium beast, CR 1/8, AC 13, HP 9 (2d8), Dex 16. Attacks: Bite +5 (1d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-giant-wolf-spider', 'srd', NULL, 'Monster: Giant Wolf Spider', 'Giant Wolf Spider. Medium beast, CR 1/4, AC 13, HP 11 (2d8), Dex 16. Attacks: Bite +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gibbering-mouther', 'srd', NULL, 'Monster: Gibbering Mouther', 'Gibbering Mouther. Medium aberration, CR 2, AC 9, HP 67 (9d8), Dex 8. Attacks: Bites +2 (5d6). Multiattack: Bites.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-glabrezu', 'srd', NULL, 'Monster: Glabrezu', 'Glabrezu. Large fiend, CR 9, AC 17, HP 157 (15d10), Dex 15. Attacks: Pincer +9 (2d10+5); Fist +9 (2d4+2). Multiattack: Pincer, Pincer, Fist, Fist.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gladiator', 'srd', NULL, 'Monster: Gladiator', 'Gladiator. Medium humanoid, CR 5, AC 16, HP 112 (15d8), Dex 15. Attacks: Spear +7 (no hit point damage); Shield Bash +7 (2d4+4). Multiattack: Spear, Shield Bash.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gnoll', 'srd', NULL, 'Monster: Gnoll', 'Gnoll. Medium humanoid, CR 1/2, AC 15, HP 22 (5d8), Dex 12. Attacks: Bite +4 (1d4+2); Spear +4 (no hit point damage); Longbow +3 (1d8+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-goat', 'srd', NULL, 'Monster: Goat', 'Goat. Medium beast, CR 0, AC 10, HP 4 (1d8), Dex 10. Attacks: Ram +3 (1d4+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-goblin', 'srd', NULL, 'Monster: Goblin', 'Goblin. Small humanoid, CR 1/4, AC 15, HP 7 (2d6), Dex 14. Attacks: Scimitar +4 (1d6+2); Shortbow +4 (1d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gold-dragon-wyrmling', 'srd', NULL, 'Monster: Gold Dragon Wyrmling', 'Gold Dragon Wyrmling. Medium dragon, CR 3, AC 17, HP 60 (8d8), Dex 14. Attacks: Bite +6 (1d10+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gorgon', 'srd', NULL, 'Monster: Gorgon', 'Gorgon. Large monstrosity, CR 5, AC 19, HP 114 (12d10), Dex 11. Attacks: Gore +8 (2d12+5); Hooves +8 (2d10+5).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gray-ooze', 'srd', NULL, 'Monster: Gray Ooze', 'Gray Ooze. Medium ooze, CR 1/2, AC 8, HP 22 (3d8), Dex 6. Attacks: Pseudopod +3 (1d6+1 + 2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-green-dragon-wyrmling', 'srd', NULL, 'Monster: Green Dragon Wyrmling', 'Green Dragon Wyrmling. Medium dragon, CR 2, AC 17, HP 38 (7d8), Dex 12. Attacks: Bite +4 (1d10+2 + 1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-green-hag', 'srd', NULL, 'Monster: Green Hag', 'Green Hag. Medium fey, CR 3, AC 17, HP 82 (11d8), Dex 12. Attacks: Claws +6 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-grick', 'srd', NULL, 'Monster: Grick', 'Grick. Medium monstrosity, CR 2, AC 14, HP 27 (6d8), Dex 14. Attacks: Tentacles +4 (2d6+2); Beak +4 (1d6+2). Multiattack: Tentacles, Beak.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-griffon', 'srd', NULL, 'Monster: Griffon', 'Griffon. Large monstrosity, CR 2, AC 12, HP 59 (7d10), Dex 15. Attacks: Beak +6 (1d8+4); Claws +6 (2d6+4). Multiattack: Beak, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-grimlock', 'srd', NULL, 'Monster: Grimlock', 'Grimlock. Medium humanoid, CR 1/4, AC 11, HP 11 (2d8), Dex 12. Attacks: Spiked Bone Club +5 (1d4+3 + 1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-guard', 'srd', NULL, 'Monster: Guard', 'Guard. Medium humanoid, CR 1/8, AC 16, HP 11 (2d8), Dex 12. Attacks: Spear +3 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-guardian-naga', 'srd', NULL, 'Monster: Guardian Naga', 'Guardian Naga. Large monstrosity, CR 10, AC 18, HP 127 (15d10), Dex 18. Attacks: Bite +8 (1d8+4); Spit Poison +8 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-gynosphinx', 'srd', NULL, 'Monster: Gynosphinx', 'Gynosphinx. Large monstrosity, CR 11, AC 17, HP 136 (16d10), Dex 15. Attacks: Claw +9 (2d8+4). Multiattack: Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-half-red-dragon-veteran', 'srd', NULL, 'Monster: Half-Red Dragon Veteran', 'Half-Red Dragon Veteran. Medium humanoid, CR 5, AC 18, HP 65 (10d8), Dex 13. Attacks: Longsword +5 (no hit point damage); Shortsword +5 (1d6+3); Heavy Crossbow +3 (1d10+1). Multiattack: Longsword, Shortsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-harpy', 'srd', NULL, 'Monster: Harpy', 'Harpy. Medium monstrosity, CR 1, AC 11, HP 38 (7d8), Dex 13. Attacks: Claws +3 (2d4+1); Club +3 (1d4+1). Multiattack: Claws, Club.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hawk', 'srd', NULL, 'Monster: Hawk', 'Hawk. Tiny beast, CR 0, AC 13, HP 1 (1d4), Dex 16. Attacks: Talons +5 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hell-hound', 'srd', NULL, 'Monster: Hell Hound', 'Hell Hound. Medium fiend, CR 3, AC 15, HP 45 (7d8), Dex 12. Attacks: Bite +5 (1d8+3 + 2d6). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hezrou', 'srd', NULL, 'Monster: Hezrou', 'Hezrou. Large fiend, CR 8, AC 16, HP 136 (13d10), Dex 17. Attacks: Bite +7 (2d10+4); Claws +7 (2d6+4). Multiattack: Bite, Claws, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hill-giant', 'srd', NULL, 'Monster: Hill Giant', 'Hill Giant. Huge giant, CR 5, AC 13, HP 105 (10d12), Dex 8. Attacks: Greatclub +8 (3d8+5); Rock +8 (3d10+5). Multiattack: Greatclub, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hippogriff', 'srd', NULL, 'Monster: Hippogriff', 'Hippogriff. Large monstrosity, CR 1, AC 11, HP 19 (3d10), Dex 13. Attacks: Beak +5 (1d10+3); Claws +5 (2d6+3). Multiattack: Beak, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hobgoblin', 'srd', NULL, 'Monster: Hobgoblin', 'Hobgoblin. Medium humanoid, CR 1/2, AC 18, HP 11 (2d8), Dex 12. Attacks: Longsword +3 (no hit point damage); Longbow +3 (1d8+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-homunculus', 'srd', NULL, 'Monster: Homunculus', 'Homunculus. Tiny construct, CR 0, AC 13, HP 5 (2d4), Dex 15. Attacks: Bite +4 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-horned-devil', 'srd', NULL, 'Monster: Horned Devil', 'Horned Devil. Large fiend, CR 11, AC 18, HP 178 (17d10), Dex 17. Attacks: Fork +10 (2d8+6); Tail +10 (1d8+6); Hurl Flame +7 (4d6). Multiattack: Fork, Fork, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hunter-shark', 'srd', NULL, 'Monster: Hunter Shark', 'Hunter Shark. Large beast, CR 2, AC 12, HP 45 (6d10), Dex 13. Attacks: Bite +6 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hydra', 'srd', NULL, 'Monster: Hydra', 'Hydra. Huge monstrosity, CR 8, AC 15, HP 172 (15d12), Dex 12. Attacks: Bite +8 (1d10+5). Multiattack: Bite.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-hyena', 'srd', NULL, 'Monster: Hyena', 'Hyena. Medium beast, CR 0, AC 11, HP 5 (1d8), Dex 13. Attacks: Bite +2 (1d6). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ice-devil', 'srd', NULL, 'Monster: Ice Devil', 'Ice Devil. Large fiend, CR 14, AC 18, HP 180 (19d10), Dex 14. Attacks: Bite +10 (2d6+5 + 3d6); Claws +10 (2d4+5 + 3d6); Tail +10 (2d6+5 + 3d6). Multiattack: Bite, Claws, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ice-mephit', 'srd', NULL, 'Monster: Ice Mephit', 'Ice Mephit. Small elemental, CR 1/2, AC 11, HP 21 (6d6), Dex 13. Attacks: Claws +3 (1d4+1 + 1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-imp', 'srd', NULL, 'Monster: Imp', 'Imp. Tiny fiend, CR 1, AC 13, HP 10 (3d4), Dex 17. Attacks: Sting (Bite in Beast Form) +5 (1d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-invisible-stalker', 'srd', NULL, 'Monster: Invisible Stalker', 'Invisible Stalker. Medium elemental, CR 6, AC 14, HP 104 (16d8), Dex 19. Attacks: Slam +6 (2d6+3). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-iron-golem', 'srd', NULL, 'Monster: Iron Golem', 'Iron Golem. Large construct, CR 16, AC 20, HP 210 (20d10), Dex 9. Attacks: Slam +13 (3d8+7); Sword +13 (3d10+7). Multiattack: Slam, Sword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-jackal', 'srd', NULL, 'Monster: Jackal', 'Jackal. Small beast, CR 0, AC 12, HP 3 (1d6), Dex 15. Attacks: Bite +1 (1d4-1). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-killer-whale', 'srd', NULL, 'Monster: Killer Whale', 'Killer Whale. Huge beast, CR 3, AC 12, HP 90 (12d12), Dex 10. Attacks: Bite +6 (5d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-knight', 'srd', NULL, 'Monster: Knight', 'Knight. Medium humanoid, CR 3, AC 18, HP 52 (8d8), Dex 11. Attacks: Greatsword +5 (2d6+3); Heavy Crossbow +2 (1d10). Multiattack: Greatsword, Heavy Crossbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-kobold', 'srd', NULL, 'Monster: Kobold', 'Kobold. Small humanoid, CR 1/8, AC 12, HP 5 (2d6), Dex 15. Attacks: Dagger +4 (1d4+2); Sling +4 (1d4+2). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-kraken', 'srd', NULL, 'Monster: Kraken', 'Kraken. Gargantuan monstrosity, CR 23, AC 18, HP 472 (27d20), Dex 11. Attacks: Bite +7 (3d8+10); Tentacle +7 (3d6+10). Multiattack: Bite, Tentacle.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-lamia', 'srd', NULL, 'Monster: Lamia', 'Lamia. Large monstrosity, CR 4, AC 13, HP 97 (13d10), Dex 13. Attacks: Claws +5 (2d10+3); Dagger +5 (1d4+3); Intoxicating Touch +5 (no hit point damage). Multiattack: Claws, Dagger.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-lemure', 'srd', NULL, 'Monster: Lemure', 'Lemure. Medium fiend, CR 0, AC 7, HP 13 (3d8), Dex 5. Attacks: Fist +3 (1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-lich', 'srd', NULL, 'Monster: Lich', 'Lich. Medium undead, CR 21, AC 17, HP 135 (18d8), Dex 16. Attacks: Paralyzing Touch +12 (3d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-lion', 'srd', NULL, 'Monster: Lion', 'Lion. Large beast, CR 1, AC 12, HP 26 (4d10), Dex 15. Attacks: Bite +5 (1d8+3); Claw +5 (1d6+3). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-lizard', 'srd', NULL, 'Monster: Lizard', 'Lizard. Tiny beast, CR 0, AC 10, HP 2 (1d4), Dex 11. Attacks: Bite +0 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-lizardfolk', 'srd', NULL, 'Monster: Lizardfolk', 'Lizardfolk. Medium humanoid, CR 1/2, AC 13, HP 22 (4d8), Dex 10. Attacks: Bite +4 (1d6+2); Heavy Club +4 (1d6+2); Javelin +4 (1d6+2); Spiked Shield +4 (1d6+2). Multiattack: Bite, Heavy Club.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mage', 'srd', NULL, 'Monster: Mage', 'Mage. Medium humanoid, CR 6, AC 12, HP 40 (9d8), Dex 14. Attacks: Dagger +5 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-magma-mephit', 'srd', NULL, 'Monster: Magma Mephit', 'Magma Mephit. Small elemental, CR 1/2, AC 11, HP 22 (5d6), Dex 12. Attacks: Claws +3 (1d4+1 + 1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-magmin', 'srd', NULL, 'Monster: Magmin', 'Magmin. Small elemental, CR 1/2, AC 14, HP 9 (2d6), Dex 15. Attacks: Touch +4 (2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mammoth', 'srd', NULL, 'Monster: Mammoth', 'Mammoth. Huge beast, CR 6, AC 13, HP 126 (11d12), Dex 9. Attacks: Gore +10 (4d8+7); Stomp +10 (4d10+7).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-manticore', 'srd', NULL, 'Monster: Manticore', 'Manticore. Large monstrosity, CR 3, AC 14, HP 68 (8d10), Dex 16. Attacks: Bite +5 (1d8+3); Claw +5 (1d6+3); Tail Spike +5 (1d8+3). Multiattack: Bite, Claw, Claw, Tail Spike, Tail Spike, Tail Spike.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-marilith', 'srd', NULL, 'Monster: Marilith', 'Marilith. Large fiend, CR 16, AC 18, HP 189 (18d10), Dex 20. Attacks: Longsword +9 (2d8+4); Tail +9 (2d10+4). Multiattack: Longsword, Longsword, Longsword, Longsword, Longsword, Longsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mastiff', 'srd', NULL, 'Monster: Mastiff', 'Mastiff. Medium beast, CR 1/8, AC 12, HP 5 (1d8), Dex 14. Attacks: Bite +3 (1d6+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-medusa', 'srd', NULL, 'Monster: Medusa', 'Medusa. Medium monstrosity, CR 6, AC 15, HP 127 (17d8), Dex 15. Attacks: Snake Hair +5 (1d4+2 + 4d6); Shortsword +5 (1d6+2); Longbow +5 (1d8+2 + 2d6). Multiattack: Snake Hair, Shortsword, Shortsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-merfolk', 'srd', NULL, 'Monster: Merfolk', 'Merfolk. Medium humanoid, CR 1/8, AC 11, HP 11 (2d8), Dex 13. Attacks: Spear +2 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-merrow', 'srd', NULL, 'Monster: Merrow', 'Merrow. Large monstrosity, CR 2, AC 13, HP 45 (6d10), Dex 10. Attacks: Bite +6 (1d8+4); Claws +6 (2d4+4); Harpoon +6 (2d6+4). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mimic', 'srd', NULL, 'Monster: Mimic', 'Mimic. Medium monstrosity, CR 2, AC 12, HP 58 (9d8), Dex 12. Attacks: Pseudopod +5 (1d8+3); Bite +5 (1d8+3 + 1d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-minotaur', 'srd', NULL, 'Monster: Minotaur', 'Minotaur. Large monstrosity, CR 3, AC 14, HP 76 (9d10), Dex 11. Attacks: Greataxe +6 (2d12+4); Gore +6 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-minotaur-skeleton', 'srd', NULL, 'Monster: Minotaur Skeleton', 'Minotaur Skeleton. Large undead, CR 2, AC 12, HP 67 (9d10), Dex 11. Attacks: Greataxe +6 (2d12+4); Gore +6 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mule', 'srd', NULL, 'Monster: Mule', 'Mule. Medium beast, CR 1/8, AC 10, HP 11 (2d8), Dex 10. Attacks: Hooves +2 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mummy', 'srd', NULL, 'Monster: Mummy', 'Mummy. Medium undead, CR 3, AC 11, HP 58 (9d8), Dex 8. Attacks: Rotting Fist +5 (2d6+3 + 3d6). Multiattack: Rotting Fist.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-mummy-lord', 'srd', NULL, 'Monster: Mummy Lord', 'Mummy Lord. Medium undead, CR 15, AC 17, HP 97 (13d8), Dex 10. Attacks: Rotting Fist +9 (3d6+4 + 6d6). Multiattack: Rotting Fist.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-nalfeshnee', 'srd', NULL, 'Monster: Nalfeshnee', 'Nalfeshnee. Large fiend, CR 13, AC 18, HP 184 (16d10), Dex 10. Attacks: Bite +10 (5d10+5); Claw +10 (3d6+5). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-night-hag', 'srd', NULL, 'Monster: Night Hag', 'Night Hag. Medium fiend, CR 5, AC 17, HP 112 (15d8), Dex 15. Attacks: Claws (Hag Form Only) +7 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-nightmare', 'srd', NULL, 'Monster: Nightmare', 'Nightmare. Large fiend, CR 3, AC 13, HP 68 (8d10), Dex 15. Attacks: Hooves +6 (2d8+4 + 2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-noble', 'srd', NULL, 'Monster: Noble', 'Noble. Medium humanoid, CR 1/8, AC 15, HP 9 (2d8), Dex 12. Attacks: Rapier +3 (1d8+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ochre-jelly', 'srd', NULL, 'Monster: Ochre Jelly', 'Ochre Jelly. Large ooze, CR 2, AC 8, HP 45 (6d10), Dex 6. Attacks: Pseudopod +4 (2d6+2 + 1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-octopus', 'srd', NULL, 'Monster: Octopus', 'Octopus. Small beast, CR 0, AC 12, HP 3 (1d6), Dex 15. Attacks: Tentacles +4 (1); Ink Cloud +0 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ogre', 'srd', NULL, 'Monster: Ogre', 'Ogre. Large giant, CR 2, AC 11, HP 59 (7d10), Dex 8. Attacks: Greatclub +6 (2d8+4); Javelin +6 (2d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-ogre-zombie', 'srd', NULL, 'Monster: Ogre Zombie', 'Ogre Zombie. Large undead, CR 2, AC 8, HP 85 (9d10), Dex 6. Attacks: Morningstar +6 (2d8+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-oni', 'srd', NULL, 'Monster: Oni', 'Oni. Large giant, CR 7, AC 16, HP 110 (13d10), Dex 11. Attacks: Claw (Oni Form Only) +7 (1d8+4); Glaive +7 (2d10+4). Multiattack: Claw (Oni Form Only), Glaive.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-orc', 'srd', NULL, 'Monster: Orc', 'Orc. Medium humanoid, CR 1/2, AC 13, HP 15 (2d8), Dex 12. Attacks: Greataxe +5 (1d12+3); Javelin +5 (1d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-otyugh', 'srd', NULL, 'Monster: Otyugh', 'Otyugh. Large aberration, CR 5, AC 14, HP 114 (12d10), Dex 11. Attacks: Bite +6 (2d8+3); Tentacle +6 (1d8+3 + 1d8). Multiattack: Bite, Tentacle, Tentacle.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-owl', 'srd', NULL, 'Monster: Owl', 'Owl. Tiny beast, CR 0, AC 11, HP 1 (1d4), Dex 13. Attacks: Talons +3 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-owlbear', 'srd', NULL, 'Monster: Owlbear', 'Owlbear. Large monstrosity, CR 3, AC 13, HP 59 (7d10), Dex 12. Attacks: Beak +7 (1d10+5); Claws +7 (2d8+5). Multiattack: Beak, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-panther', 'srd', NULL, 'Monster: Panther', 'Panther. Medium beast, CR 1/4, AC 12, HP 13 (3d8), Dex 15. Attacks: Bite +4 (1d6+2); Claw +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-pegasus', 'srd', NULL, 'Monster: Pegasus', 'Pegasus. Large celestial, CR 2, AC 12, HP 59 (7d10), Dex 15. Attacks: Hooves +6 (2d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-phase-spider', 'srd', NULL, 'Monster: Phase Spider', 'Phase Spider. Large monstrosity, CR 3, AC 13, HP 32 (5d10), Dex 15. Attacks: Bite +4 (1d10+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-pit-fiend', 'srd', NULL, 'Monster: Pit Fiend', 'Pit Fiend. Large fiend, CR 20, AC 19, HP 300 (24d10), Dex 14. Attacks: Bite +14 (4d6+8); Claw +14 (2d8+8); Mace +14 (2d6+8); Tail +14 (3d10+8). Multiattack: Bite, Claw, Mace, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-planetar', 'srd', NULL, 'Monster: Planetar', 'Planetar. Large celestial, CR 16, AC 19, HP 200 (16d10), Dex 20. Attacks: Greatsword +12 (4d6+7 + 5d8). Multiattack: Greatsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-plesiosaurus', 'srd', NULL, 'Monster: Plesiosaurus', 'Plesiosaurus. Large beast, CR 2, AC 13, HP 68 (8d10), Dex 15. Attacks: Bite +6 (3d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-poisonous-snake', 'srd', NULL, 'Monster: Poisonous Snake', 'Poisonous Snake. Tiny beast, CR 1/8, AC 13, HP 2 (1d4), Dex 16. Attacks: Bite +5 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-polar-bear', 'srd', NULL, 'Monster: Polar Bear', 'Polar Bear. Large beast, CR 2, AC 12, HP 42 (5d10), Dex 10. Attacks: Bite +7 (1d8+5); Claws +7 (2d6+5). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-pony', 'srd', NULL, 'Monster: Pony', 'Pony. Medium beast, CR 1/8, AC 10, HP 11 (2d8), Dex 10. Attacks: Hooves +4 (2d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-priest', 'srd', NULL, 'Monster: Priest', 'Priest. Medium humanoid, CR 2, AC 13, HP 27 (5d8), Dex 10. Attacks: Mace +2 (1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-pseudodragon', 'srd', NULL, 'Monster: Pseudodragon', 'Pseudodragon. Tiny dragon, CR 1/4, AC 13, HP 7 (2d4), Dex 15. Attacks: Bite +4 (1d4+2); Sting +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-purple-worm', 'srd', NULL, 'Monster: Purple Worm', 'Purple Worm. Gargantuan monstrosity, CR 15, AC 18, HP 247 (15d20), Dex 7. Attacks: Bite +9 (3d8+9); Tail Stinger +9 (3d6+9). Multiattack: Bite, Tail Stinger.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-quasit', 'srd', NULL, 'Monster: Quasit', 'Quasit. Tiny fiend, CR 1, AC 13, HP 7 (3d4), Dex 17. Attacks: Claw (Bite in Beast Form) +4 (1d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-quipper', 'srd', NULL, 'Monster: Quipper', 'Quipper. Tiny beast, CR 0, AC 13, HP 1 (1d4), Dex 16. Attacks: Bite +5 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-rakshasa', 'srd', NULL, 'Monster: Rakshasa', 'Rakshasa. Medium fiend, CR 13, AC 16, HP 110 (13d8), Dex 17. Attacks: Claw +7 (2d6+2). Multiattack: Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-rat', 'srd', NULL, 'Monster: Rat', 'Rat. Tiny beast, CR 0, AC 10, HP 1 (1d4), Dex 11. Attacks: Bite +0 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-raven', 'srd', NULL, 'Monster: Raven', 'Raven. Tiny beast, CR 0, AC 12, HP 1 (1d4), Dex 14. Attacks: Beak +4 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-red-dragon-wyrmling', 'srd', NULL, 'Monster: Red Dragon Wyrmling', 'Red Dragon Wyrmling. Medium dragon, CR 4, AC 17, HP 75 (10d8), Dex 10. Attacks: Bite +6 (1d10+4 + 1d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-reef-shark', 'srd', NULL, 'Monster: Reef Shark', 'Reef Shark. Medium beast, CR 1/2, AC 12, HP 22 (4d8), Dex 13. Attacks: Bite +4 (1d8+2). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-remorhaz', 'srd', NULL, 'Monster: Remorhaz', 'Remorhaz. Huge monstrosity, CR 11, AC 17, HP 195 (17d12), Dex 13. Attacks: Bite +11 (6d10+7 + 3d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-rhinoceros', 'srd', NULL, 'Monster: Rhinoceros', 'Rhinoceros. Large beast, CR 2, AC 11, HP 45 (6d10), Dex 8. Attacks: Gore +7 (2d8+5).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-riding-horse', 'srd', NULL, 'Monster: Riding Horse', 'Riding Horse. Large beast, CR 1/4, AC 10, HP 13 (2d10), Dex 10. Attacks: Hooves +5 (2d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-roc', 'srd', NULL, 'Monster: Roc', 'Roc. Gargantuan monstrosity, CR 11, AC 15, HP 248 (16d20), Dex 10. Attacks: Beak +13 (4d8+9); Talons +13 (4d6+9). Multiattack: Beak, Talons.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-roper', 'srd', NULL, 'Monster: Roper', 'Roper. Large monstrosity, CR 5, AC 20, HP 93 (11d10), Dex 8. Attacks: Bite +7 (4d8+4); Tendril +7 (no hit point damage). Multiattack: Bite, Tendril, Bite, Tendril.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-rug-of-smothering', 'srd', NULL, 'Monster: Rug of Smothering', 'Rug of Smothering. Large construct, CR 2, AC 12, HP 33 (6d10), Dex 14. Attacks: Smother +5 (no hit point damage).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-rust-monster', 'srd', NULL, 'Monster: Rust Monster', 'Rust Monster. Medium monstrosity, CR 1/2, AC 14, HP 27 (5d8), Dex 12. Attacks: Bite +3 (1d8+1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-saber-toothed-tiger', 'srd', NULL, 'Monster: Saber-Toothed Tiger', 'Saber-Toothed Tiger. Large beast, CR 2, AC 12, HP 52 (7d10), Dex 14. Attacks: Bite +6 (1d10+5); Claw +6 (2d6+5).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-sahuagin', 'srd', NULL, 'Monster: Sahuagin', 'Sahuagin. Medium humanoid, CR 1/2, AC 12, HP 22 (4d8), Dex 11. Attacks: Bite +3 (1d4+1); Claws +3 (1d4+1); Spear +3 (no hit point damage). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-salamander', 'srd', NULL, 'Monster: Salamander', 'Salamander. Large elemental, CR 5, AC 15, HP 90 (12d10), Dex 14. Attacks: Spear +7 (1d6); Tail +7 (2d6+4 + 2d6). Multiattack: Spear, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-satyr', 'srd', NULL, 'Monster: Satyr', 'Satyr. Medium fey, CR 1/2, AC 14, HP 31 (7d8), Dex 16. Attacks: Ram +3 (2d4+1); Shortsword +5 (1d6+3); Shortbow +5 (1d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-scorpion', 'srd', NULL, 'Monster: Scorpion', 'Scorpion. Tiny beast, CR 0, AC 11, HP 1 (1d4), Dex 11. Attacks: Sting +2 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-scout', 'srd', NULL, 'Monster: Scout', 'Scout. Medium humanoid, CR 1/2, AC 13, HP 16 (3d8), Dex 14. Attacks: Shortsword +4 (1d6+2); Longbow +4 (1d8+2). Multiattack: Shortsword, Longbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-sea-hag', 'srd', NULL, 'Monster: Sea Hag', 'Sea Hag. Medium fey, CR 2, AC 14, HP 52 (7d8), Dex 13. Attacks: Claws +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-sea-horse', 'srd', NULL, 'Monster: Sea Horse', 'Sea Horse. Tiny beast, CR 0, AC 11, HP 1 (1d4), Dex 12. Attacks: No weapon attack in the SRD stat block..', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-shadow', 'srd', NULL, 'Monster: Shadow', 'Shadow. Medium undead, CR 1/2, AC 12, HP 16 (3d8), Dex 14. Attacks: Strength Drain +4 (2d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-shambling-mound', 'srd', NULL, 'Monster: Shambling Mound', 'Shambling Mound. Large plant, CR 5, AC 15, HP 136 (16d10), Dex 8. Attacks: Slam +7 (2d8+4). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-shield-guardian', 'srd', NULL, 'Monster: Shield Guardian', 'Shield Guardian. Large construct, CR 7, AC 17, HP 142 (15d10), Dex 8. Attacks: Fist +7 (2d6+4). Multiattack: Fist.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-shrieker', 'srd', NULL, 'Monster: Shrieker', 'Shrieker. Medium plant, CR 0, AC 5, HP 13 (3d8), Dex 1. Attacks: No weapon attack in the SRD stat block..', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-silver-dragon-wyrmling', 'srd', NULL, 'Monster: Silver Dragon Wyrmling', 'Silver Dragon Wyrmling. Medium dragon, CR 2, AC 17, HP 45 (6d8), Dex 10. Attacks: Bite +6 (1d10+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-skeleton', 'srd', NULL, 'Monster: Skeleton', 'Skeleton. Medium undead, CR 1/4, AC 13, HP 13 (2d8), Dex 14. Attacks: Shortsword +4 (1d6+2); Shortbow +4 (1d6+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-solar', 'srd', NULL, 'Monster: Solar', 'Solar. Large celestial, CR 21, AC 21, HP 243 (18d10), Dex 22. Attacks: Greatsword +15 (4d6+8 + 6d8); Slaying Longbow +13 (2d8+6 + 6d8). Multiattack: Greatsword, Slaying Longbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-specter', 'srd', NULL, 'Monster: Specter', 'Specter. Medium undead, CR 1, AC 12, HP 22 (5d8), Dex 14. Attacks: Life Drain +4 (3d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-spider', 'srd', NULL, 'Monster: Spider', 'Spider. Tiny beast, CR 0, AC 12, HP 1 (1d4), Dex 14. Attacks: Bite +4 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-spirit-naga', 'srd', NULL, 'Monster: Spirit Naga', 'Spirit Naga. Large monstrosity, CR 8, AC 15, HP 75 (10d10), Dex 17. Attacks: Bite +7 (1d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-sprite', 'srd', NULL, 'Monster: Sprite', 'Sprite. Tiny fey, CR 1/4, AC 15, HP 2 (1d4), Dex 18. Attacks: Longsword +2 (1); Shortbow +6 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-spy', 'srd', NULL, 'Monster: Spy', 'Spy. Medium humanoid, CR 1, AC 12, HP 27 (6d8), Dex 15. Attacks: Shortsword +4 (1d6+2); Hand Crossbow +4 (1d6+2). Multiattack: Shortsword, Hand Crossbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-steam-mephit', 'srd', NULL, 'Monster: Steam Mephit', 'Steam Mephit. Small elemental, CR 1/4, AC 10, HP 21 (6d6), Dex 11. Attacks: Claws +2 (1d4 + 1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-stirge', 'srd', NULL, 'Monster: Stirge', 'Stirge. Tiny beast, CR 1/8, AC 14, HP 2 (1d4), Dex 16. Attacks: Blood Drain +5 (1d4+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-stone-giant', 'srd', NULL, 'Monster: Stone Giant', 'Stone Giant. Huge giant, CR 7, AC 17, HP 126 (11d12), Dex 15. Attacks: Greatclub +9 (3d8+6); Rock +9 (4d10+6). Multiattack: Greatclub, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-stone-golem', 'srd', NULL, 'Monster: Stone Golem', 'Stone Golem. Large construct, CR 10, AC 17, HP 178 (17d10), Dex 9. Attacks: Slam +10 (3d8+6). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-storm-giant', 'srd', NULL, 'Monster: Storm Giant', 'Storm Giant. Huge giant, CR 13, AC 16, HP 230 (20d12), Dex 14. Attacks: Greatsword +14 (6d6+9); Rock +14 (4d12+9). Multiattack: Greatsword, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-succubus-incubus', 'srd', NULL, 'Monster: Succubus/Incubus', 'Succubus/Incubus. Medium fiend, CR 4, AC 15, HP 66 (12d8), Dex 17. Attacks: Claw (Fiend Form Only) +5 (1d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-bats', 'srd', NULL, 'Monster: Swarm of Bats', 'Swarm of Bats. Medium swarm of Tiny beasts, CR 1/4, AC 12, HP 22 (5d8), Dex 15. Attacks: Bites +4 (2d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-beetles', 'srd', NULL, 'Monster: Swarm of Beetles', 'Swarm of Beetles. Medium swarm of Tiny beasts, CR 1/2, AC 12, HP 22 (5d8), Dex 13. Attacks: Bites +3 (4d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-centipedes', 'srd', NULL, 'Monster: Swarm of Centipedes', 'Swarm of Centipedes. Medium swarm of Tiny beasts, CR 1/2, AC 12, HP 22 (5d8), Dex 13. Attacks: Bites +3 (4d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-insects', 'srd', NULL, 'Monster: Swarm of Insects', 'Swarm of Insects. Medium swarm of Tiny beasts, CR 1/2, AC 12, HP 22 (5d8), Dex 13. Attacks: Bites +3 (4d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-poisonous-snakes', 'srd', NULL, 'Monster: Swarm of Poisonous Snakes', 'Swarm of Poisonous Snakes. Medium swarm of Tiny beasts, CR 2, AC 14, HP 36 (8d8), Dex 18. Attacks: Bites +6 (2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-quippers', 'srd', NULL, 'Monster: Swarm of Quippers', 'Swarm of Quippers. Medium swarm of Tiny beasts, CR 1, AC 13, HP 28 (8d8), Dex 16. Attacks: Bites +5 (4d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-rats', 'srd', NULL, 'Monster: Swarm of Rats', 'Swarm of Rats. Medium swarm of Tiny beasts, CR 1/4, AC 10, HP 24 (7d8), Dex 11. Attacks: Bites +2 (2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-ravens', 'srd', NULL, 'Monster: Swarm of Ravens', 'Swarm of Ravens. Medium swarm of Tiny beasts, CR 1/4, AC 12, HP 24 (7d8), Dex 14. Attacks: Beaks +4 (2d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-spiders', 'srd', NULL, 'Monster: Swarm of Spiders', 'Swarm of Spiders. Medium swarm of Tiny beasts, CR 1/2, AC 12, HP 22 (5d8), Dex 13. Attacks: Bites +3 (4d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-swarm-of-wasps', 'srd', NULL, 'Monster: Swarm of Wasps', 'Swarm of Wasps. Medium swarm of Tiny beasts, CR 1/2, AC 12, HP 22 (5d8), Dex 13. Attacks: Bites +3 (4d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-tarrasque', 'srd', NULL, 'Monster: Tarrasque', 'Tarrasque. Gargantuan monstrosity, CR 30, AC 25, HP 676 (33d20), Dex 11. Attacks: Bite +19 (4d12+10); Claw +19 (4d8+10); Horns +19 (4d10+10); Tail +19 (4d6+10). Multiattack: Bite, Claw, Claw, Horns, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-thug', 'srd', NULL, 'Monster: Thug', 'Thug. Medium humanoid, CR 1/2, AC 11, HP 32 (5d8), Dex 11. Attacks: Mace +4 (1d6+2); Heavy Crossbow +2 (1d10). Multiattack: Mace, Heavy Crossbow. Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-tiger', 'srd', NULL, 'Monster: Tiger', 'Tiger. Large beast, CR 1, AC 12, HP 37 (5d10), Dex 15. Attacks: Bite +5 (1d10+3); Claw +5 (1d8+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-treant', 'srd', NULL, 'Monster: Treant', 'Treant. Huge plant, CR 9, AC 16, HP 138 (12d12), Dex 8. Attacks: Slam +10 (3d6+6); Rock +10 (4d10+6). Multiattack: Slam, Rock.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-tribal-warrior', 'srd', NULL, 'Monster: Tribal Warrior', 'Tribal Warrior. Medium humanoid, CR 1/8, AC 12, HP 11 (2d8), Dex 11. Attacks: Spear +3 (no hit point damage). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-triceratops', 'srd', NULL, 'Monster: Triceratops', 'Triceratops. Huge beast, CR 5, AC 13, HP 95 (10d12), Dex 9. Attacks: Gore +9 (4d8+6); Stomp +9 (3d10+6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-troll', 'srd', NULL, 'Monster: Troll', 'Troll. Large giant, CR 5, AC 15, HP 84 (8d10), Dex 13. Attacks: Bite +7 (1d6+4); Claw +7 (2d6+4). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-tyrannosaurus-rex', 'srd', NULL, 'Monster: Tyrannosaurus Rex', 'Tyrannosaurus Rex. Huge beast, CR 8, AC 13, HP 136 (13d12), Dex 10. Attacks: Bite +10 (4d12+7); Tail +10 (3d8+7). Multiattack: Bite, Tail.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-unicorn', 'srd', NULL, 'Monster: Unicorn', 'Unicorn. Large celestial, CR 5, AC 12, HP 67 (9d10), Dex 14. Attacks: Hooves +7 (2d6+4); Horn +7 (1d8+4). Multiattack: Hooves, Horn.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-vampire-spawn', 'srd', NULL, 'Monster: Vampire Spawn', 'Vampire Spawn. Medium undead, CR 5, AC 15, HP 82 (11d8), Dex 16. Attacks: Bite +6 (1d6+3 + 2d6); Claws +6 (2d4+3). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-vampire-bat', 'srd', NULL, 'Monster: Vampire, Bat Form', 'Vampire, Bat Form. Medium undead, CR 13, AC 16, HP 144 (17d8), Dex 18. Attacks: Bite +9 (1d6+4 + 3d6).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-vampire-mist', 'srd', NULL, 'Monster: Vampire, Mist Form', 'Vampire, Mist Form. Medium undead, CR 13, AC 16, HP 144 (17d8), Dex 18. Attacks: No weapon attack in the SRD stat block..', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-vampire-vampire', 'srd', NULL, 'Monster: Vampire, Vampire Form', 'Vampire, Vampire Form. Medium undead, CR 13, AC 16, HP 144 (17d8), Dex 18. Attacks: Unarmed Strike +9 (1d8+4); Bite +9 (1d6+4 + 3d6). Multiattack: Unarmed Strike, Bite.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-veteran', 'srd', NULL, 'Monster: Veteran', 'Veteran. Medium humanoid, CR 3, AC 17, HP 58 (9d8), Dex 13. Attacks: Longsword +5 (no hit point damage); Shortsword +5 (1d6+3); Heavy Crossbow +3 (1d10+1). Multiattack: Longsword, Shortsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-violet-fungus', 'srd', NULL, 'Monster: Violet Fungus', 'Violet Fungus. Medium plant, CR 1/4, AC 5, HP 18 (4d8), Dex 1. Attacks: Rotting Touch +2 (1d8). Multiattack: Rotting Touch.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-vrock', 'srd', NULL, 'Monster: Vrock', 'Vrock. Large fiend, CR 6, AC 15, HP 104 (11d10), Dex 15. Attacks: Beak +6 (2d6+3); Talons +6 (2d10+3). Multiattack: Beak, Talons.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-vulture', 'srd', NULL, 'Monster: Vulture', 'Vulture. Medium beast, CR 0, AC 10, HP 5 (1d8), Dex 10. Attacks: Beak +2 (1d4). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-warhorse', 'srd', NULL, 'Monster: Warhorse', 'Warhorse. Large beast, CR 1/2, AC 11, HP 19 (3d10), Dex 12. Attacks: Hooves +6 (2d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-warhorse-skeleton', 'srd', NULL, 'Monster: Warhorse Skeleton', 'Warhorse Skeleton. Large undead, CR 1/2, AC 13, HP 22 (3d10), Dex 12. Attacks: Hooves +6 (2d6+4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-water-elemental', 'srd', NULL, 'Monster: Water Elemental', 'Water Elemental. Large elemental, CR 5, AC 14, HP 114 (12d10), Dex 14. Attacks: Slam +7 (2d8+4). Multiattack: Slam.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-weasel', 'srd', NULL, 'Monster: Weasel', 'Weasel. Tiny beast, CR 0, AC 13, HP 1 (1d4), Dex 16. Attacks: Bite +5 (1).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-werebear-bear', 'srd', NULL, 'Monster: Werebear, Bear Form', 'Werebear, Bear Form. Medium humanoid, CR 5, AC 11, HP 135 (18d8), Dex 10. Attacks: Bite +7 (2d10+4); Claw +7 (2d8+4). Multiattack: Bite, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-werebear-human', 'srd', NULL, 'Monster: Werebear, Human Form', 'Werebear, Human Form. Medium humanoid, CR 5, AC 10, HP 135 (18d8), Dex 10. Attacks: Greataxe +7 (1d12+4). Multiattack: Greataxe.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-werebear-hybrid', 'srd', NULL, 'Monster: Werebear, Hybrid Form', 'Werebear, Hybrid Form. Medium humanoid, CR 5, AC 11, HP 135 (18d8), Dex 10. Attacks: Bite +7 (2d10+4); Claw +7 (2d8+4); Greataxe +7 (1d12+4). Multiattack: Bite, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wereboar-boar', 'srd', NULL, 'Monster: Wereboar, Boar Form', 'Wereboar, Boar Form. Medium humanoid, CR 4, AC 11, HP 78 (12d8), Dex 10. Attacks: Tusks +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wereboar-human', 'srd', NULL, 'Monster: Wereboar, Human Form', 'Wereboar, Human Form. Medium humanoid, CR 4, AC 10, HP 78 (12d8), Dex 10. Attacks: Maul +5 (2d6+3). Multiattack: Maul, Maul.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wereboar-hybrid', 'srd', NULL, 'Monster: Wereboar, Hybrid Form', 'Wereboar, Hybrid Form. Medium humanoid, CR 4, AC 11, HP 78 (12d8), Dex 10. Attacks: Maul +5 (2d6+3); Tusks +5 (2d6+3). Multiattack: Maul, Tusks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wererat-human', 'srd', NULL, 'Monster: Wererat, Human Form', 'Wererat, Human Form. Medium humanoid, CR 2, AC 12, HP 33 (6d8), Dex 15. Attacks: Shortsword +4 (1d6+2); Hand Crossbow +4 (1d6+2). Multiattack: Shortsword, Hand Crossbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wererat-hybrid', 'srd', NULL, 'Monster: Wererat, Hybrid Form', 'Wererat, Hybrid Form. Medium humanoid, CR 2, AC 12, HP 33 (6d8), Dex 15. Attacks: Bite +4 (1d4+2); Shortsword +4 (1d6+2); Hand Crossbow +4 (1d6+2). Multiattack: Bite, Shortsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wererat-rat', 'srd', NULL, 'Monster: Wererat, Rat Form', 'Wererat, Rat Form. Medium humanoid, CR 2, AC 12, HP 33 (6d8), Dex 15. Attacks: Bite +4 (1d4+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-weretiger-human', 'srd', NULL, 'Monster: Weretiger, Human Form', 'Weretiger, Human Form. Medium humanoid, CR 4, AC 12, HP 120 (16d8), Dex 15. Attacks: Scimitar +5 (1d6+3); Longbow +4 (1d8+2). Multiattack: Scimitar, Longbow.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-weretiger-hybrid', 'srd', NULL, 'Monster: Weretiger, Hybrid Form', 'Weretiger, Hybrid Form. Medium humanoid, CR 4, AC 12, HP 120 (16d8), Dex 15. Attacks: Bite +5 (1d10+3); Claw +5 (1d8+3); Scimitar +5 (1d6+3); Longbow +4 (1d8+2). Multiattack: Bite, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-weretiger-tiger', 'srd', NULL, 'Monster: Weretiger, Tiger Form', 'Weretiger, Tiger Form. Medium humanoid, CR 4, AC 12, HP 120 (16d8), Dex 15. Attacks: Bite +5 (1d10+3); Claw +5 (1d8+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-werewolf-human', 'srd', NULL, 'Monster: Werewolf, Human Form', 'Werewolf, Human Form. Medium humanoid, CR 3, AC 11, HP 58 (9d8), Dex 13. Attacks: Spear +4 (no hit point damage). Multiattack: Spear, Spear.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-werewolf-hybrid', 'srd', NULL, 'Monster: Werewolf, Hybrid Form', 'Werewolf, Hybrid Form. Medium humanoid, CR 3, AC 12, HP 58 (9d8), Dex 13. Attacks: Bite +4 (1d8+2); Claws +4 (2d4+2). Multiattack: Bite, Claws.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-werewolf-wolf', 'srd', NULL, 'Monster: Werewolf, Wolf Form', 'Werewolf, Wolf Form. Medium humanoid, CR 3, AC 12, HP 58 (9d8), Dex 13. Attacks: Bite +4 (1d8+2).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-white-dragon-wyrmling', 'srd', NULL, 'Monster: White Dragon Wyrmling', 'White Dragon Wyrmling. Medium dragon, CR 2, AC 16, HP 32 (5d8), Dex 10. Attacks: Bite +4 (1d10+2 + 1d4).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wight', 'srd', NULL, 'Monster: Wight', 'Wight. Medium undead, CR 3, AC 14, HP 45 (6d8), Dex 14. Attacks: Life Drain +4 (1d6+2); Longsword +4 (no hit point damage); Longbow +4 (1d8+2). Multiattack: Life Drain, Longsword.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-will-o-wisp', 'srd', NULL, 'Monster: Will-o''-Wisp', 'Will-o''-Wisp. Tiny undead, CR 2, AC 19, HP 22 (9d4), Dex 28. Attacks: Shock +4 (2d8).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-winter-wolf', 'srd', NULL, 'Monster: Winter Wolf', 'Winter Wolf. Large monstrosity, CR 3, AC 13, HP 75 (10d10), Dex 13. Attacks: Bite +6 (2d6+4). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wolf', 'srd', NULL, 'Monster: Wolf', 'Wolf. Medium beast, CR 1/4, AC 13, HP 11 (2d8), Dex 15. Attacks: Bite +4 (2d4+2). Pack Tactics.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-worg', 'srd', NULL, 'Monster: Worg', 'Worg. Large monstrosity, CR 1/2, AC 13, HP 26 (4d10), Dex 13. Attacks: Bite +5 (2d6+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wraith', 'srd', NULL, 'Monster: Wraith', 'Wraith. Medium undead, CR 5, AC 13, HP 67 (9d8), Dex 16. Attacks: Life Drain +6 (4d8+3).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-wyvern', 'srd', NULL, 'Monster: Wyvern', 'Wyvern. Large dragon, CR 6, AC 13, HP 110 (13d10), Dex 10. Attacks: Bite +7 (2d6+4); Claws +7 (2d8+4); Stinger +7 (2d6+4). Multiattack: Bite, Stinger.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-xorn', 'srd', NULL, 'Monster: Xorn', 'Xorn. Medium elemental, CR 5, AC 19, HP 73 (7d8), Dex 10. Attacks: Bite +6 (3d6+3); Claw +6 (1d6+3). Multiattack: Bite, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-black-dragon', 'srd', NULL, 'Monster: Young Black Dragon', 'Young Black Dragon. Large dragon, CR 7, AC 18, HP 127 (15d10), Dex 14. Attacks: Bite +7 (2d10+4 + 1d8); Claw +7 (2d6+4). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-blue-dragon', 'srd', NULL, 'Monster: Young Blue Dragon', 'Young Blue Dragon. Large dragon, CR 9, AC 18, HP 152 (16d10), Dex 10. Attacks: Bite +9 (2d10+5 + 1d10); Claw +9 (2d6+5). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-brass-dragon', 'srd', NULL, 'Monster: Young Brass Dragon', 'Young Brass Dragon. Large dragon, CR 6, AC 17, HP 110 (13d10), Dex 10. Attacks: Bite +7 (2d10+4); Claw +7 (2d6+4). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-bronze-dragon', 'srd', NULL, 'Monster: Young Bronze Dragon', 'Young Bronze Dragon. Large dragon, CR 8, AC 18, HP 142 (15d10), Dex 10. Attacks: Bite +8 (2d10+5); Claw +8 (2d6+5). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-copper-dragon', 'srd', NULL, 'Monster: Young Copper Dragon', 'Young Copper Dragon. Large dragon, CR 7, AC 17, HP 119 (14d10), Dex 12. Attacks: Bite +7 (2d10+4); Claw +7 (2d6+4). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-gold-dragon', 'srd', NULL, 'Monster: Young Gold Dragon', 'Young Gold Dragon. Large dragon, CR 10, AC 18, HP 178 (17d10), Dex 14. Attacks: Bite +10 (2d10+6); Claw +10 (2d6+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-green-dragon', 'srd', NULL, 'Monster: Young Green Dragon', 'Young Green Dragon. Large dragon, CR 8, AC 18, HP 136 (16d10), Dex 12. Attacks: Bite +7 (2d10+4 + 2d6); Claw +7 (2d6+4). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-red-dragon', 'srd', NULL, 'Monster: Young Red Dragon', 'Young Red Dragon. Large dragon, CR 10, AC 18, HP 178 (17d10), Dex 10. Attacks: Bite +10 (2d10+6 + 1d6); Claw +10 (2d6+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-silver-dragon', 'srd', NULL, 'Monster: Young Silver Dragon', 'Young Silver Dragon. Large dragon, CR 9, AC 18, HP 168 (16d10), Dex 10. Attacks: Bite +10 (2d10+6); Claw +10 (2d6+6). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-young-white-dragon', 'srd', NULL, 'Monster: Young White Dragon', 'Young White Dragon. Large dragon, CR 6, AC 17, HP 133 (14d10), Dex 10. Attacks: Bite +7 (2d10+4 + 1d8); Claw +7 (2d6+4). Multiattack: Bite, Claw, Claw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('mon-zombie', 'srd', NULL, 'Monster: Zombie', 'Zombie. Medium undead, CR 1/4, AC 8, HP 22 (3d8), Dex 6. Attacks: Slam +3 (1d6+1).', 0);
