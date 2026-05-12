# Post / banner — v0.9 release

**Use case:** Top-of-page banner on Project 01 lesson, pinned message in course community channel, social media post if Nuno wants it public.

---

## Version A — Course portal banner (top of Project 01)

> **🚀 Cowork AI OS v0.9 shipped — speed fix is live.**
>
> If Cowork has felt slow on startup since you installed, this fixes it. Run `/plugin update cowork-ai-os` then `/optimize` inside Cowork. Two minutes. Identity files preserved.
>
> [Step-by-step SOP →](link-to-google-drive-sop)
> [What changed and why →](link-to-architecture-v0.9-md)

---

## Version B — Community pinned message

> **v0.9 of Cowork AI OS is live — the speed fix.**
>
> If "Start Up" was taking 20+ seconds for you, that was a bug in v0.8. My bad. v0.9 drops it to under 3 seconds.
>
> Upgrade path (2 mins):
> 1. `/plugin update cowork-ai-os`
> 2. `/optimize`
> 3. Paste the new handbook into Cowork → Settings → Global instructions when it asks.
> 4. Test with any short prompt.
>
> `rollback` undoes everything if anything looks off.
>
> Full SOP: [link]
> Detailed breakdown: [link]
>
> — Nuno

---

## Version C — Short social post (if Nuno wants this public)

Use sparingly — public framing of an internal bug. Only post if Nuno wants to be transparent about the fix.

> Shipped v0.9 of Cowork AI OS today.
>
> v0.8 had a stupid bug: the handbook told Claude to re-read every identity file on every prompt. 20+ seconds of latency per response. One of my students lost an hour to it before flagging.
>
> v0.9 kills the directive, adds memory auto-archive at 30 entries, and bundles `/optimize` — an evergreen command students can run if Cowork ever feels slow again.
>
> ~95% drop in per-turn token overhead. ~22 seconds shaved off "Start Up." Built progressive disclosure into the architecture instead of bolting it on.
>
> Big lesson: Global Instructions is a sharp tool. Anything you put in there gets shipped to the model on every single prompt. Slim handbook + identity files loaded on demand is the way.
>
> [github.com/AutomatedMarketer/cowork-ai-os](https://github.com/AutomatedMarketer/cowork-ai-os)
