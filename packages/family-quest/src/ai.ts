import type { ChatMessage } from "./dm";
import { extractEmbeddings } from "./lore";

export interface AiBinding {
  run(model: string, input: Record<string, unknown>): Promise<unknown>;
}

export interface Narration {
  text: string;
  model: string;
}

export async function narrate(
  ai: AiBinding,
  models: { primary: string; fallback: string },
  messages: ChatMessage[],
  maxTokens: number,
): Promise<Narration> {
  const attempts = [
    { model: models.primary, json: true },
    { model: models.fallback, json: true },
    { model: models.fallback, json: false },
  ];
  let lastError = "empty response";
  for (const attempt of attempts) {
    try {
      const result = await ai.run(attempt.model, {
        messages,
        temperature: 0.6,
        max_tokens: maxTokens,
        ...(attempt.json ? { response_format: { type: "json_object" } } : {}),
      });
      const text = extractModelText(result).trim();
      if (text) return { text, model: attempt.model };
      lastError = "empty response";
    } catch (error) {
      lastError = error instanceof Error ? error.message : "unknown error";
      console.error(JSON.stringify({ event: "ai_attempt_failed", model: attempt.model, error: lastError }));
    }
  }
  throw new Error(lastError);
}

export async function embedTexts(ai: AiBinding, model: string, texts: string[]): Promise<number[][]> {
  const result = await ai.run(model, { text: texts });
  const rows = extractEmbeddings(result);
  if (rows.length !== texts.length || rows.some((row) => row.length !== 384)) {
    throw new Error("The embedding model did not return 384-dimension vectors.");
  }
  return rows;
}

export function extractModelText(result: unknown): string {
  if (typeof result === "string") return result;
  if (!result || typeof result !== "object") return "";
  const record = result as Record<string, unknown>;
  if (typeof record.response === "string") return record.response;
  if (typeof record.result === "string") return record.result;
  const output = record.output;
  if (typeof output === "string") return output;
  const choices = record.choices;
  if (!Array.isArray(choices) || !choices[0] || typeof choices[0] !== "object") return "";
  const message = (choices[0] as Record<string, unknown>).message;
  if (!message || typeof message !== "object") return "";
  const content = (message as Record<string, unknown>).content;
  return typeof content === "string" ? content : "";
}

export async function synthesizeSpeech(
  ai: AiBinding,
  model: string,
  prompt: string,
): Promise<{ bytes: Uint8Array; contentType: string } | null> {
  const clipped = prompt.trim().slice(0, 450);
  if (!clipped) return null;
  const result = await ai.run(model, { prompt: clipped, lang: "en" });
  return decodeAudio(result);
}

export async function decodeAudio(result: unknown): Promise<{ bytes: Uint8Array; contentType: string } | null> {
  if (result instanceof Response) {
    const contentType = result.headers.get("content-type") ?? "";
    if (contentType.startsWith("audio/")) {
      const bytes = new Uint8Array(await result.arrayBuffer());
      return bytes.byteLength > 0 ? { bytes, contentType } : null;
    }
    const text = await result.text();
    try {
      return decodeAudio(JSON.parse(text) as unknown);
    } catch {
      return decodeAudio(text);
    }
  }
  if (result instanceof Uint8Array) {
    return result.byteLength > 0 ? { bytes: result, contentType: "audio/mpeg" } : null;
  }
  if (result instanceof ArrayBuffer) {
    const bytes = new Uint8Array(result);
    return bytes.byteLength > 0 ? { bytes, contentType: "audio/mpeg" } : null;
  }
  if (!result || typeof result !== "object") return null;
  const record = result as Record<string, unknown>;
  const audio = record.audio ?? record.result;
  if (typeof audio !== "string" || audio.trim() === "") return null;
  const bytes = decodeBase64Audio(audio);
  return bytes && bytes.byteLength > 0 ? { bytes, contentType: "audio/mpeg" } : null;
}

function decodeBase64Audio(value: string): Uint8Array | null {
  const payload = value.startsWith("data:") ? (value.split(",")[1] ?? "") : value;
  try {
    const binary = atob(payload);
    const bytes = new Uint8Array(binary.length);
    for (let index = 0; index < binary.length; index += 1) {
      bytes[index] = binary.charCodeAt(index);
    }
    return bytes;
  } catch {
    return null;
  }
}
