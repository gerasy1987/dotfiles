---
name: \equiv over := for math definitions
description: User prefers \equiv (≡) over := for defining mathematical symbols in LaTeX/Quarto math mode
type: feedback
---

Use `\equiv` (rendered ≡) rather than `:=` when defining mathematical symbols in LaTeX, Quarto, or any math environment.

**Why:** Stated personal style for math notation across documents — surfaced during the PSCI 8357 final-exam sync (2026-04-26), where the user noted "I use \equiv instead of :=" in passing while reviewing exam wording.

**How to apply:**
- Anywhere a definition like `Define X := f(...)` or `ATT(g,t) := E[...]` would naturally appear (lecture slides, exam keys, problem sets, manuscripts), use `\equiv` instead.
- Before commit/handoff on math-heavy QMD/TeX work, run `grep -n ":=" <files>` to catch leftovers from older drafts or copy-pasted source.
