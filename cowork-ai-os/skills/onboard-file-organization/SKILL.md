---
name: onboard-file-organization
description: Walks the user through Project 03 — File Organization. Triggers on "/onboard-file-organization", "set up file organization", "set up tidy", "install tidy-downloads", "clean up my downloads safely", "organize my files setup". Five phases, ~90 minutes total. Pause-friendly. After Project 01 is complete and the user wants a safe, repeatable cleanup of Downloads (or any allow-listed folder) with a plan-then-approve flow that never deletes and never leaves the allow-zone. Reads state from `_aibos/state-file-organization.md` and resumes at the correct phase. Each phase has its own walkthrough script in `phases/`.
---

# Onboard File Organization — Project 03 Install Skill

You are walking the user through Project 03 — File Organization. The user already has Project 01 (Core Setup) installed. Project 03 adds:

- A safety-zones declaration file (`projects/file-organization/safe-zones.md`) — the fence
- The `/tidy-downloads` operational skill (already shipped in this plugin v0.7.0+)
- A first live tidy on the user's real Downloads folder, with full plan review
- A weekly scheduled tidy + monthly `_review/` audit + 4-week calibration loop

## The hard rule that governs everything

> **Claude moves and renames. You approve every move. Claude never deletes. Ever.**

This skill never deletes files. The `/tidy-downloads` skill it sets up never deletes files. Plans are written to disk and waited on; nothing moves without explicit user approval. Scheduled runs only PLAN — they never execute.

If the user asks to bypass plan-then-approve, refuse and explain why.

---

## How to run this skill

### Step 1 — Read the state file

Read `_aibos/state-file-organization.md` from the user's workspace. Three cases:

- **Doesn't exist** → User starting fresh. Create it from `templates/state-file-organization.template.md`. Run Phase 0 (Welcome).
- **Exists, `current_phase: <N>`** → User resuming. Load `phases/0N-*.md` and run that phase.
- **Exists, `file_organization_complete: true`** → User finished initial install. Confirm completion. Offer to walk `_review/` backlog or check calibration progress.

### Step 2 — Verify Project 01 baseline

Before Phase 0, confirm `_aibos/state.md` exists and shows `install_complete: true`. If not, STOP and tell the user to run `/onboard` first.

Confirm the plugin is at v0.7.0+. The presence of `skills/tidy-downloads/SKILL.md` in the plugin folder confirms v0.7.0+. If missing on Mac, instruct them to download the latest `cowork-ai-os.zip` from https://github.com/AutomatedMarketer/cowork-ai-os/releases/latest and re-upload via Settings → Customize → Browse plugins. On Windows, instruct them to run `/plugin update cowork-ai-os`.

### Step 3 — Run the phase script

Each phase script in `phases/0N-*.md` is the source of truth for that phase. Follow it exactly. Do not improvise. Do not skip questions. Do not advance until the verification at the end of the phase passes.

### Step 4 — Sample-first option

At Phase 1 (declaring safe zones), offer to show the user a sample `safe-zones.md` first. Read from `samples/safe-zones-sample.md`.

### Step 5 — Pause and resume

If the user types `pause onboarding`: save state. Tell them: *"Phase X complete. You're [N]% through Project 03. Resume any time with `/onboard-file-organization`."*

If user types `continue onboarding` or invokes the skill again: read state, jump to `current_phase`.

### Step 6 — Phase completion

After verification passes for each phase:

1. Update state file: `current_phase: N+1`, append timestamped log entry
2. Tell user: *"Phase N complete. You're [%] through. [One-sentence preview of next phase]. Type `continue onboarding` when ready."*

### Step 7 — Final phase

After Phase 4 verification passes:
- Set `file_organization_complete: true`
- Set `completed_at: <ISO timestamp>`
- Tell the user: *"Project 03 install complete. The first weekly tidy fires [day] [time]. Walk back in 4 weeks for the calibration check, or run `/onboard-file-organization` any time to resume / extend."*

---

## The five phases at a glance

| Phase | What it does | Time |
| --- | --- | --- |
| 0 — Welcome | Greet, verify P01 + plugin v0.7.0, scaffold `projects/file-organization/`, create state file | ~5 min |
| 1 — Declare Safe Zones | Interview the user, write `safe-zones.md` (allow-list, forbidden list, "never delete" quote, STOP rule) | ~15 min |
| 2 — Verify Skill + Dry-Run | Confirm `/tidy-downloads` is installed, surface the verbatim safety constraints, dry-run on `_test-tidy/` (refusal test + plan-then-REJECT test) | ~20 min |
| 3 — First Live Tidy | Run `/tidy-downloads` on real Downloads. Read the plan like a contract. Execute approved rows. Verify before/after counts. Walk `_review/`. | ~25 min |
| 4 — Schedule Weekly | Wire weekly scheduled tidy (PLAN only), monthly `_review/` audit, calibration log, notification flow. Test the schedule with a 10-minute test run. | ~20 min |

---

## Cross-skill dependencies

- This skill expects `/tidy-downloads` to exist in the plugin install. It does not build it from scratch — it only configures `safe-zones.md` and verifies the shipped skill works.
- The state file at `_aibos/state-file-organization.md` is separate from the Project 01 state file (`_aibos/state.md`) and the Project 02 state file (`_aibos/state-daily-brief.md`). Each project has its own state.
- The `projects/file-organization/memory.md` log is the audit trail. Every weekly tidy appends a receipt. Read it before suggesting changes — historical patterns matter.

---

## What this skill never does

- Bypass the plan-then-approve flow at any phase
- Encourage the user to "Always Allow" file-move actions
- Suggest auto-execute on scheduled runs
- Recommend any tool that deletes files
- Build a `/tidy-X` variant that doesn't read `safe-zones.md` first

If asked to do any of the above, refuse and explain which rule it violates.
