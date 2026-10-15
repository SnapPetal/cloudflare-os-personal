import { ANCESTRIES, CLASSES, PREMISES, levelUpReady } from "./classes";
import type { CapResult } from "./cost";
import { capMessage } from "./cost";
import type { Combatant, EncounterState } from "./encounter";
import type { MonsterStat } from "./bestiary";
import type { CampaignRecord, CharacterRecord, MessageRecord } from "./repo";
import { SRD_ATTRIBUTION } from "./attribution";
import { escapeHtml } from "./text";

export function layout(input: {
  title: string;
  body: string;
  csrf?: string | null;
  questId?: string | null;
}): string {
  const csrf = input.csrf ? `<meta name="fq-csrf" content="${escapeHtml(input.csrf)}">` : "";
  const quest = input.questId ? ` data-quest="${escapeHtml(input.questId)}"` : "";
  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex">
  ${csrf}
  <title>${escapeHtml(input.title)} · Family Quest</title>
  <script src="/js/theme.js"></script>
  <link rel="stylesheet" href="/vendor/bootstrap.min.css">
  <link rel="stylesheet" href="/css/app.css">
</head>
<body${quest}>
  <header class="border-bottom">
    <div class="container py-3 d-flex justify-content-between align-items-center gap-3">
      <a class="text-decoration-none" href="/"><span class="fq-mark">Family Quest</span></a>
      <nav class="d-flex gap-3 align-items-center">
        ${input.csrf ? `<a href="/bestiary">Bestiary</a><a href="/library">Library</a><form method="post" action="/logout">${csrfInput(input.csrf)}<button class="btn btn-sm btn-outline-secondary" type="submit">Lock</button></form>` : ""}
      </nav>
    </div>
  </header>
  <main class="container py-4">${input.body}</main>
  <footer class="container pb-4 small text-secondary">${escapeHtml(SRD_ATTRIBUTION)} <a href="https://creativecommons.org/licenses/by/4.0/">CC BY 4.0</a>.</footer>
  <script src="/js/table.js" defer></script>
  <script src="/vendor/htmx.min.js" defer></script>
  <script src="/vendor/alpine.min.js" defer></script>
</body>
</html>`;
}

export function setupPage(): string {
  return layout({
    title: "Setup",
    body: `<section class="fq-card card p-4">
      <h1 class="h3">Family Quest needs its secrets</h1>
      <p>Set <code>FAMILY_PASSCODE</code> and <code>SESSION_SECRET</code> before anyone sits down at the table. The README has the Wrangler commands. Nothing here calls a paid API.</p>
    </section>`,
  });
}

export function loginPage(error: string | null): string {
  return layout({
    title: "Welcome",
    body: `<section class="row justify-content-center">
      <div class="col-lg-7">
        <p class="fq-mark mb-2">A table for the Becker family</p>
        <h1 class="display-6">Family Quest</h1>
        <p class="lead">An AI dungeon master for a shared, kid-friendly adventure. Type what you do, roll the dice, and keep the story for next time.</p>
        ${error ? `<div class="alert alert-warning">${escapeHtml(error)}</div>` : ""}
        <form method="post" action="/login" class="fq-card card p-4">
          <label class="form-label" for="passcode">Family passcode</label>
          <input class="form-control" id="passcode" name="passcode" type="password" autocomplete="current-password" required>
          <button class="btn btn-success mt-3" type="submit">Come in</button>
        </form>
      </div>
    </section>`,
  });
}

export function homePage(campaigns: CampaignRecord[], csrf: string): string {
  const cards =
    campaigns.length === 0
      ? `<p>No quests yet. Start one and the Dungeon Master will set the scene.</p>`
      : campaigns
          .map(
            (campaign) => `<article class="fq-card card p-3 mb-3">
              <div class="d-flex justify-content-between gap-3 flex-wrap">
                <div>
                  <h2 class="h4 mb-1">${escapeHtml(campaign.title)}</h2>
                  <p class="mb-1">${escapeHtml(campaign.party || "No heroes yet")}</p>
                  <p class="text-secondary small mb-0">Updated ${escapeHtml(friendlyTime(campaign.updated_at))}</p>
                </div>
                <a class="btn btn-success align-self-center" href="/quests/${escapeHtml(campaign.id)}">Continue</a>
              </div>
            </article>`,
          )
          .join("");
  return layout({
    title: "Quests",
    csrf,
    body: `<div class="d-flex justify-content-between align-items-end gap-3 mb-4 flex-wrap">
      <div>
        <p class="fq-mark mb-1">Saved quests</p>
        <h1 class="h2 mb-0">Pick up the story</h1>
      </div>
      <a class="btn btn-success" href="/quests/new">Start a new quest</a>
      <a class="btn btn-outline-success" href="/bestiary">Bestiary</a>
    </div>
    ${cards}`,
  });
}

export function newQuestPage(csrf: string, error: string | null): string {
  const premises = PREMISES.map(
    (premise, index) => `<label class="list-group-item">
      <input class="form-check-input me-2" type="radio" name="premise" value="${premise.id}" ${index === 0 ? "checked" : ""}>
      <strong>${escapeHtml(premise.title)}</strong>
      <span class="d-block small">${escapeHtml(premise.text)}</span>
    </label>`,
  ).join("");
  const classOptions = CLASSES.map((entry) => `<option value="${entry.id}">${escapeHtml(entry.name)}</option>`).join("");
  const ancestryOptions = ANCESTRIES.map((ancestry) => `<option>${escapeHtml(ancestry)}</option>`).join("");
  const customRows = [1, 2, 3, 4]
    .map(
      (slot) => `<div class="row g-2 mb-2">
        <div class="col-md-4"><input class="form-control" name="name_${slot}" placeholder="Name" maxlength="24"></div>
        <div class="col-md-4"><select class="form-select" name="class_${slot}">${classOptions}</select></div>
        <div class="col-md-4"><select class="form-select" name="ancestry_${slot}">${ancestryOptions}</select></div>
      </div>`,
    )
    .join("");
  const blurbs = CLASSES.map((entry) => `<li><strong>${escapeHtml(entry.name)}.</strong> ${escapeHtml(entry.blurb)}</li>`).join("");
  return layout({
    title: "New quest",
    csrf,
    body: `<p class="fq-mark mb-1">New quest</p>
    <h1 class="h2">Who is at the table?</h1>
    ${error ? `<div class="alert alert-warning">${escapeHtml(error)}</div>` : ""}
    <form method="post" action="/quests" class="fq-card card p-4">
      ${csrfInput(csrf)}
      <fieldset class="mb-4">
        <legend class="h5">Party</legend>
        <label class="form-check"><input class="form-check-input" type="radio" name="mode" value="quick" checked> Quick start from names</label>
        <label class="form-check mb-2"><input class="form-check-input" type="radio" name="mode" value="custom"> Choose classes</label>
        <label class="form-label" for="names">Names, one per line (quick start, up to four)</label>
        <textarea class="form-control mb-3" id="names" name="names" rows="4" placeholder="Maya&#10;Leo"></textarea>
        <p class="small text-secondary">Custom rows are used when "Choose classes" is selected. Empty rows are skipped.</p>
        ${customRows}
      </fieldset>
      <fieldset class="mb-4">
        <legend class="h5">The trouble</legend>
        <div class="list-group mb-3">${premises}
          <label class="list-group-item">
            <input class="form-check-input me-2" type="radio" name="premise" value="custom">
            <strong>Our own premise</strong>
          </label>
        </div>
        <input class="form-control mb-2" name="title" maxlength="80" placeholder="Title, if you wrote your own">
        <textarea class="form-control" name="custom_premise" rows="3" maxlength="600" placeholder="A short, gentle premise"></textarea>
      </fieldset>
      <button class="btn btn-success" type="submit">Open the quest</button>
    </form>
    <ul class="mt-4">${blurbs}</ul>`,
  });
}

export function playPage(input: {
  campaign: CampaignRecord;
  characters: CharacterRecord[];
  messages: MessageRecord[];
  encounter: { id: string; state: EncounterState } | null;
  suggested: MonsterStat[];
  csrf: string;
  cap: CapResult;
  error: string | null;
  speakText: string | null;
  fragment: boolean;
}): string {
  const root = questRoot(input);
  if (input.fragment) return root;
  return layout({
    title: input.campaign.title,
    csrf: input.csrf,
    questId: input.campaign.id,
    body: root,
  });
}

function questRoot(input: {
  campaign: CampaignRecord;
  characters: CharacterRecord[];
  messages: MessageRecord[];
  encounter: { id: string; state: EncounterState } | null;
  suggested: MonsterStat[];
  csrf: string;
  cap: CapResult;
  error: string | null;
  speakText: string | null;
}): string {
  const banner = input.cap.remaining === 0 ? `<div class="alert alert-warning">${escapeHtml(capMessage(input.cap.cap))}</div>` : "";
  const error = input.error ? `<div class="alert alert-warning">${escapeHtml(input.error)}</div>` : "";
  const turns =
    input.cap.remaining === 0
      ? ""
      : `<p class="small text-secondary">${input.cap.remaining} of ${input.cap.cap} free Dungeon Master turns left today.</p>`;
  const speak = input.speakText
    ? `<span class="visually-hidden" data-speak-now="${escapeHtml(input.speakText)}"></span>`
    : "";
  return `<div id="quest-page" data-quest-table x-data="questTable">
    ${speak}
    <div class="d-flex justify-content-between flex-wrap gap-3 mb-3">
      <div>
        <p class="fq-mark mb-1">Quest</p>
        <h1 class="h2 mb-0">${escapeHtml(input.campaign.title)}</h1>
      </div>
      <div class="d-flex gap-2 align-items-start">
        <button class="btn btn-outline-success" type="button" x-on:click="toggleVoice" x-text="voiceLabel">Narrator on</button>
        <button class="btn btn-outline-secondary" type="button" x-on:click="toggleAutoplay" x-text="autoplayLabel">Auto-play off</button>
      </div>
    </div>
    <p class="small" x-text="status"></p>
    ${banner}${error}${turns}
    <div class="row g-4">
      <div class="col-lg-8">
        ${encounterPanel(input)}
        ${storyLog(input.messages)}
        ${composer(input)}
      </div>
      <div class="col-lg-4">
        ${dicePanel(input)}
        ${partyPanel(input)}
        <details class="fq-card card p-3 mb-3">
          <summary>Story so far</summary>
          <p class="mt-3 mb-0">${escapeHtml(input.campaign.summary || "The running summary appears after the first replies.")}</p>
        </details>
        <form method="post" action="/quests/${escapeHtml(input.campaign.id)}/delete">
          ${csrfInput(input.csrf)}
          <label class="form-check small"><input class="form-check-input" type="checkbox" name="confirm" value="yes"> Delete this saved quest</label>
          <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
        </form>
      </div>
    </div>
  </div>`;
}

function storyLog(messages: MessageRecord[]): string {
  const older = messages.length >= 80 ? `<p class="small text-secondary">Earlier moments are folded into the story summary.</p>` : "";
  const entries = messages
    .map((message) => {
      const read =
        message.role === "dm" || message.role === "npc"
          ? `<button class="btn btn-sm btn-link px-0" type="button" x-on:click="readLine($el)" data-line="${escapeHtml(message.content)}">Read aloud</button>`
          : "";
      return `<article class="story-entry ${escapeHtml(message.role)}">
        <div class="d-flex justify-content-between gap-2">
          <strong>${escapeHtml(message.speaker || message.role)}</strong>
          ${read}
        </div>
        <p class="mb-0">${escapeHtml(message.content)}</p>
      </article>`;
    })
    .join("");
  return `<section class="mb-3">
    <h2 class="h5">Story</h2>
    ${older}
    <div class="story-log">${entries || "<p>The first scene is on its way.</p>"}</div>
  </section>`;
}

function composer(input: { campaign: CampaignRecord; characters: CharacterRecord[]; csrf: string; cap: CapResult }): string {
  const options = input.characters
    .map((character) => `<option value="${escapeHtml(character.name)}">${escapeHtml(character.name)}</option>`)
    .join("");
  return `<form class="fq-card card p-3" method="post" action="/quests/${escapeHtml(input.campaign.id)}/act" hx-post="/quests/${escapeHtml(input.campaign.id)}/act" hx-target="#quest-page" hx-swap="outerHTML" hx-disabled-elt="find button">
    ${csrfInput(input.csrf)}
    <label class="form-label" for="speaker">Who acts</label>
    <select class="form-select mb-2" id="speaker" name="speaker">${options}</select>
    <label class="form-label" for="action">What do you do?</label>
    <textarea class="form-control mb-2" id="action" name="action" rows="3" maxlength="500" x-ref="action" required></textarea>
    <div class="d-flex gap-2 flex-wrap">
      <button class="btn btn-success" type="submit">Send <span class="spinner-border spinner-border-sm htmx-indicator"></span></button>
      <button class="btn btn-outline-secondary" type="button" x-on:click="listen" x-text="micLabel">Speak</button>
    </div>
    ${input.cap.remaining === 0 ? `<p class="small mt-2 mb-0">The Dungeon Master is resting, so this send will be saved without a new chapter.</p>` : ""}
  </form>`;
}

function dicePanel(input: { campaign: CampaignRecord; characters: CharacterRecord[]; csrf: string }): string {
  const dice = [20, 12, 10, 8, 6, 4].map((sides) => `<option value="${sides}">d${sides}</option>`).join("");
  const speakers = input.characters
    .map((character) => `<option value="${escapeHtml(character.name)}">${escapeHtml(character.name)}</option>`)
    .join("");
  return `<form class="fq-card card p-3 mb-3" method="post" action="/quests/${escapeHtml(input.campaign.id)}/dice" hx-post="/quests/${escapeHtml(input.campaign.id)}/dice" hx-target="#quest-page" hx-swap="outerHTML">
    ${csrfInput(input.csrf)}
    <h2 class="h5">Dice</h2>
    <div class="row g-2">
      <div class="col-4"><input class="form-control" name="count" type="number" min="1" max="20" value="1"></div>
      <div class="col-4"><select class="form-select" name="sides">${dice}</select></div>
      <div class="col-4"><input class="form-control" name="modifier" type="number" min="-10" max="10" value="0"></div>
    </div>
    <select class="form-select my-2" name="mode">
      <option value="normal">Normal</option>
      <option value="advantage">Advantage</option>
      <option value="disadvantage">Disadvantage</option>
    </select>
    <select class="form-select mb-2" name="speaker">${speakers}</select>
    <button class="btn btn-outline-success" type="submit">Roll</button>
  </form>`;
}

function partyPanel(input: { campaign: CampaignRecord; characters: CharacterRecord[]; csrf: string }): string {
  const sheets = input.characters
    .map((character) => {
      const ready = levelUpReady(character.level, character.xp)
        ? `<form method="post" action="/quests/${escapeHtml(input.campaign.id)}/characters/${escapeHtml(character.id)}/level" class="mt-2">${csrfInput(input.csrf)}<button class="btn btn-sm btn-success" type="submit">Level up</button></form>`
        : "";
      return `<details class="mb-3">
        <summary><strong>${escapeHtml(character.name)}</strong> · ${escapeHtml(character.class_name)}</summary>
        <p class="mt-2 mb-1">${escapeHtml(character.ancestry)} · level ${character.level} · ${character.xp} XP · AC ${character.ac}</p>
        <p class="small">${escapeHtml(character.portrait)}</p>
        ${hpBar(character.hp, character.max_hp)}
        <p class="small mt-2 mb-2">${character.hp}/${character.max_hp} HP</p>
        <div class="ability-grid small mb-2">
          ${score("STR", character.strength)}
          ${score("DEX", character.dexterity)}
          ${score("CON", character.constitution)}
          ${score("INT", character.intelligence)}
          ${score("WIS", character.wisdom)}
          ${score("CHA", character.charisma)}
        </div>
        <form method="post" action="/quests/${escapeHtml(input.campaign.id)}/characters/${escapeHtml(character.id)}">
          ${csrfInput(input.csrf)}
          <label class="form-label small">HP <input class="form-control" name="hp" type="number" min="0" max="${character.max_hp}" value="${character.hp}"></label>
          <label class="form-label small">Inventory <textarea class="form-control" name="inventory" rows="2" maxlength="400">${escapeHtml(character.inventory)}</textarea></label>
          <label class="form-label small">Portrait <textarea class="form-control" name="portrait" rows="2" maxlength="300">${escapeHtml(character.portrait)}</textarea></label>
          <button class="btn btn-sm btn-outline-secondary" type="submit">Save sheet</button>
        </form>
        ${ready}
      </details>`;
    })
    .join("");
  return `<section class="fq-card card p-3 mb-3"><h2 class="h5">Party</h2>${sheets}</section>`;
}

function encounterPanel(input: {
  campaign: CampaignRecord;
  characters: CharacterRecord[];
  encounter: { id: string; state: EncounterState } | null;
  suggested: MonsterStat[];
  csrf: string;
}): string {
  const state = input.encounter?.state;
  if (!input.encounter || !state || state.dismissed) {
    const options = input.suggested
      .map(
        (monster) =>
          `<option value="${escapeHtml(monster.id)}">${escapeHtml(monster.name)} · CR ${escapeHtml(monster.crLabel)} · AC ${monster.ac} · HP ${monster.hp}</option>`,
      )
      .join("");
    const picker = options
      ? `<form class="mb-3" method="post" action="/quests/${escapeHtml(input.campaign.id)}/encounter" hx-post="/quests/${escapeHtml(input.campaign.id)}/encounter" hx-target="#quest-page" hx-swap="outerHTML">
      ${csrfInput(input.csrf)}
      <label class="form-label small" for="monster_id">Or face a known critter</label>
      <div class="row g-2">
        <div class="col-8"><select class="form-select" id="monster_id" name="monster_id">${options}</select></div>
        <div class="col-4"><input class="form-control" name="count" type="number" min="1" max="4" value="1" aria-label="How many"></div>
      </div>
      <button class="btn btn-outline-success mt-2" type="submit">Use the stat block</button>
    </form>`
      : "";
    return `<form class="mb-3" method="post" action="/quests/${escapeHtml(input.campaign.id)}/encounter" hx-post="/quests/${escapeHtml(input.campaign.id)}/encounter" hx-target="#quest-page" hx-swap="outerHTML">
      ${csrfInput(input.csrf)}
      <button class="btn btn-outline-success" type="submit">Ask the Dungeon Master for a gentle challenge</button>
    </form>
    ${picker}`;
  }
  const current = state.status === "active" ? state.combatants.find((combatant) => combatant.id === state.order[state.turnIndex] && combatant.out === "none") : null;
  const rows = state.order
    .map((id) => state.combatants.find((combatant) => combatant.id === id))
    .filter((combatant): combatant is Combatant => Boolean(combatant))
    .map((combatant) => {
      const mark = current?.id === combatant.id ? "←" : "";
      const conditions = combatant.conditions.length ? ` · ${combatant.conditions.join(", ")}` : "";
      const status = combatant.out === "none" ? `${combatant.hp}/${combatant.maxHp}` : combatant.out;
      return `<div class="mb-2">
        <div class="hp-row small">
          <span>${escapeHtml(combatant.name)} ${mark}</span>
          ${hpBar(combatant.hp, combatant.maxHp)}
          <span>${escapeHtml(status)}${escapeHtml(conditions)}</span>
        </div>
      </div>`;
    })
    .join("");
  const log = state.log
    .slice(-6)
    .map((entry) => `<li>${escapeHtml(entry.text)}</li>`)
    .join("");
  return `<section class="fq-card card p-3 mb-3">
    <div class="d-flex justify-content-between gap-2">
      <h2 class="h5 mb-1">${escapeHtml(state.title)}</h2>
      <span class="small">Round ${state.round}</span>
    </div>
    <p class="small">${current ? `${escapeHtml(current.name)}'s turn` : escapeHtml(state.note || state.status)}</p>
    ${rows}
    ${current && current.side === "party" ? playerTurnForm(input, current) : ""}
    ${current && current.side === "enemy" ? enemyTurnForm(input) : ""}
    <ul class="small mt-3 mb-2">${log}</ul>
    <form method="post" action="/quests/${escapeHtml(input.campaign.id)}/encounter/dismiss">${csrfInput(input.csrf)}<button class="btn btn-sm btn-link px-0" type="submit">Tuck this scene away</button></form>
  </section>`;
}

function playerTurnForm(
  input: {
    campaign: CampaignRecord;
    characters: CharacterRecord[];
    csrf: string;
    encounter: { state: EncounterState } | null;
  },
  current: Combatant,
): string {
  const enemies = enemiesOf(input);
  const allies = input.characters
    .filter((character) => character.id !== current.id)
    .map((character) => `<option value="${escapeHtml(character.id)}">${escapeHtml(character.name)}</option>`)
    .join("");
  const heal = current.heal ? `<option value="heal">Heal</option>` : "";
  return `<form method="post" action="/quests/${escapeHtml(input.campaign.id)}/encounter/act" hx-post="/quests/${escapeHtml(input.campaign.id)}/encounter/act" hx-target="#quest-page" hx-swap="outerHTML" x-data="{ action: 'attack' }">
    ${csrfInput(input.csrf)}
    <input type="hidden" name="actor" value="${escapeHtml(current.id)}">
    <label class="form-label small">Action</label>
    <select class="form-select mb-2" name="action" x-model="action">
      <option value="attack">Attack</option>
      <option value="dodge">Dodge</option>
      <option value="help">Help a friend</option>
      ${heal}
      <option value="flee">Slip away</option>
    </select>
    <div x-show="action === 'attack'">
      <label class="form-label small">Critter</label>
      <select class="form-select mb-2" name="target_enemy">${enemies}</select>
    </div>
    <div x-show="action === 'help' || action === 'heal'">
      <label class="form-label small">Friend</label>
      <select class="form-select mb-2" name="target_ally">${allies}</select>
    </div>
    <button class="btn btn-success" type="submit">Take the turn</button>
  </form>`;
}

function enemyTurnForm(input: { campaign: CampaignRecord; csrf: string }): string {
  return `<form method="post" action="/quests/${escapeHtml(input.campaign.id)}/encounter/act" hx-post="/quests/${escapeHtml(input.campaign.id)}/encounter/act" hx-target="#quest-page" hx-swap="outerHTML">
    ${csrfInput(input.csrf)}
    <input type="hidden" name="action" value="enemy">
    <button class="btn btn-outline-success" type="submit">See what they do</button>
  </form>`;
}

function enemiesOf(input: { encounter: { state: EncounterState } | null }): string {
  const state = input.encounter?.state;
  if (!state) return "";
  return state.combatants
    .filter((combatant) => combatant.side === "enemy" && combatant.out === "none")
    .map((combatant) => `<option value="${escapeHtml(combatant.id)}">${escapeHtml(combatant.name)}</option>`)
    .join("");
}

function score(label: string, value: number): string {
  return `<div><div class="text-secondary">${label}</div><strong>${value}</strong></div>`;
}

function hpBar(hp: number, max: number): string {
  const safeMax = Math.max(1, max);
  const pct = Math.max(0, Math.min(100, Math.round((Math.max(0, hp) / safeMax) * 100)));
  const tone = pct > 60 ? "success" : pct > 30 ? "warning" : "danger";
  return `<div class="progress" role="progressbar" aria-valuenow="${Math.max(0, hp)}" aria-valuemin="0" aria-valuemax="${safeMax}" aria-label="Hit points"><div class="progress-bar bg-${tone}" style="width: ${pct}%"></div></div>`;
}

export function csrfInput(csrf: string): string {
  return `<input type="hidden" name="csrf" value="${escapeHtml(csrf)}">`;
}

function friendlyTime(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return iso;
  return `${date.toLocaleString("en-US", { dateStyle: "medium", timeStyle: "short", timeZone: "UTC" })} UTC`;
}
