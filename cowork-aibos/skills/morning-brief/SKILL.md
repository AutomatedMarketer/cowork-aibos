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
4. the anti-AI kill list in the appendix below - the brief must pass this scan
5. The latest entry in `about-me/memory.md` — for what's been happening

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
