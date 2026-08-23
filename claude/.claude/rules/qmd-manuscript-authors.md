# Quarto Manuscript Author Block — Political Science Standard

**Scope.** Any `.qmd` academic manuscript rendered to PDF (papers, working papers, PAPs). When adding or editing authors on a title page, use the layout below as the default. Presentations and non-PDF outputs are out of scope.

## The standard layout

- All authors on **one line, side by side**, each name over its **university affiliation**.
- A **footnote-symbol mark next to each name** (†, ‡, …) pointing to a bottom-of-title-page footnote with position, department, and email.
- The document-level `thanks:` (acknowledgments/pre-registration note) takes the first mark (∗); author footnotes follow. Body footnotes stay arabic — KOMA `scrartcl` (Quarto's default PDF class) keeps `\thanks` marks on the `fnsymbol` series automatically.

**Canonical reference implementation:** `Learning About Bias/paper/supplementary/title.tex` + the YAML of `paper/attention_news_v2.qmd` (verified 2026-08-20).

## Implementation

**1. YAML** — structured author schema. The university (printed under the name) goes in `affiliations`; the footnote text goes in a **custom `thanksnote:` key**:

```yaml
author:
  - name: First Author
    affiliations:
      - name: University One
    thanksnote: "Assistant Professor, Department of Political Science, University One, <email@one.edu>."
  - name: Second Author
    affiliations:
      - name: University Two
    thanksnote: "Assistant Professor, Department of Political Science, University Two, <email@two.edu>."
```

**2. Template partial** — a `title.tex` partial (declared under `format: pdf: template-partials:`) builds a single `\author{}` with `\and` separators. Core line:

```latex
\author{%
$for(by-author)$$by-author.name.literal$$if(by-author.metadata.thanksnote)$\thanks{$by-author.metadata.thanksnote$}$endif$$for(by-author.affiliations)$\\ $by-author.affiliations.name$$endfor$$sep$ \and $endfor$%
}
```

Plain LaTeX `\and` produces the side-by-side name-over-affiliation blocks. **Do not use `authblk`** — its block mode stacks authors vertically, and it is unnecessary here.

## Gotchas (each cost debugging time — do not rediscover)

- **Quarto flattens the schema key `note:` to boolean `true`** before it reaches templates. Never use `note:` for the footnote text. Unrecognized author keys survive under `by-author.metadata`, hence `thanksnote:` accessed as `$by-author.metadata.thanksnote$`.
- **Template partials override by exact filename.** A partial must be named `title.tex` to replace the title partial; `title_debug.tex` is silently ignored.
- The `<email@x.edu>` autolink renders as a colored mailto link (follows the document's `urlcolor`).
- The partial degrades gracefully: authors without `thanksnote` or `affiliations` render as plain names, so plain-string author lists still compile.

## Verification

Never render the full manuscript just to check the title page (it runs the whole R pipeline). Instead render a minimal `.qmd` in the scratchpad containing only the YAML header (with **absolute paths** to the real `template-partials` and `include-in-header` files) plus one body footnote, then rasterize page 1 (`pdftoppm -png -r 100 -f 1 -l 1`) and inspect: names side by side, affiliations beneath, ∗/†/‡ footnotes at the bottom, body footnote still arabic.
