# ==============================================================================
# post_render_tables.R
# Dynamic Post-render Table Synchronizer for Quarto Manuscript (TIER 4.0)
#
# Dynamically mirrors any generated CSV tables and logs from Output/ to docs/
# for online distribution, and reports what was synchronized.
# Fully dynamic: zero hardcoded filenames, zero brittle assertions.
# Runs in Base R with zero external dependencies (--vanilla).
# ==============================================================================

root_dir <- getwd()
tables_dir <- file.path(root_dir, "Output", "Results", "Tables")
logs_dir <- file.path(root_dir, "Output", "DataAppendixOutput", "Tables")
docs_dir <- file.path(root_dir, "docs")

if (dir.exists(docs_dir)) {
  # 1. Mirror whatever tables exist in Output/Results/Tables/
  if (dir.exists(tables_dir)) {
    tbl_files <- list.files(tables_dir, pattern = "\\.csv$", full.names = FALSE)
    if (length(tbl_files) > 0) {
      docs_tables_dir <- file.path(docs_dir, "Output", "Results", "Tables")
      dir.create(docs_tables_dir, recursive = TRUE, showWarnings = FALSE)
      for (tbl in tbl_files) {
        file.copy(file.path(tables_dir, tbl), file.path(docs_tables_dir, tbl), overwrite = TRUE)
      }
      message(sprintf("[post_render_tables] Dynamically mirrored %d tables to docs/Output/Results/Tables/.", length(tbl_files)))
    }
  }
  
  # 2. Mirror whatever logs exist in Output/DataAppendixOutput/Tables/
  if (dir.exists(logs_dir)) {
    log_files <- list.files(logs_dir, pattern = "\\.csv$", full.names = FALSE)
    if (length(log_files) > 0) {
      docs_logs_dir <- file.path(docs_dir, "Output", "DataAppendixOutput", "Tables")
      dir.create(docs_logs_dir, recursive = TRUE, showWarnings = FALSE)
      for (lf in log_files) {
        file.copy(file.path(logs_dir, lf), file.path(docs_logs_dir, lf), overwrite = TRUE)
      }
      message(sprintf("[post_render_tables] Dynamically mirrored %d audit logs to docs/Output/DataAppendixOutput/Tables/.", length(log_files)))
    }
  }
}

message("[post_render_tables] Post-render table synchronization completed successfully.")
