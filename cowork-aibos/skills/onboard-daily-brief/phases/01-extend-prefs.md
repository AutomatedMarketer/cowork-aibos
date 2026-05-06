# Phase 1 — Extend Your Prefs

**Goal:** Append five new sections (Q4–Q8) to the existing `projects/daily-brief/brief-preferences.md` from P01. Don't touch the P01 sections that already work.

**Time:** ~25 minutes. Pillar: Sources + Filters.

---

## Important — what NOT to do

The user's `projects/daily-brief/brief-preferences.md` already has these P01 sections filled in:

- When the brief fires
- Inbox rules (always matter / never matter / max count)
- Calendar rules
- Priority line
- Draft replies
- Format preferences
- What to archive

**Do not rewrite or reorder these.** They already work — Phase 2 is going to verify the brief still produces a clean baseline before we add new sources.

We are APPENDING new sections to the bottom of the file. The existing P01 sections stay exactly as the user wrote them.

---

## How to run this phase

Open `projects/daily-brief/brief-preferences.md`. Scroll to the bottom. Append a `---` divider, then ask 5 questions in order:

1. Q4 — Team comms rules
2. Q5 — Tasks (today.md) rules
3. Q6 — 90-day outcome (the ranking lens)
4. Q7 — Priority line tone refinement
5. Q8 — Stricter draft rules

For each question:

1. Ask using the exact framing in the script
2. Specific answer → write into `brief-preferences.md`, advance
3. Vague answer → use the *Stuck?* prompt to push for specifics
4. Still vague → offer to read Sarah's matching section from `samples/sarahs-prefs-additions.md`
5. Still stuck → offer to draft a starter from their `about-me/business-brain.md`

Never let a vague answer slide.

---

## What gets appended to the file

After Phase 1 completes, the user's `brief-preferences.md` will look like this:

```markdown
# brief-preferences.md — Your Morning Brief Preferences

[... existing P01 sections, untouched ...]

---

# Project 02 additions

## Q4 — Team comms rules
...

## Q5 — Tasks (today.md) rules
...

## Q6 — 90-day outcome (ranking lens)
...

## Q7 — Priority line tone refinement
...

## Q8 — Stricter draft rules
...
```

---

## The 5 questions

### Q4 — Team comms rules

> *"This is the platform-agnostic team comms section. You only fill in the platforms you actually use — Slack, Discord, Telegram, Microsoft Teams. For each platform you use, two lists. C1 — which channels/servers/chats should the brief monitor for unread messages and @mentions in the last 24h? C2 — how should DMs be treated? Three buckets per platform: surface (people you always want to hear from), filter (bots, ex-team), count-only (everyone else)."*

The user fills in only the platforms they use. Empty platforms get skipped — no need to write `(none)`.

**Specific (Slack example):**
```
### Slack
- Channels to monitor: #acme-team, #brightstack-build, #general, #urgent
- DM treatment:
  - Surface: Mike, Lisa, all current paying clients
  - Filter: Slackbot, GitHub, Linear, Loom
  - Count-only: everyone else
```

**Specific (Discord example, for a community-driven business):**
```
### Discord
- Servers/channels to monitor: VCI Cohort → #questions, #announcements; YouTube Community → #superfans
- DM treatment:
  - Surface: cohort co-instructors
  - Filter: MEE6, Wick (bot accounts)
  - Count-only: everyone else
```

**Specific (Telegram example, for an international/crypto-adjacent business):**
```
### Telegram
- Chats to monitor: Trading Signals (group), Founders Roundtable (group), 1:1s with Anna and TraderBob
- Group rules: surface @mentions only — group chatter is too noisy to count
```

**Too vague:** *"Anything unread"* on any platform — returns 100+ items in a busy workspace. Push for specifics.

**Stuck prompt:** *"List the user's connected messaging platforms. For each, list channels with unread counts in the last 24h. User picks which channels are signal."*

If a connector isn't live yet for a platform the user wants to use, capture answers anyway. Phase 3 wires up live connectors and detects which Q4 sections the user actually has the connector for.

---

### Q5 — Tasks (today.md) rules

> *"Your task list lives in `projects/daily-brief/today.md`. You maintain it — the brief reads it. How do you want to format it? When do you update it? What gets surfaced?"*

**Specific:** *"Update Sunday night for the week, tweak each morning. Markdown checklist. Today's tasks at top, parking lot for the rest of the week below. Surface only unchecked items under today's section, in order. Surface [QUICK WIN] and [OVERDUE] tags inline. Do not surface anything from the parking lot."*

**Too vague:** *"You decide what's important"* — defeats the point. The brief shouldn't depend on you talking to it.

**Stuck prompt:** *"Draft a starter `today.md` with 3 fake tasks for today and 5 for the week. User edits from there in Phase 4."*

We don't create `today.md` in this phase — that's Phase 4. Just capture the format preference.

---

### Q6 — 90-day outcome (ranking lens)

> *"What's the one business outcome you're measuring everything against for the next 90 days? This becomes the brief's ranking lens — when items compete for attention, the one closer to this outcome wins."*

**Specific:** *"Sign 3 new $4,997 retainer clients by August 1. Anything moving a prospect closer to signature outranks everything else."*

**Too vague:** *"Grow the business"* — not measurable, not time-bound.

**Stuck prompt:** *"Read user's `about-me/business-brain.md`. Pull out top 3 priorities. Help user pick the one to be the brief's ranking lens for the next 90 days."*

---

### Q7 — Priority line tone refinement

> *"P01 already has a priority line — one sentence at the top of the brief. P02 sharpens it. Should it reference one of the highlights below it? What tone — coach, chief of staff, blunt friend? Give me at least one example sentence that hits."*

**Specific:** *"Chief of staff tone. One sentence. Must reference a highlight. Direct, slightly blunt, no hedging. Example: 'Address scope creep with Jenny before the retainer talk.'"*

**Too vague:** *"Make it motivational"* — wrong job, wrong tool.

**Stuck prompt:** *"Show 3 versions of the same priority line — coach, chief-of-staff, blunt-friend. User picks which voice fits."*

This refines the existing P01 priority line. The morning-brief skill will use this Q7 spec when Q7 is present, falling back to the P01 default if not.

---

### Q8 — Stricter draft rules

> *"P01 already drafts replies — but only for 'obvious' ones. P02 makes the criteria explicit. Tell me: when should a draft happen? When should it NOT? What tone? What format?"*

**Specific (When to draft):**
*"Email is in B1 (always-matter list), asks a question or invites a meeting, hasn't been replied to in 24h. Max 3 drafts per brief."*

**Specific (When NOT to draft):**
*"Anything ambiguous about what I want to say. Anything requiring numbers/decisions only I can authorize. Anything needing more than 4 paragraphs. First-time outreach from unknown senders. Sensitive topics: legal, compensation, hiring/firing."*

**Specific (Tone):**
*"Use rules from `about-me/writing-rules.md`. Match the sender's energy."*

**Specific (Format):**
*"Plain text. Max 4 paragraphs. Sign-off matches writing-rules.md."*

**Too vague:** *"Whatever you think makes sense"* — defeats the point. Q8 exists to give morning-brief sharper criteria than the P01 default.

**Stuck prompt:** *"Read user's last 20 sent emails. Pull out 3 examples of replies that were 'obviously draftable' and 3 that needed full attention. Use those to write Q8 'When to draft' and 'When NOT to draft' rules."*

The existing morning-brief draft logic uses "if obvious" — Q8 replaces that with explicit, testable criteria.

---

## Verification

Open `projects/daily-brief/brief-preferences.md`. Confirm:

- [ ] Existing P01 sections are unchanged (didn't accidentally rewrite them)
- [ ] A `---` divider separates P01 sections from P02 additions
- [ ] Q4 has at least one platform section filled in with specific channel/server/chat names AND DM/group treatment rules
- [ ] Q5 has format, update timing, what surfaces, what doesn't
- [ ] Q6 has measurable AND time-bound outcome
- [ ] Q7 has tone + at least one example sentence that hits
- [ ] Q8 has explicit "when to draft" + "when NOT to draft" + tone + format

If anything's vague, go back. Don't pass Phase 1 with soft additions. Phase 2 verifies the brief reads everything correctly.

---

## State update

Append to `_aibos/state-daily-brief.md`:

```
- <ISO timestamp> — Phase 1 (Extend Your Prefs) complete. Q4–Q8 appended to brief-preferences.md.
```

Update:
- `Q4 Team comms rules: true`
- `Q5 Tasks rules: true`
- `Q6 90-day outcome: true`
- `Q7 Priority tone refinement: true`
- `Q8 Stricter draft rules: true`
- `current_phase: 2`

---

## Pause point

> *"Phase 1 complete. You're 17% through. Your `brief-preferences.md` now has Q4–Q8 appended. Phase 2 verifies the existing morning-brief still produces a clean baseline now that we've added the new sections — about 15 minutes. Type `continue onboarding` when ready, or `pause onboarding` to resume later."*

If user continues → load `phases/02-verify-baseline.md`.
