---
name: Use DeclareDesign for simulations
description: Always use DeclareDesign package for Monte Carlo simulations, not hand-rolled loops
type: feedback
---

When the user asks for a simulation (e.g., to check bias, coverage, power), use the `DeclareDesign` package with `declare_population`, `declare_assignment`, `declare_reveal`, `declare_estimator`, and `diagnose_design`.

**Why:** The user explicitly corrected a hand-rolled simulation loop and asked for DeclareDesign instead. DeclareDesign provides standardized diagnostics (bias, RMSE, coverage, power) and parallelization via `future`.

**How to apply:** Structure simulations as a DeclareDesign `design` object. Use `label_estimator()` to wrap custom estimator functions. Use `diagnose_design(sims = N)` for results. Use `future::plan(future::multisession)` for parallelization.
