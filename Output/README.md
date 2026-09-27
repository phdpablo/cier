# Output Folder

## Overview

The `Output` folder stores all products, published findings, and audit documentation generated across the CIER data cleaning and analysis pipeline, structured according to the **TIER Protocol 4.0**.

## Subdirectories

### 1. `Results/`
Stores canonical, published analytical outputs directly embedded in the manuscript article (`index.qmd`):
- **`Tables/`**: Canonical CSV tables (`tbl-*.csv`), exported directly from analytical R objects.
- **`Figures/`**: Canonical PNG figures (`fig-*.png`), exported at publication resolution via `ggsave()`.

### 2. `DataAppendixOutput/`
Stores procedural logs and technical audit artifacts that document the exclusion trail:
- **`Tables/`**: Audit CSV logs (`exclusion_log.csv` and `posthoc-exclusion-log.csv`).
- **`Figures/`**: Reserved for auxiliary data appendix figures if required.
