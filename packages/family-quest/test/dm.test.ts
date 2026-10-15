import { describe, expect, it } from "vitest";
import { decodeAudio, extractModelText } from "../src/ai";
import { SYSTEM_PROMPT, extractJson, parseDmReply } from "../src/dm";

describe("dungeon master parsing", () => {
  it("keeps the PG rules in the system prompt", () => {
    expect(SYSTEM_PROMPT).toContain("PG");
    expect(SYSTEM_PROMPT).toContain("JSON");
    expect(SYSTEM_PROMPT).toContain("server rolls");
  });

  it("reads fenced JSON and a messy reply", () => {
    const fenced = parseDmReply(
      '```json\n{"narration":"The fox bows.","npcLines":[{"name":"Fox","line":"Sandwich?"}],"rollRequest":{"who":"Maya","reason":"to sneak","dice":"1d20","dc":12},"summary":"The fox has the basket.","encounter":null}\n```',
      "old",
    );
    expect(fenced.narration).toBe("The fox bows.");
    expect(fenced.npcLines[0]?.name).toBe("Fox");
    expect(fenced.rollRequest?.dc).toBe(12);
    expect(fenced.summary).toContain("basket");
    expect(fenced.usedFallbackText).toBe(false);

    const messy = parseDmReply('Sure! {"narration":"Birds argue cheerfully.","summary":"In the woods."}', "old");
    expect(messy.narration).toContain("Birds");
    expect(extractJson("not json")).toBeNull();
  });

  it("replaces unsafe narration and keeps the previous summary when needed", () => {
    const reply = parseDmReply('{"narration":"A gory corpse appears.","summary":""}', "Safe so far.");
    expect(reply.narration).toContain("gentle");
    expect(reply.summary).toBe("Safe so far.");
    expect(parseDmReply("The model chatted instead of JSON.", "Safe so far.").usedFallbackText).toBe(true);
  });

  it("reads Workers AI text and MeloTTS audio payloads", async () => {
    expect(extractModelText({ response: "{\"narration\":\"Hi\"}" })).toContain("narration");
    expect(extractModelText({ choices: [{ message: { content: "hello" } }] })).toBe("hello");
    const audio = await decodeAudio({ audio: btoa("abc") });
    expect(audio?.bytes).toEqual(new Uint8Array([97, 98, 99]));
    expect(audio?.contentType).toBe("audio/mpeg");
    expect(await decodeAudio({ audio: "" })).toBeNull();
  });
});
