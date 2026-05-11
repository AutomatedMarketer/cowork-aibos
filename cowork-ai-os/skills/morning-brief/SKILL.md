---
name: morning-brief
description: Generates a daily morning brief from the user calendar, inbox, and priorities. Reads about-me files for context and voice. Saves to outputs/daily-brief/. Designed to fire as a scheduled task each morning. Trigger when the user says morning brief, what is on today, daily brief, or types /morning-brief.
---

# Morning Brief — Your Day, In One Read

You generate a structured morning brief that takes 60 seconds to read and tells the user exactly what to focus on today.

## Read these first

1. `about-me/about-me.md` — for context on what they care about
2. `about-me/business-brain.md` — for the 90-day priorities
3. `about-me/writing-rules.md` — for voice (the brief must sound like them, not like AI)
4. `projects/daily-brief/brief-preferences.md` — **if it exists**, this is the user's settings file. It overrides the defaults below (which senders matter, max email count, length target, etc.). Built during onboarding Phase 6. If not present, fall back to the defaults in this skill.
5. the anti-AI kill list in the appendix below - the brief must pass this scan
6. The latest entry in `about-me/memory.md` — for what's been happening
7. `projects/daily-brief/brief-preferences.md` Q4 (team comms rules) — **if any platform section is present**, invoke the `brief-source-comms` helper skill. The helper handles whichever platforms the user has populated (Slack, Discord, Telegram, Microsoft Teams, or future MCP-supported platforms). Read-only on every platform. If Q4 is empty across all platforms, skip the Team comms section entirely.
8. `projects/daily-brief/brief-preferences.md` Q5 (Tasks rules) — **if present**, also read `projects/daily-brief/today.md` and surface the unchecked items under the "Today" header. If Q5 is empty or `today.md` doesn't exist, skip the Tasks section entirely.
9. `projects/daily-brief/brief-preferences.md` Q6 (90-day outcome) — **if present**, this becomes the ranking lens for the entire brief. When inbox items or calendar events compete for top placement, the one closer to this outcome wins. Apply it to Urgent inbox ordering (outcome-relevant first, not just most recent), Quick wins selection (favor wins that compound toward the outcome), and the priority-line choice (the priority should advance this outcome when a credible candidate exists). If Q6 is absent, fall back to "most consequential first" without an outcome lens.
10. `projects/daily-brief/brief-preferences.md` Q7 (Priority line tone refinement) — **if present**, apply Q7's tone spec and example sentence when composing the one-line priority at the top of the brief. Q7 specifies a tone (chief-of-staff, coach, blunt friend, etc.) and at least one example sentence the user picked. Mirror the cadence and bluntness of that example. If Q7 is absent, fall back to the P01 default ("direct, specific, action-oriented").
11. `projects/daily-brief/brief-preferences.md` Q8 (Draft Reply rules) — **if present**, use these stricter scoring rules instead of the default "draft if obvious" logic. Q8 specifies B1-only, response-required, max-3 drafts, exclusion topics. The default draft logic still works if Q8 is absent.

Then pull live data:
- **Google Calendar:** all events for today, plus tomorrow's first event if before 10 AM
- **Gmail:** the 3–5 most urgent unread emails from real humans, last 72 hours, exclude newsletters/receipts/notifications
- **Optional:** if the user has a Tasks bucket connector enabled (ClickUp, Notion, etc.), pull anything due today or overdue

## The brief structure

Output a markdown file with these sections, in this order. Keep total length under 300 words.

```markdown
# Morning brief — [day], [date]

**[ONE-LINE PRIORITY]** — direct, specific, action-oriented. Like "Close the contractor scope reply before the 10 AM with Megan." Not "stay on top of priorities."

## Today's calendar
- **HH:MM** — [event title] ([duration]) — [attendees] — _[one-line prep note from past emails or a project file, if available]_
- **HH:MM** — [event title] ([duration])
- ...

## Urgent inbox
1. **[sender]** — [subject] — _why it matters: [one sentence]_
2. **[sender]** — [subject] — _why it matters: [one sentence]_
3. ...

## Team comms
- **[Slack #channel]** — [snippet] — [sender first name], [time]
- **[Discord ServerName › #channel]** — [snippet] — [sender first name], [time]
- **[Telegram chat-name]** — [snippet]
- **[Slack DM Sender]** — [snippet]
- _N other DMs unread_

(Skip this entire section if no platform section in Q4 has rules. The helper skill auto-detects which platforms the user populated and pulls only from those — and only from those that have a live MCP connector.)

## Tasks (today.md)
- [ ] [task line, in user's order, with [QUICK WIN]/[OVERDUE] tags inline]

(Skip this entire section if Q5 is empty or `projects/daily-brief/today.md` is missing.)

## Quick wins (under 15 min each)
- [thing that can be done fast]
- [thing that can be done fast]

## Drafts ready for review (in Gmail Drafts)
- Reply to [sender] re: [subject] — [one-line approach]
- Reply to [sender] re: [subject] — [one-line approach]

(If nothing was draft-worthy, skip this section entirely.)
```

## Rules

- **Priority line is ONE sentence.** Not a paragraph. Specific and action-oriented.
- **Calendar events in chronological order.** Earliest first.
- **Urgent inbox is ranked.** Most consequential at top, not most recent.
- **Skip the newsletter/receipt/notification noise.** If the user explicitly listed senders to ignore in `about-me/`, respect that.
- **Drafts go to Gmail Drafts only — never sent.** And only when the reply is genuinely obvious (a confirmation, a quick acknowledgment, a yes/no). Don't draft replies for things requiring judgment.
- **Voice match.** Run the brief against the anti-AI kill list in the appendix below before showing. Rewrite anything that hits the list.
- **No "Good morning!" preamble.** No "I hope this finds you well." Skip the niceties — open with the priority line.
- **Team comms pulling.** When Q4 has rules for any messaging platform, invoke the `brief-source-comms` helper skill. The helper detects which platforms the user populated, checks which have live MCP connectors, queries each live platform read-only, and returns a unified Team comms section with `[Platform]` tags on each item. If the helper skill isn't installed, append: `(Team comms source not available — install latest cowork-ai-os plugin)` and continue. If a platform has Q4 rules but the connector isn't live, the helper notes that inline and still pulls from the connectors that ARE live. If Q4 is empty across all platforms, skip the Team comms section entirely.
- **Tasks reading.** When Q5 is present in `brief-preferences.md`, read `projects/daily-brief/today.md`, filter to the "Today" section, surface only unchecked items in user-defined order, with inline tags ([QUICK WIN], [OVERDUE], [DELEGATE], [BLOCKED]) rendered as written. Do NOT modify `today.md` — read-only.
- **Ranking with Q6 (90-day outcome).** When Q6 is present in `brief-preferences.md`, use the stated outcome as the ranking lens for the brief. Apply to: (a) Urgent inbox order — items moving the user closer to the outcome rank higher than items that are merely recent; (b) Priority-line selection — the one-sentence priority at the top should advance the Q6 outcome when a credible candidate exists; (c) Quick wins — favor wins that compound toward the outcome. If Q6 is absent, fall back to "most consequential first" without an outcome lens.
- **Priority-line tone with Q7.** When Q7 is present in `brief-preferences.md`, apply Q7's tone spec and match the cadence of its example sentence when writing the one-line priority. Q7 might specify "chief of staff, direct, must reference a highlight below" with an example like "Address scope creep with Jenny before the retainer talk." Mirror that bluntness and structure. If Q7 is absent, fall back to the P01 default tone (direct, specific, action-oriented).
- **Draft scoring with Q8.** When Q8 is present in `brief-preferences.md`, use it as the draft selection lens. Q8 tells you which B1 emails to draft replies for, what to exclude (sensitive topics, ambiguous intent, requires user-specific data), and the format (plain text, voice rules applied, max paragraphs). Q8 overrides the default "if reply is obvious" heuristic. If Q8 is absent, fall back to the default logic above.
- **Voice on drafts.** Drafts must apply `about-me/writing-rules.md` AND pass the anti-AI kill list before saving to Gmail Drafts.

## Save and log

Save the brief to `outputs/daily-brief/YYYY-MM-DD-brief.md`. Use today's date.

Move yesterday's brief to `outputs/daily-brief/archive/` if it exists.

Append to `about-me/memory.md`:

```
### YYYY-MM-DD — Morning brief generated
- Calendar: <N> events
- Inbox urgent: <N> emails
- Drafts created: <N>
- Top priority: <quote>
```

## When this fires as a scheduled task

The user won't be at the computer. So:

- Don't ask any questions.
- Save the brief to disk.
- DO NOT send anything (Gmail send is BLOCKED in their settings — double-check).
- Append the memory entry.
- Stop.

When the user opens Cowork later, they can find the brief at `outputs/daily-brief/YYYY-MM-DD-brief.md`. Some users like to ask "summarize today's brief" — that should work because the brief is in their workspace and gets read by the SessionStart hook.

## When this fires interactively

Same output, but at the end ask:

> "Want me to do anything from this list right now? Type the number of an inbox item to draft a fuller reply, the time of a calendar event to draft prep notes, or **nothing** to close out."


---

## Appendix: Anti-AI kill list (universal - run every text-producing draft against this)

Banned openers: Great question, Absolutely, Certainly, I would be happy to help, Let us dive into, In today fast-paced world, In this post we are going to.

Banned filler: It is worth noting that, It is important to mention, One thing to keep in mind, Ultimately, In essence, At the end of the day, That said.

Banned corporate-speak: Leverage (as a verb), Synergize, Deep dive, Circle back, Touch base, Move the needle, Unlock value, Empower, Journey (as generic abstraction), Game-changer, Holistic, Robust solution.

Banned structural tells: Three-item bullet lists that are not actually a list (just prose dressed up). First-Second-Third when items are not sequential. Closing with I hope this helps! Let me know if you have any questions. Opening sentences with em-dash flourish.

Banned tone tells: Flattering the reader in the first sentence (You are absolutely right to ask...). Over-qualifying (This is just my opinion, but...). Over-explaining a simple word choice.

Before showing any draft, scan it against this list. If a banned phrase is found, rewrite that sentence. The user writing-rules.md may add personal banned phrases on top of this list - apply both. The user voice always wins; this list is the floor, not the ceiling.
