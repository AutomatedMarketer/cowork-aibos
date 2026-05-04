# brief-preferences.md — Your Morning Brief Preferences

This file lives in `projects/daily-brief/brief-preferences.md`. The `/morning-brief` skill reads it before writing anything. It's how you teach Claude what *your* useful morning looks like.

Replace `{{placeholders}}` with your answers.

---

## When the brief fires

- **Weekday time:** {{e.g. 7:00 a.m.}} local time ({{YOUR_TIMEZONE}}).
- **Weekends:** {{FIRES or SKIPS — and if fires, at what time}}.
- **When the laptop is off:** the brief waits. First boot-up of the morning regenerates it.

---

## Inbox rules

### Senders who ALWAYS matter
- {{e.g. Any email from a current paying client — see list below}}
- {{e.g. Replies to quotes I sent in the last 7 days}}
- {{e.g. Mentions from press / partners}}
- **Explicit always-matter list:** {{name@domain.com, name@domain.com, …}}

### Senders who NEVER matter
- Automated newsletters, receipts, calendar invites, shipping notifications.
- **Explicit never-matter list:** {{newsletter@, notifications@, noreply@, …}}

### How many emails to include
- Pull up to **{{3–5}} urgent** emails per morning. If there are more, pick the most urgent and note that others are waiting.
- **Ignore** anything older than 48 hours unless it's from an always-matter sender.

---

## Calendar rules

- **Window:** show everything for today, plus the first event of tomorrow if tomorrow is before 10 a.m.
- **Details to include per event:**
  - Title, time, duration.
  - Attendees (just names, not emails).
  - A one-line **prep note** — pulled from past emails with the attendee, or a meeting-brief file in `projects/` if one exists.
- **Events to skip:** personal items tagged {{TAG}}, all-day events without a description.

---

## Priority line

- At the top of the brief, Claude writes **one sentence** naming the single most important thing for the day, based on inbox + calendar combined.
- Style: direct and specific. "Close the contractor scope reply before the 10 a.m." — not "stay on top of priorities".

---

## Draft replies

- Draft replies to urgent emails where the reply is **obvious** (confirmations, quick answers, short acknowledgements).
- **Never** draft replies to: {{e.g. anything involving pricing, contracts, apologies, or emotional content}}.
- All drafts land in **Gmail Drafts**. Never sent automatically.

---

## Format preferences

- **File location:** `outputs/daily-brief/YYYY-MM-DD-brief.md` (dated filename so old briefs survive).
- **Length target:** {{150–300}} words. If I can't read it in 60 seconds, it's too long.
- **Style:** short sentences. No headers-within-headers. No emoji.
- **Opening line:** the priority sentence — no "Good morning!" preamble.

---

## What to archive

- Yesterday's brief gets moved to `outputs/daily-brief/archive/` before today's brief writes.
- Anything older than 30 days gets deleted from the archive on the 1st of the month.
