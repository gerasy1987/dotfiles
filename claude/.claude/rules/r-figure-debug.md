---
paths:
  - "**/*.qmd"
  - "**/*.Rmd"
  - "**/*.R"
---

# R Figure Debugging Protocol

When creating or modifying R code that generates **any type of plot** (simulations, visualizations, diagrams, etc.) in `.qmd`, `.Rmd`, or `.R` files, **do not ask the user to render and inspect figures**. Instead, debug figures autonomously using either the **inline workflow** or the **background agent workflow**.

## Preferred: Background Agent Workflow

For iterative debugging (e.g., tuning DGP parameters, adjusting aesthetics until a figure clearly communicates its point), **launch a background `general-purpose` agent** so you can continue working on other tasks in parallel.

The agent prompt must include:
1. The **full R code** to debug (extracted from the source file, including preamble)
2. The **pedagogical/analytical goal** the figure must achieve (e.g., "HT should have visibly wider variance than Hajek")
3. The **target file and line range** where the final code should be inserted
4. Instructions to iterate: write script → run → read PNG → assess → modify → repeat until the goal is met
5. The agent should return: (a) the final working R code block, and (b) a PNG of the final figure for your review

When the agent completes, **review its proposed code and figure**, then apply the changes to the source file.

## Alternative: Inline Workflow

For quick one-shot checks (e.g., verifying a plot renders without errors), debug inline:

1. **Extract** the R code (preamble + relevant chunk) from the source file.
2. **Write** a self-contained R script to `/tmp/claude_fig_debug.R` that:
   - Loads required packages via `pacman::p_load()`
   - Includes the preamble setup (theme, seed, etc.) from the source file
   - Generates the data (via simulation, synthetic data, or package-bundled datasets)
   - Saves the figure to `/tmp/claude_fig_debug.png` via `ggsave()` (use `width = 10, height = 6, dpi = 150`)
3. **Run** the script via `Rscript /tmp/claude_fig_debug.R` (timeout ~120s for simulations).
4. **Read** the saved PNG using the Read tool (which renders images visually).
5. **Assess** whether the figure achieves the pedagogical/analytical goal.
6. **Iterate** if needed — modify parameters and repeat steps 2-5.

## Data Privacy

- **NEVER read or load identifiable data files** (`.csv`, `.dta`, `.rds`, `.xlsx`, etc.) without the user's explicit permission. This applies even if the code references such files.
- For debugging plots that depend on real data, create **synthetic data** that mimics the structure (column names, types, distributions) inferred from the code — not from reading the actual data file.
- If the plot cannot be meaningfully debugged without real data, ask the user for permission before proceeding.

## Key Notes

- Always include `set.seed()` for reproducibility.
- For QMD files, replicate the `thematic::thematic_rmd()` theme setup from the preamble.
- Use `ggplot2::ggsave()` with explicit dimensions — never rely on RStudio/Quarto viewer sizing.
- If the simulation is slow (>30s), reduce `N` or number of replications for the debug run, then restore original values after confirming the figure works.
- For Gruvbox-themed slides, set `theme_set(theme_minimal())` and use the project's hex colors directly.
- Clean up temp files after debugging is complete.

## When to Use

- After modifying any DGP parameters, plot aesthetics, or ggplot layers
- When creating new plots or figures from scratch
- When a user reports that a figure "doesn't look right"
- Proactively before presenting figure changes to the user
