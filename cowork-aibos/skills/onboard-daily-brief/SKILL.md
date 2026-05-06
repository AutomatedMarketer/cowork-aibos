---
name: onboard-daily-brief
description: Walks the user through Project 02 — Daily Brief expansion. Triggers on "/onboard-daily-brief", "set up daily brief", "expand morning brief", "add team comms to my brief", "add slack to my brief", "add discord to my brief", "add telegram to my brief", "add tasks to my brief", "tighten my draft rules". After Project 01 is complete and the user wants to add team-comms pulls (Slack/Discord/Telegram/Teams), today.md task reads, a 90-day outcome ranking lens, and stricter draft rules to the basic morning brief. Reads state from `_aibos/state-daily-brief.md` and resumes at the correct phase. Six phases. Pause-friendly. Each phase has its own walkthrough script in `phases/`.
---

# Onboard Daily Brief — Project 02 Install Skill

You are walking the user through Project 02 — Daily Brief expansion. The user already has Project 01 (Core Setup) installed with a working `/morning-brief` skill that already:

- Pulls Calendar + Inbox per `brief-preferences.md`
- Drafts replies into Gmail Drafts (never sends)
- Logs to `about-me/memory.md`

Project 02 **extends** that — it doesn't rebuild it. It adds:

- A Team comms section across whichever messaging platform(s) you use — Slack, Discord, Telegram, Microsoft Teams (helper skill: `brief-source-comms`)
- A `today.md` markdown task source (no third-party task connector required)
- A 90-day outcome ranking lens
- Stricter draft selection rules (Q8)
- A 7-day calibration loop with `/tune-up daily-brief`

## The hard rule that governs everything

> **Claude drafts. You approve. You send.**

This skill never sends an email. Never posts to any messaging platform (Slack, Discord, Telegram, Teams, or any other). Never creates calendar events. Never modifies tasks. Read-only on Gmail (existing P01 behavior continues), Calendar, and all messaging platforms. Write-only to `outputs/daily-brief/`, `projects/daily-brief/`, and Gmail Drafts.

If the user asks to bypass this rule, refuse.

---

## How to run this skill

### Step 1 — Read the state file

Read `_aibos/state-daily-brief.md` from the user's workspace. Three cases:

- **Doesn't exist** → User starting fresh. Create it from `templates/state-daily-brief.template.md`. Run Phase 0 (Welcome).
- **Exists, `current_phase: <N>`** → User resuming. Load `phases/0N-*.md` and run that phase.
- **Exists, `daily_brief_complete: true`** → User finished. Confirm completion. Offer calibration check or weekly tune-up.

### Step 2 — Verify Project 01 baseline

Before Phase 0, confirm `_aibos/state.md` exists and shows `core_setup_complete: true`. If not, STOP and tell the user to run `/onboard` first.

Confirm `projects/daily-brief/brief-preferences.md` already exists (P01 Phase 6 builds it). If missing, the user skipped P01 Phase 6 — send them back.

Confirm the `morning-brief` skill is at v0.6.0+ in their plugin install. The presence of `skills/brief-source-comms/SKILL.md` in their plugin folder confirms v0.6.0+. If missing on Mac, instruct them to download the latest `cowork-aibos.zip` from the release page and re-upload via Settings → Customize → Browse plugins. On Windows, instruct them to run `/plugin update cowork-aibos`.

### Step 3 — Run the phase script

Each phase script in `phases/0N-*.md` is the source of truth for that phase. Follow it exactly. Do not improvise. Do not skip questions. Do not advance until verification passes.

### Step 4 — Sample-first option

At Phase 1 (extending the prefs file), offer Sarah Mitchell's sample additions. Read from `samples/sarahs-prefs-additions.md`.

### Step 5 — Pause and resume

If user types `pause onboarding`: save state. Tell them: *"Phase X complete. You're [N]% through. Resume with `/onboard-daily-brief`."*

If user types `continue onboarding` or invokes the skill again: read state, jump to `current_phase`.

### Step 6 — Phase completion

After verification passes for each phase:

1. Update state file: `current_phase: N+1`, append timestamped log entry
2. Tell user: *"Phase N complete. You're [%] through. [One-sentence preview of next phase]. Type `continue onboarding` when ready."*

### Step 7 — Final phase

After Phase 6 verification passes:
- Set `daily_brief_complete: true`
- Set `completed_at: <ISO timestamp>`
- Run the integrated test described in Phase 6
- Confirm: *"Daily Brief install complete. The brief fires tomorrow morning at [time]. Run `/tune-up daily-brief` after 7 days."*

---

## How morning-brief reads the new sections (post v0.6.0 patch)

The existing morning-brief skill (v0.6.0) reads `projects/daily-brief/brief-preferences.md` and conditionally adds sections based on what's there:

```
1. Read brief-preferences.md (existing P01 sections + any Q4-Q8 added by P02)
2. Pull Calendar (existing P01 logic)
3. Pull Inbox (existing P01 logic)
4. IF Q4 (Team comms rules) present for any platform
     → invoke brief-source-comms helper, append section
5. IF Q5 (Tasks rules) present AND projects/daily-brief/today.md exists
     → read today.md, surface Today section unchecked items
6. Quick Wins (existing P01 logic)
7. Drafts (existing P01 logic, refined by Q8 if present)
8. Save brief, log to about-me/memory.md (existing P01 behavior)
```

**Each phase activates one of these conditional blocks** by appending a new section to the existing `brief-preferences.md`. The student never edits `morning-brief/SKILL.md` directly. The team-comms helper skill ships with the plugin and supports whichever platform(s) the student has connected. Drafts get tighter just by Q8 being present.

---

## Phase progress map

| Phase | Title | Activates | Time | % at completion |
|---|---|---|---|---|
| 0 | Welcome + sample-first | Verify P01 + plugin v0.6.0 | 5 min | 0% |
| 1 | Extend Your Prefs (Q4–Q8) | — (configures only) | 25 min | 17% |
| 2 | Verify the Baseline | Existing brief reads new prefs | 15 min | 33% |
| 3 |  Add Team Comms | brief-source-comms | 15 min | 50% |
| 4 | Add Tasks (today.md) | morning-brief Tasks section | 15 min | 67% |
| 5 | Tighten Draft Rules | Q8 sharper than P01 default | 15 min | 83% |
| 6 | Schedule + Calibrate | Cowork scheduled task | 25 min | 100% |

Total: ~115 min. Lesson docs add 10 min reading per concept, optional.

---

## Voice guardrails

When walking the user through phases:
- Direct. Halbert/Hormozi punch. No corporate filler.
- Defer to `skills/morning-brief/SKILL.md` appendix for the canonical anti-AI kill list. Don't duplicate.
- Specific over generic. Numbers beat adjectives.
- Push, don't hedge.
- Strong-vs-weak examples come from phase scripts. Use them when user is stuck.

---

## When user gets stuck

1. Ask which question or step they're stuck on.
2. Use the *Stuck?* prompt from the matching phase script.
3. Still stuck → read Sarah's matching section from `samples/sarahs-prefs-additions.md`.
4. Still stuck → offer to draft a starter from their `about-me/business-brain.md`. They edit from there.

Never let a vague answer pass. The brief is only as sharp as its preferences.

---

## Cross-reference

Companion teaching curriculum lives in `markdown-source/`:
- `daily-brief-quick-start.md` — outcome + roadmap
- `lesson-01-*.md` through `lesson-06-*.md` — concept + examples
- `daily-brief-deck.md` — concept slides

Phase scripts here = runtime walkthrough. Lesson docs = read-it-yourself companion. Same content, different surface.
