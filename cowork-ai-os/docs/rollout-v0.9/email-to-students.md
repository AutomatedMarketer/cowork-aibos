# Email to students — v0.9 release + speed fix

**Audience:** Anyone enrolled in the course who has installed Cowork AI OS (just a few people).
**Send:** The day v0.9.0 is tagged on GitHub. Or earlier with the manual-workaround variant if v0.9 ships later than expected.
**From:** Nuno, personal address, not a marketing list.

---

## Version A — when v0.9.0 ships (recommended)

**Subject:** Quick fix for Cowork — 5 mins, big speed win

Hey —

Short one.

If Cowork has been feeling slow on startup (20+ seconds before Claude responds), that's a bug in the Cowork AI OS plugin I shipped, not your setup. The old handbook was telling Claude to re-read your whole `about-me/` folder on every prompt. That's where all the time was going. My bad.

v0.9 is live and fixes this at the source. Here's how to upgrade (2 minutes):

1. Open Cowork. Type `/plugin update cowork-ai-os`.
2. Then type `/optimize`. It'll diagnose what's slow and show you a fix.
3. When it gives you a new handbook in a code block, copy it. Open **Cowork → Settings → Cowork → Global instructions**. Paste over what's there. Save.
4. Send any quick prompt to test. Should respond in under 3 seconds.

If anything looks off afterward, type `rollback` and it puts everything back exactly how it was.

Your identity files (`about-me/`, writing-rules, memory, etc.) are preserved. Your scheduled tasks keep running. This is just a config fix.

Full release notes (if you're curious): [link to GitHub Release for v0.9.0]
Step-by-step SOP with screenshots: [link to Google Drive SOP doc]

If you lost meaningful time to the slowness before today, hit reply and I'll send a refund for the hour. No questions asked.

— Nuno

P.S. If you've been frustrated and didn't say anything — that's also on me. Direct line: nuno@digitalvoltage.net. Tell me what's annoying and I'll fix it.

---

## Version B — workaround-first (if v0.9 ships later than today)

Use this version if you want to unblock students NOW and ship v0.9 a few days later.

**Subject:** Quick fix for Cowork slowness — 5 mins until v0.9 ships

Hey —

Short one.

If Cowork has been feeling slow on startup (20+ seconds before Claude responds), that's a bug in the Cowork AI OS plugin I shipped, not your setup. My bad. v0.9 ships this week and fixes it permanently. Until then, here's a 5-minute manual workaround:

1. Open **Cowork → Settings → Cowork → Global instructions**.
2. Find the `## Things to always do` section.
3. Delete the entire line that starts with *"At the start of every session, read every file in `about-me/`..."* — just that one line. Leave the rest of the section.
4. Save.

That's it. Startup should drop from ~25s to under 3s immediately.

When v0.9 ships, I'll send a second email with the proper upgrade path (`/plugin update cowork-ai-os` → `/optimize`). The upgrade will detect this manual edit and clean up cleanly — you don't need to undo anything first.

If you lost meaningful time to the slowness before today, hit reply and I'll send a refund for the hour.

— Nuno

P.S. The full backstory + what changes in v0.9: [link to Google Drive SOP doc / blog post]
