---
paths:
  - "**/*.R"
  - "**/*.r"
  - "**/*.do"
  - "**/*.ado"
  - "**/*.py"
  - "**/*.cpp"
  - "**/*.cc"
  - "**/*.cxx"
  - "**/*.hpp"
  - "**/*.h"
---

# Code Comment Brevity

**Scope.** All languages the user writes — R, Stata, Python, C++. The user reads code fluently and does not need line-by-line narration of what the code does.

**Principle.** Comment the non-obvious *why*, never the obvious *what*. Verbose preambles and restatements of plain code are noise that buries the comments that actually carry information.

- **Headers:** short — title, one or two lines of purpose, inputs/outputs, and any safety-critical or non-obvious operational note (e.g. a PII warning, "run from project root"). No essay-style HOW-TO-RUN / ASSUMPTIONS / VERIFICATION sections.
- **Inline:** comment only a non-obvious decision, a magic value (e.g. `999 = missing`), a guard's rationale, a deviation, or a workaround. Never restate what the code plainly says.
- **Structure:** keep stable semantic section headers used for navigation (e.g. R/RStudio `# IMPORT ----`). Do not add decorative or chronological banners that describe when or why content was added (e.g. `# ==== Added for revision ====`); normal file ordering and Git history carry that information.
- **Exception:** genuinely complex or non-trivial logic warrants a real explanatory comment.

For R specifically this complements the Console Output Policy in `r-code-conventions.md` (no `cat()`/`print()` noise) — keep both console output and comments lean.
