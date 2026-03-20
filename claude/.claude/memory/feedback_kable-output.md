---
name: Use kable tables for formatted output
description: Present all numeric output in kable/kableExtra tables, not raw R console output; use set.seed() for bootstrap reproducibility
type: feedback
---

All numeric output (balance tables, regression results, sensitivity analyses, comparison tables) should be formatted with `knitr::kable()` / `kableExtra` instead of printing raw console output.

**Why:** Raw R output (e.g., `summary()`) is hard to read in rendered PDFs. Clean tables are easier to interpret and grade.

**How to apply:** Replace `summary()` and raw object prints with piped kable calls. Use `kableExtra::kable_styling(font_size = 9)` for wide tables. Use `set.seed()` before any bootstrap-based inference to ensure reproducibility across renders.
