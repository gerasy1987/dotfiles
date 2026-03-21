---
name: Use future/future.apply for parallelization
description: Prefer future.apply::future_lapply over pbapply::pblapply or parallel::mclapply for parallel computation
type: feedback
---

Use `future` / `future.apply` for parallel computation instead of `pbapply` or `parallel::mclapply`.

**Why:** The user switched from `pbapply` to `future.apply` and found it more performant. `future` also provides a more portable backend (works on all platforms including Windows), cleaner API with `future::plan(future::multisession, workers = N)`, and built-in RNG handling via `future.seed`.

**How to apply:** Use `future.apply::future_lapply()` (with `future.seed` for reproducibility) instead of `pbapply::pblapply(cl = n_cores)` or `parallel::mclapply()`. Set up workers with `future::plan(future::multisession, workers = max(1L, future::availableCores() - 2L))`. Load `future` and `future.apply` packages instead of `pbapply`/`parallel`.

For progress bars, use `progressr` (negligible overhead — updates are batched):
```r
progressr::handlers("txtprogressbar")
result <- progressr::with_progress({
  p <- progressr::progressor(n)
  future.apply::future_lapply(seq_len(n), function(i) {
    p()
    # ... work ...
  }, future.seed = seed)
})
```
