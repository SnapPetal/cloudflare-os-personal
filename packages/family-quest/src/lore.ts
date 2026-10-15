export interface LoreChunk {
  id: string;
  title: string;
  body: string;
  source: string;
}

const QUESTION = /\?|\b(rule|rules|lore|spell|spells|advantage|disadvantage|how do|how does|how can|what is|what are|what's|can i|can we|could i|srd|saving throw|condition)\b/i;

export function wantsLore(action: string): boolean {
  return QUESTION.test(action);
}

export function chunkNote(idBase: string, title: string, text: string): LoreChunk[] {
  const clean = text.replace(/\r/g, "").trim();
  const pieces = wrap(clean);
  return pieces.map((body, index) => ({
    id: `${idBase}-${index}`.slice(0, 60),
    title: pieces.length > 1 ? `${title} (${index + 1})` : title,
    body,
    source: "note",
  }));
}

export function rankChunks(query: string, chunks: readonly LoreChunk[], limit = 4): LoreChunk[] {
  const needles = tokens(query);
  if (needles.length === 0) return [];
  return chunks
    .map((chunk) => ({ chunk, score: scoreChunk(needles, chunk) }))
    .filter((row) => row.score > 0)
    .toSorted((left, right) => right.score - left.score || left.chunk.title.localeCompare(right.chunk.title))
    .slice(0, limit)
    .map((row) => row.chunk);
}

export function libraryPrompt(chunks: readonly LoreChunk[]): string {
  if (chunks.length === 0) return "";
  const lines = chunks.map((chunk) => `${chunk.title}\n${chunk.body}`);
  return `Library snippets from the SRD 5.1 or the family's notes. Use them when they answer the question. Explain in PG language and skip anything graphic. If they do not apply, ignore them.\n\n${lines.join("\n\n")}`;
}

export function extractEmbeddings(result: unknown): number[][] {
  if (!result || typeof result !== "object") return [];
  const data = (result as { data?: unknown }).data;
  if (!Array.isArray(data)) return [];
  return data.filter((row): row is number[] => Array.isArray(row) && row.every((value) => typeof value === "number"));
}

function wrap(text: string): string[] {
  const parts: string[] = [];
  let rest = text;
  while (rest.length > 1400) {
    let cut = rest.lastIndexOf("\n\n", 1400);
    if (cut < 400) cut = rest.lastIndexOf(" ", 1400);
    if (cut < 400) cut = 1400;
    parts.push(rest.slice(0, cut).trim());
    rest = rest.slice(cut).trim();
  }
  if (rest) parts.push(rest);
  return parts.length > 0 ? parts : [];
}

function tokens(value: string): string[] {
  return [...new Set(value.toLowerCase().split(/[^a-z0-9]+/).filter((token) => token.length > 2))];
}

function scoreChunk(needles: readonly string[], chunk: LoreChunk): number {
  const title = chunk.title.toLowerCase();
  const body = chunk.body.toLowerCase();
  let score = 0;
  for (const needle of needles) {
    if (title.includes(needle)) score += 3;
    if (body.includes(needle)) score += 1;
  }
  return score;
}
