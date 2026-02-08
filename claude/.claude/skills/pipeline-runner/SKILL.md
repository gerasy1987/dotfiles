---
name: pipeline-runner
description: Execute the analysis pipeline (clean, analyze, generate outputs) and report failures, warnings, or stale outputs. Use to verify reproducibility.
disable-model-invocation: true
argument-hint: "[all | clean | analysis | script.R]"
---

# Run Analysis Pipeline

Execute the project's data cleaning and analysis pipeline, report any failures or warnings, and flag stale output files.

## Steps

1. **Read CLAUDE.md** to find:
   - Data cleaning scripts and their execution order
   - Analysis scripts and their dependencies
   - Expected output directories (figures, tables)
   - Working directory and R project configuration

2. **Determine scope from arguments:**
   - `$ARGUMENTS` = `all`: run full pipeline (clean + analysis)
   - `$ARGUMENTS` = `clean`: run only data cleaning scripts
   - `$ARGUMENTS` = `analysis`: run only analysis scripts (assumes clean data exists)
   - `$ARGUMENTS` = specific `.R` filename: run that single script
   - Default (no arguments): run `all`

3. **Run cleaning scripts** (if in scope):
   - Execute each cleaning script in dependency order
   - Capture stdout, stderr, and exit code
   - Record runtime for each script
   - Check that expected output data files are created/updated

4. **Run analysis scripts** (if in scope):
   - Execute each analysis script
   - Capture stdout, stderr, and exit code
   - Record runtime for each script
   - Note any warnings (especially from statistical functions)

5. **Check output freshness:**
   - Compare modification times of output files (figures, tables) against source scripts
   - Flag outputs that are older than their generating script (stale)
   - Flag scripts that produce no detectable output files

6. **Produce a pipeline report** with:
   - Script-by-script results (PASS / WARN / FAIL)
   - Runtime for each script
   - Error messages and warnings (full text)
   - List of stale output files
   - List of missing expected outputs

7. **Save report** to `quality_reports/pipeline_run.md`

8. **Present summary:**
   - Total scripts run / passed / warned / failed
   - Critical failures highlighted
   - Stale outputs listed

## Important Notes

- Scripts should be run with the project root as the working directory
- Use `Rscript` to run R scripts (not `R CMD BATCH`)
- If a cleaning script fails, do NOT proceed to analysis scripts that depend on its output
- Capture warnings separately from errors — warnings may indicate data issues worth investigating
