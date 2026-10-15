import { parseDice } from "./dice";
import { clipText } from "./text";

export interface ChatMessage {
  role: "system" | "user" | "assistant";
  content: string;
}

export interface NpcLine {
  name: string;
  line: string;
}

export interface RollRequest {
  who: string;
  reason: string;
  dice: string;
  dc: number | null;
}

export interface DmReply {
  narration: string;
  npcLines: NpcLine[];
  rollRequest: RollRequest | null;
  summary: string;
  encounter: unknown;
  usedFallbackText: boolean;
}

const UNSAFE = /\b(gore|gory|corpse|dismember|sexual|sexually|sexy|erotic|suicide|murder|alcohol|drugs)\b/i;

export const SYSTEM_PROMPT = `You are the Dungeon Master for Family Quest, a tabletop adventure played by adults and children together.

Safety rules, always:
- Keep every scene rated PG and kind. Cozy trouble is welcome. Graphic violence, gore, body horror, romance, flirting, drugs, alcohol, and cruelty are not.
- Critters are mischievous or grumpy, never truly dangerous. When someone runs out of hit points they are knocked out and wake up safe.
- No real-world tragedy, no personal data, and no instructions that could hurt someone.
- Use clear words a 7-year-old can follow. Short paragraphs. Offer a few choices.
- Speak to the party as "you" and give people they meet distinct, gentle voices.
- Ask for a dice roll when the outcome is uncertain. Never invent the number on the die. The family rolls, and the server rolls during combat.
- During a combat scene, do not declare hits, misses, or damage. The server does that math.
- Stay consistent with the running summary and the party sheet.
- When library snippets are provided, use them for rules and lore. Explain them in PG language. Do not quote graphic examples.
- Critters in a challenge must be chosen by exact name from the allowed list. Never invent hit points, armor class, attack bonuses, or damage.

Reply with one JSON object and nothing else:
{
  "narration": "2 to 5 sentences",
  "npcLines": [{"name": "Name", "line": "what they say"}],
  "rollRequest": {"who": "hero name", "reason": "why", "dice": "1d20", "dc": 12},
  "summary": "updated running summary under 900 characters",
  "encounter": null
}
Set rollRequest to null when no roll is needed. Set encounter to null unless a turn-by-turn challenge is starting right now. If it is starting, encounter looks like:
{"title":"short title","monsters":[{"name":"Goblin","count":2}],"loot":["a jar of fireflies"]}
Use at most 3 kinds of monster, and at most 2 of each. Names must match the allowed list exactly.`;

export const ENEMY_SYSTEM_PROMPT = `You choose one action for a single critter in a family-friendly PG combat scene.
The critter is mischievous, not cruel. Nobody is really hurt when they reach 0 HP; they are knocked out and safe.
Do not invent dice results, damage, or hit points. The server rolls and applies the rules.
Reply with one JSON object and nothing else:
{"action":"attack","targetId":"id from the list","flavor":"one short gentle sentence"}
action is one of attack, dodge, help, flee. help uses an ally id. attack and flee use a hero id when attacking.`;

export function storyMessages(input: {
  premise: string;
  summary: string;
  party: string;
  recent: string;
  speaker: string;
  action: string;
  encounter: string;
  library?: string;
  bestiary?: string;
}): ChatMessage[] {
  const summary = input.summary.trim() || "The quest is just beginning.";
  const library = input.library?.trim() ? `\n\n${input.library.trim()}` : "";
  const bestiary = input.bestiary?.trim() ? `\n\nAllowed critters:\n${input.bestiary.trim()}` : "";
  return [
    { role: "system", content: SYSTEM_PROMPT },
    {
      role: "user",
      content: `Premise:\n${input.premise}\n\nRunning summary:\n${summary}\n\nParty:\n${input.party}\n\nRecent log:\n${input.recent || "(no earlier lines)"}\n\nScene status:\n${input.encounter}${bestiary}${library}\n\n${input.speaker} now does: ${input.action}`,
    },
  ];
}

export function enemyMessages(input: { summary: string; battle: string; actor: string }): ChatMessage[] {
  return [
    { role: "system", content: ENEMY_SYSTEM_PROMPT },
    {
      role: "user",
      content: `Summary: ${input.summary || "A gentle challenge is underway."}\n\nBattle:\n${input.battle}\n\nChoose the action for ${input.actor}.`,
    },
  ];
}

export function cannedOpening(title: string, names: string[]): string {
  const party = names.length > 0 ? names.join(", ") : "The party";
  return `${party} stand at the start of ${title}. The light is warm, the trouble is small, and someone nearby could use a brave, kind plan. What do you do?`;
}

export function extractJson(text: string): unknown {
  const trimmed = text.trim();
  const fenced = /^```(?:json)?\s*([\s\S]*?)\s*```$/i.exec(trimmed);
  const body = fenced?.[1] ?? trimmed;
  try {
    return JSON.parse(body);
  } catch {
    const start = body.indexOf("{");
    const end = body.lastIndexOf("}");
    if (start === -1 || end <= start) return null;
    try {
      return JSON.parse(body.slice(start, end + 1));
    } catch {
      return null;
    }
  }
}

export function parseDmReply(raw: string, previousSummary: string): DmReply {
  const parsed = asRecord(extractJson(raw));
  const narration = clipText(parsed?.narration, 1200);
  if (!parsed || !narration) {
    const plain = clipText(raw.replace(/```[\s\S]*?```/g, " "), 1200);
    return {
      narration: soften(plain || "The Dungeon Master pauses, smiles, and asks what you do next."),
      npcLines: [],
      rollRequest: null,
      summary: previousSummary,
      encounter: null,
      usedFallbackText: true,
    };
  }

  const npcLines = Array.isArray(parsed.npcLines)
    ? parsed.npcLines
        .map((line) => {
          const record = asRecord(line);
          const name = clipText(record?.name, 40);
          const spoken = clipText(record?.line, 240);
          return name && spoken ? { name, line: spoken } : null;
        })
        .filter((line): line is NpcLine => line !== null)
        .slice(0, 3)
    : [];

  return {
    narration: soften(narration),
    npcLines: npcLines.map((line) => ({ name: line.name, line: soften(line.line) })),
    rollRequest: parseRoll(parsed.rollRequest),
    summary: clipText(parsed.summary, 1500) || previousSummary,
    encounter: parsed.encounter ?? null,
    usedFallbackText: false,
  };
}

function parseRoll(raw: unknown): RollRequest | null {
  const record = asRecord(raw);
  if (!record) return null;
  const who = clipText(record.who, 40);
  const reason = clipText(record.reason, 120);
  const dice = clipText(record.dice, 12);
  if (!who || !reason || !dice) return null;
  try {
    parseDice(dice);
  } catch {
    return null;
  }
  const dcValue = record.dc;
  const dcNumber = typeof dcValue === "number" ? dcValue : typeof dcValue === "string" ? Number(dcValue) : Number.NaN;
  const dc = Number.isInteger(dcNumber) ? Math.min(25, Math.max(5, dcNumber)) : null;
  return { who, reason, dice, dc };
}

function soften(text: string): string {
  if (!UNSAFE.test(text)) return text;
  return "The Dungeon Master keeps the scene gentle and asks the party for a kinder plan.";
}

function asRecord(raw: unknown): Record<string, unknown> | null {
  if (!raw || typeof raw !== "object" || Array.isArray(raw)) return null;
  return raw as Record<string, unknown>;
}
