---
name: R is the CRAN framework build only (no Homebrew R)
description: Since 2026-09-08 there is exactly one R on this Mac, the CRAN framework build reached as /usr/local/bin/Rscript; Homebrew R was removed. Install packages with plain Rscript, never brew install r.
type: feedback
---

There is exactly one R installation on this machine: the CRAN framework build under `/Library/Frameworks/R.framework` (R 4.6.1 as of 2026-09-08), with `R` and `Rscript` symlinked at `/usr/local/bin`. The Homebrew R (`/opt/homebrew/Cellar/r`) was removed on 2026-09-08. VS Code's R extension points at `/usr/local/bin/R` (`r.rpath.mac`), and Quarto's knitr engine uses whichever `Rscript` is first on PATH, so everything now resolves to the same R and the same, user-writable library: `/Library/Frameworks/R.framework/Versions/4.6/Resources/library`.

**Why:** On 2026-09-07 Claude installed RefManageR for the personal website using Homebrew's Rscript, and Quarto rendering from VS Code then failed with "there is no package called 'RefManageR'" because VS Code was using the framework R. Two installs meant two package libraries, and packages kept landing in the wrong one. The user removed Homebrew R to end the confusion.

**How to apply:**
- Install packages with plain `Rscript -e 'install.packages("pkg")'`; they go to the framework library.
- Never `brew install r`, and do not suggest it as a fix for anything.
- If `which -a Rscript` ever lists more than `/usr/local/bin/Rscript`, or `quarto check knitr` reports a path other than `/Library/Frameworks/R.framework/Resources`, flag it before installing anything.
- After an R minor-version upgrade (a new `Versions/4.x` directory) packages must be reinstalled. The personal website (`~/github/gerasy1987.github.io`) needs RefManageR and yaml to render.
