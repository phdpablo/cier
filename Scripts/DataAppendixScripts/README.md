# DataAppendixScripts Folder

## Overview

The `DataAppendixScripts` folder contains automated lifecycle hooks invoked by the Quarto Manuscript build system (`_quarto.yml`).

These scripts run in **Base R with zero external dependencies** (`Rscript --vanilla`), guaranteeing that project preparation, output synchronization, and preview integrity checks execute reliably across different environments.

## Script Inventory

### 1. `pre_render_prepare.R` (Pre-render Hook)
- **Role**: Validates execution context and directory readiness before any `.qmd` files are knitted.
- **Actions**:
  1. Verifies that execution takes place from the project root (`_quarto.yml` present).
  2. Asserts the presence of mandatory raw data (`Data/InputData/data.csv`) and main article (`index.qmd`).
  3. Ensures that all required TIER 4.0 directory trees (`Data/IntermediateData`, `Data/AnalysisData`, `Output/Results/Figures`, `Output/Results/Tables`, `Output/DataAppendixOutput/Tables`, etc.) exist prior to notebook execution.
- **Safety**: Does not modify code or perform duplicate heavy computations.

### 2. `post_render_figures.R` (Post-render Hook)
- **Role**: Synchronizes graphical assets after compilation.
- **Actions**:
  1. Dynamically discovers all image files (`.png`, `.pdf`, `.svg`) in `Output/Results/Figures/` and mirrors them to `docs/Output/Results/Figures/` for web publication.
  2. Resolves Quarto's native companion notebook preview limitation: inspects rendered `*-preview.html` files in `docs/Scripts/ProcessingScripts/`, identifies referenced `<img>` elements, and synchronizes the corresponding images into `<notebook>_files/figure-html/`.
  3. Safely removes temporary intermediate notebook build folders (`*_files`) from the source tree (`Scripts/ProcessingScripts/`), keeping the workspace clean.
- **Design**: 100% dynamic — contains no hardcoded lists of figure names, ensuring resilience as figures are added or modified.

### 3. `post_render_tables.R` (Post-render Hook)
- **Role**: Synchronizes tabular outputs and audit documentation.
- **Actions**:
  1. Dynamically mirrors all published CSV tables from `Output/Results/Tables/` to `docs/Output/Results/Tables/`.
  2. Dynamically mirrors audit logs from `Output/DataAppendixOutput/Tables/` to `docs/Output/DataAppendixOutput/Tables/`.
  3. Verifies embedded table references in `docs/index.html` when an HTML build is executed.
- **Design**: 100% dynamic — operates without hardcoded table names or rigid assert failures, preserving direct analytical CSV exports.

## Configuration in `_quarto.yml`

The hooks are registered in the project configuration as follows:

```yaml
project:
  type: manuscript
  output-dir: docs
  pre-render:
    - Rscript Scripts/DataAppendixScripts/pre_render_prepare.R
  post-render:
    - Rscript Scripts/DataAppendixScripts/post_render_figures.R
    - Rscript Scripts/DataAppendixScripts/post_render_tables.R
```
