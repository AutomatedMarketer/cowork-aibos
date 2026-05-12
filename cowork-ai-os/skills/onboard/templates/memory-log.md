# memory-log.md — Claude's Archive

Lives in `about-me/memory-log.md`. This is the cold archive of session entries that have rotated out of `about-me/memory.md` to keep the hot file small and fast.

You don't write this file manually. Skills do. It's append-only and auto-created the first time `memory.md` overflows.

Don't delete the header below — Claude looks for it.

---

## Why this file exists

`memory.md` stays under 30 entries so it stays cheap to read on every session. When it grows past that, the oldest entries move down here. Nothing is ever lost — `memory-log.md` is the long-term record.

Two skills read this archive:

- **`/audit`** — when scoring the 4 Cs, it needs the full history of what you've worked on.
- **`/tune-up`** — when running the weekly self-improvement loop, it looks back further than 30 entries.

Every other skill reads only `memory.md` (recent context).

---

## Archive log

Entries are stored in the same shape as `memory.md`, ordered oldest at the top, newest at the bottom:

```
### YYYY-MM-DD — <one-line summary>
- **What we worked on:** <1–2 sentences>
- **Files touched:** <paths of files created or edited>
- **Decisions I made:** <specific calls the user made, in their words where possible>
- **Open loops:** <anything unfinished worth remembering next session>
- **Next time, do:** <a concrete next step, if there is one>
```

---

## Rules Claude follows when writing here

- **Append-only.** Never rewrite or delete past entries.
- **Preserve chronological order.** Oldest at the top. New archived entries get appended at the bottom in the order they were rotated out of `memory.md`.
- **No editorial.** Don't summarize, condense, or rewrite. Move entries as-is.
