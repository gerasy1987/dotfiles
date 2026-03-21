if (interactive()) {
  columns <- suppressWarnings(as.integer(Sys.getenv("COLUMNS", unset = NA)))

  if (!is.na(columns) && columns > 0) {
    options(width = columns)
  }

  options(setWidthOnResize = TRUE)
}

if (interactive() && Sys.getenv("RSTUDIO") == "" && Sys.getenv("TERM_PROGRAM") == "vscode") {
  vscode_init <- file.path(Sys.getenv("HOME"), ".vscode-R", "init.R")

  if (file.exists(vscode_init)) {
    source(vscode_init)
  }
}