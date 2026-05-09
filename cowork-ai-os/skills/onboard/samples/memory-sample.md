# memory.md — Claude's Notebook

This file lives in `about-me/memory.md`. Claude reads it every session to recall what's happened in prior sessions. Claude also **appends** one entry at the end of each working session — that's how the memory grows.

You don't write this file manually. You just leave it open for Claude to keep appending.

Below is the format Claude uses. Don't delete the header — Claude looks for it.

---

## Session log

Claude appends one entry per working session, newest at the bottom, using this shape:

```
### YYYY-MM-DD — <one-line summary>
- **What we worked on:** <1–2 sentences>
- **Files touched:** <paths of files created or edited>
- **Decisions I made:** <specific calls the user made, in their words where possible>
- **Open loops:** <anything unfinished worth remembering next session>
- **Next time, do:** <a concrete next step, if there is one>
```

---

## Example entry (for format reference — delete once you have real entries)

### 2026-04-15 — Set up Core Setup handbook and About Me files

- **What we worked on:** Installed Claude Co-Work, wrote the handbook, and built all four About Me files via the interview.
- **Files touched:** `claude.md` (handbook), `about-me/about-me.md`, `about-me/business-brain.md`, `about-me/writing-rules.md`, `about-me/memory.md`.
- **Decisions I made:** Workspace folder lives at `~/Claude Cowork/`. Primary ICP is solo coaches at $5K–$30K/month. Default tone is "direct, warm-but-sharp".
- **Open loops:** Writing-rules.md samples are only 2 so far — should add a third next session.
- **Next time, do:** Connect Gmail and Calendar (Project 01 Lesson 4).

---

## Rules Claude follows when writing here

- **Append-only.** Never rewrite or delete past entries.
- **One entry per session.** If a session produces nothing, skip (don't write "nothing happened").
- **Specific, not general.** "User decided primary ICP is solo coaches at $5K–$30K/month" — not "discussed business strategy".
- **Quote the user where it matters.** Especially on decisions and preferences.
