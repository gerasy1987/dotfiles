# /draft-survey — Draft a Survey Instrument

Generate the initial draft of a survey instrument as a clean, self-contained Quarto document with English plus one or more target-language versions, following my questionnaire conventions. The English version is the documentation/reference text; the target language(s) are what respondents actually see.

## Step 0 — Intake

Gather before drafting (ask only for what you cannot infer from the project; batch the questions):

1. **Study source**: the design document grounding the instrument (PAP, proposal, hypothesis list). Read it — every registered construct (outcomes, mediators, moderators, manipulation checks, screeners) must map to items.
2. **Purpose**: pilot or main study; what the draft must accomplish (item testing vs. effect estimation changes placement of outcome batteries).
3. **Target language(s)**: which language versions besides English; which is fielded.
4. **Sections/batteries requested**: demographics, media, attitudes, outcomes, attention checks, consent/debrief, etc.
5. **Source questionnaires**: prior projects or published instruments to reuse. **Reuse wording verbatim wherever an equivalent item exists** (including legacy numeric codes) — check the source library before drafting any new item, and record provenance per battery.
6. **Fielding constraints**: panel provider, platform, mode, target duration, screeners/quotas, compensation arrangement.
7. **Ethics needs**: consent form (and whether IRB requires specific elements), sensitivity constraints on wording, debriefing (mandatory if the design involves deception or induced negative affect).

## Step 1 — Mine sources

Convert source instruments to text (`textutil -convert txt` for docx; parse Qualtrics `.qsf` JSON for exports). Build the draft battery-by-battery from verbatim source wording; only draft new items where no equivalent exists. Never read data files (see data-privacy rules) — instruments and codebooks only.

## Step 2 — Produce TWO files

- **`<study>_instrument.qmd`** — the clean instrument. No design commentary, no per-item source notes.
- **`<study>_instrument_notes.qmd`** — companion notes: About (instrument flow), Sources (provenance per battery, with citations; bibliography lives here), Implementation notes (randomization, screeners, paging, timing variables), and numbered Design notes (open decisions to resolve before fielding).

YAML for both: `format: docx:` with `reference-doc:` pointing at a repo copy of the all-black Word template (copy it from `~/dotfiles/claude/.claude/templates/word_template_black.docx`; see the word-docx-template rule), `toc: true`, `number-sections: false`.

## Formatting conventions (binding)

- **Structure**: English instrument first, then one full mirror per target language, separated by `{{< pagebreak >}}` — all in the single instrument file. Question sets must stay identical across language versions; when the user edits one version, sweep the change into the others and flag meaning divergences. No separate per-language export files.
- **Question format**: `**slug** *[TYPE, condition]*` followed by the question text on the same line. TYPE ∈ SINGLE / MULTIPLE / MATRIX / TEXT / NUMERIC / DROPDOWN / DISPLAY. Conditions reference slugs and option labels with codes, e.g. `*[SINGLE, If employment = Working permanently (1)]*`.
- **Options**: every option carries its numeric code: `Label (code)`. Reused items keep the source instrument's legacy codes verbatim, including out-of-sequence codes. Open options: `Other (please specify) (666) ________`. Exclusive options get an `*[exclusive]*` prefix.
- **Matrices**: rows first as `- **slug_row:** text (code)`, then `*Answer options:*` (translated equivalent in target-language versions) as a bullet list.
- **No "don't know" options anywhere.** Respondents may skip any item after one soft prompt (Request Response, never Force Response); record item nonresponse. Only eligibility screeners (consent, age, residence) require a response and terminate on failure.
- **Sections** are lettered with a short intro `DISPLAY` transition each. Sensitive/boring demographics go at the end; screeners at the front. Attention checks: one embedded in a pre-treatment grid (always displayed last in its matrix), one standalone immediately before the treatment section; record pass/fail, never screen out mid-survey.
- **Consent**: FAQ structure with drop-down (collapsible) answers instead of a wall of text (better comprehension in reading-heavy online surveys); the IRB submission renders the same content as continuous text under the same headers. Include: purpose, eligibility, procedures, duration, risks (forecast sensitive/unsettling content when applicable), benefits/compensation, data protection, voluntariness, author and IRB contacts.
- **Language register — naturalness over academic language.** In the fielded language, choose everyday terms over academic or genre-marked ones; when a terminology choice arises, propose the most natural variant with a one-line rationale, then apply it consistently instrument-wide (including consent and debrief). English should read naturally rather than mirror the target language literally.
- Provenance and design rationale go ONLY in the notes document.

## Step 3 — Verify

Render both qmds to docx (`quarto render <file> --to docx`). Confirm: output created, citations resolve, any embedded images present in the docx media, no default Word theme colors in styles. Check that every hypothesis/construct in the study source maps to at least one item, and state any that do not.

## Step 4 — Persist

Append the instrument's file names, render commands, and the conventions above (abridged) to the project's CLAUDE.md so future ad-hoc edits in that project follow them without re-invoking this skill. If the project will collect survey data, ensure CLAUDE.md has the Data Privacy section required by the data-privacy rule.
