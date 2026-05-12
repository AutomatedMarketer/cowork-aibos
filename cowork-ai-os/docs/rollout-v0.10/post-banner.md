# Rollout — v0.10 announcement copy

**Audience:** Course community + course portal Project 01 banner.
**Tone:** Feature release (additive, exciting), not corrective. No "my bad" framing — v0.9 was the corrective release.
**Send timing:** Day v0.10.0 is tagged on GitHub.

---

## Version A — Course portal banner (top of Project 01)

> **🚀 Cowork AI OS v0.10 shipped — the discovery layer.**
>
> Two new skills: `/browse-skills` recommends community plugins for your specific business. `/browse-connectors` identifies which MCP buckets are empty and suggests safe-by-default connectors to fill them. Both read your `about-me/business-brain.md` and return ranked picks with reasoning + install instructions.
>
> Already installed? Type `/plugin update cowork-ai-os`. Two-minute upgrade. Then try `/browse-skills` or `/browse-connectors`.
>
> [What's new →](link-to-changelog) | [Skills catalog →](link-to-skills-overview) | [Connectors catalog →](link-to-connectors-overview)

---

## Version B — Community pinned message

> **v0.10 of Cowork AI OS is live — the discovery layer.**
>
> The personal AI OS now helps you find the right OTHER skills + connectors for your business.
>
> **Two new commands:**
> - `/browse-skills` — reads your business-brain, recommends 3 specific community plugins with reasoning + install commands.
> - `/browse-connectors` — looks at your 7-bucket setup, identifies empty buckets, recommends MCPs with safe permission defaults baked in.
>
> Plus sharpening on the existing skills:
> - `/level-up` now hands off to `/browse-skills` or `/browse-connectors` when the highest-leverage gap is a marketplace install.
> - `/onboard` Phase 5 (connectors) personalizes recommendations from your just-built business-brain.
> - `/onboard` Phase 7 (skills tour) recommends 1–2 community plugins specific to your business at the end of onboarding.
>
> Upgrade: `/plugin update cowork-ai-os`. Then try `/browse-skills` to see what's recommended for you.
>
> Full release notes on GitHub.
>
> — Nuno

---

## Version C — Optional social / blog post

Use sparingly — this is a feature release more than a "lesson learned" story. Only post if Nuno wants to share the architectural thinking publicly.

> Shipped v0.10 of Cowork AI OS today.
>
> The big v0.10 question wasn't "is it fast" (v0.9 fixed that) — it was "is it actually best-in-class?" After researching what successful Claude plugins do well, the gap was discovery: cowork-ai-os onboarded users and tuned itself, but didn't help users find the OTHER skills and MCP connectors that would compound the personal-AI-OS effect.
>
> v0.10 adds a discovery layer:
>
> - `/browse-skills` reads your business-brain and returns 3 ranked plugin recommendations with reasoning.
> - `/browse-connectors` identifies which of the 7 Connection buckets are empty and recommends MCPs with safe permission defaults.
>
> Plus sharpening on `/level-up` and `/onboard` to use the recommenders automatically.
>
> The catalogs are bundled markdown — no remote MCP hosting, no API ops. Refreshed each plugin release. PRs welcome for new entries.
>
> Architectural principle from the research that informed this: **specialize the recommendation logic, not the bundle.** Some plugins win by being focused. cowork-ai-os wins by being a broad personal AI OS — but the discovery layer needed to know how to recommend in a way tied to the user's specific business, not generic.
>
> Total per-prompt overhead at cold start: ~1,820 tokens of skill metadata + ~300 tokens of slim handbook = ~2,120 tokens. Down from ~11,000 in v0.8.
>
> [github.com/AutomatedMarketer/cowork-ai-os](https://github.com/AutomatedMarketer/cowork-ai-os)
