# ==============================================================================
# post_render_figures.R
# Dynamic Post-render Figure Synchronizer for Quarto Manuscript (TIER 4.0)
#
# 1. Dynamically mirrors all generated figures from Output/Results/Figures/ to docs/.
# 2. Dynamically synchronizes figure assets for companion notebook previews (*-preview.html),
#    resolving Quarto's native preview asset placement limitation.
# 3. Cleans up temporary intermediate build directories (*_files) from source script folders.
# Fully dynamic: zero hardcoded filenames, zero brittle assertions.
# Runs in Base R with zero external dependencies (--vanilla).
# ==============================================================================

root_dir <- getwd()
out_figs_dir <- file.path(root_dir, "Output", "Results", "Figures")
docs_dir <- file.path(root_dir, "docs")
docs_figs_dir <- file.path(docs_dir, "Output", "Results", "Figures")
index_figs_dir <- file.path(docs_dir, "index_files", "figure-html")

# ------------------------------------------------------------------------------
# 1. Dynamic mirror of Output/Results/Figures/ to docs/
# ------------------------------------------------------------------------------
if (dir.exists(out_figs_dir) && dir.exists(docs_dir)) {
  present_figs <- list.files(out_figs_dir, pattern = "\\.(png|pdf|svg|jpg|jpeg)$", full.names = FALSE)
  if (length(present_figs) > 0) {
    dir.create(docs_figs_dir, recursive = TRUE, showWarnings = FALSE)
    for (fig in present_figs) {
      file.copy(file.path(out_figs_dir, fig), file.path(docs_figs_dir, fig), overwrite = TRUE)
    }
    message(sprintf("[post_render_figures] Dynamically mirrored %d figures to docs/Output/Results/Figures/.", length(present_figs)))
  }
}

# ------------------------------------------------------------------------------
# 2. Workaround for Quarto freeze figure directory if knitr generates index_files in root
# ------------------------------------------------------------------------------
if (dir.exists(docs_dir)) {
  root_index_files <- file.path(root_dir, "index_files")
  if (dir.exists(root_index_files)) {
    dir.create(index_figs_dir, recursive = TRUE, showWarnings = FALSE)
    root_figs <- list.files(file.path(root_index_files, "figure-html"), full.names = TRUE)
    if (length(root_figs) > 0) {
      file.copy(root_figs, index_figs_dir, overwrite = TRUE)
    }
    unlink(root_index_files, recursive = TRUE)
  }
}

# ------------------------------------------------------------------------------
# 3. Dynamic figure synchronization for companion notebook previews (*-preview.html)
# ------------------------------------------------------------------------------
docs_scripts_dirs <- c(
  file.path(docs_dir, "Scripts", "ProcessingScripts"),
  file.path(docs_dir, "Scripts", "AnalysisScripts")
)

synced_preview_figs <- 0

for (s_dir in docs_scripts_dirs) {
  if (!dir.exists(s_dir)) next
  
  preview_files <- list.files(s_dir, pattern = "-preview\\.html$", full.names = TRUE)
  index_files <- if (dir.exists(index_figs_dir)) list.files(index_figs_dir, full.names = TRUE) else character(0)
  
  for (pf in preview_files) {
    nb_name <- sub("-preview\\.html$", "", basename(pf))
    lines <- readLines(pf, warn = FALSE)
    
    # Match all <img src="<nb_name>_files/figure-html/([^"\' >]+)">
    pattern <- sprintf('%s_files/figure-html/([^"\' >]+)', nb_name)
    matches <- regmatches(lines, gregexpr(pattern, lines))
    found_refs <- unique(unlist(matches))
    
    if (length(found_refs) == 0) next
    
    target_preview_dir <- file.path(s_dir, paste0(nb_name, "_files"), "figure-html")
    dir.create(target_preview_dir, recursive = TRUE, showWarnings = FALSE)
    
    for (ref in found_refs) {
      img_name <- basename(ref)
      target_file <- file.path(target_preview_dir, img_name)
      fig_stem <- sub("-\\d+\\.[a-zA-Z]+$", "", img_name)
      
      # 1. Search in docs/index_files/figure-html/
      matching_idx <- index_files[grepl(fig_stem, basename(index_files), fixed = TRUE)]
      if (length(matching_idx) > 0) {
        file.copy(matching_idx[1], target_file, overwrite = TRUE)
        synced_preview_figs <- synced_preview_figs + 1
      } else {
        # 2. Search in Output/Results/Figures/
        fallback_file <- file.path(out_figs_dir, paste0(fig_stem, ".png"))
        if (file.exists(fallback_file)) {
          file.copy(fallback_file, target_file, overwrite = TRUE)
          synced_preview_figs <- synced_preview_figs + 1
        }
      }
    }
  }
}

if (synced_preview_figs > 0) {
  message(sprintf("[post_render_figures] Synchronized %d figure assets to notebook preview directories.", synced_preview_figs))
}

# ------------------------------------------------------------------------------
# 4. Safe cleanup of intermediate notebook build artifacts (*_files) in source tree
# ------------------------------------------------------------------------------
src_scripts_dirs <- c(
  file.path(root_dir, "Scripts", "ProcessingScripts"),
  file.path(root_dir, "Scripts", "AnalysisScripts")
)

for (s_dir in src_scripts_dirs) {
  if (!dir.exists(s_dir)) next
  leftovers <- list.files(s_dir, pattern = "_files$", full.names = TRUE)
  for (lft in leftovers) {
    unlink(lft, recursive = TRUE)
  }
}

message("[post_render_figures] Post-render figure synchronization completed successfully.")
