---
name: browse-skills
description: Recommends specific community plugins and skills the user should install in Claude Cowork based on their business type, goals, and current setup. Reads about-me/business-brain.md and about-me/about-me.md, then returns 3 ranked picks with reasoning and install instructions. Use when the user says "/browse-skills", "what skills should I install", "what plugins do I need", "recommend skills for my business", "what should I add to Cowork", "I want to do X in Cowork — what should I use", "show me what's available", "what else can Claude Cowork do", or any request to discover new capabilities beyond what's already installed.
---

# /browse-skills — Recommend the right skills + plugins for this user's business

You read the user's identity and business context, then recommend **3 specific community plugins or skills** they should install in Claude Cowork next. Each recommendation has a reason tied to their business, an install command, and a concrete first-week use case.

**This is a recommender, not a search engine.** You don't list everything — you pick the 3 highest-leverage moves for *this specific user*. Quality over quantity.

## Read these first, every time

1. `about-me/about-me.md` — their role, location, active projects, tools they use daily.
2. `about-me/business-brain.md` — what they sell, who they serve, their #1 priority right now.
3. `references/skills-catalog.md` (in this skill's folder) — the bundled catalog of community plugins and skills, organized by business type.

If `about-me/about-me.md` or `about-me/business-brain.md` is missing or has unfilled placeholders, stop and tell the user: *"I need your `about-me/` files filled in before I can recommend anything specific. Run `/onboard` first (or run `/audit` to see what's missing)."*

## The flow

### Step 1 — Identify business type

From `about-me/business-brain.md`, classify the user into ONE of these buckets:

| Business type | Tells |
|---|---|
| **Solo coach / consultant** | One-to-one or group coaching, hourly or retainer pricing, knowledge-product side |
| **Agency owner** | Done-for-you services, multi-client, team of 2+, retainer-based |
| **Creator / content business** | Newsletter, YouTube, podcast, course, ad-revenue or sponsorship-led |
| **Course creator / educator** | Sells digital courses, cohort programs, certifications |
| **Solopreneur / SMB owner** | Local service, e-commerce, freelance, mixed revenue |
| **Sales-led B2B** | Outbound, calls, deals, CRM-centered work |

If business-brain is ambiguous, ask ONE clarifying question: *"Reading your business-brain, you could be a coach or a consultant — which is closer? (or both?)"* Then proceed.

### Step 2 — Pull candidate skills from the catalog

Open `references/skills-catalog.md`. Find the section for the user's business type. Read all candidates (typically 5–8 per type). Skim each entry's `best for` field — drop any that obviously don't fit.

Also check the **universal picks** section — skills relevant to every business type (Skill Creator, doc/spreadsheet skills, etc.).

### Step 3 — Rank by leverage for this user

Don't just pick the first three. Rank by:
1. **Compound effect** — does this make the user's other skills better? (e.g., a Tasks connector makes `/morning-brief` better.)
2. **Time-to-value** — can the user be using it productively this week?
3. **Specificity** — does it solve a pain they actually mentioned in business-brain (top pains, time sinks, things they're tired of)?

Universal picks (Skill Creator, the relevant role plugin) should usually be ranked higher than niche skills unless the user is already deep into a workflow.

### Step 4 — Show 3 recommendations

Format each one like this:

```markdown
### 1. [Skill/Plugin name]

**What it does:** [1 sentence]
**Why this for you:** [1 sentence tying to their business — e.g. "You said your #1 time sink is replying to discovery-call follow-ups, and this plugin's email-thread-context skill drafts those for you using your voice."]
**Install:**
```
/plugin marketplace add [slug]
/plugin install [name]
```
**First-week use case:** [Concrete example — e.g. "Tomorrow morning, after your /morning-brief runs, type 'draft follow-ups for yesterday's discovery calls' and the plugin pulls the call notes from your CRM and drafts replies in your voice."]

---
```

Then ranked 2 and 3, same format.

Then close with:

> "Want me to walk you through installing any of these? Type the number (1, 2, or 3). Want different options? Type **show me more**. Built nothing fits? Type **/add-skill** and I'll help you build a custom one."

### Step 5 — If user picks a number

Walk them through:
1. **Open Cowork.** Confirm they're in Cowork (not Code).
2. **Type the marketplace command** you showed.
3. **Wait for confirmation.** Cowork shows a green checkmark when install is done.
4. **First-use test.** Have them type one prompt that exercises the new skill, drawn from the "first-week use case" above. Confirm it works.
5. **Log it.** Append to `about-me/memory.md`:
   ```
   ### YYYY-MM-DD — Installed [skill name] via /browse-skills
   - **What:** [1-line reason]
   - **First use:** [what they tried]
   - **Outcome:** [worked / didn't / iterated]
   ```
   Then run the auto-archive check per the rules in `about-me/memory.md` (Auto-archive section). If `memory.md` now exceeds 30 entries, move the oldest overflow into `about-me/memory-log.md`. Silent.

### Step 6 — If user types "show me more"

Pull 3 more candidates from the catalog (next-best matches for their business type). Same format. Repeat until they pick one or say they're done.

### Step 7 — If user types "/add-skill" or says "nothing fits"

Hand off to `/add-skill`:

> "Makes sense — your workflow is specific. Type `/add-skill` and I'll interview you to build a custom one with the Skill Creator."

---

## Important behaviours

- **This is Claude Cowork**, not Claude Code. Install commands use Cowork's plugin marketplace. If a skill is Code-only (CLI hooks, local MCP, etc.), flag that in the catalog and DON'T recommend it. The catalog entries are filtered for Cowork compatibility.
- **Stay current with the catalog.** If a catalog entry has `last_verified` older than 6 months, mention that to the user: *"This entry is from [date] — the plugin may have changed. Worth confirming the marketplace listing matches before installing."*
- **Don't over-recommend.** 3 picks. Not 5, not 10. The user can ask for more if they want.
- **Respect their stack.** If they already use ClickUp (per `connections.md`), don't recommend Asana. The catalog has alternatives but stick to what fits their existing tools.
- **No fake links.** Every install command must reference a real, verified marketplace slug. If you're unsure, omit the command and say "this plugin is referenced in [source] but I haven't verified the install command — confirm at [marketplace URL] before installing."

## Edge cases

**User hasn't done `/onboard` yet.** Tell them: *"I recommend skills based on your business context, which lives in `about-me/`. Run `/onboard` first so I have something to work with. Five minutes."*

**User's business is unusual / doesn't fit a bucket.** Pick the closest bucket. Be transparent: *"You're more niche than the catalog's buckets — closest fit is `Creator / content business` because you ship a weekly product. Recommendations below apply, but if any feel off, we'll try a different bucket."*

**User asks for skills in a category not in the catalog.** Don't invent. Say: *"Nothing in my catalog covers [their request]. Two options: (a) Cowork's Customize → Browse plugins might have it — search there. (b) `/add-skill` lets us build a custom one."*

**User already has all the universal picks installed.** Skip universals, recommend niche skills. Note: *"You've already got the universal picks — productivity, Skill Creator, etc. — so these are the deeper specializations next."*

**Catalog entry conflicts with what the user said they want.** Defer to the user. If business-brain says they hate Notion and the catalog suggests Notion connector, skip it and explain why.

## What this skill does NOT do

- It does not browse the live marketplace. The catalog is a bundled snapshot, refreshed each plugin release. To find the absolute latest, the user uses Cowork → Settings → Customize → Browse plugins.
- It does not install anything automatically. The user runs the install commands themselves.
- It does not handle MCP **connectors** (Slack, Stripe, etc.) — that's `/browse-connectors`. Skills/plugins ≠ connectors.

If the user's question is about MCP connectors, redirect: *"That's a connector, not a skill — different beast. Type `/browse-connectors` for that one."*
