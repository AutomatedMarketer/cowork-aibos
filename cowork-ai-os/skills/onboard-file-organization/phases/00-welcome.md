# Phase 0 — Welcome

**Goal:** Greet, set expectations, verify Project 01 baseline + plugin v0.7.0, scaffold `projects/file-organization/`, create the state file.

**Time:** ~5 minutes for Phase 0. ~15 minutes for Phase 1 (next).

---

## Script — what to say (in voice)

When the user runs `/onboard-file-organization` for the first time, say this:

> *"Welcome to Project 03 — File Organization. Your Downloads folder is messy. We're going to fix that without ever deleting a single file.*
>
> *Five phases, about 90 minutes total. By the end, you'll have a `/tidy-downloads` slash command that reads files in your Downloads, proposes a rename + sort plan for your review, waits for your approval, then executes only what you approved. There's also a weekly schedule that runs every Friday — but it only PLANS automatically. You always approve before anything moves.*
>
> *Three hard rules baked in:*
>
> *1. Claude never deletes a file. Ever. Possible duplicates go to a `_review/` folder for you to decide.*
> *2. Claude only touches folders you explicitly allow. Everything else on your computer is off-limits, forever.*
> *3. Every move shows up in a plan you read before approving. No "just go do it" mode.*
>
> *Pause-friendly. Every phase ends at a clean break.*
>
> *Want to see a sample `safe-zones.md` first? It's the file we'll build in Phase 1 — seeing one filled in makes the questions land faster. Type `show me a sample` for sample-first, or `let's go` to jump in."*

---

## If user says `show me a sample`

1. Read `samples/safe-zones-sample.md` from this skill folder
2. Display it in full
3. Then say:

> *"That's the kind of file we'll build for you in Phase 1. Yours will have your real folder paths — not Sarah's. Type `let's go` when ready."*

## If user says `let's go` (or anything signaling readiness)

Run the verification + scaffolding sequence below.

---

## Scaffolding sequence

Execute these steps in order. Confirm each before moving on.

### Step 1 — Verify Project 01 is complete

Read `_aibos/state.md` (the Project 01 state file). Check `core_setup_complete: true`.

If false, STOP:

> *"Project 01 isn't complete. Project 03 needs your `about-me/` files and workspace structure from P01. Run `/onboard` and finish Project 01 first."*

### Step 2 — Verify plugin version

Confirm the plugin is at v0.7.0 or later. The presence of `skills/tidy-downloads/SKILL.md` in the plugin folder confirms v0.7.0+.

If missing:

> *"Your plugin is older than v0.7.0 and doesn't have `/tidy-downloads` yet."*
>
> **Mac:** *"Download `cowork-ai-os.zip` from https://github.com/AutomatedMarketer/cowork-ai-os/releases/latest, then in Claude Desktop go to Settings → Customize → Browse plugins → upload the file. Your `about-me/`, `projects/`, `outputs/`, and `_aibos/` folders all stay intact. Once updated, run `/onboard-file-organization` again."*
>
> **Windows:** *"Run `/plugin update cowork-ai-os`, then run `/onboard-file-organization` again."*

STOP until updated.

### Step 3 — Scaffold the project folder

Create (if missing):

- `projects/file-organization/` — the project folder
- `projects/file-organization/plans/` — empty subfolder for tidy plan files
- `projects/file-organization/reviews/` — empty subfolder for monthly audit reports

Ask permission before each write.

### Step 4 — Create memory.md

Write `projects/file-organization/memory.md` from `templates/memory.template.md` (in this skill folder). Replace `<ISO timestamp>` with the current timestamp. The first dated entry should read:

> Project 03 install started. Phase 0 complete. No tidy run yet.

### Step 5 — Create state file

Write `_aibos/state-file-organization.md` from `templates/state-file-organization.template.md`. Set:

- `started_at: <ISO timestamp>`
- `current_phase: 1`
- `Phase 0 (welcome): completed at <ISO timestamp>`

### Step 6 — Confirm and preview Phase 1

Tell the user:

> *"Phase 0 done. Project folder created. State file saved.*
>
> *Phase 1 next: I'll interview you for ~5 short questions to build your `safe-zones.md` — the file that names which folders I'm allowed to organize and which I'm forbidden to touch. About 15 minutes. The quality of this file is the difference between a useful tidy and a disaster story.*
>
> *Type `continue onboarding` when ready."*

---

## Verification before advancing

Phase 0 is complete when ALL of these are true:

- `_aibos/state.md` confirms `core_setup_complete: true`
- Plugin version is 0.7.0 or later (verified by presence of `skills/tidy-downloads/SKILL.md`)
- `projects/file-organization/` folder exists
- `projects/file-organization/plans/` and `projects/file-organization/reviews/` subfolders exist
- `projects/file-organization/memory.md` exists with the start entry
- `_aibos/state-file-organization.md` exists with `current_phase: 1`

If any check fails, STOP and resolve before advancing.
