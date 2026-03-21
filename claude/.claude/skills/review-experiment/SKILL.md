---
name: review-experiment
description: Run the experimental methods review protocol on analysis code. Checks randomization, estimation, multiple testing, PAP compliance, and robustness. Produces a report without editing files.
disable-model-invocation: true
argument-hint: "[filename or 'all']"
---

# Review Experimental Study

Run the comprehensive experimental methods review protocol.

## Steps

1. **Read CLAUDE.md** to find:
   - Pre-analysis plan (PAP) location
   - Analysis script locations
   - Treatment arms and outcome definitions
   - Study design details (randomization unit, sample size, factorial structure)

2. **Identify files to review:**
   - If `$ARGUMENTS` is a specific `.R` or `.qmd` filename: review that file only
   - If `$ARGUMENTS` is `all`: review all analysis scripts referenced in CLAUDE.md
   - If `$ARGUMENTS` is a directory: review all analysis files in that directory

3. **Launch the `experiment-reviewer` agent** with instructions to:
   - Read the PAP first (location from CLAUDE.md)
   - Review each analysis script through all 5 lenses
   - Cross-check analysis code against PAP specifications
   - Save report to `quality_reports/experiment_review.md`

4. **After review completes**, present a summary:
   - Overall assessment (SOUND / MINOR ISSUES / MAJOR ISSUES / CRITICAL ERRORS)
   - Total issues by lens
   - Blocking issues highlighted
   - PAP compliance status

5. **IMPORTANT: Do NOT edit any source files.**
   Only produce the report. Fixes are applied after user review.
