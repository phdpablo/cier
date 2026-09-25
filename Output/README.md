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

## Guidelines

- **Traceability**: All output files are generated programmatically by notebooks in `Scripts/ProcessingScripts/`. No file in this directory should ever be modified manually.
- **Direct Export**: All tables are generated via direct R object export (`readr::write_csv2()`), guaranteeing exact numerical precision and reproducibility.
- **Web Distribution**: During manuscript builds, outputs are dynamically mirrored to `docs/Output/` for web availability without duplicating tracked source assets.

## Additional Resources

For more detailed instructions and best practices, refer to the [TIER Protocol 4.0 Output Guidelines](https://www.projecttier.org/tier-protocol/protocol-4-0/root/output/).
