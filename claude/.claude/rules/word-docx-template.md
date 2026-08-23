# Word Document Output — All-Black Template

**This rule applies to ALL projects.** Any `.docx` output produced via Quarto or pandoc must use the all-black reference template, never the default Word theme (its colored Title/Heading styles are unacceptable).

- **Canonical template**: `~/dotfiles/claude/.claude/templates/word_template_black.docx` — every style color set to `000000` (headings, title, subtitle, hyperlinks, borders), all theme-color attributes stripped so Word cannot re-tint from the theme.
- **Machine default**: `~/.local/share/pandoc/reference.docx` is a symlink to the canonical template, so ad-hoc `pandoc` / `quarto pandoc` docx conversions pick it up automatically with no flags (verified with Quarto's vendored pandoc, 2026-07-23).
- **Versioned or shared projects**: do not rely on the invisible machine default. Copy the canonical template into the repo and set `format: docx: reference-doc: <file>` explicitly, so collaborators and other machines render identically.
- If a document legitimately needs colored styles, override explicitly and flag the deviation.

## Rebuild recipe (if the canonical template is lost)

`quarto pandoc -o ref.docx --print-default-data-file reference.docx`, unzip, edit `word/styles.xml`: replace hex values in `w:val="HEX"` occurrences with `000000` (the `<w:color>` elements are pretty-printed across lines — match the attribute, not the whole element), blacken `w:color="HEX"` attribute forms on borders, strip all `w:themeColor`/`w:themeShade`/`w:themeTint` attributes, rezip the directory contents. Verify by unzipping a rendered docx and grepping `styles.xml` for non-`000000` hex values; leftover `*Tok` syntax-highlight styles are harmless when the document has no code blocks.
