---
name: review-r
description: Run the R code review protocol on R scripts. Checks code quality, reproducibility, domain correctness, and professional standards. Produces a report without editing files.
disable-model-invocation: true
argument-hint: "[filename or 'all']"
---

# Review R Scripts

Run the comprehensive R code review protocol.

## Steps

1. **Read CLAUDE.md** to find:
   - R script locations in this project
   - Project-specific conventions (shared functions, output paths, package patterns)
   - Any known pitfalls or exceptions

2. **Identify scripts to review:**
   - If `$ARGUMENTS` is a specific `.R` filename: review that file only
   - If `$ARGUMENTS` is `all`: review all R scripts found in the project (check CLAUDE.md for where scripts live)
   - If `$ARGUMENTS` is a directory name: review all `.R` files in that directory

3. **For each script, launch the `r-reviewer` agent** with instructions to:
   - Follow the full protocol in the agent instructions
   - Read `.claude/rules/r-code-conventions.md` for current standards
   - Read CLAUDE.md for project-specific conventions
   - Save report to `quality_reports/[script_name]_r_review.md`

4. **After all reviews complete**, present a summary:
   - Total issues found per script
   - Breakdown by severity (Critical / High / Medium / Low)
   - Top 3 most critical issues

5. **IMPORTANT: Do NOT edit any R source files.**
   Only produce reports. Fixes are applied after user review.
