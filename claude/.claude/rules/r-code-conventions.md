---
paths:
  - "**/*.R"
  - "**/*.r"
---

# R Code Standards

**Standard:** Senior Principal Data Engineer + PhD researcher quality

These standards apply to all R scripts in this repository.

---

## 1. Script Structure

Every script MUST follow this section layout:

```r
# ==============================================================================
# [Descriptive Title]
# ==============================================================================
#
# Author:   [Your Name]
# Source:   [Paper(s) replicated / adapted from]
#
# Purpose:
#   [2-4 sentence description]
#
# Inputs:
#   - [data source, path, or URL]
#
# Outputs:
#   - [file.pdf]  -- [description]
#   - [file.rds]  -- [description]
#
# Runtime: ~X min
# ==============================================================================
```

### Section Markers

Use all-caps section headers with trailing dashes to ~75 characters:

```r
# PREAMBLE ----------------------------------------------------------------
# LOAD DATA ---------------------------------------------------------------
# ESTIMATION --------------------------------------------------------------
# FIGURES -----------------------------------------------------------------
# EXPORT ------------------------------------------------------------------
```

## 2. Console Output Policy

**Scripts are NOT notebooks.**

- **Allowed:** `message()` for progress milestones only
- **Forbidden:** `cat()`, `print()`, ASCII banners, per-iteration output

## 3. Reproducibility

- `set.seed()` called ONCE at top (YYYYMMDD format)
- All packages loaded at top via `pacman::p_load()`:

```r
if (!require("pacman")) install.packages("pacman")

pacman::p_load(
  tidyverse,
  estimatr,
  labelled,
  haven,
  knitr, kableExtra,
  modelsummary
)
```

- All paths relative to project root (Quarto uses `execute-dir: project`)
- `dir.create(..., recursive = TRUE)` for output directories

## 4. Function Design

- `snake_case` naming, verb-noun pattern
- Roxygen-style documentation (`#'` with `@param`, `@return`, `@examples`)
- Default parameters, no magic numbers
- Named return values (lists or tibbles)

## 5. Domain Correctness

- Verify estimator implementations match formulas in paper/slides
- Use `estimatr::lm_robust()` with `se_type = "HC2"` for treatment effect estimation
- Check CLAUDE.md for known package pitfalls specific to the project

## 6. Visual Identity

### Color Palettes

```r
# Primary: ggsci cosmic palette
pal <- ggsci::pal_cosmic(alpha = 1, palette = "signature_substitutions")

# Secondary: ggsci AAAS palette
pal_alt <- ggsci::pal_aaas(alpha = 1)

# Tertiary: RColorBrewer Dark2
pal_dark2 <- RColorBrewer::brewer.pal(name = "Dark2", n = 8)[c(2, 8, 1, 3:7)]
```

### Custom Theme

```r
base_size <- 16
base_family <- "palatino"

plot_theme <-
  hrbrthemes::theme_ipsum_rc(
    base_family = base_family,
    strip_text_face = "bold",
    axis_title_just = "center",
    axis_title_size = base_size,
    axis_title_face = "bold",
    caption_size = base_size - 3,
    caption_face = "italic",
    caption_family = base_family
  ) +
  ggplot2::theme(
    legend.title = element_blank(),
    axis.text.x = element_text(face = "bold"),
    axis.text.y = element_text(face = "bold"),
    legend.text = element_text(face = "bold", size = base_size),
    legend.position = "bottom"
  )
```

Font rendering requires `showtext::showtext_auto()` before any plotting.

### Figure Dimensions

```r
ggsave(filepath, width = 12, height = 5)
```

Always specify explicit `width` and `height` in `ggsave()`.

## 7. Tables

### kable + kableExtra Pipeline

```r
knitr::kable(
  df,
  format = "latex",       # or "html"
  booktabs = TRUE,
  col.names = names(df),
  align = "lcccc",
  digits = 2,
  linesep = ""
) |>
  kableExtra::kable_classic(latex_options = c("HOLD_position"), font_size = 11) |>
  kableExtra::column_spec(1, bold = TRUE, width = "8em") |>
  kableExtra::footnote(
    general = "Note text here",
    escape = FALSE,
    fixed_small_size = FALSE,
    threeparttable = TRUE
  )
```

Use `modelsummary` for regression tables with custom `gof_map` and `coef_map`.

## 8. RDS Data Pattern

**Heavy computations saved as RDS; rendering loads pre-computed data.**

```r
readr::write_rds(result, file.path(out_dir, "descriptive_name.rds"))
# Load with: readr::read_rds(path)
```

## 9. Code Style

- 2-space indentation (no tabs)
- Prefer native pipe `|>` in new code; `%>%` acceptable in existing code
- Lines under 100 characters where possible
- Consistent spacing around operators
- No legacy patterns: always `TRUE`/`FALSE`, never `T`/`F`

## 10. Code Quality Checklist

```
[ ] Header with all fields
[ ] Section markers (ALL-CAPS with dashes)
[ ] Packages at top via pacman::p_load()
[ ] set.seed() once at top
[ ] All paths relative to project root
[ ] Functions documented with Roxygen
[ ] No cat/print output
[ ] Figures: explicit dimensions, project palette/theme
[ ] RDS: computed objects saved for downstream use
[ ] Comments explain WHY not WHAT
```

## 11. Common Pitfalls

| Pitfall | Impact | Prevention |
|---------|--------|------------|
| `cat()` for status | Noisy stdout | Use `message()` sparingly |
| Hardcoded absolute paths | Breaks portability | Use paths relative to project root |
| Missing `showtext_auto()` | Fonts don't render in plots | Call before any plotting |
| Wrong SE type | Invalid inference | Use `se_type = "HC2"` by default |
| Mixed pipe styles | Inconsistent code | Prefer `\|>` in new code |
