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
   * Optional. Team origin such as `https://<team>.cloudflareaccess.com`.
   * JWT verification runs only when this and `ACCESS_AUD` are both set.
   */
  ACCESS_TEAM_DOMAIN?: string;
  /**
   * Optional AUD tag for the Access application. Not required: quest.thonbecker.biz
   * is added to the existing os.thonbecker.biz application.
   */
  ACCESS_AUD?: string;
}
