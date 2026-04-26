<!-- Externalized from /home/zhora/dotfiles/claude/.claude/agents/domain-reviewer.md -->

## Lens 1: Assumption Stress Test

For every identification result or theoretical claim on every slide:

- [ ] Is every assumption **explicitly stated** before the conclusion?
- [ ] Are **all necessary conditions** listed?
- [ ] Is the assumption **sufficient** for the stated result?
- [ ] Would weakening the assumption change the conclusion?
- [ ] Are "under regularity conditions" statements justified?
- [ ] For each theorem application: are ALL conditions satisfied in the discussed setup?

<!-- Customize: Add field-specific assumption patterns to check -->

---

## Lens 2: Derivation Verification

For every multi-step equation, decomposition, or proof sketch:

- [ ] Does each `=` step follow from the previous one?
- [ ] Do decomposition terms **actually sum to the whole**?
- [ ] Are expectations, sums, and integrals applied correctly?
- [ ] Are indicator functions and conditioning events handled correctly?
- [ ] For matrix expressions: do dimensions match?
- [ ] Does the final result match what the cited paper actually proves?

---

## Lens 3: Citation Fidelity

For every claim attributed to a specific paper:

- [ ] Does the slide accurately represent what the cited paper says?
- [ ] Is the result attributed to the **correct paper**?
- [ ] Is the theorem/proposition number correct (if cited)?
- [ ] Are "X (Year) show that..." statements actually things that paper shows?

**Cross-reference with:**
- The project bibliography file
- Papers in `master_supporting_docs/supporting_papers/` (if available)
- The knowledge base in `.claude/rules/` (if it has a notation/citation registry)

---

## Lens 4: Code-Theory Alignment

When scripts exist for the lecture:

- [ ] Does the code implement the exact formula shown on slides?
- [ ] Are the variables in the code the same ones the theory conditions on?
- [ ] Do model specifications match what's assumed on slides?
- [ ] Are standard errors computed using the method the slides describe?
- [ ] Do simulations match the paper being replicated?

<!-- Customize: Add your field's known code pitfalls here -->
<!-- Example: "Package X silently drops observations when Y is missing" -->

---

## Lens 5: Backward Logic Check

Read the lecture backwards — from conclusion to setup:

- [ ] Starting from the final "takeaway" slide: is every claim supported by earlier content?
- [ ] Starting from each estimator: can you trace back to the identification result that justifies it?
- [ ] Starting from each identification result: can you trace back to the assumptions?
- [ ] Starting from each assumption: was it motivated and illustrated?
- [ ] Are there circular arguments?
- [ ] Would a student reading only slides N through M have the prerequisites for what's shown?

---

## Cross-Lecture Consistency

Check the target lecture against the knowledge base:

- [ ] All notation matches the project's notation conventions
- [ ] Claims about previous lectures are accurate
- [ ] Forward pointers to future lectures are reasonable
- [ ] The same term means the same thing across lectures
