interface Env {
  DB: D1Database;
  NOTES: R2Bucket;
  /** Absent until a Vectorize index is bound. Text search covers that gap. */
  LORE?: VectorizeIndex;
  AI: Ai;
  AI_DAILY_CAP: string;
  AI_MODEL: string;
  AI_MODEL_FALLBACK: string;
  TTS_MODEL: string;
  EMBED_MODEL: string;
  FAMILY_PASSCODE: string;
  SESSION_SECRET: string;
}
