---
name: Pandoc/Quarto text-mode gotchas next to math
description: Two recurring failures when mixing markdown text and display math in QMD → LaTeX → PDF; check rendered PDFs before declaring done
type: feedback
---

Two pandoc-markdown → LaTeX gotchas that bite repeatedly when mixing text and math in a QMD that renders to PDF:

1. **Brace escaping outside math mode.** `100{,}000` written in plain markdown text gets pandoc-escaped to `100\{,\}000` in the LaTeX output and renders with literal braces visible. Either:
   - Use plain `100,000` in text mode, **or**
   - Wrap in math mode: `$100{,}000$`.

2. **Markdown italics don't span display math.** A standalone `*Spec 1 — label:*` followed by a display math block (`$$ ... $$`) and then more prose can have the closing `*` mis-paired: the next `*` somewhere later in the paragraph (e.g. inside `*growth rate*`) becomes the actual closer, and italics span the equation and several lines after it.
   - Fix: write the label as `\noindent\emph{Spec 1 — label:}` (raw LaTeX) instead of `*Spec 1 — label:*`.

**Why:** Both failed during PSCI 8357 final-exam Part 3 setup (2026-04-26). The fix shipped as `\emph{...}` for spec labels and plain `100,000` for the population-rate text — visible in `problem_sets/final_exam.qmd` Q3.2 setup.

**How to apply:**
- Prefer plain `100,000` in text mode; only use `100{,}000` inside `$...$`.
- For italic labels that introduce display math, write `\emph{label}` (raw LaTeX) rather than `*label*` markdown.
- After rendering math-heavy sections, spot-check the rendered PDF (read it back) before saying "done" — these don't show up in source-only review.
