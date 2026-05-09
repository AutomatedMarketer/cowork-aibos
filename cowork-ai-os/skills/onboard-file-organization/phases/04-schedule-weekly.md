# Phase 4 — Schedule Weekly + Monthly Audit + Calibration

**Goal:** Wire the weekly scheduled tidy (PLAN ONLY — never auto-execute), the monthly `_review/` audit task, the 4-week calibration log, and an optional notification flow. Test the schedule with a one-time fire ~10 minutes from now.

**Time:** ~20 minutes setup. ~3 min/week ongoing for plan approval. ~5 min/month for `_review/` walk.

---

## Script — what to say (in voice)

> *"Phase 4 turns the tidy into a habit. Three things go on the calendar:*
>
> *1. Weekly scheduled tidy. Default: Friday 5pm. Fires the SCAN + PLAN phase only. Writes a plan to your projects folder. Notifies you. You open Co-Work whenever (Monday morning works), read the plan, approve, execution happens then.*
>
> *2. Monthly `_review/` audit. First of each month at 8am. Reads your projects folder, reports how many tidies ran, counts files in `_review/`, flags anything older than 30 days, suggests pattern-based skill updates.*
>
> *3. 4-week calibration log. After each weekly approval, I'll ask one question: 'any pattern in what you rejected this week?' I capture answers in a log. After 4 weeks, this prompt auto-disables — you can re-enable quarterly later.*
>
> *The hard rule that NEVER changes: scheduled runs only PLAN. They never execute. Auto-execute is forbidden, even after a year of perfect runs. The asymmetry — 5 seconds to reject a bad plan vs. an afternoon to undo bad moves — is permanent.*
>
> *Type `let's schedule` when ready."*

---

## Step A — Confirm the schedule

Ask:

> *"Default is Friday 5:00 p.m. local time. Friday end-of-week is when Downloads has the most accumulated junk and your attention is cleanup-oriented. But other choices work fine:*
>
> *- Sunday evening (plan Sunday, approve Monday morning)*
> *- Monday morning (plan 7am, approve 9am with coffee)*
> *- Wednesday midday (mid-week cleanup if Downloads fills fast)*
>
> *Whatever day/time, the approval window should land in a time you reliably open Co-Work. What works for you?"*

Capture day + time.

Also confirm: which allow-zone does the weekly tidy target by default? (Typically the first entry in `safe-zones.md` — Downloads.)

---

## Step B — Wire the weekly scheduled task

Schedule a recurring task that fires `/tidy-downloads` at the chosen day/time, with these constraints encoded in the task spec:

- The scheduled run executes the SCAN + PLAN phase ONLY.
- The scheduled run writes the plan to `projects/file-organization/plans/tidy-plan-YYYY-MM-DD-HHmm.md`.
- The scheduled run does NOT execute any file moves under any circumstance. No "scheduled auto-execute" option exists. Attempting to enable one is a critical safety violation.
- After writing the plan, the task appends a notification entry to `projects/file-organization/memory.md`:

```markdown
## PLAN WAITING — <ISO timestamp>
- **Plan:** <path>
- **Totals:** <N> files planned, <K> flagged for review.
- **Action required:** Open the plan, reply APPROVE / REJECT / EDIT.
```

Confirm the task is saved and show the user the next firing time.

---

## Step C — Notification options

Ask:

> *"Two ways to know a plan is waiting. Pick one or both:*
>
> *C1. Email yourself a draft. Subject: 'Weekly tidy plan ready — [date]'. Body: link to the plan file. **DRAFT only — never sent automatically.** Same rule as the morning brief.*
>
> *C2. Co-Work startup nudge. When you next open Co-Work after the plan fires, the startup sequence reads `memory.md`, finds 'PLAN WAITING' entries, and surfaces them. No nag, just visibility.*
>
> *C1, C2, both, or neither?"*

Wire the chosen option(s). For C1, the scheduled task creates a Gmail Draft — never sends. For C2, append a startup-prompt entry to the user's startup config.

---

## Step D — Monthly `_review/` audit

Schedule a monthly task (1st of each month, 8:00 a.m. local) that:

1. Reads `projects/file-organization/`.
2. Counts: how many weekly tidies ran vs. expected, files currently in `_review/unknown/`, files in `_review/duplicates/`, age distribution (flag any > 30 days).
3. Looks for rejected-by-user patterns in recent plans (e.g. "you rejected 3 rows that wanted to move videos — consider adding videos to the skip list").
4. Outputs a report to `projects/file-organization/reviews/YYYY-MM-tidy-review.md`.

Create the `reviews/` subfolder if missing.

---

## Step E — Calibration cadence (4 weeks)

For the first 4 weekly tidies, after each user approval/execution, prompt:

> *"Looking at this week's plan vs. how you actually approved, was there a pattern? Any skill update I should propose?"*

Capture the user's answer in `projects/file-organization/calibration-log.md` with a dated entry. After 4 weeks, this prompt auto-disables.

If the user later wants a quarterly check-in, they can ask: *"Re-enable the calibration prompt on a quarterly cadence — every 3 months."*

---

## Step F — Test the schedule (don't wait until Friday)

Schedule a ONE-TIME test run for ~10 minutes from now. When it fires, verify:

1. Plan file is written to `projects/file-organization/plans/`.
2. NO files were moved in the allow-zone (scheduled runs only plan).
3. `memory.md` has a fresh "PLAN WAITING" entry.
4. If C1 enabled: a draft appears in Gmail Drafts (subject and body match the template). Gmail Sent is unchanged — no email actually sent.

After verification, tell the skill `REJECT` for the test plan so nothing pollutes the user's allow-zone.

If any test fails:

> *"[Specific failure]. Diagnosing: was the scheduled task invoked at the right time? Did it call `/tidy-downloads`? Did it respect the scan-and-plan-only rule? Show me the run log."*

---

## Step G — Verify the schedule is persistent

Ask the user to open Co-Work → Settings → Scheduled Tasks. They should see two tasks:

- `Weekly Tidy — [day] [time]` with a next-run timestamp matching their choice
- `Monthly Tidy Review — 1st of month 8am` with next-run on the 1st of next month

If either is missing, re-create per Step B / Step D specs.

---

## Step H — Log Phase 4 complete

Append to `projects/file-organization/memory.md`:

> *"Phase 4 complete. Weekly tidy scheduled for [day] [time]. Monthly audit scheduled for 1st of month 8am. Calibration log primed for 4 weeks. Project 03 install complete (provisional — pending 4-week calibration window)."*

Update `_aibos/state-file-organization.md`:

- `current_phase: 5` (sentinel — past Phase 4)
- `weekly scheduled task: true`
- `monthly _review audit task: true`
- `calibration log: true`
- `file_organization_complete: true`
- `completed_at: <ISO timestamp>`
- Calibration window: `weeks_completed: 0`, `next_check_due: <date 4 weeks from now>`
- `Phase 4 (schedule weekly): completed at <ISO timestamp>`

---

## Wrap-up

Tell the user:

> *"Project 03 install complete.*
>
> *What happens now:*
> *- [Day] [time]: first scheduled tidy fires. Writes a plan. Notifies you. You approve when convenient.*
> *- 1st of next month: monthly audit produces a report at `projects/file-organization/reviews/`.*
> *- After each of the next 4 weekly approvals: I'll ask one quick calibration question.*
> *- 4 weeks from now: come back and we tune the skill based on what we learned.*
>
> *Two pieces of guidance for the long run:*
> *1. Don't enable 'Always Allow' for file moves. Even after 6 months. The per-move prompts are cheap; bypassed prompts are expensive.*
> *2. Walk `_review/` every week along with the plan approval. It's a queue, not a graveyard.*
>
> *That's it. Close the laptop. The system runs."*

---

## What this phase never does

- Configure the scheduled task to auto-execute moves
- Send any actual emails (only Gmail Drafts)
- Disable the per-move approval prompts
- Skip the test fire (Step F is critical — verifying the scheduled task respects plan-only)
