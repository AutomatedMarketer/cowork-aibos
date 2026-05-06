---
name: brief-source-comms
description: Pulls team-comms data (channels, DMs, mentions) for the daily brief from whichever messaging platform(s) the user has connected — Slack, Discord, Telegram, Microsoft Teams, or others. Triggered by the morning-brief skill when brief-preferences.md has Q4 (team comms rules) populated. Reads per-platform rules from Q4, queries each connected platform for the last 24h, filters per rules, returns a unified formatted "Team comms" section. Read-only on every platform — never posts, never reacts, never modifies. Activated by /onboard-daily-brief Phase 3.
---

# Brief Source — Team Comms

You are a helper skill called by `/morning-brief` when the user's `projects/daily-brief/brief-preferences.md` has Q4 rules populated. You pull team-comms data from whichever messaging platforms the user has connected, filter per rules, and return a unified "Team comms" section the morning-brief skill inserts between Urgent Inbox and Quick Wins.

This skill is **platform-agnostic**. The user might be on Slack, Discord, Telegram, Microsoft Teams, or some combination. You handle each platform with the right tools, and the brief sees one unified section.

---

## Hard rule — read-only on every platform

You may invoke read tools only. The exact tool names depend on which MCP connector(s) the user has installed, but the pattern is the same across platforms:

**Slack** — typical read tools: `slack_search_channels`, `slack_read_channel`, `slack_search_users`, `slack_read_thread`, `slack_read_user_profile`.

**Discord** — typical read tools: list servers, read channels, search messages, read DMs.

**Telegram** — typical read tools: list chats, read messages from a chat or group.

**Microsoft Teams** — typical read tools: list teams, read channels, read chat messages.

You may NEVER invoke write tools on any platform. This includes:
- Sending messages, drafts, or scheduled messages
- Creating, updating, or deleting channels, threads, canvases, or any resource
- Posting reactions, replies, or any change of state
- Forwarding, sharing, or cross-posting

If a write tool is somehow available on any platform, refuse to use it. If the user asks you to post on their behalf, refuse — that's outside the scope of this skill.

---

## How to run

### Step 1 — Read the rules

Read `projects/daily-brief/brief-preferences.md`. Extract Q4. The user's Q4 is structured per-platform — they only fill in the platforms they actually use:

```
## Q4 — Team comms rules

### Slack (if you use it)
- Channels to monitor: ...
- DM treatment: surface / filter / count-only

### Discord (if you use it)
- Servers/channels to monitor: ...
- DM treatment: ...

### Telegram (if you use it)
- Chats to monitor: ...
- Group rules: ...

### Microsoft Teams (if you use it)
- Teams/channels to monitor: ...
- Chat treatment: ...
```

If Q4 is empty (no platform sections filled in), return an empty section with this note: `(No team comms rules in brief-preferences.md — run /onboard-daily-brief to add them.)`

### Step 2 — Detect which platforms have connectors live

For each platform with rules in Q4, check whether the corresponding MCP connector is available in this Cowork session:

- **Slack rules present?** → check for Slack tools availability
- **Discord rules present?** → check for Discord tools availability
- **Telegram rules present?** → check for Telegram tools availability
- **Microsoft Teams rules present?** → check for Teams tools availability

For each platform where the user filled in Q4 rules but the connector is NOT live, add a note line in the output:

```
- _Discord rules in Q4 but Discord connector not connected — Settings → Customize → Connectors_
```

For platforms with no Q4 rules, skip silently. The user doesn't use them.

### Step 3 — Calculate the time window

Pull from the last 24 hours from the current time. If the brief is firing at 7 AM Tuesday, pull 7 AM Monday → 7 AM Tuesday.

### Step 4 — Query each live platform per Q4 rules

For each live platform with Q4 rules:

1. Pull unread messages and @mentions in the time window from the channels/servers/chats listed in that platform's section
2. Apply the platform's DM/chat treatment rules (surface / filter / count-only)
3. Cap at 5 items per channel maximum (longest channels get truncated with `... +N more in <channel>`)
4. Apply any platform-specific filtering (bot accounts, ex-team members, etc.)

### Step 5 — Format a unified section

Combine results from all platforms into ONE "Team comms" section. Tag each item with a short `[Platform]` prefix so the user knows where each item came from:

```
## Team comms
- **[Slack #acme-team]** — <message snippet, max 80 chars> — <sender first name>, <relative time>
- **[Slack #urgent]** — @<sender first name> mentioned you: <snippet>
- **[Slack DM Lisa]** — "<snippet>"
- **[Discord #vci-cohort]** — student question about MCP setup — <sender>, <time>
- **[Telegram @TraderBob]** — quick Q on signal entry
- **[Teams #retainer-clients]** — Jenny shared updated brand guide
- _<N> other DMs/messages unread (filtered)_
```

Rules:
- Max 8 items in the entire section across all platforms combined. If more, truncate with `... +N more items` line at the end. Sort priority: explicit @mentions of the user first, then DMs from "surface" people, then channel items.
- Sender names: first name only (consistent with morning-brief's calendar attendee convention).
- Snippets: 80 character maximum, append `…` if truncated.
- Order within section: explicit @mentions and "surface" DMs float to the top regardless of platform; everything else chronological (oldest first).
- If section is empty (nothing in last 24h matching rules across all live platforms), return:
  ```
  ## Team comms
  _(no unread items in monitored channels across <platforms>)_
  ```

### Step 6 — Apply voice / kill list

Run any text you've written (status notes, snippets you've truncated, etc.) against the anti-AI kill list defined in `skills/morning-brief/SKILL.md` appendix. The morning-brief is the source of truth for voice rules — don't duplicate them here.

This applies only to text YOU write. Do not edit the actual messages from any platform — those are quoted as-is, just truncated.

### Step 7 — Log

Append to `projects/daily-brief/memory.md` (the P02 calibration log, not `about-me/memory.md`):

```
- <ISO timestamp> — Team comms pulled. Platforms: <Slack:5, Discord:2>. <total channel items>, <total DMs surfaced>, <bots filtered>, <other DMs counted>.
```

If `projects/daily-brief/memory.md` doesn't exist, skip the log step. The user hasn't run `/onboard-daily-brief` Phase 0 yet (or the file got deleted). Don't create it.

### Step 8 — Return

Return the formatted Team comms section as a string. The morning-brief skill handles insertion into the brief.

---

## Failure modes

### A connector listed in Q4 isn't authenticated

Append within the section:
```
- _<Platform> rules in Q4 but <Platform> connector not connected — Settings → Customize → Connectors_
```
Continue with the other live platforms.

### Channel/server name in Q4 doesn't exist

Skip that channel. Note in `projects/daily-brief/memory.md`:
```
<Platform> channel '<name>' not found — check spelling in brief-preferences.md Q4.
```

### Rate limit hit on a platform

Return what was pulled successfully from that platform. Append within the section:
```
- _<Platform> rate limit hit — partial results._
```
Continue with the other live platforms.

### Q4 rules malformed (can't parse)

Return:
```
## Team comms
_(Q4 rules in brief-preferences.md couldn't be parsed — re-run /onboard-daily-brief Phase 3 to fix)_
```

### No Q4 platform sections filled in

Return:
```
## Team comms
_(No team comms rules in brief-preferences.md — run /onboard-daily-brief Phase 3 to add Slack, Discord, Telegram, or Teams)_
```

---

## What this skill does NOT do

- Does not summarize threads (just surfaces snippets)
- Does not draft replies or messages on any platform
- Does not modify data on any platform
- Does not run on its own — only invoked by morning-brief
- Does not re-read brief-preferences.md mid-run (load once, use)
- Does not duplicate the anti-AI kill list (defers to morning-brief's appendix)
- Does not auto-install missing MCP connectors — the user installs them themselves through Settings → Customize → Connectors

---

## Adding a new platform later

If a new MCP connector ships (e.g., WhatsApp, Signal, IRC, Matrix), add a new platform section to Q4 in `brief-preferences.md`. This skill handles arbitrary platforms as long as:

1. The MCP exposes read-only tools (channel listing, message reading, user lookup)
2. The user's Q4 has rules for that platform
3. The connector is authenticated in their Cowork session

No code change to this skill needed — the section format is platform-agnostic. The platform name flows through the `[Platform]` tag in the output.
