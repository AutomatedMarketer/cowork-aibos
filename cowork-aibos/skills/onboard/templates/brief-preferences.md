# brief-preferences.md — Your Morning Brief Preferences

Lives in `projects/daily-brief/brief-preferences.md`. The `/morning-brief` skill reads this before writing anything.

Replace every `~~placeholder` with your answer. Look at `samples/brief-preferences-sample.md` if you want to see what a filled-out version looks like.

---

## When the brief fires

- **Weekday time:** ~~weekday_time local time (~~your_timezone)
- **Weekends:** ~~fires_or_skips_and_when
- **When the laptop is off:** the brief waits. First boot-up of the morning regenerates it.

---

## Inbox rules

### Senders who ALWAYS matter

- ~~always_matter_pattern_1
- ~~always_matter_pattern_2
- ~~always_matter_pattern_3
- **Explicit always-matter list:** ~~explicit_emails_or_domains

### Senders who NEVER matter

- Automated newsletters, receipts, calendar invites, shipping notifications.
- **Explicit never-matter list:** ~~never_matter_patterns

### How many emails to include

- Pull up to **~~max_urgent (3-5 recommended) urgent** emails per morning. If there are more, pick the most urgent and note that others are waiting.
- **Ignore** anything older than 48 hours unless it's from an always-matter sender.

---

## Calendar rules

- **Window:** show everything for today, plus the first event of tomorrow if tomorrow is before 10 a.m.
- **Details to include per event:** title, time, duration, attendees (names not emails), and a one-line prep note pulled from past emails or a meeting-brief file in `projects/`.
- **Events to skip:** ~~skip_rules

---

## Priority line

- At the top of the brief, Claude writes **one sentence** naming the single most important thing for the day.
- Style: direct and specific. Never generic.

---

## Draft replies

- Draft replies to urgent emails where the reply is **obvious** (confirmations, quick answers, short acknowledgements).
- **Never** draft replies to: ~~never_draft_categories
- All drafts land in **Gmail Drafts**. Never sent automatically.

---

## Format preferences

- **File location:** `outputs/daily-brief/YYYY-MM-DD-brief.md`
- **Length target:** ~~length_target_words words. If you can't read it in 60 seconds, it's too long.
- **Style:** ~~style_notes
- **Opening line:** the priority sentence — no "Good morning!" preamble.

---

## What to archive

- Yesterday's brief gets moved to `outputs/daily-brief/archive/` before today's brief writes.
- Anything older than 30 days gets deleted from the archive on the 1st of the month.
