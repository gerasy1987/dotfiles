---
name: compile-latex
description: Compile a LaTeX document with XeLaTeX (3 passes + bibtex). Use when compiling LaTeX slides or papers.
disable-model-invocation: true
argument-hint: "[filename with or without .tex extension]"
---

# Compile LaTeX Document

Compile a LaTeX document using XeLaTeX with full citation resolution.

## Steps

1. **Read CLAUDE.md** to find:
   - LaTeX source directory and any required environment variables (TEXINPUTS, BIBINPUTS)
   - Compilation commands specific to this project
   - Bibliography file locations

2. **Compile with 3-pass sequence** (from the appropriate directory):

**Default (xelatex + bibtex):**
```bash
xelatex -interaction=nonstopmode $ARGUMENTS.tex
bibtex $ARGUMENTS
xelatex -interaction=nonstopmode $ARGUMENTS.tex
xelatex -interaction=nonstopmode $ARGUMENTS.tex
```

**Preferred alternative (latexmk):**
```bash
latexmk -xelatex -interaction=nonstopmode $ARGUMENTS.tex
```

Set TEXINPUTS and BIBINPUTS as specified in CLAUDE.md before running.

3. **Check for warnings:**
   - Grep output for `Overfull \\hbox` warnings
   - Grep for `undefined citations` or `Label(s) may have changed`
   - Report any issues found

4. **Report results:**
   - Compilation success/failure
   - Number of overfull hbox warnings
   - Any undefined citations
   - PDF page count

## Why 3 passes?
1. First xelatex: Creates `.aux` file with citation keys
2. bibtex: Reads `.aux`, generates `.bbl` with formatted references
3. Second xelatex: Incorporates bibliography
4. Third xelatex: Resolves all cross-references with final page numbers

## Important
- **Always use XeLaTeX**, never pdflatex
- Check CLAUDE.md for project-specific TEXINPUTS and BIBINPUTS paths
- If the project uses `latexmk` with a `latexmkrc`, prefer that over manual 3-pass
