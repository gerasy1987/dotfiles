---
name: output-syncer
description: Compare analysis output files (figures, tables) against their copies in the manuscript directory. Flag stale, missing, or orphaned files. Produces a report without editing files.
disable-model-invocation: true
---

# Check Output File Sync Status

Compare analysis output files in the project's build directories against their copies in the manuscript directory. Identify files that are out of sync, missing, or orphaned.

## Steps

1. **Read CLAUDE.md** to find:
   - Analysis output directories (figures, tables)
   - Manuscript directory location
   - Manuscript figure/table subdirectories
   - Output flow documentation

2. **Inventory both sides:**

   **Analysis repo outputs:**
   - List all figure files (e.g., `.pdf` in `Figures/`)
   - List all table files (e.g., `.tex` in `Tables/`)
   - Record modification timestamps

   **Manuscript directory copies:**
   - List all files in manuscript figures directory
   - List all files in manuscript tables directory
   - Record modification timestamps

3. **Compare and classify each file:**

   **STALE** (Major): File exists in both places but the manuscript copy is older than the analysis copy
   - The analysis was re-run but outputs weren't copied over

   **MISSING_IN_MANUSCRIPT** (Major): File exists in analysis repo but not in manuscript directory
   - New output that hasn't been deployed yet

   **ORPHANED_IN_MANUSCRIPT** (Minor): File exists in manuscript directory but not in analysis repo
   - May have been manually added, or the source script was removed

   **IN_SYNC** (OK): File exists in both places with matching or newer manuscript timestamp

4. **Check manuscript references:**
   - Read the manuscript `.tex` file(s)
   - Find all `\input{tables/...}` and `\includegraphics{figures/...}` references
   - Flag any referenced file that doesn't exist in the manuscript directory

5. **Produce a sync report** with:
   - Summary counts: In Sync / Stale / Missing / Orphaned
   - Table listing each file with its status and timestamps
   - List of manuscript references to missing files (critical)

6. **Save report** to `quality_reports/output_sync.md`

7. **IMPORTANT: Do NOT copy, move, or delete any files.**
   Only produce the report. Syncing is done after user review.

8. **Present summary:**
   - Sync status breakdown
   - Critical: files referenced in manuscript but missing
   - Stale files that need updating
