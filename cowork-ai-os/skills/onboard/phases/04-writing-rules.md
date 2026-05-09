# Phase 4 — writing-rules.md + memory.md (your voice + Claude's notebook)

**What this phase does:** Builds the third dossier file — `about-me/writing-rules.md` — and drops the empty `about-me/memory.md` notebook in place. This phase closes out the about-me/ folder.

**Time:** 15-20 minutes
**Output:** `about-me/writing-rules.md` + `about-me/memory.md` (template-only)

---

## Step 1 — Greet briefly

Read `_aibos/state.md`. Confirm `interview_path`.

Say:

> "Phase 4 of 9: writing-rules + memory. This is the file that protects your voice. Claude reads it before writing anything in your name — emails, posts, replies, captions. About 15-20 minutes. 7 questions plus you'll paste a few writing samples.
>
> Bring 3-5 real samples — past emails, LinkedIn posts, newsletter sections, website copy. The more honest, the sharper the voice match. Have them ready?
>
> Type **go** when you have samples in hand."

Wait for `go`.

If `interview_path` is `sample-first` AND they did NOT see writing-rules-sample in Phase 2, paste `samples/writing-rules-sample.md` first as a refresher.

---

## Step 2 — Run the writing-rules.md interview (7 questions + analysis)

Read `templates/writing-rules.md` for structure. Ask these one at a time:

1. Your writing voice in one sentence — or name 3 creators you want to sound like?
2. 3–5 adjectives for how you DO sound; 3–5 for how you do NOT sound?
3. 5–10 words/phrases you use often; words you refuse to use?
4. Emoji preference; formatting defaults (bullets vs paragraphs, sentence length, capitalization)?
5. Signature moves — distinctive things you do when writing?
6. What specifically bugs you about AI-written content?
7. **Paste 3–5 samples of your past writing.** Analyze rhythm, vocabulary, structure, tone.

After Q7, build the writing-rules.md file. **Always include the universal anti-AI kill list** as Part 2 (the full list is in the voice-writer SKILL.md appendix — copy it verbatim).

The user's voice goes in Part 1. The kill list (universal) goes in Part 2 unchanged. Iterate, save to `about-me/writing-rules.md`.

---

## Step 3 — Drop the memory.md notebook

Copy `templates/memory.md` to `about-me/memory.md` if it doesn't already exist (it might already, since Phase 2 and 3 appended log entries to it). If it exists with prior entries, leave them — just confirm the file is present.

Tell the user:

> "memory.md is your session notebook. I append one entry every time we work together. You don't write in it — I do. It's how I remember what we did last time."

---

## Step 4 — Verify the whole about-me/ folder

Tell the user:

> "Quick sanity check. Open a fresh Cowork task. Type: **'Summarize what you know about me, my business, and how I write — in 3 sentences.'**
>
> The answer should be specific and use your actual words from these four files. If it sounds generic or wrong, the about-me/ files might be in the wrong place or empty. Tell me what you see."

Wait for confirmation.

---

## Step 5 — Log and advance

Append to memory.md:

```
### YYYY-MM-DD — Phase 4 complete: writing-rules.md + memory.md built
- **What we worked on:** Built writing-rules.md via interview + writing samples. memory.md notebook in place. About-me/ dossier complete.
- **Files touched:** about-me/writing-rules.md, about-me/memory.md.
- **Decisions I made:** Tone: <quote>. Voice influences: <quotes>. Banned phrases I added: <list>.
- **Open loops:** <anything the user said they'd revisit later>
- **Next time, do:** Phase 5 (connectors).
```

Update `_aibos/state.md`: `phases.4.status: complete`, `next_phase: 5`.

---

## Step 6 — Hand off

Say:

> "Phase 4 done. writing-rules.md is saved and memory.md is ready for me to start appending to. The about-me/ folder is now complete — 4 of 4 files done. Every skill from here on reads them automatically.
>
> Phase 5 connects me to your tools — email, calendar, and whatever else you use. About 20 minutes. Mostly clicking, not typing.
>
> Continue to Phase 5, or pause and take a break? (Type **continue** or **pause**.)"

Wait. Run Phase 5 or stop. The about-me/ dossier is the heaviest lift — many users will pause here and come back fresh tomorrow. That's fine. State.md will route them to Phase 5 when they return.
