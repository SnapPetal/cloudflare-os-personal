export function clipText(value: unknown, max: number): string {
  if (typeof value !== "string") return "";
  let clean = "";
  for (const char of value) {
    const code = char.codePointAt(0) ?? 0;
    if (code >= 32 && code !== 127) clean += char;
  }
  return clean.trim().slice(0, max);
}

export function escapeHtml(value: string): string {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}
