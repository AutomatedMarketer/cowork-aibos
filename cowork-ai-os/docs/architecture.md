# Cowork AI OS — architecture brief

**TL;DR:** Cowork AI OS is a Claude Cowork plugin that turns Cowork into a personal AI operating system. As of v0.10 (May 2026) it bundles 14 skills, organized into onboarding, daily-work, evolution, maintenance, and discovery. Everything runs locally in Cowork — no hooks, no local MCP servers, no background processes. Self-installed, self-onboarding.

This doc explains how the pieces fit together, the architectural principles behind it, and what changed in each major version.

---

## v0.10 — the discovery layer (May 2026)

The big v0.10 question: is cowork-ai-os actually best-in-class, or just unbloated? Research showed the architecture was sound but missing one thing — a way to help users find and install the OTHER skills + MCP connectors that would compound the personal-AI-OS effect.

v0.10 adds two conversational recommender skills:

- **`/browse-skills`** — reads your business-brain, returns 3 ranked plugin/skill recommendations from a curated catalog of community and Anthropic-official options. Each with reasoning tied to your business, an install command, and a first-week use case.
- **`/browse-connectors`** — reads your `connections.md` and identifies which of the 7 Connection buckets (Revenue, Customer, Calendar, Comms, Tasks, Meetings, Knowledge) are empty. Recommends 1–3 MCP connectors to fill the highest-leverage gap, with safe permission defaults baked in.

Plus integrations:
- `/level-up` now branches into 6 forms — including delegating to `/browse-skills` (Form E) and `/browse-connectors` (Form B) when those are the highest-leverage gap.
- `/onboard` Phase 5 (connectors) — after Gmail+Calendar, invokes `/browse-connectors` logic to personalize additional connector recommendations from the just-built business-brain.
- `/onboard` Phase 7 (skills tour) — after demoing bundled skills, invokes `/browse-skills` logic to recommend 1–2 community plugins specific to the user's business.

The catalogs are bundled markdown (no remote hosting, no API dependencies) and refreshed each plugin release. PRs welcome.

---

## v0.9 — the speed fix (May 11, 2026)

**TL;DR:** Cowork was slow because v0.8 told Claude to re-read your entire identity folder on every prompt. v0.9 stops that. Your "Start Up" time drops from ~25 seconds to under 3.

Nothing about your daily workflow changes. Your identity files (`about-me/`) and your scheduled tasks keep working exactly the same. Skills still know who you are. They just stop loading that context until they actually need it.

---

## The bug, in one paragraph

The v0.8 handbook (the file pasted into Cowork's Global Instructions during onboarding) contained a line that said:

> *"At the start of every session, read every file in `about-me/` before responding to my first message."*

Cowork treated every prompt like a session start, so Claude obediently re-read 5–7 identity files on **every** prompt before answering anything. After a few months of daily use, that was 11,000+ tokens of pre-loaded context per prompt and 20+ seconds of latency. Sarah, one of the first students to install, lost an hour to it in one week. She's the reason this got fixed.

---

## What v0.9 actually does

### 1. The handbook is slim now (and stops telling Claude to pre-load)

The new template at `skills/onboard/templates/claude-md.md`:

- Keeps your identity sections (Who I am, How to work with me, Never-do, Safety rules, Three priorities).
- Removes the `## Things to always do` section — that's the one with the bug.
- Adds a new `## Where my identity lives` section that explicitly tells Claude: *"My full identity lives in `about-me/`. Skills load it when needed. Do **not** pre-read those files on every turn."*

### 2. Skills load identity on demand (this part already worked)

`/morning-brief`, `/voice-writer`, `/audit`, `/tune-up`, `/level-up`, `/add-skill`, `/tidy-downloads` — every skill that needs identity files reads them itself at runtime, when it fires. That part of v0.8 was already correct. The bug was that the handbook redundantly loaded them too. v0.9 stops that redundancy.

### 3. Memory auto-archives at 30 entries

Previously `about-me/memory.md` was append-only with no rotation — after months of daily use it'd grow to 7,500+ tokens, all loaded on every relevant skill. v0.9:

- **`memory.md`** stays small — last 30 entries, ~500 tokens.
- **`memory-log.md`** holds the full history, created automatically when the first overflow happens.
- Skills that need recent context (morning-brief, voice-writer, level-up) read only `memory.md`.
- Skills that need the long view (audit, tune-up) read both.
- The rotation is silent — you see one memory file in your workspace and don't need to think about it. Nothing is ever deleted.

### 4. `/optimize` — the fix command

If your Cowork ever feels slow, run `/optimize`. The skill:

1. Diagnoses what's wrong (old handbook? memory bloat?).
2. Tells you in plain English what it'll fix.
3. Waits for your "yes".
4. Backs up `claude.md` and `memory.md` to `_aibos/backups/` (so `rollback` is always available).
5. Rewrites your handbook in your workspace, preserving every answer you gave during onboarding.
6. Shows you the new handbook as a copy-friendly block and walks you through pasting it into Cowork → Settings → Global instructions (this step is unavoidable — Cowork doesn't let plugins edit Global Instructions directly).
7. Archives any memory overflow silently.
8. Tells you to test with a quick prompt.

If anything looks wrong, type `rollback` and it puts everything back.

---

## What v0.9 does **not** change

- Your identity files — `about-me/about-me.md`, `business-brain.md`, `writing-rules.md`, `connections.md`, `audit-log.md`, `brief-preferences.md`. Untouched.
- Your scheduled tasks — `/morning-brief`, `/tune-up`, weekly `/tidy-downloads`. Keep firing through the migration.
- Your saved deliverables in `outputs/`.
- Your project files in `projects/`.
- The `_aibos/` state files — onboarding doesn't re-run; the plugin just learns the new version.

---

## How to upgrade (existing students)

1. **In Cowork**, type `/plugin update cowork-ai-os`. Wait for it to finish.
2. Then type `/optimize`. Follow the on-screen prompts.
3. When it shows you the new handbook in a code block, copy it, open **Cowork → Settings → Cowork → Global instructions**, replace the existing text, save.
4. Type **done** in Cowork to confirm.
5. Send a quick prompt — anything. It should respond in under 3 seconds.

Takes ~2 minutes. Identity files preserved. Schedules preserved.

If something looks off, type `rollback` and it puts everything back.

---

## New students

You don't need to do anything special. Run `/onboard` like normal. The new architecture ships from day one. No `/optimize` needed unless your Cowork starts feeling slow later (which it shouldn't, given the auto-archive).

---

## Why this matters beyond speed

Token efficiency isn't just about latency — it's about quality. When Cowork was shipping 11,000 tokens of pre-loaded identity context per prompt, Claude had to filter through a lot of noise to find what was actually relevant. Less noise → better focus → better answers. The speed-up is the visible part; the quality lift is the quiet part.

---

## Credit where credit's due

The principles behind this refactor — progressive disclosure, hot/cold memory split, semantic search before fetch — are well-established in the Anthropic skills documentation and are also implemented beautifully (for Claude Code CLI users) in [claude-mem](https://github.com/thedotmack/claude-mem) by @thedotmack. We can't use claude-mem directly because it's CLI-only and requires local infrastructure Cowork web doesn't support. But the principles are sound and v0.9 applies them in pure-Cowork form.
