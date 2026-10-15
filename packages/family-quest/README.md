# Family Quest

A family-friendly web app where an AI dungeon master runs a shared D&D-style adventure. Kids can play. The owner is Thon Becker.

The table is server-rendered HTML (Bootstrap 5, Alpine.js, and htmx, vendored in `public/`). The browser's light or dark setting is followed. There is no theme toggle and no stored theme. Noto Sans is vendored under the SIL Open Font License (`public/fonts/OFL.txt`).

Nothing in this app calls a paid third-party API or asks for a new API key. Workers AI and D1 are used through Cloudflare bindings, inside the free daily allowance, with a configurable cap in front of that allowance.

This Worker lives in `packages/family-quest` of `SnapPetal/cloudflare-os-personal`. Its name is `thonbecker-family-quest`. A separate `SnapPetal/family-quest` repository was not created.

`deployment.jsonc` sets `workers.familyQuest.route` to `{ "customDomain": "quest.thonbecker.biz" }`. Merging uploads the Worker, attaches that hostname, and lets Wrangler provision its D1 database and R2 notes bucket. Set `FAMILY_PASSCODE` and `SESSION_SECRET` before anyone should open the table. Vectorize is not in the Wrangler config: Wrangler does not create indexes, and a missing index would fail the deploy of this repository. Rules and notes are still searchable as text. Add the `vectorize` binding after `npx wrangler vectorize create thonbecker-family-quest-lore --dimensions=384 --metric=cosine`.

## What you can do

- Create a quest or continue a saved one. Quick start builds a party from names. Custom start picks a kid-friendly class and ancestry for each hero.
- Each hero has a name, class, ancestry, level, HP, AC, the six ability scores, inventory, XP, and a short portrait description.
- Type actions. The dungeon master narrates, gives people you meet a voice, and asks for rolls. A running summary is stored in D1 so a long quest does not have to resend the whole log.
- Turn the narrator on, optionally auto-play new replies, and speak an action with the browser Web Speech API where the browser supports it.
- Ask for a gentle challenge. Combat has initiative, enemies, turns, attack and damage rolls, conditions, and an ending with victory, loot, and XP. The encounter panel shows turn order and HP bars.
- Roll d4–d20 with a modifier, advantage, or disadvantage. Combat dice use the same roller.
- The server rolls every die with `crypto.getRandomValues` and rejection sampling. The model chooses critter actions and story. The server applies the numbers.
- A shared family passcode (Worker secret) sets a signed session cookie.
- A daily cap on Workers AI calls is stored in D1. Dice, sheets, and saved chapters keep working after the cap, with a plain explanation.

Classes: Brave Knight, Forest Ranger, Kind Healer, Spark Wizard, Sneaky Scout, Story Bard, Animal Friend, Gadget Inventor.

Ready-made premises: The Lost Picnic, The Birthday Dragon, The Library of Living Books, and Rainbow Bridge Repair.

`@cf/baai/bge-small-en-v1.5` embeds the library. It costs about 1,841 neurons per million input tokens and returns 384 dimensions, which keeps Vectorize inside the free stored-dimension quota. `@cf/deepgram/aura-1` is still not used.

## Bestiary

The bestiary is the D&D Systems Reference Document 5.1 monster list, 334 stat blocks, loaded into D1 by `migrations/0002_srd.sql`. The Dungeon Master may only start a fight with names from that table (or a family critter) at a challenge rating that fits the party's level. The server copies hit points, armor class, attack bonus, and damage dice from the row. It rolls those dice. Save-based riders such as poison and breath weapons stay on the stat block and are not applied automatically.

Family critters are created from the Bestiary page. SRD rows are not editable.

Monster stat blocks and rules text are from the Dungeons & Dragons Systems Reference Document 5.1, copyright Wizards of the Coast LLC, licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). The structured JSON is the SRD compilation in [5e-bits/5e-database](https://github.com/5e-bits/5e-database) (MIT), commit `a6212beb4b278917c2cff41c2b04c4ef4f3e0d6f`. Only those SRD files are imported. The madness, disease, and poison chapters are left out of the family library. No non-SRD books are included.

Rebuild the committed data, if you ever need to, with `node scripts/build-srd.mjs`. The package test task checks the committed files without downloading them again.

## Library

Rules snippets and family notes live in D1. Notes are also stored in R2. Before the Dungeon Master answers a rules or lore question, the Worker embeds the question and asks Vectorize for the nearest snippets. If the index is missing, it falls back to a text search in D1, so the table still works before you create Vectorize.

Vectorize's current intro says the product is on the Workers Free and Paid plans, with a free quota of 5 million stored dimensions and 30 million queried dimensions per month. The pricing page also still says Vectorize is Workers Paid only, next to that same free quota. This app is sized for the free quota (about 360,000 stored dimensions for the SRD library). If an account cannot create the index without a paid plan, skip that command. Text search and the bestiary still work, and nothing else in the app calls a paid API.

Index the library from the Library page. Each click embeds up to 32 snippets and uses one daily AI turn. The full SRD set is a few hundred neurons, spread across those clicks so it stays inside the free neuron day.

## Cost and model limits

Workers AI includes **10,000 neurons per day** on the free allocation. That resets at 00:00 UTC. Past that, Cloudflare bills neurons, so this app stops itself first.

| Setting | Default | Purpose |
| --- | --- | --- |
| `AI_DAILY_CAP` | `40` | AI turns per UTC day (story, critter choices, narrator audio, and library indexing). A turn counts when the app is allowed to call Workers AI, including a turn whose models all fail |
| `AI_MODEL` | `@cf/meta/llama-3.3-70b-instruct-fp8-fast` | Dungeon master |
| `AI_MODEL_FALLBACK` | `@cf/meta/llama-3.1-8b-instruct-fast` | Used when the 70B model errors or returns nothing |
| `TTS_MODEL` | `@cf/myshell-ai/melotts` | Narrator audio |
| `EMBED_MODEL` | `@cf/baai/bge-small-en-v1.5` | Library embeddings, 384 dimensions |

`@cf/meta/llama-3.3-70b-instruct-fp8-fast` is listed at about 26,668 neurons per million input tokens and 204,805 neurons per million output tokens ([Workers AI pricing](https://developers.cloudflare.com/workers-ai/platform/pricing/)). A normal turn is on the order of a couple thousand input tokens and a few hundred output tokens, roughly 100–200 neurons. Forty turns stay under the free 10,000-neuron day for ordinary family play. The smaller fallback model is cheaper when the primary call fails. A failed primary call may try the fallback; that still counts as one family turn in D1, but it can spend neurons twice.

Narration uses `@cf/myshell-ai/melotts`, which is Cloudflare-hosted (about $0.000205 per audio minute, billed as neurons). Each clip is cut to 450 characters. `@cf/deepgram/aura-1` is available on Workers AI, but it is a partner model billed at about $0.015 per 1,000 characters, outside the neuron pool. This app does not call it.

If MeloTTS fails, the daily cap is spent, or the browser blocks autoplay, the page falls back to `speechSynthesis`. Speaking an action uses the browser `SpeechRecognition` API only. Some browsers, especially iOS Safari and Firefox, do not implement speech recognition; the microphone button says so and typing still works. Auto-play can also be blocked until a click, so each Dungeon Master line has its own Read aloud button.

The system prompt requires a PG, family-friendly tone: cozy trouble, no gore, no romance, and no real harm. A small server-side word check replaces a reply that slips past the prompt. Knockouts wake up safe with 1 HP. Combat numbers come from the bestiary, not from the model.

## Local setup

From the repository root, after `pnpm install`:

```bash
cd packages/family-quest
cp .dev.vars.example .dev.vars
```

Edit `.dev.vars`:

- `FAMILY_PASSCODE` — at least 4 characters. This is the shared family passcode.
- `SESSION_SECRET` — at least 16 characters. Use a long random string (`openssl rand -base64 32`).

Create a local D1 database and apply the migrations. This does not create a remote database:

```bash
pnpm exec wrangler d1 migrations apply thonbecker-family-quest --local
pnpm exec wrangler dev
```

Open the URL Wrangler prints (usually `http://localhost:8787`). The session cookie is `Secure` only on HTTPS, so local HTTP still keeps you signed in.

## Deploy

Do not run `wrangler deploy` from this package. The repository Deploy workflow (`pnpm deploy`) uploads this Worker with the others.

On the next push to `main` that includes this package:

- The Worker script is uploaded as `thonbecker-family-quest`.
- `workers.dev` stays off and no custom domain is attached. There is no public URL.
- Wrangler provisions the D1 database `thonbecker-family-quest` and applies `migrations/`, and provisions the R2 binding `NOTES`.
- Vectorize is not created. Semantic search stays on the D1 text fallback.
- `FAMILY_PASSCODE` and `SESSION_SECRET` are not required for that upload. Set them before anyone should be able to open the table:

```bash
printf '%s' 'your-family-passcode' | pnpm exec wrangler secret put FAMILY_PASSCODE --name thonbecker-family-quest
printf '%s' "$(openssl rand -base64 32)" | pnpm exec wrangler secret put SESSION_SECRET --name thonbecker-family-quest
```

### quest.thonbecker.biz

The production hostname is already set in `deployment.jsonc`. Wrangler creates the DNS and TLS custom domain on deploy when the `thonbecker.biz` zone is in the same Cloudflare account. The table still shows the setup page until `FAMILY_PASSCODE` and `SESSION_SECRET` are set.

## Tests

```bash
pnpm --filter thonbecker-family-quest types:check
pnpm exec vp run -F thonbecker-family-quest test
```

Vitest covers the dice roller (including unbiased sampling, advantage, and disadvantage), the encounter engine (initiative, hits, misses, crits, conditions, victory, loot, XP, and defeat), the bestiary (real stat blocks, challenge-rating caps, and family critters), the library text search helpers, and the daily AI cap. The test task also checks the committed SRD files. The repository Pull Request and Deploy workflows run those checks with the other Workers.

## Project map

- `src/dice.ts` — crypto dice
- `src/encounter.ts` — combat rules
- `src/cost.ts` — daily cap
- `src/dm.ts` — PG system prompt and JSON parsing
- `src/ai.ts` — Workers AI text and MeloTTS audio
- `src/auth.ts` — passcode check and HMAC session cookie
- `migrations/0001_init.sql` — quests, heroes, messages
- `migrations/0002_srd.sql` — SRD bestiary and rules library
- `public/` — vendored Bootstrap, Alpine, htmx, Noto Sans, and app CSS/JS
