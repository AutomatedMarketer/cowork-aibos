# Phase 3 — Add Team Comms

**Goal:** Activate the `brief-source-comms` helper skill so the morning brief includes a Team comms section per Q4 rules. Works across Slack, Discord, Telegram, Microsoft Teams — whichever platforms the user has connected.

**Time:** ~15 minutes. Pillar: Sources.

**Why this phase exists:** Team comms are signal-rich, but most of it is noise. The Q4 rules from Phase 1 — per platform — decide if your comms section helps or hurts.

---

## Script — what to say

> *"Phase 3 adds team comms. The `brief-source-comms` helper skill shipped with cowork-ai-os v0.6.0 — it's already in your plugin folder. The morning-brief patch tells the brief to call this helper when Q4 is present in your prefs.*
>
> *This skill works across whatever messaging platform you actually use — Slack, Discord, Telegram, Microsoft Teams. The first thing we do is figure out which connectors you have live, then verify your Q4 rules match those platforms, then run the brief and tune."*

---

## Step 1 — Identify which platforms the user actually uses

Ask the user:

> *"Which messaging platforms run your work life? Check all that apply: Slack, Discord, Telegram, Microsoft Teams, other?"*

Capture the list. Cross-reference against Q4 in `projects/daily-brief/brief-preferences.md`:

- **User said they use a platform but Q4 has no section for it** → go back to Phase 1 and add that platform's Q4 section before continuing
- **User said they don't use a platform but Q4 has a section for it** → mark that section as "skip" or remove it, no point pulling from a platform they don't actually use
- **Q4 sections match user's actual platforms** → continue

---

## Step 2 — Verify connectors per platform

For each platform the user named, check Connectors:

> *"Open Settings → Customize → Connectors. Check each platform you use. Tell me which ones show as green/connected and which ones aren't connected yet."*

For each platform with Q4 rules:

**Connector live (green):**
- Confirm permissions are read-only. The exact permissions vary by platform but the principle is consistent: the helper skill must be able to list channels, read messages, look up users — and nothing else. Block any "send" / "post" / "write" / "modify" / "react" permission if the connector exposes them as separate toggles.

**Connector not live:**
- Walk user through enabling it (click **Connect** in Settings → Customize → Connectors → that platform → authorize on platform's OAuth screen).
- For each new permission listed, confirm only read scopes are enabled — block anything that mentions sending, posting, writing, or modifying.
- After connecting, return to Cowork and confirm green status.
- If the user can't connect (workspace admin required, MCP not yet available for the platform), pause this platform. They can:
  - Continue with the other platforms they have connected
  - Come back to this one later by re-running `/onboard-daily-brief` (the skill will pick up at this phase)
  - Remove the platform from Q4 if they're not going to use it

---

## Step 3 — Confirm helper skill is on disk

The `brief-source-comms` skill ships with cowork-ai-os v0.6.0+. Confirm by checking the user's plugin install path for `skills/brief-source-comms/SKILL.md`.

If missing → user is on an older plugin version. Send them back to Phase 0 verification:
- **Mac:** download latest `cowork-ai-os.zip`, re-upload via Settings → Customize → Browse plugins
- **Windows:** `/plugin update cowork-ai-os`

Don't proceed until the helper is installed.

---

## Step 4 — Run the brief

Have the user run `/morning-brief`.

The brief should now include a unified Team comms section between Urgent Inbox and Quick Wins. If the user has multiple platforms connected, items from each appear with a `[Platform]` tag prefix:

```
## Urgent inbox
1. **Jenny Park** — Move Q3 retainer convo to today's 10 AM? — _why it matters: ..._
2. ...

## Team comms
- **[Slack #acme-team]** — Mike flagged scope creep on landing page revisions — Mike, 9:42 PM yesterday
- **[Slack #urgent]** — @mention from Jenny: "can we move the 10 AM?" — Jenny, 7:03 AM today
- **[Slack DM Lisa]** — "approved the welcome sequence — looks great"
- **[Discord #vci-cohort]** — student question about MCP setup — Marco, 6:14 AM today
- _3 other DMs unread (filtered)_

## Quick wins
- ...
```

If the user only has one platform connected, the section still uses `[Platform]` tags for consistency — students who later add a second platform won't see a structural change in the brief.

---

## Step 5 — Diagnose the Team comms section

Ask, per platform with Q4 rules:

1. *"Does the section show real, unread messages from the last 24h on each platform you use?"*
2. *"Anything showing from channels NOT in your Q4 list for that platform?"*
3. *"Any DMs filtered that you'd actually want to see?"*
4. *"Any bot DMs (Slackbot, MEE6 on Discord, generic notification bots) leaking through?"*
5. *"Is the entire section short enough to read in 5 seconds, or is it overwhelming?"*

**Length test — if more than 8 items in Team comms section:** filters are too broad somewhere. Identify which platform's items dominate the section and tighten that platform's Q4 rules first.

**If items missing for a platform:** Channel/server name might be misspelled in Q4 for that platform. These are usually case-sensitive. Have user copy the exact name from the platform UI and paste into Q4.

**If bot DMs leaking through:** Add specific bot names to that platform's filter list in Q4.

**If a platform isn't pulling at all:** Check that the connector is still green in Settings (sometimes auth tokens expire). Re-authenticate if needed.

---

## Step 6 — Re-run after tuning

If user edited Q4 in Step 5, run `/morning-brief` again. Verify Team comms section is now clean.

Each run also appends to `projects/daily-brief/memory.md` (the P02 calibration log):

```
- <ISO timestamp> — Team comms pulled. Platforms: <Slack:5, Discord:2>. <total channel items>, <total DMs surfaced>, <bots filtered>, <other DMs counted>.
```

---

## Verification

Before marking Phase 3 complete:

- [ ] User has identified which platforms they actually use
- [ ] Each platform with Q4 rules has either a live connector OR is explicitly removed from Q4
- [ ] Live connectors are read-only (no send/post/write permissions enabled)
- [ ] `brief-source-comms` skill is on disk (plugin v0.6.0+)
- [ ] Q4 in `brief-preferences.md` has specific rules for each platform the user uses
- [ ] Brief now includes a unified Team comms section between Urgent Inbox and Quick Wins
- [ ] Section has 8 or fewer items total across all platforms
- [ ] No leaked channels, no bot DMs
- [ ] User can read the Team comms section in 5 seconds and act on it
- [ ] `projects/daily-brief/memory.md` got at least one Team comms pull entry

If section is noisy after 2 tuning rounds, pause. Don't keep spamming runs. Have user manually look at each platform's workspace, identify which channels are actually signal vs noise, and rewrite Q4 with that ground truth.

---

## State update

Append to `_aibos/state-daily-brief.md`:

```
- <ISO timestamp> — Phase 3 (Add Team Comms) complete. Platforms wired: <list>. <N> tuning iterations.
```

Set `brief-source-comms activated: true`. Update `current_phase: 4`.

---

## Pause point

> *"Phase 3 complete. You're 50% through. Halfway. Phase 4 wires in your task file — about 15 minutes. Type `continue onboarding` when ready, or `pause onboarding` to resume later."*

If user continues → load `phases/04-add-tasks.md`.
