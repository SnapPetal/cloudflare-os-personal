import { describe, expect, it } from "vitest";
import { chunkNote, extractEmbeddings, libraryPrompt, rankChunks, wantsLore } from "../src/lore";

describe("lore library", () => {
  it("notices rules questions and ignores ordinary actions", () => {
    expect(wantsLore("How does advantage work?")).toBe(true);
    expect(wantsLore("What is a goblin?")).toBe(true);
    expect(wantsLore("Maya looks under the picnic blanket.")).toBe(false);
  });

  it("chunks a long note and ranks the matching snippet", () => {
    const chunks = chunkNote("note-1", "House rules", `${"The picnic blanket is safe. ".repeat(80)}\n\nAdvantage means roll two d20s and keep the higher one.`);
    expect(chunks.length).toBeGreaterThan(1);
    expect(chunks.every((chunk) => chunk.body.length <= 1400)).toBe(true);
    const ranked = rankChunks("how does advantage work", [
      { id: "a", title: "Movement", body: "You can walk up to your speed.", source: "srd" },
      ...chunks,
    ]);
    expect(ranked[0]?.body.toLowerCase()).toContain("advantage");
    expect(libraryPrompt(ranked)).toContain("PG");
  });

  it("reads a Workers AI embedding payload", () => {
    const rows = extractEmbeddings({ data: [[0.1, 0.2], [0.3]] });
    expect(rows).toEqual([[0.1, 0.2], [0.3]]);
    expect(extractEmbeddings({ response: "nope" })).toEqual([]);
  });
});
