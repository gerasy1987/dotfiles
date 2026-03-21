---
name: Avoid one-off intermediate objects
description: Prefer longer pipelines over creating throwaway intermediate variables
type: feedback
---

Do not create one-off intermediate objects that are only used once. Inline the expression directly or extend the pipeline instead.

**Why:** The user has a strong preference for longer pipelines over cluttering the namespace with single-use variables. Examples: `which(df$col < 0.1)` fed directly as a function argument, `arrange()` appended to an existing pipeline rather than assigned to a new `_tbl` object.

**How to apply:** Before creating a new variable, check if it's used more than once. If not, inline it. This applies to all R scripts.
