# memory.md — Claude's Notebook

Lives in `about-me/memory.md`. Claude reads it every session to recall what happened in prior sessions, and **appends** one entry at the end of each working session.

You don't write this file manually. Claude does. Just leave it open for Claude to keep appending.

Don't delete the header below — Claude looks for it.

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

- **What we worked on:** Installed Cowork AI OS, ran /onboard, completed all 7 phases.
- **Files touched:** `claude.md` (handbook), `about-me/about-me.md`, `about-me/business-brain.md`, `about-me/writing-rules.md`, `about-me/memory.md`, `about-me/connections.md`.
- **Decisions I made:** Workspace folder is `~/Claude Cowork/`. Primary ICP is solo coaches at $5K–$30K/month. Default tone: "direct, warm-but-sharp."
- **Open loops:** writing-rules.md samples are only 2 — should add a third.
- **Next time, do:** Run /audit to get the baseline 4 C's score, then pick the next project from the recommendations.

---

## Rules Claude follows when writing here

- **Append-only.** Never rewrite or delete past entries.
- **One entry per session.** If a session produces nothing, skip (don't write "nothing happened").
- **Specific, not general.** "User decided primary ICP is solo coaches at $5K–$30K/month" — not "discussed business strategy."
- **Quote the user where it matters.** Especially on decisions and preferences.
