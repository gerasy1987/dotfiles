# MEMORY — Global

## User

- [user_qmd-first-workflow.md](user_qmd-first-workflow.md) — Transitioning from Beamer to QMD-first for slides; don't default to Beamer workflows

## Feedback

- [feedback_tidyverse-style.md](feedback_tidyverse-style.md) — Use tibble, pipe-first style, kable(digits=) over manual round(); minimal formatting code
- [feedback_kable-output.md](feedback_kable-output.md) — Present numeric output in kable tables, not raw console; set.seed() for bootstrap reproducibility
- [feedback_no-cat-print.md](feedback_no-cat-print.md) — Never use cat()/print() for ancillary messages in R scripts
- [feedback_use-declaredesign.md](feedback_use-declaredesign.md) — Use DeclareDesign for Monte Carlo simulations, not hand-rolled loops
- [feedback_no-throwaway-objects.md](feedback_no-throwaway-objects.md) — Inline single-use expressions; prefer longer pipelines over one-off variables
- [feedback_use-future-apply.md](feedback_use-future-apply.md) — Use future/future.apply for parallelization, not pbapply or parallel
- [feedback_check-sources.md](feedback_check-sources.md) — Always verify claims against original sources before answering; don't rely on memory
- [feedback_overleaf_compile.md](feedback_overleaf_compile.md) — Never compile LaTeX files that live in or are symlinked to the Dropbox/Apps/Overleaf folder; Overleaf builds them automatically
- [feedback_review_priorities.md](feedback_review_priorities.md) — For all academic reviews (chapters AND journal referee reports): lead with substance; keep methods nitpicks low-priority unless explicitly asked
- [feedback_verify-before-handoff.md](feedback_verify-before-handoff.md) — Self-test simple/system fixes before handoff; don't for large scientific analysis changes
- [feedback_universal-over-per-tool.md](feedback_universal-over-per-tool.md) — Lead with universal/scalable config solutions before per-instance setup
- [feedback_latex-equiv-over-coloneq.md](feedback_latex-equiv-over-coloneq.md) — Use `\equiv` not `:=` for math definitions
- [feedback_pandoc-text-mode-gotchas.md](feedback_pandoc-text-mode-gotchas.md) — Brace-escaping (`100{,}000`) and italics-spanning-display-math traps in QMD→PDF
- [feedback_macos-shell-quirks.md](feedback_macos-shell-quirks.md) — grep is ugrep (regex complexity limits → use /usr/bin/grep), fish expands --include globs (quote them), BSD cat has no -A
- [feedback_lean-pap-disclosure.md](feedback_lean-pap-disclosure.md) — PAP deviations: disclose each once, factually; no inventories or "not pre-registered" tags; never justify test choice by results; verify the OSF form + PAP PDF and scan appendix tables/figures before any registration wording; don't restate a global deviation per analysis
- [feedback_commit-message-style.md](feedback_commit-message-style.md) — Commits: one lowercase subject line in his wording, no body, trailer accepted, stage only the named files
- [feedback_enhance-not-rewrite.md](feedback_enhance-not-rewrite.md) — Extend existing functions with a minimal diff in the file's own style, one opt-in argument with companion defaults, and a drop-in check that the option-off output is unchanged
- [feedback_questions-want-mechanism.md](feedback_questions-want-mechanism.md) — "Is there a way…?" questions want the mechanism and levers explained with a recommendation, not a fix applied; he picks the numbers himself
- [feedback_r-framework-only.md](feedback_r-framework-only.md) — Only one R since 2026-09-08: CRAN framework build (/usr/local/bin/Rscript), Homebrew R removed; install packages with plain Rscript, never brew install r

## Reference

- [reference_quarto-html-figure-check.md](reference_quarto-html-figure-check.md) — Inspect embed-resources Quarto HTML renders: extract base64 figures by fig id (`role="img"` precedes `src`), dump kable tables; wrap star/quote cells in backticks
