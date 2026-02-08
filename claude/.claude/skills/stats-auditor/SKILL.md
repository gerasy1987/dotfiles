---
name: stats-auditor
description: Cross-check statistics cited in a manuscript against analysis code output and generated tables. Flags mismatches between paper claims and code. Produces a report without editing files.
disable-model-invocation: true
argument-hint: "[filename]"
---

# Audit Statistics in Manuscript

Cross-check every quantitative claim in the manuscript against the analysis code and output tables. The goal is to catch number drift — where the paper says one thing but the code produces another.

## Steps

1. **Read CLAUDE.md** to find:
   - Manuscript location and filename
   - Analysis code directory
   - Output tables/figures directories
   - Data cleaning scripts

2. **Identify manuscript to audit:**
   - If `$ARGUMENTS` is a specific `.tex` filename: audit that file
   - Otherwise: audit the primary manuscript listed in CLAUDE.md

3. **Extract all quantitative claims** from the manuscript:
   - Sample sizes (e.g., "N = 2,631", "2,631 respondents")
   - Treatment effect estimates (coefficients, standard errors)
   - Percentages and proportions
   - Means, standard deviations, medians
   - P-values and significance statements
   - Confidence intervals
   - Test statistics (t, F, chi-squared)
   - Reliability measures (Cronbach's alpha, etc.)
   - Response rates, attrition rates

4. **Cross-check against analysis code and output tables:**

   **Sample sizes:**
   - Compare against data cleaning scripts (look for filtering, `nrow()`, row counts)
   - Compare against summary statistics tables

   **Regression results:**
   - Compare against estimation code (look for model output, coefficient extraction)
   - Compare against result tables (`.tex` or `.csv`)

   **Descriptive statistics:**
   - Compare against descriptive analysis scripts
   - Compare against summary statistics tables

   **Heterogeneous effects / robustness:**
   - Compare against robustness scripts and their output tables

5. **For each claim, record:**
   - Manuscript location (line number, section)
   - Claimed value in text
   - Source (script + line, or table file + cell)
   - Actual value from source
   - Match status: MATCH | MISMATCH | UNVERIFIABLE
   - Severity of mismatch (if any)

6. **Flag common issues:**
   - Rounding inconsistencies (e.g., text says "0.15" but table shows "0.152")
   - Stale numbers (text not updated after re-running analysis)
   - Significance claims that don't match p-values
   - Sample size changes between specifications not noted

7. **Save report** to `quality_reports/stats_audit.md` with a table of all checks

8. **IMPORTANT: Do NOT edit any source files.**
   Only produce the report. Fixes are applied after user review.

9. **Present summary:**
   - Total claims checked
   - Matches / Mismatches / Unverifiable
   - List of all mismatches with severity
