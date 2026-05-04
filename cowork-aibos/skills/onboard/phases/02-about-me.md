# Phase 2 — About Me (the 4-file identity dossier)

**What this phase does:** Conducts a structured interview to fill out the four about-me/ files. This is the highest-leverage phase. Output quality across every later skill is capped by what gets written here.

**Time:** 30–45 minutes
**Output:** `about-me/about-me.md`, `business-brain.md`, `writing-rules.md`, `memory.md`

---

## Step 1 — Greet, set expectations

Say:

> "Phase 2 of 7: about-me. This is the big one. We'll build four files that teach me who you are, what you sell, how you write, and a notebook I'll keep updating. About 30–45 minutes. Don't rush this — every later skill gets better when these files are richer. Ready? Type **go**."

Wait for `go`.

## Step 2 — File 1: about-me.md (10 questions)

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

## Step 3 — File 2: business-brain.md (12 questions)

Read `templates/business-brain.md` for structure. Ask these one at a time:

1. What is your business — explain to a smart friend, no jargon, one paragraph?
2. Main offers/products/services — price, what's included, who it's for?
3. Ideal customer — age, profession, company size, geography, the **now** trigger?
4. What does your ideal customer believe about their problem, and what have they tried before?
5. Top 3 objections before buying?
6. How does the business make money — revenue model, split if multiple?
7. Click-to-close flow — every step from stranger to paying customer with timeline?
8. Top 3 pains you solve (not features)?
9. Why customers pick you over alternatives — if unclear, say "unclear"?
10. Current state — revenue range, team size, main channels, #1 priority right now?
11. 12-month and 3-year aspirations?
12. Anti-goals + 3 things you're tired of re-explaining?

Draft, show, iterate, save to `about-me/business-brain.md`.

## Step 4 — File 3: writing-rules.md (7 questions + analysis)

Read `templates/writing-rules.md` for structure. Tell the user:

> "Bring 3–5 real writing samples for the last question — past emails, LinkedIn posts, newsletter sections, website copy. The more honest the samples, the sharper the voice match."

Ask these one at a time:

1. Your writing voice in one sentence — or name 3 creators you want to sound like?
2. 3–5 adjectives for how you DO sound; 3–5 for how you do NOT sound?
3. 5–10 words/phrases you use often; words you refuse to use?
4. Emoji preference; formatting defaults (bullets vs paragraphs, sentence length, capitalization)?
5. Signature moves — distinctive things you do when writing?
6. What specifically bugs you about AI-written content?
7. **Paste 3–5 samples of your past writing.** Analyze rhythm, vocabulary, structure, tone.

After Q7, build the writing-rules.md file. **Always include the universal anti-AI kill list** inlined as the universal section (look at voice-writer SKILL.md appendix for the full list) as Part 2.

The user's voice goes in Part 1. The kill list (universal) goes in Part 2 unchanged. Iterate, save to `about-me/writing-rules.md`.

## Step 5 — File 4: memory.md (no interview, just create)

Copy `templates/memory.md` to `about-me/memory.md`. Tell the user:

> "memory.md is your session notebook. I'll append to it every time we work together. You don't write in it — I do. Just leave it there."

## Step 6 — Verify

Tell the user:

> "Open a fresh Cowork task. Type: **'Summarize what you know about me, my business, and how I write — in 3 sentences.'** It should be specific and use your actual words from these files."

Wait for confirmation. If the answer sounds generic, the about-me/ files are probably empty or in the wrong place — check.

## Step 7 — Log and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 2 complete: about-me/ built
- **What we worked on:** Built all four about-me/ files via interview.
- **Files touched:** about-me/about-me.md, about-me/business-brain.md, about-me/writing-rules.md, about-me/memory.md.
- **Decisions I made:** ICP: <quote>. Tone: <quote>. Top business priority: <quote>.
- **Open loops:** <anything the user said they'd revisit later>
- **Next time, do:** Phase 3 (connectors).
```

Update `_aibos/state.md`: `phases.2.status: complete`, `next_phase: 3`.

## Step 8 — Hand off

Say:

> "Phase 2 done. The four files in `about-me/` now teach me who you are. Every skill from here on reads them automatically. Phase 3 connects me to your tools — email, calendar, and whatever else you use. About 20 minutes. Continue, or pause?"

Wait. Run phase 3 or stop.
