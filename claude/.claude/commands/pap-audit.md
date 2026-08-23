---
name: pap-audit
description: Multi-agent audit of a pre-analysis plan — checks hypothesis-theory entailment, hypothesis-design identification, and logistical completeness in parallel, then proposes improvements behind an approval gate and applies approved edits with verification. Reads project conventions from CLAUDE.md; works for any PAP-bearing project.
---

# /pap-audit — Multi-agent PAP audit

Audit a project's pre-analysis plan along three independent axes:
1. **Entailment** — does each hypothesis directly follow from the theory section?
2. **Design contrast** — does the experimental design cleanly identify each hypothesis?
3. **Logistics** — is the PAP operationally complete by pre-registration norms?

Phases 1–3 run as **three parallel subagents**. Phases 4 (improvement proposals + approval gate) and 5 (edits + verification) run in the main conversation.

This skill is **interactive**. Do not run it inside `/loop` or a scheduled cron — Phase 4 requires the user to be at the keyboard.

## Phase 0 — Discover project context (mandatory)

Before spawning anything, **read `CLAUDE.md`** at the project root and extract every fact below. If `CLAUDE.md` does not contain a fact, recover it by reading the PAP, or — if still ambiguous — ask the user. Do not guess.

Record this context bundle:

- `PAP_PATH` — path to the PAP `.tex` (or other format) file. Common patterns: `pre_analysis_plan.tex`, `pap.tex`, files under `01_pap/`, `PAP/`, `pre-registration/`. If the file is a symlink (e.g., to Overleaf), note this — do not delete and recreate it during edits, and do not compile locally.
- `BIB_PATH` — bibliography file, if any.
- `HYPOTHESIS_LABELS` — list of labels in the file (e.g., `H1, H2a, H2b, ...`).
- `DESIGN_CELLS` — the experimental conditions as written.
- `CAUSAL_STRUCTURE` — any committed mediator(s), moderator(s), and the channel structure.
- `ALTERNATIVE_MECHANISMS` — pre-specified rivals to discriminate against.
- `DESIGN_AGNOSTICISM` — any dimension across which the design is described as agnostic (modality, framing, dosage source).
- `TERMINOLOGY_GUARDS` — preferred vs. forbidden terms (e.g., "submissive" not "non-dominant").
- `CITATION_OVEREXTENSION_WARNINGS` — citations that `CLAUDE.md` flags as routinely misrepresented; never propose edits that rely on these without re-reading the actual paper.
- `FORMATTING_CONVENTIONS` — bib style (natbib + chicago, biblatex, etc.), spacing (`\onehalfspacing`, `\doublespacing`), block-paragraph rules, languages / encodings.
- `BUILD_POLICY` — does the user compile locally, or is the file synced to Overleaf / similar (no local build)?

If `CLAUDE.md` does not exist, ask the user before proceeding.

### Phase 0 sanity check

1. Confirm `PAP_PATH` exists. If it's expected to be a symlink, verify with `ls -la`. Stop if broken.
2. Read the first ~150 lines of the PAP plus the hypothesis section to confirm `HYPOTHESIS_LABELS` match the file. Update if they differ.
3. Note the rough section structure (Introduction / Theory / Design / Hypotheses / Estimator / Appendix) with line ranges.

## Phase 1–3 — Spawn three subagents in parallel

In a **single message**, spawn three Agent calls simultaneously:

- `pap-entailment-auditor` — Phase 1
- `pap-design-auditor` — Phase 2
- `pap-logistics-auditor` — Phase 3

Pass each subagent the full Phase 0 context bundle so it does not have to re-derive the inputs. Tell each: "Return only your structured report. The orchestrator will collate."

Wait for all three to finish before continuing.

## Phase 3.5 — Collate

Render the three reports back-to-back to the user under the headings **Phase 1 — Entailment**, **Phase 2 — Design contrast**, **Phase 3 — Logistics**. Do not summarize away the tables; the user needs the raw findings to evaluate proposals. Add a one-line top-of-output count, e.g.:

```
entailment: 2 over-claims, 1 not entailed | design: 1 under-identified | logistics: 4 partial, 2 missing
```

## Phase 4 — Improvement proposals (APPROVAL GATE)

Generate a numbered list of concrete improvement proposals. Each proposal:

- (a) **Issue addressed** — cross-reference the specific Phase 1 / 2 / 3 row.
- (b) **Concrete change** — exact text or structural edit. For text additions, draft the actual sentence(s) verbatim, in the project's style and terminology guards.
- (c) **Tradeoff or risk** — what gets harder, what assumption is added, what new disclosure becomes necessary.
- (d) **Target location** — section heading and line range in the PAP.
- (e) **New citations needed** — bib key, full reference, and whether the key already exists in `BIB_PATH` (grep first; do not assume). Do not propose a citation that lands on a `CITATION_OVEREXTENSION_WARNINGS` entry without first re-reading the actual paper to verify it supports the claim.

After listing, **STOP**. Tell the user explicitly to reply per item with one of:

- `y` — approve as written
- `n` — reject
- `modify: <change>` — approve with a modification

Do not bulk-infer approval. Do not proceed to Phase 5 on a vague "looks good."

## Phase 5 — Apply approved edits, then verify

For each approved item, edit the PAP (and `BIB_PATH` if new citations are needed). Preserve everything in `FORMATTING_CONVENTIONS` and `TERMINOLOGY_GUARDS`. If `BUILD_POLICY` says "no local build", do not compile.

If the PAP file is a symlink, edit through it — do **not** delete and recreate it as a regular file (this would break the sync).

### Verification (run all four; report each)

- **V1.** Re-read each edited block. Confirm the approved change is in place, byte-accurate to what the user approved (or to the `modify:` text).
- **V2.** Confirm the hypothesis section remains consistent with the theory section after edits. Flag any new entailment gap.
- **V3.** For every new `\cite{}` (or equivalent) key, grep `BIB_PATH` and confirm the key resolves. If a new entry was added, confirm it's well-formed (no unmatched braces, required fields present).
- **V4.** Confirm no edit relies on a `CITATION_OVEREXTENSION_WARNINGS` citation in an overextended way.

### Final report

- Items applied (cross-ref Phase 4 numbers).
- Items the user approved that you could not cleanly implement, with reason.
- Any new entailment / contrast gap introduced by the edits.

## Output conventions

- Phases 1–3: tables with line-range refs, terse prose only.
- Phase 4: numbered list, then HARD STOP.
- Phase 5: only after per-item approvals.
- No executive summary, no PAP recap, no pleasantries.
- `unclear from PAP` is a valid finding; guessing is not.
