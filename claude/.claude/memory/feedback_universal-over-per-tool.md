---
name: Prefer universal solutions over per-instance configuration
description: User prefers configuration approaches that scale to new cases without manual setup, even if narrower per-case solutions are simpler
type: feedback
---

When the user asks how to set something up, lead with the most universal mechanism available before falling back to per-instance configuration. They explicitly value "doesn't need a separate adjustment for each new X" as a property worth designing around.

**Why:** Stated directly in conversation about fish completions: *"is that possible to implement reliably and universally (without the need to do a separate adjustment for each new command)?"* This was a preference signal, not just a question about that one feature.

**How to apply:**
- When designing config (shell completions, keybindings, theming, hooks, etc.), surface the universal mechanism first (e.g. fish's `fish_update_completions` for man pages, ecosystem-wide patterns like cobra's `<cmd> completion fish`).
- Only after that, document the per-tool snippets needed for cases the universal mechanism can't cover.
- Be honest when full universality isn't achievable — name the realistic ceiling rather than overselling. The user accepts "90% universal + documented patterns for the rest" but dislikes "set this up once per tool" presented as the only option.
- Group per-tool config by *pattern* (argcomplete tools, cobra tools, click tools) so adding a new tool is one line, not a research task.
