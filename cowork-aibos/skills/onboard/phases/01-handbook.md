# Phase 1 — Handbook (Global Instructions)

**What this phase does:** Walks the user through pasting a personalized handbook into Cowork's Global Instructions setting, so Claude has it loaded for every session.

**Time:** 10–15 minutes
**Output:** Global Instructions saved in Cowork settings + a backup `claude.md` at workspace root

---

## Step 1 — Greet, set context

Say:

> "Phase 1 of 7: the handbook. This is the rulebook Claude reads at the start of every Cowork session. It tells Claude how to talk to you, what never to do, and what you care about most. Takes about 10 minutes. Ready? Type **go** to start."

Wait for `go`.

## Step 2 — Five-question interview

Ask these one at a time. Don't ask the next until they've answered.

1. **"What's your name, role, and one sentence about what you do?"**
2. **"How do you want me to talk to you? Tone, length preference, and 2–3 things AI tools do that annoy you."**
3. **"What are 3 things I should never do?"** (e.g. send emails without approval, use emoji, write at 2 a.m.)
4. **"Three safety rules that are non-negotiable?"** (e.g. never delete files, never send anything to clients without showing you first)
5. **"US or UK English? Anything else I should know about how you write?"**

If the user says "I don't know" or seems stuck, offer a default and ask if it fits. Don't make them invent answers.

## Step 3 — Draft the handbook

Read `templates/claude-md.md`. Use it as the structure. Fill in the answers from Step 2.

Show the draft to the user as a code block. Say:

> "Here's your handbook. Read it. If anything is off, tell me **change [X]** and I'll redraft. Otherwise type **looks good**."

Iterate until they approve.

## Step 4 — Save it (two places)

When approved:

1. Tell the user: **"Open Cowork → Settings → Cowork → Global instructions → Edit. Select all the existing text and replace it with what I just gave you. Click Save. Tell me when that's done."**
2. Wait for confirmation.
3. Then say: **"Now I'll save a backup copy in your workspace at `claude.md` so you have it for reference."**
4. Write the same content to the user's workspace as `claude.md`.

## Step 5 — Verify

Tell the user:

> "Open a brand new task in Cowork. Type: **'Summarize how I want you to work with me.'** It should answer using the actual content from your handbook, not generic AI talk."

Wait for them to confirm the test passed. If it didn't:

- Ask them to paste what Cowork said back.
- If it sounds generic, tell them to check that the handbook actually saved in Settings (sometimes it doesn't on the first try).

## Step 6 — Log and advance

Append to `about-me/memory.md`:

```
### YYYY-MM-DD — Phase 1 complete: handbook saved
- **What we worked on:** Wrote and saved the Global Instructions handbook.
- **Files touched:** Settings → Cowork → Global instructions, claude.md (workspace backup)
- **Decisions I made:** Tone: <quote>. Hard nos: <quote>. Safety rules: <quote>.
- **Open loops:** None for this phase.
- **Next time, do:** Phase 2 (about-me/).
```

Update `_aibos/state.md`:
- `phases.1.status: complete`
- `phases.1.completed: <today's date>`
- `next_phase: 2`

## Step 7 — Hand off

Say:

> "Phase 1 done. Your handbook is saved and Claude knows the basics about how you want to work. Next phase builds the deeper context — your actual business, your voice, what's on your mind right now. About 30 minutes. Continue to phase 2, or pause? (Type **continue** or **pause**.)"

Wait. If `continue`, run phase 2. If `pause`, stop here and remind them they can resume by saying "continue onboarding."
