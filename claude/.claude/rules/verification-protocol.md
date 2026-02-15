---
paths:
  - "**/*.tex"
  - "**/*.qmd"
  - "**/*.R"
---

# Task Completion Verification Protocol

**At the end of EVERY task, Claude MUST verify the output works correctly.** This is non-negotiable.

## General Principle

**Always check CLAUDE.md first** for project-specific build commands, output paths, and directory structure. The procedures below are defaults; CLAUDE.md overrides them.

## For Quarto Slides/Documents:
1. Run `quarto render <file>` to render the document
2. Verify output file was created (HTML, PDF, or both depending on format)
3. Check for render warnings in output
4. If HTML: verify images display by reading 2-3 image files to confirm valid content
5. Check for overflow by scanning dense slides
6. Verify environment parity: every Beamer box environment has a CSS equivalent in the QMD
7. Report verification results

## For LaTeX/Beamer Slides:
1. Compile with xelatex (check CLAUDE.md for compilation commands and required environment variables like TEXINPUTS, BIBINPUTS)
2. If no project-specific command, use: `xelatex -interaction=nonstopmode <file>.tex`
3. Open the PDF to verify figures render
4. Check for overfull hbox warnings

## For TikZ Diagrams in HTML/Quarto:
1. Browsers **cannot** display PDF images inline — ALWAYS convert to SVG
2. Use SVG (vector format) for crisp rendering: `pdf2svg input.pdf output.svg`
3. **NEVER use PNG for diagrams** — PNG is raster and looks blurry
4. Verify SVG files contain valid XML/SVG markup
5. **Freshness check:** Before using any TikZ SVG, verify the extraction source matches current Beamer source

## For R Scripts:
1. Run `Rscript <path/to/script.R>` from the project root
2. Verify output files (PDF, RDS, tex) were created with non-zero size
3. Spot-check estimates for reasonable magnitude
4. If script writes to an external directory (e.g., Overleaf), verify outputs arrived

## For Paper/Manuscript Outputs:
1. Verify generated tables exist in the expected output directory (check CLAUDE.md)
2. Verify generated figures exist in the expected output directory
3. If Overleaf integration: check that files were written to the Overleaf directory

## Common Pitfalls:
<<<<<<< HEAD
- **PDF images in HTML**: Browsers don't render PDFs inline — convert to SVG
- **Relative paths**: Quarto's `execute-dir: project` means all R paths are relative to project root, not the .qmd file location
=======
- **PDF images in HTML**: Browsers don't render PDFs inline → convert to SVG
- **Relative paths**: verify that figure paths resolve correctly from the file's directory; deployment directories may differ → use sync scripts if available
>>>>>>> 1a46b4fdd1ac4c2178c60dedab0b1a41d1925d48
- **Assuming success**: Always verify output files exist AND contain correct content
- **Stale TikZ SVGs**: extraction source diverges from Beamer source — always diff-check

## Verification Checklist:
```
[ ] Output file created successfully
[ ] No compilation/render errors
[ ] Images/figures display correctly
[ ] Paths resolve correctly (check execute-dir setting)
[ ] Opened in browser/viewer to confirm visual appearance
[ ] Reported results to user
```
