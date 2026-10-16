import { readFileSync } from "node:fs";
import { DatabaseSync } from "node:sqlite";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");

export function readBytes(relativePath) {
  return readFileSync(join(root, relativePath));
}

export function readText(relativePath) {
  return readFileSync(join(root, relativePath), "utf8");
}

class SqliteStatement {
  constructor(db, sql, params = []) {
    this.db = db;
    this.sql = sql;
    this.params = params;
  }

  bind(...params) {
    return new SqliteStatement(this.db, this.sql, params);
  }

  async all() {
    return { results: this.db.prepare(this.sql).all(...this.params) };
  }

  async first() {
    return this.db.prepare(this.sql).get(...this.params) ?? null;
  }

  async run() {
    this.db.prepare(this.sql).run(...this.params);
    return { success: true };
  }
}

export function openTable() {
  const raw = new DatabaseSync(":memory:");
  raw.exec("PRAGMA foreign_keys = ON");
  const init = readText("migrations/0001_init.sql");
  const srd = readText("migrations/0002_srd.sql");
  const tables = srd.slice(0, srd.indexOf("INSERT INTO"));
  raw.exec(`${init}\n${tables}`);
  const db = {
    prepare(sql) {
      return new SqliteStatement(raw, sql);
    },
    async batch(statements) {
      raw.exec("BEGIN");
      try {
        const results = [];
        for (const statement of statements) results.push(await statement.run());
        raw.exec("COMMIT");
        return results;
      } catch (error) {
        raw.exec("ROLLBACK");
        throw error;
      }
    },
  };
  const env = {
    DB: db,
    AI_DAILY_CAP: "40",
    AI_MODEL: "stub-primary",
    AI_MODEL_FALLBACK: "stub-fallback",
    TTS_MODEL: "stub-tts",
    EMBED_MODEL: "stub-embed",
  };
  return {
    env,
    raw,
    close() {
      raw.close();
    },
  };
}
