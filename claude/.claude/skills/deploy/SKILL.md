---
name: deploy
description: Render and deploy project outputs (slides, documents, figures). Check CLAUDE.md for project-specific deployment targets and commands.
disable-model-invocation: true
argument-hint: "[filename or 'all']"
---

# Deploy Project Outputs

Render documents and deploy outputs to their target locations.

## Steps

1. **Read CLAUDE.md** to find:
   - Deployment commands and scripts (e.g., sync scripts, quarto render, latexmk)
   - Deployment targets (e.g., docs/ directory, GitHub Pages, Overleaf folder)
   - Output directories for figures and tables

2. **Render/build the specified target:**
   - If `$ARGUMENTS` is a specific file: render that file with `quarto render $ARGUMENTS`
   - If `$ARGUMENTS` is `all`: render all documents listed in CLAUDE.md
   - If a deployment script exists: run it as specified in CLAUDE.md

3. **Verify deployment:**
   - Check that output files exist at the expected locations
   - Check that asset directories were copied (e.g., `_files/` for RevealJS)
   - Check that figures and tables reached their target directories

4. **Verify interactive charts** (if applicable):
   - Grep rendered HTML for interactive widget count
   - Confirm count matches expected

5. **Verify TikZ SVGs** (if applicable):
   - Check that all referenced SVG files exist at their deployment locations

6. **Open output** for visual verification (if possible)

7. **Report results** to the user
