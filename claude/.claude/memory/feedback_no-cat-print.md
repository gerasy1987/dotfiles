---
name: No cat/print messages in scripts
description: Never use cat() or print() for ancillary/diagnostic messages in generated R scripts
type: feedback
---

Do not use `cat()` or `print()` to output ancillary messages, status updates, or diagnostic summaries in R scripts.

**Why:** The user finds these noisy and unhelpful. They can inspect objects directly in the console.

**How to apply:** Store results in data frames or tibbles that the user can inspect interactively. Let the final object print implicitly (e.g., a tibble at the end of the script) rather than constructing formatted output strings.
