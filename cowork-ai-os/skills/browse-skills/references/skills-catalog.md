---
catalog_version: 2026-05-12
last_audited: 2026-05-12
audit_cadence: each plugin release
maintainer: Nuno Tavares
scope: Claude Cowork (web/desktop client) only — Claude Code-only items are excluded
---

# Skills + Plugins Catalog

A curated list of community plugins and skills that compound the value of Cowork AI OS, organized by user business type. Every entry verified to work in Claude Cowork as of `last_audited`. Read by `/browse-skills`.

If you find a new plugin or skill that should be in here, tell `/add-skill` to draft an entry and submit it as a PR to the cowork-ai-os repo.

---

## Universal picks (relevant to every business type)

These should usually be the first recommendations unless the user already has them.

### Skill Creator (Anthropic built-in)
- **slug:** built-in Cowork skill (enable via Settings → Customize)
- **what it does:** Interviews you about a workflow you want to automate, then builds a custom slash-command skill that does it.
- **best for:** Every business type. The single highest-leverage skill in the Cowork ecosystem.
- **install:** Already shipped with Cowork. Enable via **Settings → Customize → Toggle ON: Skill Creator.**
- **first-week use case:** Type `/add-skill` and have Claude build you a "/follow-up" skill that drafts follow-up emails based on yesterday's meetings.
- **gotchas:** Skills built via Skill Creator live in your account — they're not automatically shared with teammates.
- **anti-pattern:** Don't try to build a skill that just calls an existing Anthropic role plugin (productivity, sales, etc.). Install the plugin instead.
- **last verified:** 2026-05-12

### Anthropic productivity plugin
- **slug:** productivity (Anthropic official)
- **what it does:** Tasks, calendar, daily workflows. Anthropic's most universal role plugin.
- **best for:** Every business type. Especially solopreneurs, agency owners, course creators.
- **install:** `/plugin marketplace add anthropics/productivity` then `/plugin install productivity`
- **first-week use case:** After install, ask "what's my week look like?" — it pulls calendar + tasks across whatever Tasks-bucket connector you have.
- **gotchas:** Works best with at least one Tasks connector installed (ClickUp, Notion, etc.). Without one, you get only calendar capability.
- **anti-pattern:** Don't install if you have zero Tasks-bucket connectors yet — install a connector first via `/browse-connectors`.
- **last verified:** 2026-05-12

### docx, pptx, canvas-design (Anthropic built-ins)
- **slug:** built-in Cowork skills (enable via Settings → Customize)
- **what they do:** docx writes proper Word documents. pptx writes slide decks. canvas-design produces visual outputs (posters, infographics, diagrams).
- **best for:** Anyone who delivers documents, presentations, or visual content to clients/students/audience.
- **install:** Already shipped with Cowork. Enable via **Settings → Customize → Toggle ON: docx, pptx, canvas design.**
- **first-week use case:** Ask Claude to "write me a 5-page proposal for [client]" and it produces a real .docx file you can open in Word.
- **gotchas:** None significant.
- **anti-pattern:** None.
- **last verified:** 2026-05-12

---

## Solo coach / consultant

Picks for one-to-one or group coaches, knowledge-product side businesses, and consultants with retainer or hourly pricing.

### Anthropic marketing plugin
- **slug:** marketing (Anthropic official)
- **what it does:** Content drafting, repurposing, social posts, email sequences.
- **best for:** Coaches with a content/audience-building side. Consultants doing thought-leadership.
- **install:** `/plugin marketplace add anthropics/marketing` then `/plugin install marketing`
- **first-week use case:** Paste a long-form transcript or essay → ask for "5 LinkedIn posts in my voice from this." Combines with your voice-writer skill.
- **gotchas:** Voice quality depends on your `writing-rules.md` (Project 01 Lesson 3). If that's thin, output is generic.
- **anti-pattern:** If your business is service-delivery-first (not audience-first), prioritise productivity instead.
- **last verified:** 2026-05-12

### Anthropic customer-support plugin
- **slug:** customer-support (Anthropic official)
- **what it does:** Drafts replies to client questions, FAQ generation, support-thread summarization.
- **best for:** Coaches with active client communities or many email replies to clients.
- **install:** `/plugin marketplace add anthropics/customer-support` then `/plugin install customer-support`
- **first-week use case:** Forward a stuck client thread → ask for a draft reply that addresses the question + acknowledges the emotional context.
- **gotchas:** Drafts go to Gmail Drafts only (per your safety rules). You always review before sending.
- **anti-pattern:** If you don't reply to clients via email frequently (e.g. all via DMs), the value is lower.
- **last verified:** 2026-05-12

---

## Agency owner

Picks for done-for-you services, multi-client work, retainer-based businesses with a team of 2+.

### Anthropic productivity plugin
- (See universal picks — highest-leverage for agency operations.)

### Anthropic sales plugin
- **slug:** sales (Anthropic official)
- **what it does:** Lead qualification, follow-up sequences, proposal drafting, deal-stage summaries.
- **best for:** Agencies with an outbound or proposal-heavy sales motion.
- **install:** `/plugin marketplace add anthropics/sales` then `/plugin install sales`
- **first-week use case:** Connect your CRM (HubSpot/GoHighLevel/Salesforce — see `/browse-connectors`), ask "which deals need touching this week?" Returns a ranked list with suggested next actions.
- **gotchas:** Needs a CRM connector to be useful — install one first via `/browse-connectors`.
- **anti-pattern:** Don't install if you don't have an outbound or proposal-driven sales process. The plugin assumes a pipeline.
- **last verified:** 2026-05-12

### Anthropic customer-support plugin
- (See coach section — also high-leverage for agency client-services workflows.)

---

## Creator / content business

Picks for newsletter writers, YouTubers, podcasters, content creators with ad-revenue or sponsorship models.

### Anthropic marketing plugin
- (See coach section — first-tier pick for creators.)

### claude-mem (CLI users only — flagged)
- **slug:** thedotmack/claude-mem
- **what it does:** Persistent memory across sessions in Claude Code. Captures observations, compresses with AI, recalls relevant context.
- **best for:** Creators who do heavy research/writing across many sessions and want long-term memory.
- **install:** **Requires Claude Code (CLI), not Cowork.** `npx claude-mem install`
- **first-week use case:** Use after a research session — memory carries across to next session without re-explaining context.
- **gotchas:** **CLI-only.** Requires Bun, Python uv, SQLite. Won't work in Cowork web. For Project 04+ advanced users only.
- **anti-pattern:** Don't install for Cowork-only users. Skip.
- **last verified:** 2026-05-12

---

## Course creator / educator

Picks for digital course sellers, cohort program operators, certification businesses.

### Anthropic marketing plugin
- (See coach section — course launches are content launches.)

### Anthropic productivity plugin
- (See universal picks — managing cohort schedules + student tasks.)

### Anthropic customer-support plugin
- (See coach section — student support volume scales with course size.)

---

## Solopreneur / SMB owner

Picks for local services, e-commerce, freelance, mixed-revenue businesses.

### Anthropic productivity plugin
- (See universal picks — top priority.)

### Anthropic customer-support plugin
- (See coach section — handles customer email volume.)

### Anthropic sales plugin
- (See agency section — if there's outbound or proposal work involved.)

---

## Sales-led B2B

Picks for outbound-heavy, deal-driven, CRM-centered businesses.

### Anthropic sales plugin
- (See agency section — top priority.)

### Anthropic customer-support plugin
- (See coach section — handles existing-customer expansion.)

### Anthropic productivity plugin
- (See universal picks — managing call schedules + follow-up cadence.)

---

## How to add a new entry

If you find a community skill that belongs here:
1. Verify it works in Claude Cowork (not Code-only).
2. Fill in all fields per the schema at the top of this file.
3. Set `last_verified` to today's date.
4. Submit a PR to https://github.com/AutomatedMarketer/cowork-ai-os against `cowork-ai-os/skills/browse-skills/references/skills-catalog.md`.

If you found a Claude Code (CLI) skill that's awesome but doesn't work in Cowork, flag it with **CLI-only** and note it under the relevant business type. `/browse-skills` will warn the user before recommending.

---

## Discovery beyond this catalog

This catalog is hand-curated and intentionally small (verified > exhaustive). For everything else:

- **Cowork's built-in browser:** Settings → Customize → Browse plugins. The official surface for finding new plugins.
- **Anthropic skills marketplace:** https://platform.claude.com (and the official anthropics/skills GitHub repo for open-source examples).
- **Community lists:** awesome-claude-skills (https://github.com/travisvn/awesome-claude-skills), VoltAgent/awesome-agent-skills.
- **Build your own:** `/add-skill` walks you through building a custom skill via Cowork's Skill Creator. For workflows nothing else covers.
