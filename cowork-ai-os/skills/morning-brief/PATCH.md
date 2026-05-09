# morning-brief — v0.6.0 PATCH

This file documents the additive change to `skills/morning-brief/SKILL.md` for the v0.6.0 release.

The patch adds **two new optional sections** to the brief — Team comms and Tasks — read from the user's `brief-preferences.md` if they configured them via Project 02 (`/onboard-daily-brief`).

**The existing brief structure does not change.** Order, voice rules, draft logic, archive logic, and the anti-AI kill list are all preserved.

The Team comms section is **platform-agnostic**. It pulls from whichever messaging platform(s) the user has connected — Slack, Discord, Telegram, Microsoft Teams, or any future MCP-supported platform. The user fills in only the platforms they actually use; empty platforms get skipped.

---

## What changes

The existing morning-brief skill currently produces:

1. Priority line (one sentence)
2. Today's calendar
3. Urgent inbox
4. Quick wins
5. Drafts ready for review (in Gmail Drafts)

After the patch, when the user has the relevant Q4 / Q5 sections in `brief-preferences.md`, the brief will include:

1. Priority line
2. Today's calendar
3. Urgent inbox
4. **Team comms** *(new — optional, only if any platform section in Q4 has rules)*
5. **Tasks** *(new — optional, only if Q5 in brief-preferences.md AND `today.md` exists)*
6. Quick wins
7. Drafts ready for review

If a user never runs `/onboard-daily-brief`, the brief looks identical to v0.5.2. Backward compatible.

---

## Patch — what gets added to `skills/morning-brief/SKILL.md`

### 1. Three new items in `## Read these first`

After the existing item 6 (`The latest entry in about-me/memory.md`), add:

- Item 7: Q4 team comms rules → invoke `brief-source-comms` helper if any platform section is present
- Item 8: Q5 Tasks rules → read `projects/daily-brief/today.md` if present
- Item 9: Q8 Draft Reply rules → use stricter scoring if present, fall back to default if absent

### 2. Two new sections in `## The brief structure` example

Between the existing `## Urgent inbox` and `## Quick wins` blocks, insert:

- `## Team comms` section with `[Platform]`-tagged items (skip if Q4 empty across all platforms)
- `## Tasks (today.md)` section (skip if Q5 empty or today.md missing)

### 3. Four new rules at end of `## Rules`

Append:

- **Team comms pulling** — invoke `brief-source-comms` helper, support multiple platforms, graceful fallback when connectors not live
- **Tasks reading** — read-only access to today.md, surface Today section unchecked items
- **Draft scoring with Q8** — Q8 overrides default "if obvious" heuristic when present
- **Voice on drafts** — apply writing-rules.md AND anti-AI kill list before saving

---

## What does NOT change

These elements of the existing morning-brief stay exactly as they are:

- Anti-AI kill list (appendix)
- Save path (`outputs/daily-brief/YYYY-MM-DD-brief.md`)
- Archive logic (yesterday's brief moves to `archive/`)
- `about-me/memory.md` append (existing log unchanged)
- Quick wins section
- Draft destination (Gmail Drafts only, never sent)
- Voice match → run against kill list
- "No Good morning preamble" rule
- Scheduled task vs interactive run behavior

If you only ever ran P01, your brief looks identical to v0.5.2. The new sections only appear when you've configured them through `/onboard-daily-brief`.

---

## Why platform-agnostic instead of Slack-only?

Earlier drafts of this patch defaulted to Slack-specific rules (`brief-source-slack` helper, Slack-only Q4 schema). That was the wrong call for two reasons:

1. **Audience reality.** The user base running cowork-ai-os uses Slack, Discord, Telegram, Microsoft Teams, and combinations. Locking to Slack would force students on other platforms to fork the plugin or skip P02 entirely.
2. **Stack philosophy.** Tech stacks are liabilities, not assets. Locking the brief to one chat platform creates exactly the kind of vendor dependency cowork-ai-os is meant to avoid.

The `brief-source-comms` helper reads a per-platform Q4 from prefs, detects which MCP connectors the user has live, pulls from each read-only, and returns one unified section with `[Platform]` tags. Adding a new platform later (WhatsApp, Signal, Matrix) doesn't require a helper code change — just add a new platform section to Q4.

---

## Two-file logging note

The existing morning-brief logs to `about-me/memory.md`. That continues unchanged.

Project 02 introduces a separate calibration log at `projects/daily-brief/memory.md` — purpose-built for the 7-day HIT/MISS/EXTRA scoring loop. The two files coexist. `about-me/memory.md` = global activity log. `projects/daily-brief/memory.md` = brief-specific tuning log read by `/tune-up daily-brief`.

If you don't run P02, the second file never gets created. No conflict.

---

## Migration notes for v0.5.2 → v0.6.0 users

When users update from v0.5.2 to v0.6.0:

- Their existing `brief-preferences.md` survives (lives in their workspace, not in the plugin).
- The morning-brief skill picks up the new logic on next run.
- If they never run `/onboard-daily-brief`, Q4/Q5/Q8 stay absent and the new sections never render — backward compatible.

**Mac users:** `/plugin update cowork-ai-os` doesn't reliably work on Mac (Anthropic's open marketplace bugs). Mac users should download the new `cowork-ai-os.zip` from the v0.6.0 release page and re-upload via Settings → Customize → Browse plugins. Their workspace files (`about-me/`, `projects/`, `outputs/`, `_aibos/`) survive the re-upload.

**Windows users:** `/plugin update cowork-ai-os` works as expected.

---

## Why a patch file instead of replacing morning-brief/SKILL.md?

1. The change is purely additive. No reordering, no behavior changes for users who don't run P02.
2. A documented patch makes diffs and rollbacks clean.
3. v0.5.2 users who never run P02 see zero changes.

When this patch is applied to the actual `skills/morning-brief/SKILL.md`, the file grows from 113 lines to roughly 135 lines. Anti-AI kill list appendix stays where it is — appendix material at the bottom.
