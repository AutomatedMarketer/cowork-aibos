# cowork-aibos v0.7.0 — File Organization

**Project 03 ships.** Your Downloads folder gets a plan-then-approve cleanup that **never deletes any file**, never leaves the folder you allow-list, and waits for your explicit approval before moving anything. There's a weekly schedule, but scheduled runs only PLAN — execution is always your call.

---

## What's new

### A new install walkthrough: `/onboard-file-organization`

Five phases, ~90 minutes total, pause-friendly.

| Phase | What it does |
|---|---|
| 0 | Welcome + verify P01 + plugin v0.7.0 + scaffold the project folder |
| 1 | Interview you to build `safe-zones.md` — the fence that names which folders I may touch and which are forbidden forever |
| 2 | Show you the verbatim safety block in `/tidy-downloads`, then dry-run on a test folder. Refusal test: skill must refuse non-allow-listed folders. Plan-then-REJECT test: zero files moved. |
| 3 | First real tidy on your actual Downloads. Read the plan like a contract. Approve carefully. Verify before/after counts. Walk `_review/`. |
| 4 | Wire the weekly scheduled tidy (plan-only — never auto-execute), monthly `_review/` audit, 4-week calibration log, optional Gmail draft notification |

### A new operational skill: `/tidy-downloads`

The skill that does the work. Loads `safe-zones.md` BEFORE opening any folder. If a folder isn't on your allow-list, the skill refuses. If a path matches the forbidden list, the skill stops and reports what it almost did.

**The six verbatim hard safety constraints** baked into the skill (never paraphrased, never relaxed):

1. Never delete any file. Possible duplicates go to `_review/duplicates/`. Possible junk goes to `_review/unknown/`. The user decides.
2. Never write outside the current allow-zone — not even into a sibling allow-zone.
3. Never touch any path matching the forbidden list. If the target zone CONTAINS a forbidden subpath, skip it entirely.
4. Always write the plan BEFORE executing. Wait for explicit user approval. No assumptions.
5. If the user says "STOP" at any time, halt immediately and report.
6. Never delete its own plan file while it contains approved-but-not-yet-executed actions.

The **one exception** to "never delete": when the user replies REJECT to a plan, the skill deletes its own plan file (since nothing has been acted on, and keeping a rejected plan around risks accidental approval). All other deletions are forbidden.

### Plan-then-approve flow

```
Claude reads safe-zones.md
  ↓
Claude reads files in allow-zone (one level deep by default)
  ↓
Claude writes PLAN to projects/file-organization/plans/
  ↓
YOU read the plan
  ↓
YOU reply APPROVE / REJECT / EDIT
  ↓
Claude executes only approved rows
  ↓
Claude writes RECEIPT to projects/file-organization/memory.md
```

Four pause points where you can stop. One hard rule (never delete). One hard boundary (never leave the allow-zone). That's the entire safety model.

### Scheduled runs are PLAN ONLY

The weekly Friday-5pm (default) scheduled task fires `/tidy-downloads`, which **only runs the SCAN + PLAN phase** when invoked via the scheduler. The plan gets written to your projects folder. A "PLAN WAITING" entry lands in `memory.md`. Optionally a Gmail Draft (never sent) lands in your drafts folder.

You return to Co-Work whenever (Monday morning works fine), open the plan, review, and reply APPROVE / REJECT / EDIT. Execution is always your manual approval. There is no "scheduled auto-execute" option. Attempting to enable one is a critical safety violation.

### A monthly `_review/` audit

First of each month at 8am, a separate task reads your `projects/file-organization/` folder and produces an audit at `projects/file-organization/reviews/YYYY-MM-tidy-review.md`:
- Tidies run vs. expected
- Files in `_review/unknown/` and `_review/duplicates/`
- Anything older than 30 days flagged for decision
- Rejected-by-user patterns (e.g. *"you rejected 3 rows that wanted to move videos — consider adding videos to the skip list"*)

### A 4-week calibration window

After each of your first 4 weekly approvals, the skill asks one question: *"Looking at this week's plan vs. how you actually approved, was there a pattern?"* Answers go to `projects/file-organization/calibration-log.md`. After 4 weeks the prompt auto-disables. You can re-enable on a quarterly cadence later.

---

## The three hard rules of Project 03 — these never relax

1. **Never delete a file. Ever.** Duplicates go to `_review/duplicates/`. Junk goes to `_review/unknown/`. You delete manually after the tidy if you want to.
2. **Never write outside declared safe zones.** The forbidden list always wins over the allow-list.
3. **Every move shows up in a plan you approve.** No "always allow" mode — not on the first run, not on the hundredth.

---

## Backward compatibility

**If you never run `/onboard-file-organization`, the plugin behaves identically to v0.6.0.** The new skills only activate when you've configured them through the install walkthrough.

- Existing Project 01 (`/onboard`) and Project 02 (`/onboard-daily-brief`) are completely untouched.
- `/tidy-downloads` refuses to run if `safe-zones.md` is missing — so installing the plugin without running the onboarding cannot accidentally trigger any file moves.
- All connector permissions unchanged. `send_email` stays BLOCKED.
- New skills are read-only on connectors and write-restricted to declared allow-zones for filesystem operations.

---

## Install / update

### Mac users (recommended path)

`/plugin update cowork-aibos` doesn't reliably work on Mac due to Anthropic's open marketplace bugs ([#26951](https://github.com/anthropics/claude-code/issues/26951), [#28125](https://github.com/anthropics/claude-code/issues/28125), [#27196 closed not-planned](https://github.com/anthropics/claude-code/issues/27196)).

**Update via zip:**

1. Download `cowork-aibos.zip` from the assets below
2. Open Claude Desktop → click your name (top right) → **Settings**
3. **Customize** → **Browse plugins** → upload the zip
4. Open a fresh Cowork task → run `/onboard-file-organization`

Your workspace files (`about-me/`, `projects/`, `outputs/`, `_aibos/`) survive the re-upload.

### Windows users

```
/plugin update cowork-aibos
```

Then in a fresh Cowork task:
```
/onboard-file-organization
```

### Fresh install (new users)

Follow the [README install flow](https://github.com/AutomatedMarketer/cowork-aibos#install) — install P01 first via `/onboard`, then run `/onboard-daily-brief` for P02 (optional), then `/onboard-file-organization` for P03 (optional).

---

## Files changed

```
+ cowork-aibos/skills/tidy-downloads/SKILL.md
+ cowork-aibos/skills/onboard-file-organization/
+   SKILL.md
+   phases/00-welcome.md
+   phases/01-declare-safe-zones.md
+   phases/02-verify-skill-and-dryrun.md
+   phases/03-first-live-tidy.md
+   phases/04-schedule-weekly.md
+   templates/state-file-organization.template.md
+   templates/safe-zones.template.md
+   templates/memory.template.md
+   templates/tidy-plan.template.md
+   samples/safe-zones-sample.md
~ cowork-aibos/.claude-plugin/plugin.json (0.6.0 → 0.7.0)
~ .claude-plugin/marketplace.json (description updated)
~ CHANGELOG.md (v0.7.0 entry added)
```

---

## Why no `/tidy-desktop` variant in v0.7.0

`/tidy-downloads` accepts an optional `[allow-zone-name]` argument. If you allow-list your Desktop in `safe-zones.md`, you can run `/tidy-downloads desktop` to target it. Shipping a separate `/tidy-desktop` skill would duplicate code without adding capability. Possible future v0.7.x if there's demand for a true alias.

---

## Curriculum (VCI cohort students)

The full Project 03 curriculum (Quick Start + 4 lessons + concept deck) is available to VCI cohort members at [vcinc.com](https://vcinc.com). Each lesson maps 1:1 to a phase of this install:

- VCI Lesson C03-01 (Declare Your Safe Zones) → Phase 1
- VCI Lesson C03-02 (Build the /tidy-downloads Skill) → Phase 2 (now: verify the shipped skill instead of building one)
- VCI Lesson C03-03 (First Live Tidy + Approval Flow) → Phase 3
- VCI Lesson C03-04 (Schedule the Weekly Tidy) → Phase 4

The structural change in Phase 2: the plugin now ships `/tidy-downloads` directly, so the user verifies and dry-runs the canonical skill instead of building one via Skill Creator. Strictly safer — no Skill Creator drift, every user gets the identical verbatim safety constraints.

---

## Known issues / next release

- **#TBD** — `/tidy-downloads` does not yet support a `--batch-size N` argument. Folders with 2000+ files produce one large plan; future release will support batched scans.
- **#TBD** — `_review/duplicates/` detection currently uses filename + size. Content-hash duplicate detection is a future enhancement.
- **Watch** — Anthropic's plugin persistence bug ([#38429](https://github.com/anthropics/claude-code/issues/38429)) still requires Mac users to re-upload after Claude Desktop restart in some cases.

---

## Built by

[Nuno Tavares](https://nunomtavares.com) for VCI cohort students and anyone whose Downloads folder has been an open wound for three years.

- Newsletter: [automatedmarketer.net](https://automatedmarketer.net)
- YouTube: [@AutomatedMarketer](https://youtube.com/@AutomatedMarketer)
- VCI cohort: [vcinc.com](https://vcinc.com)
