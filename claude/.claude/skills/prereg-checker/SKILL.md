---
name: prereg-checker
description: Compare actual analyses against the pre-analysis plan (PAP). Flag undocumented deviations, missing registered analyses, and exploratory analyses needing disclosure.
disable-model-invocation: true
---

# Check Pre-Registration Compliance

Compare the project's actual analyses against its pre-analysis plan (PAP) to identify deviations that need documentation.

## Steps

1. **Read CLAUDE.md** to find:
   - Pre-analysis plan file location (usually a PDF in `PAP/`)
   - Analysis code directory
   - Manuscript location (to check deviation disclosures)

2. **Read the pre-analysis plan** and extract:
   - Registered hypotheses (numbered list)
   - Primary outcome variables
   - Secondary outcome variables
   - Planned estimation strategy (model, estimator, controls)
   - Planned sample restrictions or exclusion criteria
   - Planned subgroup analyses or heterogeneity tests
   - Planned robustness checks
   - Multiple testing correction plans

3. **Read the analysis scripts** and catalog what was actually run:
   - Outcome variables used
   - Estimation methods used
   - Control variables included
   - Sample restrictions applied
   - Subgroup analyses performed
   - Robustness checks conducted
   - Multiple testing corrections applied

4. **Compare PAP vs actual analyses and flag:**

   **MISSING_FROM_CODE** (Critical): Analyses registered in PAP but not found in code
   - e.g., a registered outcome that was never analyzed

   **UNREGISTERED** (Major): Analyses in code but not in PAP — exploratory, needs disclosure
   - e.g., additional moderators, alternative specifications, new outcome measures

   **DEVIATION** (Major): Registered analyses done differently than planned
   - e.g., different control variables, different estimator, different sample restriction

   **DISCLOSURE_CHECK** (Minor): Check if deviations are properly documented in the manuscript
   - Look for appendix sections on "deviations from pre-registration" or similar
   - Match each deviation to its disclosure

5. **Produce a compliance report** with:
   - Table: PAP item | Status (Compliant / Deviated / Missing / Exploratory) | Notes
   - List of undocumented deviations
   - List of exploratory analyses needing disclosure
   - Overall compliance assessment

6. **Save report** to `quality_reports/prereg_compliance.md`

7. **IMPORTANT: Do NOT edit any source files.**
   Only produce the report. Fixes are applied after user review.

8. **Present summary:**
   - Compliance rate (% of PAP items found in code)
   - Number of undocumented deviations
   - Number of exploratory analyses needing disclosure
