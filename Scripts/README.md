# Scripts Folder

## Overview

The `Scripts` folder holds all computational scripts and executable companion notebooks for the CIER project, organized according to **Project TIER Protocol 4.0** guidelines.

## Subdirectories

### 1. `ProcessingScripts/`
Contains the core analytical and diagnostic Quarto companion notebooks that transform raw survey responses into the final analysis-ready dataset:
- **`01_procedural.qmd`**: Level 1 procedural exclusions (dropout identification, response time filtering, attention check evaluation, missing item control).
- **`02_posthoc.qmd`**: Level 2 post-hoc statistical C/IER detection (Laz.R, Longstring, Mahalanobis Distance, IRV, Kneedle thresholding, and composite decision rules).

### 2. `DataAppendixScripts/`
Contains lightweight, zero-dependency Base R scripts executed as pre-render and post-render lifecycle hooks by Quarto (`_quarto.yml`):
- **`pre_render_prepare.R`**: Pre-render environment verification and folder scaffolding.
- **`post_render_figures.R`**: Post-render dynamic figure mirroring to `docs/` and synchronization of companion notebook preview assets.
- **`post_render_tables.R`**: Post-render dynamic table and log mirroring to `docs/Output/`.

### 3. `AnalysisScripts/`
Reserved for downstream substantive analytical models (e.g., Confirmatory Factor Analysis [CFA] or Structural Equation Modeling [SEM] operating on the screened `whoqol_analysis.csv` dataset).

## Execution and Reproduction Workflow

The execution flow is orchestrated seamlessly by the Quarto Manuscript build system:

```text
[ quarto render ]
       │
       ▼
 1. pre_render_prepare.R      ──> Checks inputs (data.csv) & builds directory scaffold
       │
       ▼
 2. 01_procedural.qmd         ──> Level 1: raw data -> whoqol_imported.csv + exclusion_log.csv
       │
       ▼
 3. 02_posthoc.qmd            ──> Level 2: whoqol_imported.csv -> whoqol_analysis.csv + tables/plots
       │
       ▼
 4. index.qmd                 ──> Compiles manuscript (embeds chunks via {{< embed >}})
       │
       ▼
 5. post_render_figures.R     ──> Dynamically mirrors figures & syncs notebook preview assets
 6. post_render_tables.R      ──> Dynamically mirrors tables and audit logs to docs/
```

To execute manually in R without rendering the manuscript, run the processing notebooks in order:
1. `Scripts/ProcessingScripts/01_procedural.qmd`
2. `Scripts/ProcessingScripts/02_posthoc.qmd`

## Additional Resources

Refer to the [TIER Protocol 4.0 Scripts Guidelines](https://www.projecttier.org/tier-protocol/protocol-4-0/root/scripts/) for standard replication specifications.
