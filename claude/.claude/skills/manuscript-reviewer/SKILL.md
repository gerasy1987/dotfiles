---
name: manuscript-reviewer
description: Review LaTeX manuscript for structural completeness — orphaned references, missing files, cross-reference consistency, appendix integrity. Produces a report without editing files.
disable-model-invocation: true
argument-hint: "[filename]"
---

# Review LaTeX Manuscript Structure

Review a LaTeX manuscript for structural integrity: orphaned references, missing input files, cross-reference consistency, and appendix completeness.

## Steps

1. **Read CLAUDE.md** to find the manuscript location and bibliography file paths for this project.

2. **Identify manuscript to review:**
   - If `$ARGUMENTS` is a specific `.tex` filename: review that file
   - Otherwise: review the primary manuscript listed in CLAUDE.md

3. **Read the full manuscript** and extract all structural elements:

   **REFERENCES:** Find all `\ref{...}` and `\label{...}` — flag any `\ref` without a matching `\label`
   **CITATIONS:** Find all `\cite{...}`, `\citet{...}`, `\citep{...}` — cross-check against the project's `.bib` files
   **INPUTS:** Find all `\input{...}` and `\includegraphics{...}` — verify each referenced file exists on disk
   **FOOTNOTES:** Check footnotes for dangling references or incomplete text
   **APPENDIX:** Verify that main-text references to appendix sections (e.g., "Appendix A", "Table A1") have matching `\label` targets in the appendix

4. **Check section structure:**
   - All `\section`, `\subsection` have content (not empty)
   - No orphaned `\begin{...}` without matching `\end{...}`
   - Table and figure environments have both `\caption` and `\label`
   - No duplicate `\label` keys

5. **Check bibliography completeness:**
   - Every `\cite` key exists in one of the project's `.bib` files
   - Flag `.bib` entries with missing required fields (author, title, year)
   - Flag potential typos in citation keys (fuzzy match near-misses)

6. **Produce a detailed report** listing every finding with:
   - Location (line number)
   - Issue type (ORPHAN_REF | MISSING_FILE | MISSING_CITE | DUPLICATE_LABEL | EMPTY_SECTION | UNCLOSED_ENV)
   - Severity (Critical / Major / Minor)
   - Description of the problem

7. **Save report** to `quality_reports/manuscript_review.md`

8. **IMPORTANT: Do NOT edit any source files.**
   Only produce the report. Fixes are applied after user review.

9. **Present summary** to the user:
   - Total issues by severity
   - Most critical problems highlighted
   - List of missing files (if any)
