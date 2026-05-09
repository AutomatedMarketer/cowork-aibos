# Phase 2 — about-me.md (your résumé for Claude)

**What this phase does:** Builds the first of four identity files — `about-me/about-me.md`. This is who you are, what you're working on, who you work with, and how you like to work. Claude reads it at the start of every session.

**Time:** 15 minutes
**Output:** `about-me/about-me.md`

> **Heads up:** the about-me dossier is split across 4 files and 3 phases (Phase 2 → about-me, Phase 3 → business-brain, Phase 4 → writing-rules + memory). You can stop after any phase and resume later. Just say **continue onboarding** next time and I'll pick up where we left off.

---

## Step 1 — Greet, offer two paths (this phase only)

Say:

> "Phase 2 of 9: about-me. We'll build the first of four files that teach me who you are. About 15 minutes.
>
> Two ways we can do this whole about-me dossier (Phases 2-4):
>
> **(a) Interview** — I ask questions one at a time. We build each file together. Best if you want to think out loud.
>
> **(b) Sample-first** — I show you fully fleshed-out examples for ALL four files (about-me, business-brain, writing-rules, memory) right now. You read them for 5 minutes to see what 'good' looks like. Then we do each interview, and they go faster because you've seen the shape. Best if you're a visual thinker or you've never done this before.
>
> Type **interview** or **sample-first**."

Wait for response. Save the choice in `_aibos/state.md` so Phase 3 and 4 don't ask again.

---

## Step 2 (sample-first only) — Walk through ALL FOUR samples

If they chose `sample-first`, before any questions:

> "Here's what a fully filled-out about-me/ folder looks like for a fictional online coach. All four files. Read them. Take 5 minutes. Tell me when you're ready."

Then paste each sample as a code block, with a one-line intro per file:

1. **claude.md** (handbook — already built in Phase 1, but here's how it relates): paste contents of `samples/claude-md-sample.md`
2. **about-me.md** (this phase): paste contents of `samples/about-me-sample.md`
3. **business-brain.md** (Phase 3): paste contents of `samples/business-brain-sample.md`
4. **writing-rules.md** (Phase 4): paste contents of `samples/writing-rules-sample.md`

After pasting, say:

> "That's the finished set. Now we build YOUR about-me.md. Then in Phase 3 we do business-brain, and Phase 4 we do writing-rules + memory. Ready for the about-me interview? Type **go**."

Wait for `go`.

---

## Step 3 — Run the about-me.md interview (10 questions)

Read `templates/about-me.md` for the structure. Ask these one at a time:

1. Name, city/country, languages?
2. One-sentence description of what you do (the dinner-party version)?
3. Your current primary roles and job titles?
4. 3–5 active projects and their phase (early / building / launched / scaling / maintaining)?
5. Exactly who you serve — industry, size, geography, the trigger that makes them buy. Not "small business owners."
6. Tools you open every day, and tools used only weekly or monthly?
7. Personal context to keep across sessions (family, schedule quirks, values)? Optional.
8. How you learn best?
9. What made a successful Claude session — 2–3 specific behaviors you want to repeat?
10. Anything else important?

After Q10, draft the file using the template structure. Show as a code block. Iterate until approved. Save to `about-me/about-me.md`.

---

## Step 4 — Log and advance

Append to memory.md (creating it from `templates/memory.md` if it doesn't exist yet):

```
### YYYY-MM-DD — Phase 2 complete: about-me.md built
- **What we worked on:** Built about-me.md via interview. {{interview or sample-first path}}.
- **Files touched:** about-me/about-me.md.
- **Decisions I made:** Role: <quote>. Active projects: <quotes>. Tools: <list>.
- **Open loops:** <anything the user said they'd revisit later>
- **Next time, do:** Phase 3 (business-brain).
```

Update `_aibos/state.md`: `phases.2.status: complete`, `next_phase: 3`, save `interview_path: <interview|sample-first>` so Phases 3 and 4 know which mode to use.

---

## Step 5 — Hand off

Say:

> "Phase 2 done. about-me.md is saved. That's 1 of 4 dossier files in the bag.
>
> Phase 3 builds **business-brain.md** — what you sell, who buys it, what they object to. About 15 minutes. 12 questions.
>
> Continue to Phase 3, or pause and pick up later? (Type **continue** or **pause**.)"

Wait. Run Phase 3 or stop. If they pause, the next time they invoke /onboard or say "continue onboarding", state.md will route them to Phase 3.
