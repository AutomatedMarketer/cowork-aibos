# cowork-aibos v0.6.0 — Daily Brief Expansion

**Project 02 ships.** Your morning brief now optionally pulls team comms from whichever messaging platform you actually use — Slack, Discord, Telegram, Microsoft Teams — reads a `today.md` task file, and uses sharper draft selection rules. All without touching the P01 baseline that already works.

---

## What's new

### A new install walkthrough: `/onboard-daily-brief`

Six phases, ~2 hours, pause-friendly. Extends your existing `brief-preferences.md` instead of rewriting it.

| Phase | What it does |
|---|---|
| 0 | Welcome + verify P01 + plugin v0.6.0 |
| 1 | Append Q4–Q8 to your existing prefs (does NOT replace P01 sections) |
| 2 | Verify the brief still produces a clean baseline |
| 3 | Activate Team comms — Slack, Discord, Telegram, or Microsoft Teams |
| 4 | Add `today.md` task source |
| 5 | Tighten draft rules via Q8 |
| 6 | Schedule + 7-day calibration loop |

### One new helper skill: `brief-source-comms`

Platform-agnostic team comms helper. Called by morning-brief when any Q4 platform section is populated.

- Handles **Slack, Discord, Telegram, Microsoft Teams** — and any future MCP-supported messaging platform
- You fill in only the platforms you actually use; empty platforms get skipped silently
- Multi-platform supported (e.g., Slack for client work + Discord for community)
- **Read-only on every platform.** Never posts, never reacts, never modifies.
- Returns a unified `Team comms` section with `[Platform]` tags so each item is clearly attributed

### A new task source: `today.md`

A markdown file at `projects/daily-brief/today.md` you maintain. The brief reads it. The brain that knows what's important today is yours — not a third-party task system.

### Sharper drafts via Q8

Existing morning-brief drafts already worked ("if obvious"). Q8 replaces that heuristic with explicit, testable criteria — B1-only, response-required, max 3, sensitive-topic exclusions. Q8 is optional; without it, P01 default behavior continues.

### A 7-day calibration loop

Day 1–7: read brief, score HIT/MISS/EXTRA in `projects/daily-brief/memory.md`. Day 8: run `/tune-up daily-brief`. The tune-up reads your scoring and proposes specific edits to your prefs.

---

## Backward compatibility

**If you never run `/onboard-daily-brief`, the brief looks identical to v0.5.2.** The new sections only appear when you've configured them through the install walkthrough.

- Existing `brief-preferences.md` files (built in P01 Phase 6) are extended, not replaced
- P01 sections (When fires, Inbox, Calendar, Priority, Drafts, Format, Archive) stay exactly as you wrote them
- Existing `about-me/memory.md` continues to log every brief run
- All connector permissions unchanged. `send_email` stays BLOCKED — that rule never changes
- Every messaging platform stays read-only

---

## Install / update

### Mac users (recommended path)

`/plugin update cowork-aibos` doesn't reliably work on Mac due to Anthropic's open marketplace bugs ([#26951](https://github.com/anthropics/claude-code/issues/26951), [#28125](https://github.com/anthropics/claude-code/issues/28125), [#27196 closed not-planned](https://github.com/anthropics/claude-code/issues/27196)).

**Update via zip:**

1. Download `cowork-aibos.zip` from the assets below
2. Open Claude Desktop → click your name (top right) → **Settings**
3. **Customize** → **Browse plugins** → upload the zip
4. Open a fresh Cowork task → run `/onboard-daily-brief`

Your workspace files (`about-me/`, `projects/`, `outputs/`, `_aibos/`) survive the re-upload.

### Windows users

```
/plugin update cowork-aibos
```

Then in a fresh Cowork task:
```
/onboard-daily-brief
```

### Fresh install (new users)

Follow the [README install flow](https://github.com/automatedmarketer/cowork-aibos#install) — install P01 first via `/onboard`, then run `/onboard-daily-brief` for P02.

---

## Files changed

```
+ cowork-aibos/skills/onboard-daily-brief/
+   SKILL.md
+   phases/00-welcome.md through 06-schedule-calibrate.md
+   templates/ (today, memory, state, prefs-additions)
+   samples/sarahs-prefs-additions.md
+ cowork-aibos/skills/brief-source-comms/SKILL.md
+ cowork-aibos/skills/morning-brief/PATCH.md
~ cowork-aibos/.claude-plugin/plugin.json (0.5.2 → 0.6.0)
~ .claude-plugin/marketplace.json (description updated)
+ CHANGELOG.md
```

The morning-brief patch is documented in `cowork-aibos/skills/morning-brief/PATCH.md` — apply it to the existing `morning-brief/SKILL.md` to wire up Team comms / Tasks / Q8 reading. Backward compatible — only renders new sections when configured.

---

## Why platform-agnostic

The original P02 design was Slack-only. That was a mistake — half this audience runs on Discord (community businesses), Telegram (international), or Microsoft Teams (enterprise-adjacent). The `brief-source-comms` helper handles all of them. Users fill in only the platforms they actually use.

Adding a new platform later requires zero code changes to the skill — it dispatches based on Q4 sections and available MCP connectors. As more messaging MCPs ship, the skill automatically extends.

---

## Curriculum (VCI cohort students)

The full Project 02 — Daily Brief curriculum (Quick Start + 6 lessons + concept deck) is available to VCI cohort members at [vcinc.com](https://vcinc.com). Each lesson maps 1:1 to a phase of this install.

---

## Known issues / next release

- **#TBD** — `/tune-up daily-brief` scoping currently relies on the user passing the scope flag. A future release will auto-detect P02 calibration log presence.
- **#TBD** — `today.md` doesn't yet support recurring tasks (every-Monday tasks). Workaround: maintain in Parking Lot, manually promote weekly.
- **Watch** — Anthropic's plugin persistence bug ([#38429](https://github.com/anthropics/claude-code/issues/38429)) still requires Mac users to re-upload after Claude Desktop restart in some cases.

---

## Built by

[Nuno Tavares](https://nunomtavares.com) for VCI cohort students and anyone who wants to stop using Claude like a chatbot — and start using it like infrastructure.

- Newsletter: [automatedmarketer.net](https://automatedmarketer.net)
- YouTube: [@AutomatedMarketer](https://youtube.com/@AutomatedMarketer)
- VCI cohort: [vcinc.com](https://vcinc.com)
