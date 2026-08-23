# Academic Prose Style: Syunyaev (LaTeX manuscripts)

**Scope.** When editing my academic writing in LaTeX (papers, pre-analysis plans, proposals), match the conventions below. They were extracted from a published paper of mine ("Learning About Bias" / `attention_news_submit.tex`) and are meant to keep my voice consistent across projects.

**Posture.** Apply these as defaults, not absolute rules. The substantive argument always wins. If a convention would distort the claim, flag it rather than silently bend it.

---

## A. Sentence rhythm

- Default sentence length is moderate-to-long (about 25 to 45 words): a main clause plus one or two qualifying phrases. Pure short sentences are rare and reserved for emphasis.
- Long compound sentences are appropriate when stacking parallel mechanisms or claims (e.g., "First… Second… Third…" within one sentence). Structure: topic claim, then `\emph{...}`-marked alternatives joined by commas and "and."
- Short, punchy sentences mark transitions and paragraph closes.
- Paragraph openers should announce the move being made before diving into evidence ("We argue that…", "Our study addresses this gap by…", "To test these expectations…", "Consider first the…").
- Paragraph closes should state an interpretive takeaway, not trail on a fact.

## B. Paragraph architecture

- Topic-sentence-first: lead with the claim, then accumulate evidence and citations.
- Citations are clustered and sentence-final when supporting general claims. Multi-key `\citep{A, B, C}` blocks at sentence end are normal.
- Use named pivots between paragraphs ("First,", "Second,", "Finally,", "By contrast,", "In contrast,", "At the same time,", "Importantly,", "Crucially,", "Taken together,"). They do real signposting work and are not filler.
- Three-part enumeration is recurring: "First… Second… Third…" or "(i)…(ii)…(iii)…", inside a sentence or across paragraphs.
- Close paragraphs by extracting an implication ("This suggests that…", "These findings indicate that…", "In line with this interpretation, …").

## C. Diction and register

- First-person plural is the default voice ("We argue", "We find", "We provide", "Our study", "We conceptualize"). Use freely. Do not hedge it.
- Hedging vocabulary, in rough order of use: "may", "can", "is likely to", "suggests", "indicates", "consistent with", "in line with", "appears to". The standard load-bearing claim verb is "we argue."
- Avoid: "we believe", "arguably", "interestingly", rhetorical questions in body prose, "it should be noted that", "obviously" / "clearly" as filler, "very", "really".
- Register is crisp-formal academic, not stiff: no contractions and no second person. Everyday verbs ("watch", "pay attention", "discount", "puncture") sit alongside technical ones ("attenuate", "moderate", "decouple").
- Defined terms get `\emph{...}` on first use. Subsequent uses go unmarked. `\textbf{...}` is reserved for structural labels (treatment-arm names, mechanism headers), not in-prose emphasis.

## D. Citation integration

- Default form is sentence-final `\citep{...}` after the claim is fully stated. The text reads cleanly without the citation.
- In-text named citations (`\citet`, `\citeauthor`) appear only when the cited paper is itself the subject of the sentence ("A notable exception is `\citet{X}`, who find that…"). Otherwise keep the author name out of the prose.
- Multi-citation clusters (3 to 5 keys) are appropriate when a literature, not a single source, supports the claim.
- State claims about cited papers in your own framing first, then append the citation. Do not paraphrase a paper and then say "as X argues."

## E. Dashes and hyphenated compounds

- Do not use em dashes or en dashes in prose. Replace them with commas, parentheses, colons, or full stops. Write a punchy contrast as "X, not Y, is the pathway."
- For an appositive expansion at the end of a clause, use a colon. Set off a short mid-sentence appositive with commas. For a long parenthetical with internal commas, use parentheses or split the material into two sentences.
- Hyphenated compounds are used only for genuine adjectival compounds ("pro-government", "state-owned", "pre-existing", "cross-cutting", "wartime", "two-week", "self-reported", "low-cost"). Do not invent novel compounds. Use standard ones only.
- **Do not compress two academic concepts into a hyphenated modifier of a noun.** Patterns like "directional-updating models", "image-management practices", "face-perception literature", "stability-signal account", and "regime-survival beliefs" should be recast as prepositional phrases: "models of directional updating", "practices of image management", "literature on face perception", "account of the stability signal", and "beliefs about regime survival". This rule applies to two-academic-word compounds. It does **not** apply to (a) standard short adjectival compounds in the list above, (b) prefix forms (`self-`, `pre-`, `non-`, `anti-`, `cross-`, `pro-`, `meta-`), (c) defined treatment-arm or channel labels (e.g., `weakness-cue conditions`, `submissive-modified image`, `anxiety-support channel`), or (d) set phrases of the methodological literature (e.g., `cue-taking`, `scope-condition`, `room-to-update`).
- **My standing instruction to Claude on this:** curb your own habitual overuse of hyphenated compounds, but do not strip legitimate compounds. The corrective is selective suppression. When in doubt, flag a candidate rather than silently inserting or deleting it.
- **Specific compounds I've previously rejected (do not introduce in any draft):**
    - `social-behavioral modality` / `social-behavior modality`: use "social modality" if a parallel to "facial modality" is needed. Otherwise describe the actual mechanism.
    - `submissive-modified image`: introduce the modification process once at the treatment description, then refer to the stimulus as just `submissive image`.
    - `scope-condition hypothesis`: rephrase the actual claim, e.g., "we expect X to moderate Y."
    - `news-style vignette`: call it a `vignette` and, on first introduction, note that it is presented as a brief news report.
    - `room-to-update logic`: describe the asymmetry directly.
    - `load-bearing pillar`: drop the metaphor. Use "central pillar", "central determinant", or "essential."

## F. Signposting and section openings

- Section openings get one short framing sentence before the substantive move.
- Forecasting is explicit but light, usually a single sentence ("We then assess whether…"). No bullet preview at section start.
- Cross-references use `\Cref{...}` / `\ref{...}` / `Section~\ref{...}` / `Appendix \ref{...}` consistently. Use "see Section X" only when navigating the reader, not as filler.

## G. Footnotes, lists, italics

- Footnotes are short and load-bearing: a clarifying caveat, a numerical detail, a deviation note, a URL. Not a place to dump tangential argument.
- In-text lists with `(a)/(b)/(c)` or `(i)/(ii)/(iii)` are the default for parallel items inside a sentence. Display `itemize` lists are rare in body prose.
- `\emph{...}` marks defined terms on first use and contrastive emphasis on a single word. Not decorative.

## H. Semicolons

- Use semicolons only to separate long items inside enumerated `(a)/(b)/(c)` or `(i)/(ii)/(iii)` lists when commas would be ambiguous.
- Do not use a semicolon to join independent clauses. Keep the sentence whole with commas when grammatical, or split it into separate sentences.
- Use commas or parentheses for parenthetical material.

---

## How to apply

- Read existing prose in the target document before editing. Established document conventions override this guide on conflicts (e.g., a document-specific bold-emphasis pattern).
- When making non-trivial stylistic edits, briefly note which rule above drove each change so I can audit your judgment.
- This is a **prose** style guide, not a content guide. Do not change arguments, claims, hypotheses, defined terms, or citations under cover of "stylistic edit."
