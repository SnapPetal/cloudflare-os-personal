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
  /**
   * Shared family passcode. Absent until the Deploy workflow sets it, and then it is
   * `undefined` rather than an empty string. `secretsReady` treats that as not set up.
   */
  FAMILY_PASSCODE?: string;
  /** HMAC key for the session cookie. Absent, not `""`, until the Deploy workflow sets it. */
  SESSION_SECRET?: string;
}
