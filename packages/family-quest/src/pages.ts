import { crOptions, attackSummary, type MonsterStat } from "./bestiary";
import { layout, csrfInput } from "./view";
import type { LoreRow, NoteRow } from "./repo";
import { escapeHtml } from "./text";

export function bestiaryPage(input: {
  csrf: string;
  monsters: MonsterStat[];
  query: string;
  showAll: boolean;
  error: string | null;
}): string {
  const rows = input.monsters
    .map(
      (monster) => `<tr>
        <td><a href="/bestiary/${escapeHtml(monster.id)}">${escapeHtml(monster.name)}</a></td>
        <td>${escapeHtml(monster.crLabel)}</td>
        <td>${monster.ac}</td>
        <td>${monster.hp}</td>
        <td>${escapeHtml(monster.source === "homebrew" ? "Family" : "SRD")}</td>
      </tr>`,
    )
    .join("");
  const all = input.showAll ? "" : `<a class="btn btn-link" href="/bestiary?all=1">Show the whole SRD</a>`;
  return layout({
    title: "Bestiary",
    csrf: input.csrf,
    body: `<div class="d-flex justify-content-between flex-wrap gap-3 mb-3">
      <div>
        <p class="fq-mark mb-1">SRD 5.1</p>
        <h1 class="h2">Bestiary</h1>
      </div>
      <a class="btn btn-success" href="/bestiary/new">New family critter</a>
    </div>
    ${input.error ? `<div class="alert alert-warning">${escapeHtml(input.error)}</div>` : ""}
    <form class="row g-2 mb-3" method="get" action="/bestiary">
      <div class="col-md-8"><input class="form-control" name="q" value="${escapeHtml(input.query)}" placeholder="Search by name"></div>
      <div class="col-md-4"><button class="btn btn-outline-success" type="submit">Search</button></div>
    </form>
    <div class="table-responsive">
      <table class="table">
        <thead><tr><th>Name</th><th>CR</th><th>AC</th><th>HP</th><th>Source</th></tr></thead>
        <tbody>${rows || `<tr><td colspan="5">No critters match.</td></tr>`}</tbody>
      </table>
    </div>
    ${all}`,
  });
}

export function monsterPage(monster: MonsterStat, csrf: string, error: string | null): string {
  const attacks = monster.attacks
    .map(
      (attack) =>
        `<li>${escapeHtml(attack.name)} +${attack.bonus} (${escapeHtml(attack.damage.join(" + ") || "no hit point damage")})</li>`,
    )
    .join("");
  const multi = monster.multiattack.length > 0 ? `<p>Multiattack: ${escapeHtml(monster.multiattack.join(", "))}.</p>` : "";
  const pack = monster.packTactics ? "<p>Pack Tactics: advantage on attacks while a friend is still in the scene.</p>" : "";
  const notice = error ? `<div class="alert alert-warning">${escapeHtml(error)}</div>` : "";
  const editor =
    monster.source === "homebrew"
      ? `${notice}${monsterForm(monster, csrf, "Save changes")}
      <form class="mt-3" method="post" action="/bestiary/${escapeHtml(monster.id)}/delete">
        ${csrfInput(csrf)}
        <label class="form-check"><input class="form-check-input" type="checkbox" name="confirm" value="yes"> Delete this family critter</label>
        <button class="btn btn-outline-danger btn-sm" type="submit">Delete</button>
      </form>`
      : `${notice}<p class="small text-secondary">SRD stat blocks stay as published. Add a family critter if you want a new one.</p>`;
  return layout({
    title: monster.name,
    csrf,
    body: `<p class="fq-mark mb-1">${monster.source === "homebrew" ? "Family critter" : "SRD 5.1"}</p>
      <h1 class="h2">${escapeHtml(monster.name)}</h1>
      <p>${escapeHtml(monster.size)} ${escapeHtml(monster.type)} · CR ${escapeHtml(monster.crLabel)} · ${monster.xp} XP · AC ${monster.ac} · HP ${monster.hp}${monster.hitDice ? ` (${escapeHtml(monster.hitDice)})` : ""} · Dex ${monster.dexterity}</p>
      ${monster.note ? `<p>${escapeHtml(monster.note)}</p>` : ""}
      <ul>${attacks || "<li>No weapon attack.</li>"}</ul>
      ${multi}${pack}
      <p class="small">Attacks: ${escapeHtml(attackSummary(monster))}.</p>
      ${editor}
      <p class="mt-3"><a href="/bestiary">Back to the bestiary</a></p>`,
  });
}

export function newMonsterPage(csrf: string, error: string | null): string {
  return layout({
    title: "New critter",
    csrf,
    body: `<h1 class="h2">New family critter</h1>
      ${error ? `<div class="alert alert-warning">${escapeHtml(error)}</div>` : ""}
      ${monsterForm(null, csrf, "Save critter")}`,
  });
}

export function libraryPage(input: {
  csrf: string;
  notes: NoteRow[];
  total: number;
  indexed: number;
  preview: LoreRow[];
  error: string | null;
  notice: string | null;
}): string {
  const notes = input.notes
    .map(
      (note) => `<li class="mb-2">${escapeHtml(note.title)} <span class="text-secondary">(${note.bytes} bytes)</span>
        <form class="d-inline" method="post" action="/library/notes/${escapeHtml(note.id)}/delete">${csrfInput(input.csrf)}<button class="btn btn-link btn-sm" type="submit">Remove</button></form>
      </li>`,
    )
    .join("");
  const preview = input.preview
    .map((chunk) => `<article class="mb-3"><h2 class="h6">${escapeHtml(chunk.title)}</h2><p class="small mb-0">${escapeHtml(chunk.body.slice(0, 280))}</p></article>`)
    .join("");
  return layout({
    title: "Library",
    csrf: input.csrf,
    body: `<p class="fq-mark mb-1">Rules and family notes</p>
      <h1 class="h2">Library</h1>
      <p>The Dungeon Master checks this library before answering a rules or lore question. ${input.indexed} of ${input.total} snippets are in the vector index.</p>
      ${input.error ? `<div class="alert alert-warning">${escapeHtml(input.error)}</div>` : ""}
      ${input.notice ? `<div class="alert alert-success">${escapeHtml(input.notice)}</div>` : ""}
      <form class="fq-card card p-3 mb-3" method="post" action="/library/index">${csrfInput(input.csrf)}
        <button class="btn btn-success" type="submit">Index the next batch</button>
        <p class="small mb-0 mt-2">Each batch is one Workers AI embedding call and counts toward today's cap. It uses @cf/baai/bge-small-en-v1.5.</p>
      </form>
      <form class="fq-card card p-3 mb-4" method="post" action="/library/notes">
        ${csrfInput(input.csrf)}
        <h2 class="h5">Family notes</h2>
        <label class="form-label" for="title">Title</label>
        <input class="form-control mb-2" id="title" name="title" maxlength="80" required>
        <label class="form-label" for="body">Markdown or plain text</label>
        <textarea class="form-control mb-2" id="body" name="body" rows="8" maxlength="80000" required></textarea>
        <button class="btn btn-outline-success" type="submit">Save note</button>
      </form>
      <ul class="list-unstyled">${notes || "<li>No family notes yet.</li>"}</ul>
      <h2 class="h5 mt-4">Search the text</h2>
      <form class="row g-2 mb-3" method="get" action="/library">
        <div class="col-md-8"><input class="form-control" name="q" placeholder="advantage, goblin, picnic"></div>
        <div class="col-md-4"><button class="btn btn-outline-success" type="submit">Search</button></div>
      </form>
      ${preview}`,
  });
}

function monsterForm(monster: MonsterStat | null, csrf: string, label: string): string {
  const action = monster ? `/bestiary/${escapeHtml(monster.id)}` : "/bestiary";
  const options = crOptions()
    .map(
      (option) =>
        `<option value="${option.value}" ${monster?.crLabel === option.value ? "selected" : ""}>CR ${option.label}</option>`,
    )
    .join("");
  const attack = (slot: number) => {
    const current = monster?.attacks[slot - 1];
    return `<div class="row g-2 mb-2">
      <div class="col-md-4"><input class="form-control" name="attack_name_${slot}" placeholder="Attack name" value="${escapeHtml(current?.name ?? "")}"></div>
      <div class="col-md-2"><input class="form-control" name="attack_bonus_${slot}" placeholder="+4" value="${current ? String(current.bonus) : ""}"></div>
      <div class="col-md-6"><input class="form-control" name="attack_damage_${slot}" placeholder="1d6+2" value="${escapeHtml(current?.damage.join("+") ?? "")}"></div>
    </div>`;
  };
  return `<form class="fq-card card p-3" method="post" action="${action}">
    ${csrfInput(csrf)}
    <label class="form-label" for="name">Name</label>
    <input class="form-control mb-2" id="name" name="name" required maxlength="40" value="${escapeHtml(monster?.name ?? "")}">
    <div class="row g-2 mb-2">
      <div class="col-md-3"><label class="form-label">CR</label><select class="form-select" name="cr">${options}</select></div>
      <div class="col-md-3"><label class="form-label">AC</label><input class="form-control" name="ac" type="number" min="8" max="22" value="${monster?.ac ?? 12}" required></div>
      <div class="col-md-3"><label class="form-label">HP</label><input class="form-control" name="hp" type="number" min="1" max="200" value="${monster?.hp ?? 7}" required></div>
      <div class="col-md-3"><label class="form-label">Dex</label><input class="form-control" name="dexterity" type="number" min="1" max="20" value="${monster?.dexterity ?? 12}" required></div>
    </div>
    <p class="mb-1">Attacks</p>
    ${attack(1)}${attack(2)}${attack(3)}
    <label class="form-label" for="multiattack">Swings on its turn</label>
    <input class="form-control mb-2" id="multiattack" name="multiattack" type="number" min="1" max="3" value="${Math.max(1, monster?.multiattack.length || 1)}">
    <label class="form-check mb-2"><input class="form-check-input" type="checkbox" name="pack_tactics" value="yes" ${monster?.packTactics ? "checked" : ""}> Pack tactics</label>
    <label class="form-label" for="note">Note for the family</label>
    <textarea class="form-control mb-3" id="note" name="note" rows="2" maxlength="240">${escapeHtml(monster?.note ?? "")}</textarea>
    <button class="btn btn-success" type="submit">${label}</button>
  </form>`;
}
