---
name: data-validator
description: Validate data integrity — check missingness patterns, variable distributions, treatment balance, sample size consistency, and cross-reference against manuscript claims. Produces a report without editing files.
disable-model-invocation: true
argument-hint: "[dataset filename]"
---

# Validate Data Integrity

Check the project's cleaned dataset for integrity issues: unexpected missingness, implausible distributions, treatment imbalance, and consistency with manuscript claims.

## Steps

1. **Read CLAUDE.md** to find:
   - Cleaned dataset location and filename
   - Key variable names (treatment, outcomes, controls)
   - Expected sample size
   - Manuscript location (for cross-checking claims)

2. **Identify dataset to validate:**
   - If `$ARGUMENTS` is a specific filename: validate that file
   - Otherwise: validate the primary cleaned dataset listed in CLAUDE.md

3. **Write and run a validation R script** that checks:

   **Basic structure:**
   - Number of rows and columns
   - Variable names and types (numeric, character, factor)
   - Duplicate row detection (by respondent ID if available)

   **Missingness:**
   - Per-variable missing rate
   - Flag variables with >20% missing
   - Check if missingness is correlated with treatment assignment
   - Identify rows with >50% missing values

   **Treatment assignment:**
   - Frequency table of treatment variable
   - Balance check: roughly equal N per arm
   - Chi-squared test for uniform distribution

   **Outcome variables:**
   - Range check (are indices bounded as expected?)
   - Distribution summary (mean, SD, skewness)
   - Correlation matrix among outcomes
   - Check for floor/ceiling effects

   **Control variables:**
   - Plausible ranges (e.g., age > 0 and < 120)
   - Valid categories for factor variables (e.g., state codes)
   - Flag any suspiciously uniform distributions

   **Cross-dataset consistency** (if multiple dataset versions exist):
   - Compare row counts across variants
   - Compare variable availability
   - Check that subsetting is documented

4. **Produce a validation report** with:
   - Dataset summary table (N rows, N cols, file size)
   - Missingness heatmap description (top 20 variables by missing rate)
   - Treatment balance table
   - Outcome distribution summary
   - List of flagged issues with severity

5. **Save report** to `quality_reports/data_validation.md`

6. **IMPORTANT: Do NOT edit any data files or analysis scripts.**
   Only produce the report. Issues are investigated after user review.

7. **Present summary:**
   - Dataset dimensions
   - Number of issues flagged by severity
   - Most critical concerns highlighted
