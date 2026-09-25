# DataAppendixOutput Folder

## Overview

The `DataAppendixOutput` folder contains the audit logs and procedural documentation generated during the data cleaning and C/IER screening pipeline, conforming to **Project TIER Protocol 4.0** standards.

## Subdirectories and Contents

### `Tables/` (`Output/DataAppendixOutput/Tables/`)

Stores complete record-level audit logs for all excluded survey participants:

| File Name | Generating Script | Description |
|---|---|---|
| `exclusion_log.csv` | `Scripts/ProcessingScripts/01_procedural.qmd` | Detailed log of all participants removed during Level 1 procedural screening (dropout, duration < 208 s, ≥ 2 QC item failures, > 5 missing items), including respondent `ID`, `criterion`, `value`, and descriptive `detail`. |
| `posthoc-exclusion-log.csv` | `Scripts/ProcessingScripts/02_posthoc.qmd` | Audit log of respondents flagged and excluded by post-hoc C/IER decision rules (Plan A: ≥ 2 flags among Laz.R, MD, IRV high, and IRV low), recording respondent `ID`, individual indicator flags, and composite exclusion rationale. |

### `Figures/` (`Output/DataAppendixOutput/Figures/`)
Reserved for auxiliary diagnostic figures or inspection graphs that are not directly published in the main article body.

## Guidelines

- **Reproducibility**: These files are regenerated during the Quarto execution pipeline.
- **Traceability**: Audit logs provide full traceability so that researchers can verify why any specific observation was retained or excluded from the analysis-ready sample.
