---
name: QMD-first workflow
description: User is transitioning from Beamer LaTeX to Quarto QMD as the primary slide format — don't default to Beamer-first workflows
type: user
---

The user is moving away from Beamer LaTeX slides toward Quarto QMD as the primary authoring format. Beamer is no longer the "source of truth" — QMD files are primary.

When working on lecture slides:
- Default to QMD workflows, not Beamer
- Don't suggest "edit Beamer first, then sync to QMD"
- The `/translate-to-quarto` skill and `beamer-translator` agent are still useful for migrating legacy Beamer lectures, but new content should be QMD-first
- TikZ diagrams can originate in QMD or standalone .tex files, not necessarily Beamer source
