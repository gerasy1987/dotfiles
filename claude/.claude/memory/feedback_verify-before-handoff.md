---
name: Verify fixes before handing back
description: When to self-test fixes before asking the user to try — system commands yes, large analysis changes no
type: feedback
---

For simpler commands/scripts, system fixes (config, dotfiles, packages), and teaching simulations: run the command yourself to verify the fix works before handing back to the user.

Do NOT do this for large changes in scientific project analyses — hand those back for the user to verify.

**Why:** User wants fast iteration on system-level debugging without being the one to discover a fix didn't work. But for scientific analyses, the user needs to control verification themselves.

**How to apply:** After fixing a config issue, shell script, system tool, or teaching simulation — run it and confirm. After modifying analysis pipelines, statistical code, or research scripts in scientific projects — describe what changed and let the user test.
