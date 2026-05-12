# Cowork AI OS — your AI operating system inside Claude Cowork

> *Most AI templates ship 30 skills you can't relate to. Cowork AI OS ships 7 skills every business needs, and teaches you to build the next 30 yourself — for your business, in your voice, on your terms.*

**Built by Nuno Tavares · Automated Marketer · VCInc**

---

## What this is

Cowork AI OS is a Claude Cowork plugin. It turns Cowork into your AI business operating system in about 90 minutes. After install, your AI teammate:

- **Knows who you are** — what you sell, who you serve, how you talk
- **Reads your tools safely** — email, calendar, plus whatever else you connect
- **Drafts in your voice** — with a built-in anti-AI kill list so nothing sounds generic
- **Writes you a daily brief** — every morning, on a timer
- **Improves itself every week** — one specific change per Friday, with your approval
- **Teaches you to build your own skills** — for the parts of your business no one else's plugin covers

That's the foundation. From there, you layer Anthropic's role plugins (productivity, sales, marketing, etc.) and your own custom skills on top.

---

## Install (two commands, 30 seconds)

In Cowork (Claude Desktop), open a new task and type:

```
/plugin marketplace add automatedmarketer/cowork-ai-os
```

Then:

```
/plugin install cowork-ai-os
```

That's it. Cowork AI OS is now installed.

To start the install walkthrough, type:

```
start onboarding
```

---

## What's bundled

10 core skills:

| Slash command | Plain English | What it does |
|---|---|---|
| `/onboard` | "start onboarding" | The 9-phase install. Resumable from any phase. |
| `/audit` | "check my system" | 4 C's audit. Score 0-100. Top 3 gaps. |
| `/level-up` | "what should I improve next" | 5 questions → one specific recommendation across 6 forms (refine context, add connector, install skill, build skill, schedule routine) |
| `/tune-up` | "weekly tune-up" | The 5-gate self-improvement loop |
| `/morning-brief` | "morning brief" | Calendar + inbox + priorities, every morning |
| `/voice-writer` | "write this in my voice" | Drafts anything using `writing-rules.md` |
| `/add-skill` | "build me a new skill" | Hands off to Cowork's Skill Creator with a spec |
| `/optimize` | "Cowork is slow" | Diagnoses workspace bloat (old handbook directive, memory overflow) and fixes it. Use any time per-prompt latency creeps up. **v0.9.** |
| `/browse-skills` | "what skills should I install" | Reads your business-brain, recommends 3 community plugins with reasoning + install. **New in v0.10.** |
| `/browse-connectors` | "what connectors do I need" | Identifies empty buckets, recommends MCP connectors with safe permission defaults. **New in v0.10.** |

Plus three operational skills layered on top: `/tidy-downloads` (plan-then-approve file organization), `/onboard-daily-brief` (Project 02 add-on), `/onboard-file-organization` (Project 03 add-on), and the `brief-source-comms` helper for team comms (Slack/Discord/Telegram/Teams).

Plus 7 templates (handbook, about-me, business-brain, writing-rules, memory, connections, audit-log), 9 onboarding phase files, and reference appendices for the 4 C's framework, anti-AI kill list, and complementary plugins.

---

## First run (30–90 minutes)

In Cowork, type `start onboarding`.

You'll go through 9 phases, conversationally:

1. **Handbook** — your global instructions (~10 min)
2. **About-me file** — who you are (~15 min)
3. **Business brain** — what you sell, who you serve (~15 min)
4. **Voice + memory files** — how you write + session log (~20 min)
5. **Gmail + Calendar connectors** — safe permissions (~15 min)
6. **Folder system** — workspace structure (~5 min)
7. **Skills tour + plugin install** — turn on the four built-in Cowork skills Cowork AI OS depends on (Skill Creator, docx, pptx, canvas design), then see every Cowork AI OS skill with a tiny demo (~20 min)
8. **Daily brief on a schedule** — morning brief + weekly tune-up (~15 min)
9. **Integrated verification + upkeep** — end-to-end test + baseline audit (~15 min)

You can pause anytime. Resume by saying "continue onboarding."

### Built-in Cowork skills you'll be turning ON during Phase 7

These ship with Cowork but are OFF by default. Cowork AI OS turns them on in Phase 5 of `/onboard`:

- **Skill Creator** — required. `/add-skill` hands off to it.
- **docx** — for proper Word document outputs.
- **pptx** — for slide decks.
- **canvas design** — for visual outputs (posters, infographics, diagrams).

---

## After onboarding

You're done. Cowork AI OS will:

- Generate your morning brief every morning at the time you picked
- Run the weekly tune-up every week at the time you picked, walking you through one specific improvement
- Apply your voice rules to anything it drafts
- Load your identity files (`about-me/`) **on demand** — skills that need them read them when they fire, not on every prompt (v0.9)
- Recommend new community skills and MCP connectors over time, personalized to your business (v0.10 — run `/browse-skills` and `/browse-connectors` any time)

Look at `about-me/audit-log.md` once a month to watch your score climb. If Cowork ever starts feeling slow on startup, type `/optimize` and follow the prompts.

---

## What's NOT in Cowork AI OS (and where to get it)

Cowork AI OS is the foundation. It does NOT include:

- Sales workflows → install Anthropic's `sales` plugin
- Marketing workflows → `marketing` plugin
- Project management → `productivity` plugin
- Customer support → `customer-support` plugin
- Design workflows → `design` plugin
- Legal, finance, data, etc. → see Anthropic's plugin marketplace

For workflows specific to *your* business that no plugin covers — your client onboarding, your specific lead qualification, your weekly internal report — use `/add-skill` to build it yourself with Cowork's Skill Creator.

---

## Updates

When a new version ships, type in Cowork:

```
/plugin update cowork-ai-os
```

Your `about-me/`, `outputs/`, and `_aibos/state.md` survive — they're in your workspace, not the plugin folder.

---

## License

MIT — see `LICENSE`.

---

## Support

This is an early release. Issues, suggestions, weird behavior — file at `github.com/automatedmarketer/cowork-ai-os/issues` or DM `@imnunotavares`.
