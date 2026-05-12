# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.9.0] — 2026-05-11

### Changed — BREAKING: progressive-disclosure architecture

The handbook directive that pre-loaded every file in `about-me/` on every turn is **removed**. That single directive was responsible for ~20+ seconds of "Start Up" latency per prompt in Claude Cowork. Identity files are now loaded only by the skills that need them at runtime — which they already do; the pre-load was redundant.

**What this means for you:**

- **Per-prompt "Start Up" latency drops from ~23–25 seconds to under 3 seconds** on typical installs.
- **Per-turn token overhead drops ~95%** (from ~11,000 tokens of pre-loaded identity context to ~300 tokens of slim handbook). The savings grow over time as memory accumulates.
- Your identity files (`about-me/about-me.md`, `business-brain.md`, `writing-rules.md`, `memory.md`, `connections.md`, `audit-log.md`, `brief-preferences.md`) are **untouched**. Skills still read them — just on-demand, when relevant.

### Added — Memory auto-archive (silent hot/cold split)

`about-me/memory.md` now auto-archives at 30 entries. Older entries move to `about-me/memory-log.md` (created automatically on first overflow), preserving the full history. Nothing is ever deleted.

- **Hot file (`memory.md`)** — last 30 entries, ~500 tokens max. Read by `morning-brief`, `voice-writer`, `level-up`, and other daily-work skills.
- **Cold archive (`memory-log.md`)** — full append-only history. Read **only** by `/audit` and `/tune-up` when they need the long view.
- The rotation is silent — students see one memory file in their workspace and don't need to think about it.

This caps the always-loaded surface at ~500 tokens regardless of how long the student has been using the system. Previously, `memory.md` grew unbounded (~7,500 tokens after 6 months of daily use, still loaded on every relevant skill invocation).

### Added — `/optimize` skill (evergreen speed-fix)

New skill at `skills/optimize/SKILL.md`. Works two ways:

1. **One-time migration** for students upgrading from v0.8 or earlier: detects the old handbook directive in their workspace `claude.md`, rewrites it to the new slim handbook with all their existing answers preserved, guides them through pasting the new version into Cowork → Settings → Global instructions, and archives any memory overflow. Backups go to `_aibos/backups/`; `rollback` restores them.
2. **Ongoing speed tool** for any student whose Cowork starts feeling slow later: diagnoses handbook + memory state, applies fixes, archives overflow.

**Trigger phrases:** `/optimize`, "Cowork is slow", "speed up Cowork", "fix slowness", "Claude is slow", "decrease tokens", "every prompt takes forever", "Start Up takes too long".

The skill is plan-then-approve — it never edits files without showing the diagnosis and waiting for "yes".

### Changed — Slim handbook template

The Phase 1 handbook template at `skills/onboard/templates/claude-md.md` is now under ~300 tokens (down from ~450 + the bloat caused by the pre-read directive). The deleted `## Things to always do` section is replaced by a new `## Where my identity lives` section that explicitly tells Claude **not** to pre-read `about-me/` on every turn.

New students running `/onboard` get the new architecture from day one — no extra steps.

### Changed — Memory-aware skills

The following skills now run an auto-archive check after appending to `about-me/memory.md`:

- `morning-brief` — appends the daily brief entry, then archives overflow.
- `voice-writer` — appends the draft entry (for longer pieces), then archives overflow.
- `tune-up` — appends the weekly tune-up entry, then archives overflow.
- `audit` — appends the deferred-action note (when user says "wait"), then archives overflow.

`audit` and `tune-up` also now read `about-me/memory-log.md` (the cold archive) when assessing Context (C1) and reviewing prior tune-up actions, so the full history is available to them.

### Migration path for existing users

Just a few students installed v0.7 / v0.8. The fix path:

1. **Update the plugin** — type `/plugin update cowork-ai-os` in Cowork.
2. **Run `/optimize`** — follow the on-screen prompts.
3. **Paste the new handbook** into Cowork → Settings → Cowork → Global instructions when prompted.
4. **Test** — send any short prompt. "Start Up" should drop from ~25s to under 3s.
5. **If anything looks wrong**, type `rollback`.

In-flight scheduled tasks (`/morning-brief`, `/tune-up`, weekly `/tidy-downloads`) keep firing through the migration — they're not affected.

### Not in v0.9 (deferred to v1.0 backlog)

- `/recall` skill (semantic memory search) — deferred.
- `/connect-comms` skill (toggle Slack/Discord MCPs) — handshake is only ~2–4s of the 23s; not the main culprit. Deferred.
- Auto-detection that proactively suggests `/optimize` mid-skill — direct comms (email + post + SOP) is sufficient given the small installed base.

### Mac install note

Same as v0.8.x — `/plugin update cowork-ai-os` is unreliable on Mac due to Anthropic's open marketplace bugs (#26951, #28125, #27196 closed not-planned). Mac users update by downloading the v0.9.0 `cowork-ai-os.zip` from the [release page](https://github.com/AutomatedMarketer/cowork-ai-os/releases/latest) and re-uploading via Settings → Customize → Browse plugins. User workspace files survive the re-upload.

---

## [0.8.1] — 2026-05-11

### Fixed — Consistency fixes from internal audit

Five findings from a Bugbot-style logic & consistency review. None are security issues; #1 is the only one that breaks user behavior.

1. **Field-name mismatch (the breaking one).** P01 onboarding writes `install_complete: true` at completion, but P02 (`onboard-daily-brief`) and P03 (`onboard-file-organization`) both checked for `core_setup_complete: true` — a field that was never written anywhere. Every user finishing P01 and trying P02 or P03 would be told "run /onboard first" forever. Six reads changed to use the field P01 actually writes (`install_complete`), across SKILL.md and 00-welcome.md in both onboard-daily-brief and onboard-file-organization.
2. **7-phase vs 9-phase inconsistency.** `/onboard` expanded from 7 phases to 9 in an earlier release, but four user-facing locations still said "7-phase install" (07-skills-tour.md intro + skills-tour log template; 09-verify.md final memory.md entry; cowork-ai-os/README.md badge + phase enumeration + "Phase 5" cross-reference now Phase 7). The user-facing `memory.md` and `skills-tour.md` will now record the correct phase count.
3. **Q6 and Q7 collected but never read.** `onboard-daily-brief` Phase 1 collects Q6 (90-day outcome ranking lens) and Q7 (priority-line tone refinement) and writes them to state — but `morning-brief/SKILL.md` only handled Q4, Q5, and Q8. Added explicit read entries and matching rule entries: Q6 applied to inbox ordering / quick-win selection / priority-line choice; Q7 applied to priority-line tone/cadence. Falls back to P01 defaults when either is absent.
4. **Wrong phase number in Phase 9 state update.** Phase 9 (verify) wrote `phases.7.status: complete` when marking install done — an off-by-two from the 7→9 phase expansion. Fixed to `phases.9.status: complete`.
5. **Stale version badge.** Outer README showed v0.5.2; current version was v0.8.0. Badge bumped.

---

## [0.8.0] — 2026-05-09

### Changed — BREAKING: full rebrand to Cowork AI OS

The plugin's identifier (`name` in `plugin.json` and `marketplace.json`) is renamed from `cowork-aibos` to `cowork-ai-os`. The plugin folder inside the repo is renamed to match. The user-facing brand throughout the README, CONNECTORS, skill descriptions, phase walkthroughs, and templates is now **Cowork AI OS** instead of "AIBOS" (the "B" in AIBOS originally stood for "Business Operating System" — dropped for clarity). The GitHub repo itself is also renamed from `cowork-aibos` to `cowork-ai-os` in this release.

**What this means for you:**

- **New installs (Mac, Windows, Linux):** use the new marketplace path:
  ```
  /plugin marketplace add automatedmarketer/cowork-ai-os
  /plugin install cowork-ai-os
  ```
- **Existing installs (anyone on v0.7.0 or earlier):** the old `cowork-aibos` plugin name will not auto-upgrade to `cowork-ai-os` because the slash-command namespace changed. To migrate:
  1. Uninstall the old plugin: `/plugin uninstall cowork-aibos`
  2. Remove the old marketplace: `/plugin marketplace remove cowork-aibos`
  3. Add the new marketplace: `/plugin marketplace add automatedmarketer/cowork-ai-os`
  4. Install the new plugin: `/plugin install cowork-ai-os`
  5. Your workspace files (`about-me/`, `projects/`, `outputs/`, `_aibos/`) are unchanged and will be picked up by the new plugin automatically.
- **The `_aibos/` state folder name is preserved** for backwards compatibility with existing user installs. The plugin still reads/writes `_aibos/state.md`, `_aibos/state-daily-brief.md`, and `_aibos/state-file-organization.md` at the workspace root. This may be renamed in a future major release.
- **Mac users:** continue using the zip-upload route (per v0.5.2 note) — `/plugin update` is still unreliable on Mac due to Anthropic's open marketplace bugs. Download `cowork-ai-os.zip` from the [release page](https://github.com/AutomatedMarketer/cowork-ai-os/releases/latest) and re-upload via Settings → Customize → Browse plugins.

### Why the rename

The "AIBOS" acronym (AI Business Operating System) was opaque — students and beta testers consistently asked what the "B" stood for. The new name "Cowork AI OS" reads cleanly in the plugin list and matches how the plugin is taught in the accompanying course materials.

### Upgrade impact

- **Slash-command namespace change:** if Claude Cowork starts namespacing slash commands as `/<plugin-name>:<skill>`, existing scripts/notes referencing `/cowork-aibos:onboard` (etc.) need to become `/cowork-ai-os:onboard`. Bare `/onboard` continues to work where Cowork resolves namespaces automatically.
- **No content changes:** all 9 phases, all 10 skills, all hard safety rules (`send_email = BLOCKED`, plan-then-approve for `/tidy-downloads`, append-only `memory.md`) are preserved unchanged. This is a rename release, not a feature release.

---

## [0.7.0] — 2026-05-06

### Added — Project 03 (File Organization)

- **`tidy-downloads` operational skill** — plan-then-approve file organization for any allow-listed folder. Loads `projects/file-organization/safe-zones.md` BEFORE opening any directory. Writes a plan to `projects/file-organization/plans/`, waits for explicit user approval, executes only approved rows. Six verbatim hard safety constraints in the skill instructions:
  - Never deletes any file (one scoped exception: deleting its own plan file on REJECT)
  - Never writes outside the current allow-zone
  - Never touches any path matching the forbidden list
  - Always writes the plan BEFORE executing — waits for explicit user approval
  - Halts immediately on user "STOP" word
  - Never deletes its own plan file while it contains approved-but-not-yet-executed actions
- **`onboard-file-organization` skill** — 5-phase install walkthrough (~90 minutes total, pause-friendly):
  - Phase 0: Welcome + verify P01 baseline + plugin v0.7.0 + scaffold projects folder
  - Phase 1: Declare safe zones — interview to build `safe-zones.md` (allow-list, forbidden list, "never delete" verbatim user quote, STOP rule)
  - Phase 2: Verify shipped `/tidy-downloads` skill + dry-run on `_test-tidy/` (refusal test + plan-then-REJECT test)
  - Phase 3: First live tidy on real allow-zone, with red-flag prompts during plan review and 4-check verification report after execute
  - Phase 4: Wire weekly scheduled tidy (PLAN ONLY — never auto-execute), monthly `_review/` audit, 4-week calibration log, optional Gmail draft notification
- **State file** at `_aibos/state-file-organization.md` — phase tracker, pause/resume support
- **Audit log** at `projects/file-organization/memory.md` — every weekly tidy appends a receipt with reconciled counts (planned/approved/executed/failed/rejected)
- **Plan files** at `projects/file-organization/plans/tidy-plan-YYYY-MM-DD-HHmm.md` — kept for at least 60 days as the file paper trail
- **Sample** at `samples/safe-zones-sample.md` — Sarah Mitchell's filled-in `safe-zones.md` for sample-first onboarding

### Changed

- **Plugin version** bumped 0.6.0 → 0.7.0
- **Plugin description** mentions `/tidy-downloads` + declared safe zones + never deletes
- **`marketplace.json` description** updated similarly

### Backward compatibility

- Users who never run `/onboard-file-organization` see zero changes. The plugin behaves identically to v0.6.0.
- Project 02 (daily brief) and Project 01 (core setup) are completely untouched.
- `/tidy-downloads` refuses to run if `safe-zones.md` is missing, so installing the plugin without running onboarding cannot accidentally trigger any file moves.
- All connector permissions unchanged. `send_email` stays BLOCKED. The new skills are read-only on connectors and write-restricted to declared allow-zones for filesystem operations.

### Mac install note

Same as v0.6.0 — `/plugin update cowork-aibos` is unreliable on Mac due to Anthropic's open marketplace bugs (#26951, #28125, #27196 closed not-planned). Mac users update by downloading `cowork-aibos.zip` from the [release page](https://github.com/AutomatedMarketer/cowork-aibos/releases/latest) and re-uploading via Settings → Customize → Browse plugins. User workspace files survive the re-upload. Windows users continue using `/plugin update cowork-aibos`.

---

## [0.6.0] — 2026-05-06

### Added — Project 02 (Daily Brief Expansion)

- **`onboard-daily-brief` skill** — 6-phase install walkthrough that extends the existing morning-brief without rewriting it
  - Phase 0: Welcome + verify P01 baseline + plugin v0.6.0
  - Phase 1: Append Q4–Q8 to existing `brief-preferences.md` (does NOT replace P01 sections)
  - Phase 2: Verify the existing brief still produces a clean baseline
  - Phase 3: Activate Team comms section (Slack, Discord, Telegram, Microsoft Teams)
  - Phase 4: Add `today.md` task source
  - Phase 5: Tighten draft selection rules via Q8
  - Phase 6: Schedule task + 7-day calibration loop
- **`brief-source-comms` helper skill** — read-only team comms pull, platform-agnostic. Called by morning-brief when any Q4 platform section is populated. Handles Slack, Discord, Telegram, Microsoft Teams, and any future MCP-supported messaging platform — the user fills in only the platforms they use; empty platforms get skipped silently.
- **`today.md` task source** — markdown-file-based task list scaffolded in `projects/daily-brief/today.md`, read by morning-brief when Q5 is present in prefs
- **P02 calibration log** at `projects/daily-brief/memory.md` — separate from existing `about-me/memory.md` activity log
- **`/tune-up daily-brief`** scoped run on day 8 of calibration loop (uses existing tune-up skill)

### Changed

- **`morning-brief/SKILL.md`** patched (additive only) — preserves existing structure (Priority → Calendar → Urgent inbox → Quick wins → Drafts), inserts optional Team comms section after Urgent inbox and optional Tasks section after Team comms. New sections only render when corresponding Q4/Q5 are present in `brief-preferences.md`.
- **Draft selection** — when Q8 is present in prefs, morning-brief uses the explicit Q8 criteria (B1-only, response-required, max 3, exclusion topics) instead of the default "if reply is obvious" heuristic. Q8 is optional; without it, P01 default behavior continues.
- **Plugin version** bumped 0.5.2 → 0.6.0
- **Plugin description** now mentions multi-platform team comms

### Backward compatibility

- Users who never run `/onboard-daily-brief` see zero changes. The brief looks identical to v0.5.2.
- Existing `brief-preferences.md` files (built in P01 Phase 6) are extended, not replaced. P01 sections stay untouched.
- Existing `about-me/memory.md` log behavior preserved.
- All connector permissions unchanged. `send_email` stays BLOCKED — non-negotiable.
- All messaging platforms wired in read-only mode. No posting, no reactions, no modifications on any platform.

### Mac install note

- `/plugin update cowork-aibos` continues to be unreliable on Mac due to Anthropic's open marketplace bugs (#26951, #28125, #27196 closed not-planned).
- Mac users update by downloading the v0.6.0 `cowork-aibos.zip` from the [release page](https://github.com/automatedmarketer/cowork-aibos/releases/latest) and re-uploading via Settings → Customize → Browse plugins.
- User workspace files (`about-me/`, `projects/`, `outputs/`, `_aibos/`) survive the re-upload.
- Windows users continue using `/plugin update cowork-aibos`.

---

## [0.5.2] — 2026-05-05

### Changed

- Promoted zip-upload as the recommended Mac install path (no longer a fallback)
- README updated with Mac-specific install flow + live-demo contingency table
- Section renamed: "❌ If install fails on Mac" → "✅ Mac install (recommended): zip upload"

### Why

Anthropic closed [#27196](https://github.com/anthropics/claude-code/issues/27196) ("All Anthropic plugins fail in Cowork on macOS") as not-planned. Zip upload is now the only reliable Mac install method. Mac users hit the working path immediately instead of failing first.

---

## [0.5.1] and earlier

See git history for prior releases.
