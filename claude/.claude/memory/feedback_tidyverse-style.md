---
name: Tidyverse coding style
description: Use tibble over data.frame, pipe-first style, kable(digits=) over manual round(), minimal code for formatting
type: feedback
---

Use tidyverse conventions in all R code:
- `tibble()` instead of `data.frame()`
- Pipe-first style: `obj |> tidy()` not `tidy(obj)`
- Use `kable(digits = ...)` instead of manually `round()`ing each variable
- Column names can be passed via `col.names` in `kable()` directly
- Don't pollute the environment with intermediate objects for formatting — pipe the result directly
- Don't overcomplicate formatting code; keep it minimal

**Why:** User is a heavy tidyverse user and prefers clean, idiomatic code. Verbose formatting code detracts from substantive content.

**How to apply:** In all R code — scripts, answer keys, slides, analysis files. When presenting numeric output, use `knitr::kable()` with `digits` parameter rather than raw `print()`/`summary()` calls or manual rounding.
