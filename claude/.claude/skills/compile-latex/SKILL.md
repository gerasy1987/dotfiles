---
name: compile-latex
description: Compile a Beamer LaTeX slide deck with XeLaTeX (3 passes + bibtex). Use when compiling lecture slides.
disable-model-invocation: true
argument-hint: "[filename without .tex extension]"
---

# Compile Beamer LaTeX Slides

Compile a Beamer slide deck using XeLaTeX with full citation resolution.

## Steps

1. **Locate the .tex file:** Search for `**/$ARGUMENTS.tex` using Glob. Identify the directory containing the file (referred to as `$SLIDES_DIR` below). If multiple matches or the directory is ambiguous, confirm the path with the user before proceeding.

2. **Navigate to the slides directory** and compile with 3-pass sequence:

```bash
cd $SLIDES_DIR
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode $ARGUMENTS.tex
BIBINPUTS=..:$BIBINPUTS bibtex $ARGUMENTS
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode $ARGUMENTS.tex
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode $ARGUMENTS.tex
```

**Alternative (latexmk):**
```bash
cd $SLIDES_DIR
TEXINPUTS=../Preambles:$TEXINPUTS BIBINPUTS=..:$BIBINPUTS latexmk -xelatex -interaction=nonstopmode $ARGUMENTS.tex
```

3. **Check for warnings:**
   - Grep output for `Overfull \\hbox` warnings
   - Grep for `undefined citations` or `Label(s) may have changed`
   - Report any issues found

4. **Open the PDF** for visual verification:
   ```bash
   open $SLIDES_DIR/$ARGUMENTS.pdf
   ```

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
- **TEXINPUTS** is required: your Beamer theme lives in `Preambles/`
- **BIBINPUTS** is required: your `.bib` file lives in the repo root
