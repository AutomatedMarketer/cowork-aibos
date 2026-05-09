# Phase 0 — Welcome

**Goal:** Greet the user, set expectations, offer the sample-first option, verify Project 01 baseline + plugin v0.6.0, scaffold the new project folders, create the state file.

**Time:** ~5 minutes for Phase 0. ~25 minutes for Phase 1 (next).

---

## Script — what to say (in voice)

When the user runs `/onboard-daily-brief` for the first time, say this:

> *"Welcome to Project 02. Your morning brief already works — Calendar, Inbox, Drafts, Quick Wins. Project 01 wired all that. We're going to extend it.*
>
> *Six phases, about 2 hours total. By the end, your brief also pulls team comms (Slack/Discord/Telegram/Teams), reads a `today.md` task file you maintain, and ranks priorities against your 90-day outcome. Drafts get sharper too.*
>
> *Pause-friendly. Every phase ends at a clean break.*
>
> *One hard rule still in effect: Claude drafts. You approve. You send. This skill never sends an email, never posts to any messaging platform, never modifies your calendar.*
>
> *Before we start Phase 1, do you want to see Sarah Mitchell's Q4–Q8 prefs additions? Reading her version first makes the questions land faster. Type `show me sarah's additions` for sample-first, or `let's go` to jump in."*

---

## If user says `show me sarah's additions`

1. Read `samples/sarahs-prefs-additions.md` from this skill folder
2. Display it in full
3. Then say:

> *"That's the Q4–Q8 block you'll add to your existing brief-preferences.md in Phase 1. We're not rewriting your file — just appending. Type `let's go` when ready."*

## If user says `let's go` (or anything signaling readiness)

Run the verification + scaffolding sequence below.

---

## Scaffolding sequence

Execute these steps in order. Confirm each before moving on.

### Step 1 — Verify Project 01 is complete

Read `_aibos/state.md` (the Project 01 state file). Check `core_setup_complete: true`.

If false, STOP:

> *"Project 01 isn't complete. Project 02 needs your `about-me/` files, voice rules, connectors, and an existing `brief-preferences.md`. Run `/onboard` and finish Project 01 first."*

### Step 2 — Verify existing brief-preferences.md

Confirm `projects/daily-brief/brief-preferences.md` exists. P01 Phase 6 builds it with these sections:

- When the brief fires
- Inbox rules (always matter / never matter / max count)
- Calendar rules
- Priority line
- Draft replies
- Format preferences
- What to archive

If the file is missing, the user skipped P01 Phase 6:

> *"Your `projects/daily-brief/brief-preferences.md` is missing — P01 Phase 6 builds it. Re-run `/onboard` and complete Phase 6 before continuing here."*

If the file exists but is mostly empty placeholders, walk the user back through P01 Phase 6 to fill it in. Don't proceed until those sections have real content.

### Step 3 — Verify plugin version v0.6.0+

The plugin needs to be at v0.6.0 or later for the new helper skill (`brief-source-comms`) and the morning-brief patch to be present.

Check by reading the plugin install path for `skills/brief-source-comms/SKILL.md`. If present → v0.6.0+. If missing → v0.5.x.

**If v0.5.x:**

Detect the user's OS (or ask: *"Are you on Mac or Windows?"*).

**Mac users:**
> *"Your cowork-ai-os plugin is older than v0.6.0. On Mac, the marketplace update path is unreliable (Anthropic's open bugs). Here's the working path:*
>
> *1. Download the latest `cowork-ai-os.zip` from https://github.com/automatedmarketer/cowork-ai-os/releases/latest*
> *2. Settings → Customize → Browse plugins → upload the zip*
> *3. Open a fresh Cowork task → re-run `/onboard-daily-brief`*
>
> *Your `about-me/`, `projects/`, `outputs/`, and `_aibos/` files survive the re-upload."*

**Windows users:**
> *"Your cowork-ai-os plugin is older than v0.6.0. Run:*
> ```
> /plugin update cowork-ai-os
> ```
> *Then re-run `/onboard-daily-brief` to continue."*

Don't proceed until the plugin is at v0.6.0+.

### Step 4 — Verify connectors

Confirm with the user (don't query the connectors directly — ask):

- Gmail connector live? (yes/no — should be from P01 Phase 5)
- Calendar connector live? (yes/no — should be from P01 Phase 5)
- Messaging platform connector(s) live? Capture which ones (Slack / Discord / Telegram / Teams). Flag any missing — Phase 3 walks through enabling them.

If Gmail or Calendar are not live, STOP. Tell user to enable them in **Settings → Customize → Connectors** and re-run `/onboard-daily-brief`.

### Step 5 — Confirm `send_email` is BLOCKED

Tell the user:

> *"Open Settings → Customize → Connectors → Gmail → Permissions. Confirm `send_email` is BLOCKED. Tell me when you've checked."*

Wait for confirmation. Do not proceed until user confirms.

This rule was set in P01. We're re-confirming because Project 02 makes drafts sharper, and the temptation to "just unblock send" grows when drafts get good. Don't let it.

### Step 6 — Scaffold the new P02 folders

Create these in the user's Cowork workspace (don't touch what already exists):

```
projects/daily-brief/archive/        ← may already exist from P01, that's fine
```

The folder `projects/daily-brief/` itself was created in P01. Just confirm `archive/` exists inside it.

### Step 7 — Copy P02 templates into place

Copy from this skill's `templates/` folder into the user's workspace:

- `templates/memory.template.md` → `projects/daily-brief/memory.md` *(this is the P02 calibration log, separate from the existing `about-me/memory.md` activity log — both will be appended to going forward)*

Do NOT copy `today.template.md` yet — that happens in Phase 4 when the user is ready for tasks.

Do NOT touch the existing `brief-preferences.md` — Phase 1 appends to it.

### Step 8 — Create state file

Create `_aibos/state-daily-brief.md` from `templates/state-daily-brief.template.md`:

```markdown
# Daily Brief — Install State

project: daily-brief
version: v2 (P02 expansion)
plugin_version: 0.6.0
started_at: <ISO timestamp>
current_phase: 1
daily_brief_complete: false

## P02 sections added to brief-preferences.md
- Q4 Team comms rules: false
- Q5 Tasks rules: false
- Q6 90-day outcome: false
- Q7 Priority tone refinement: false
- Q8 Stricter draft rules: false

## Skill activation
- brief-source-comms activated: false
- today.md created: false
- scheduled task: false

## Phase log
- <ISO timestamp> — Phase 0 (Welcome) complete. P01 baseline verified. Ready for Phase 1.
```

---

## Verification

Before marking Phase 0 complete, confirm:

- [ ] `core_setup_complete: true` in `_aibos/state.md`
- [ ] `projects/daily-brief/brief-preferences.md` exists with P01 sections filled in
- [ ] Plugin v0.6.0+ — `skills/brief-source-comms/SKILL.md` exists in plugin install
- [ ] Gmail connector live, `send_email` BLOCKED
- [ ] Calendar connector live
- [ ] `projects/daily-brief/archive/` folder exists
- [ ] `projects/daily-brief/memory.md` exists (empty P02 calibration log)
- [ ] `_aibos/state-daily-brief.md` exists with `current_phase: 1`

---

## Transition to Phase 1

> *"Baseline verified. Phase 1 extends your existing brief-preferences.md with five new sections — Team comms (Slack/Discord/Telegram/Teams), Tasks, 90-day outcome, priority tone refinement, stricter draft rules. About 25 minutes. Don't rush it. Ready?"*

If yes, load `phases/01-extend-prefs.md` and run it.
