# ==============================================================================
# pre_render_prepare.R
# Pre-render preparation hook for Quarto Manuscript (TIER Protocol 4.0)
#
# Verifies presence of required input data and project configuration, and ensures
# that all standard TIER 4.0 output and intermediate directories exist.
# Does NOT execute computations or re-render files.
# Runs in Base R with zero external dependencies (--vanilla).
# ==============================================================================

root_dir <- getwd()

# 1. Validate execution context
if (!file.exists(file.path(root_dir, "_quarto.yml"))) {
  stop("[pre_render_prepare] Error: Must be executed from project root (containing _quarto.yml).")
}

message("[pre_render_prepare] Initializing pre-render verification...")

# 2. Check required source inputs
raw_data_path <- file.path(root_dir, "Data", "InputData", "data.csv")
if (!file.exists(raw_data_path)) {
  stop(sprintf("[pre_render_prepare] Error: Raw input data missing: %s", raw_data_path))
}

article_path <- file.path(root_dir, "index.qmd")
if (!file.exists(article_path)) {
  stop("[pre_render_prepare] Error: Main manuscript article 'index.qmd' missing.")
}

# 3. Ensure required TIER 4.0 directory structure exists
required_dirs <- c(
  file.path(root_dir, "Data", "IntermediateData"),
  file.path(root_dir, "Data", "AnalysisData"),
  file.path(root_dir, "Output", "Results", "Figures"),
  file.path(root_dir, "Output", "Results", "Tables"),
  file.path(root_dir, "Output", "DataAppendixOutput", "Tables"),
  file.path(root_dir, "Output", "DataAppendixOutput", "Figures")
)

created_dirs <- character(0)
for (d in required_dirs) {
  if (!dir.exists(d)) {
    dir.create(d, recursive = TRUE, showWarnings = FALSE)
    created_dirs <- c(created_dirs, d)
  }
}

if (length(created_dirs) > 0) {
  message(sprintf("[pre_render_prepare] Created %d missing directory(ies).", length(created_dirs)))
}

message("[pre_render_prepare] Verified: Raw data and project configuration present.")
message("[pre_render_prepare] Pre-render preparation complete.")
