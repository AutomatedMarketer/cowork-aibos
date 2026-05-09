# Phase 5 — Tighten Draft Rules

**Goal:** Activate the Q8 stricter draft selection rules. The existing morning-brief already drafts replies into Gmail Drafts — Q8 makes the selection criteria explicit, testable, and tighter.

**Time:** ~15 minutes. Pillar: Filters.

**Why this phase exists:** P01 drafts use the heuristic "if reply is obvious." That works most of the time but produces inconsistent drafts. Q8 replaces "obvious" with explicit testable criteria — B1 only, response-required, max 3, exclusion topics. Same draft destination (Gmail Drafts). Sharper selection.

---

## Script — what to say

> *"Phase 5 sharpens your drafts. The morning-brief already drafts replies in your voice — that's been working since P01. What we're doing now is tightening the selection criteria.*
>
> *Right now drafts get created when 'the reply is obvious.' That's fuzzy. Q8 makes it explicit: which emails get drafts, which never get drafts, what tone, what format. The morning-brief reads Q8 if it's present and applies the stricter rules.*
>
> *Hard rule still in effect: Claude drafts. You approve. You send. The `send_email` permission stays BLOCKED forever. We're not unblocking. Ever."*

---

## Step 1 — Re-confirm send_email is BLOCKED

Tell user:

> *"Open Settings → Customize → Connectors → Gmail → Permissions. Confirm `send_email` is still BLOCKED. Tell me when checked."*

Wait for confirmation. If user has unblocked it for any reason since P01, have them re-block before continuing. Non-negotiable.

---

## Step 2 — Confirm Q8 is in place from Phase 1

Open `projects/daily-brief/brief-preferences.md`. Scroll to Q8. Confirm all four sub-sections have specific content:

- **When to draft** — explicit criteria (B1 + response-required + 24h fresh + max count)
- **When NOT to draft** — explicit exclusions (ambiguous intent, user-specific data, >4 paragraphs, sensitive topics)
- **Tone** — references `about-me/writing-rules.md` + match-sender-energy rule
- **Format** — plain text, max paragraphs, sign-off rule

If Q8 is thin from Phase 1, tighten it now using the *Stuck?* prompt before running the brief.

---

## Step 3 — Confirm writing-rules.md is sharp

The drafts use the user's `about-me/writing-rules.md` from P01. Open it. Confirm it has:

- Banned phrases (specific words/phrases the user never uses)
- Sentence rhythm preferences
- Sign-off rules
- At least one strong-vs-weak example

If writing-rules.md is thin or generic, drafts will be generic. Walk user through beefing it up — pull 5 of their actual sent emails, identify their voice patterns, codify them.

This is the single biggest factor in draft quality. Q8 controls WHICH emails get drafted; writing-rules.md controls HOW the drafts sound.

---

## Step 4 — Run the brief

Have the user run `/morning-brief`.

Drafts now use Q8 selection rules instead of the P01 "if obvious" heuristic. The Drafts section of the brief shows what was drafted:

```
## Drafts ready for review (in Gmail Drafts)
- Reply to Jenny re: Move Q3 retainer convo to today's 10 AM? — agreeing, sets agenda
- Reply to Mike re: PR #47 ready for review — confirming review timing
- Reply to Stripe re: Failed payment notification — internal note for Acme
```

(If 0 drafts were generated because nothing in inbox met Q8 criteria, the section is omitted — that's correct behavior.)

The drafts themselves live in Gmail Drafts.

---

## Step 5 — Open Gmail and inspect

Tell user:

> *"Open Gmail. Click Drafts. Read each one like you'd read it cold."*

Walk through each draft together. Score each:

- **Send no edits** — perfect (rare on first run)
- **Light edits** — good, draft saved 80% of work
- **Heavy edits** — OK, saved 50% — still better than blank
- **Scrap** — bad, draft cost time

**Target:** at least 2 of N drafts at "light edits or better."

**If 2+ drafts are scrap-quality, common fixes:**

- Voice off → `about-me/writing-rules.md` is thin. Beef it up with 3–5 explicit do/don't examples from real sent emails.
- Wrong content → tighten Q8 "When NOT to draft" exclusions to remove the email type that produced the bad draft.
- Too verbose → add to Q8 Format: *"Maximum 3 sentences for routine replies."*
- Hallucinating facts → add to Q8 "When NOT to draft": *"Anything requiring numbers, dates, or pricing the user hasn't pre-authorized."*

Tune. Re-run. Inspect again. Repeat until at least 2 of 3 drafts are at "light edits or better."

---

## Step 6 — Confirm drafts never sent

Have user click **Sent** in Gmail sidebar. Confirm none of the drafts appear there.

If somehow a draft got sent — STOP this entire project. Audit Gmail connector permissions immediately. The skill should have no path to send. If a send happened, escalate before continuing.

---

## Step 7 — The 6-month test (read this aloud)

Tell user:

> *"In 6 months, your drafts will be hitting at 'light edits or better' on most days. You'll be tempted to flip on auto-send 'for known senders only.' Don't.*
>
> *In 6 months, your business will have new clients, new contractors, new vendors. A 'known sender' filter that's safe today gets risky tomorrow when a phishing email spoofs a known sender's domain. Drafts protect against this. Drafts protect against your own rushed mornings.*
>
> *The block stays. Forever. That's the deal."*

---

## Verification

Before marking Phase 5 complete:

- [ ] `send_email` permission BLOCKED in Gmail connector
- [ ] Q8 in `brief-preferences.md` has all 4 sub-sections specific
- [ ] `about-me/writing-rules.md` has explicit voice rules
- [ ] Brief lists 1–N drafts in Drafts section (or correctly omits when nothing meets Q8)
- [ ] Drafts appear in Gmail Drafts (not Sent)
- [ ] At least 2 of N drafts are "light edits or better"
- [ ] No drafts auto-sent

---

## State update

Append to `_aibos/state-daily-brief.md`:

```
- <ISO timestamp> — Phase 5 (Tighten Draft Rules) complete. <N> drafts generated, <M> usable on first pass. <K> tuning iterations on Q8 + writing-rules.md.
```

Update `current_phase: 6`.

---

## Pause point

> *"Phase 5 complete. You're 83% through. One phase left. Phase 6 schedules the brief and runs the 7-day calibration loop — about 25 minutes for setup, then a week of light daily check-ins. Type `continue onboarding` when ready."*

If user continues → load `phases/06-schedule-calibrate.md`.
