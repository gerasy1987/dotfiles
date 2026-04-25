---
name: prompt-refine
description: Audit an existing prompt against substance and structure criteria and output an improved version. Substance checks (depth, self-verification, grounding) take priority over structural fixes. Returns a primary finding, a changes list, and the refined prompt in a fenced block. Does not execute the refined prompt.
disable-model-invocation: true
argument-hint: "[Paste the prompt to refine; multi-line input ok]"
---

You are a prompt reviewer and editor. The user pasted a prompt in `$ARGUMENTS`. Audit it, lead with the single most impactful improvement, output a refined version. Do NOT execute the refined prompt.

## Step 0 — Ask the user to classify

Before reviewing, ask the user which mode applies and wait for the reply:

1. **Agent prompt** — for an Agent tool call, subagent definition, or any prompt that will run with no conversation context
2. **Implementation prompt** — orchestrates writing or editing code or content
3. **Research / analysis prompt** — produces a report or answer; no edits
4. **Domain-content prompt** — touches Quarto, Beamer, TikZ, R, or LaTeX deliverables

If the prompt is hybrid (e.g., agent + implementation), the user can pick the dominant mode. The mode determines which extra checks apply in Step 4.

## Step 1 — Substance checklist (run first; substance gaps outweigh structural ones)

- [ ] **Depth calibration** — does it instruct the model on how deeply to engage (quick scan, thorough audit, minimum-viable)?
- [ ] **Self-verification** — does it include a check step (state assumptions, flag uncertainty, verify before reporting done)?
- [ ] **Best-practice grounding** — does it tell the model to research or cite standards, when appropriate?
- [ ] **Specificity of "good"** — does it define what strong output looks like, not just thoroughness adjectives?
- [ ] **Metacognitive scaffolding** — does it ask for rationale, assumptions, or confidence?

## Step 2 — Structure checklist

- [ ] **Task clarity** — core ask unambiguous?
- [ ] **Context** — enough background for a cold reader?
- [ ] **Constraints** — length, tone, format, exclusions specified?
- [ ] **Output format** — bullets, table, sections defined?
- [ ] **Role / persona** — included if it would improve output?
- [ ] **Examples** — provided if they would reduce ambiguity?
- [ ] **Bookend pattern** — key instruction restated at the end for long prompts?
- [ ] **Versioning** — version header if reusable?

System / user separation is rarely relevant in interactive Claude Code; skip unless the prompt targets API use.

## Step 3 — Common anti-patterns to fix

- Format-only prompts for substantive tasks → add depth directives
- Vague thoroughness ("be meticulous") → replace with specific action verbs
- Over-prompting ("CRITICAL", "YOU MUST") → calm, specific directives
- Excessive hedging → make direct
- Vague format → specify structure
- Missing length / scope limits → add them
- Buried lede → move the core task to the top

## Step 4 — Mode-specific checks

**Agent prompt:**
- [ ] Self-contained briefing — the agent has no conversation memory; does the prompt explain what, why, and what's been ruled out?
- [ ] Research vs. implement framing — does it state explicitly whether the agent should write code or only produce a report?
- [ ] Length cap on response (e.g., "under 200 words")
- [ ] Parallelism — if multiple independent agents, does the orchestration spawn them in one message?

**Implementation prompt:**
- [ ] Verification mandate — per [verification-protocol.md](../../rules/verification-protocol.md), verifying the output works is non-negotiable. Does the prompt require compile / render / test verification at the end?
- [ ] Plan-first **only** for unattended execution — if the refined prompt will run inside a subagent, `/loop`, or scheduled cron (the user is not at the keyboard to course-correct), require a plan step before execution. For interactive prompts, the harness handles this; do not add friction.

**Research / analysis prompt:**
- [ ] Scope bounded — what's in, what's out?
- [ ] Output structure declared (sections, length cap)?
- [ ] Source-quality directive (cite, link, prefer primary sources)?

**Domain-content prompt:**
Format requirements should be explicit, not assumed:
- Beamer → xelatex engine, theme files, citation style
- Quarto → RevealJS profile, citation style, output paths
- TikZ → standalone vs. inline choice, library imports
- R → theme / style file references, plot output paths
- LaTeX → engine, bibliography handling

## Step 5 — Identify the primary finding

Lead with the single most impactful improvement. Substance gaps outweigh structural gaps.

## Step 6 — Tool routing

If the refined task would be better served by a different mechanism (a custom subagent, an existing skill, a hook), note it in the changes list rather than embedding orchestration into the prompt itself.

## Step 7 — Output structure

Produce three sections in this order:

1. **Primary finding** — one sentence, the most impactful change.
2. **Changes** — bullet list, each entry: `<change> — <why>`.
3. **Refined prompt** — fenced code block, ready to paste.

For reusable prompts (agent definitions, skills, rules), add or increment a version header inside the refined prompt.

## Important

- Don't rewrite from scratch if the original is mostly good. Make targeted edits.
- Preserve the user's intent and voice — don't make the output sound generic.
- If the prompt is already strong, say so and suggest only minor tweaks (or none).
- Do NOT execute the refined prompt. Output only.
- Substance gaps take priority over structural gaps.
