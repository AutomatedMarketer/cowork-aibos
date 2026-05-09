# Phase 2 — Verify the Baseline

**Goal:** Run `/morning-brief` once with the extended `brief-preferences.md`. Confirm the existing P01 sections (Priority, Calendar, Urgent Inbox, Quick Wins, Drafts) still render clean before adding Team comms and Tasks.

**Time:** ~15 minutes. Pillar: Format.

**Why this phase exists:** You just appended Q4–Q8 to your prefs file. Even though the new sections aren't surfaced yet (Phases 3–5 will activate them), we want to confirm the existing brief still renders correctly. If something broke during the append, fix it now — before stacking more on top.

---

## Script — what to say

> *"Phase 2 is the first run after extending your prefs. We're going to run `/morning-brief` and confirm the existing P01 sections — priority, calendar, urgent inbox, quick wins, drafts — still come out clean. We're NOT adding Team comms or Tasks yet. Just verifying the foundation didn't crack when we appended Q4–Q8.*
>
> *Ready to run it?"*

---

## Step 1 — Run morning-brief

Have the user invoke `/morning-brief` in their Cowork window.

The brief at this stage will contain (existing P01 structure):

- Priority line (one sentence, top of brief)
- Today's calendar
- Urgent inbox (3–5 items)
- Quick wins (under 15 min each)
- Drafts ready for review (Gmail Drafts)

**No Team comms section** — Phase 3 activates that.
**No Tasks section** — Phase 4 activates that.

The brief is saved to `outputs/daily-brief/YYYY-MM-DD-brief.md`.

---

## Step 2 — Diagnose the output

Open the brief together with the user. Walk through these checks:

### Priority line check

1. *"Is the priority line one sentence?"*
2. *"Is it specific (refers to something in the brief) or generic?"*
3. *"Does the tone match what you specified in Q7?"*

If the priority line is generic ("focus on growth today"), Q7 examples are too soft. Sharpen them.

### Calendar check

1. *"Are today's actual meetings on the brief?"*
2. *"Anything showing that should be skipped per your existing P01 calendar rules?"*
3. *"Is the prep note on each event useful, or just filler?"*

If prep notes are filler, the morning-brief is hallucinating. Tell user to tighten the calendar rules in the P01 section: *"Only attach a prep note if there's a recent email thread or a meeting-brief file in projects/."*

### Urgent inbox check

1. *"Are all your B1 senders accounted for if they emailed in the last 72h?"*
2. *"Anything from your never-matter list leaking through?"*
3. *"Is the count between 3–5? More = filters too broad. Less = filters too narrow."*

### Quick wins check

1. *"Are the quick wins actually under 15 minutes each?"*
2. *"Are they specific enough to act on, or vague?"*

If Quick Wins are vague, the morning-brief is reaching. Better an empty Quick Wins section than a wrong one.

### Drafts check

1. *"Are 1–N drafts in your Gmail Drafts?"*
2. *"Are they replies to actual urgent items from this brief, or random?"*
3. *"Read each one — would you send with light edits, heavy edits, or scrap?"*

Q8 hasn't activated stricter scoring yet (the morning-brief still uses the P01 default "if obvious" logic — Q8 takes effect once you finish this phase and the morning-brief next reads the file). Phase 5 sharpens drafts. For now, just confirm drafts are happening.

---

## Step 3 — Re-run if changes were made

If user edited any P01 section in `brief-preferences.md` based on Step 2 findings, run `/morning-brief` again. Verify the issues are fixed.

The brief overwrites `outputs/daily-brief/YYYY-MM-DD-brief.md` on every run — same day = same file. Yesterday's brief moves to `archive/`.

---

## Step 4 — Confirm the existing memory.md got appended

Open `about-me/memory.md`. The morning-brief skill appends an entry every run:

```
### YYYY-MM-DD — Morning brief generated
- Calendar: <N> events
- Inbox urgent: <N> emails
- Drafts created: <N>
- Top priority: <quote>
```

If `about-me/memory.md` got an entry from your test runs, the existing logging works. Continue.

(Note: `projects/daily-brief/memory.md` — the P02 calibration log — won't have entries yet. It only starts logging once Team comms and Tasks helpers are activated in Phases 3–4.)

---

## Verification

Before marking Phase 2 complete:

- [ ] `/morning-brief` ran successfully (no errors in Cowork window)
- [ ] Brief file exists at `outputs/daily-brief/<today>-brief.md`
- [ ] Priority line is one sentence and references a highlight
- [ ] Calendar section shows today's actual meetings
- [ ] Urgent inbox shows 3–5 items, B1 senders present, no never-matter noise
- [ ] Quick wins are specific (or section is empty — both fine)
- [ ] Drafts in Gmail Drafts (Sent inbox unchanged)
- [ ] `about-me/memory.md` got at least one timestamped entry from your runs

If any check fails, tune the relevant P01 section in `brief-preferences.md` and re-run. Don't pass Phase 2 with a noisy baseline.

---

## State update

Append to `_aibos/state-daily-brief.md`:

```
- <ISO timestamp> — Phase 2 (Verify Baseline) complete. Existing P01 sections render clean post-append. <N> tuning iterations.
```

Update `current_phase: 3`.

---

## Pause point

> *"Phase 2 complete. You're 33% through. Foundation holds. Phase 3 activates Team comms — about 15 minutes. Type `continue onboarding` when ready, or `pause onboarding` to resume later."*

If user continues → load `phases/03-add-comms.md`.
