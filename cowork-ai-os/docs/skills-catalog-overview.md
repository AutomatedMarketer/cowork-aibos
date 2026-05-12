# Skills catalog — public overview

This is the public-facing summary of what `/browse-skills` recommends inside Cowork AI OS. The full machine-readable catalog lives at [`cowork-ai-os/skills/browse-skills/references/skills-catalog.md`](../skills/browse-skills/references/skills-catalog.md).

Goal: every entry is **verified to work in Claude Cowork** (the web/desktop client). Code-only options are flagged but generally excluded — most users in the course are on Cowork, not the CLI.

---

## What gets recommended

`/browse-skills` reads your `about-me/business-brain.md` and `about-me/about-me.md`, classifies your business into one of 7 types, and returns 3 ranked recommendations.

Business types covered:
- Solo coach / consultant
- Agency owner
- Creator / content business
- Course creator / educator
- Solopreneur / SMB owner
- Sales-led B2B
- Plus a "Universal picks" section relevant to every business

Each recommendation includes:
- What it does (1 sentence)
- Why this for you (tied to your specific business context)
- Install command (Cowork marketplace path)
- First-week use case (a concrete prompt you can try once installed)
- Gotchas + anti-patterns (when NOT to install)
- Last-verified date

---

## What's in the initial catalog (v0.10.0)

**Universal picks** (recommended for almost every user):
- Cowork's built-in **Skill Creator** (enables `/add-skill`)
- Cowork's built-in **docx**, **pptx**, **canvas-design** skills
- Anthropic's **productivity** plugin

**Role-based plugins** (Anthropic-official):
- **marketing** — content drafting, repurposing, social posts, email sequences
- **customer-support** — client/customer reply drafts, FAQ generation
- **sales** — lead qualification, follow-up sequences, proposal drafting

**Notable flagged entry:**
- **claude-mem** — excellent memory plugin, but **Claude Code (CLI) only**. Not installable in Cowork. Flagged for Project 04+ advanced CLI users only.

---

## How the catalog stays current

- **Cadence:** each plugin release. v0.10.0 catalog is current as of 2026-05-12.
- **PRs welcome:** if you've connected a community skill that works in Cowork and isn't here, fork and submit a PR at https://github.com/AutomatedMarketer/cowork-ai-os.
- **Stale entries get flagged:** any entry with `last_verified` more than 6 months old triggers a warning in `/browse-skills` recommendations.

---

## Discovery beyond the catalog

The catalog is intentionally small (verified > exhaustive). For broader discovery:

- **Cowork's built-in browser:** Settings → Customize → Browse plugins. The official surface.
- **Anthropic skills marketplace** and the official `anthropics/skills` GitHub repo (open-source examples).
- **Community lists:** `awesome-claude-skills`, `VoltAgent/awesome-agent-skills`.
- **Build your own:** `/add-skill` — the bridge to Cowork's Skill Creator for anything no community skill covers.
