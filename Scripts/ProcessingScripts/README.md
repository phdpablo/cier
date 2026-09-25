# ProcessingScripts Folder

## Overview

The `ProcessingScripts` folder holds the computational Quarto companion notebooks (`.qmd`) responsible for cleaning, filtering, and performing statistical screening of Careless/Insufficient Effort Responding (C/IER) on the survey data.

Each notebook is self-contained, relies on project-root path resolution (`here::here()`), and exposes labelled chunks consumed directly by the main manuscript (`index.qmd`) via Quarto's `{{< embed >}}` shortcodes.

## Notebook Inventory

### 1. `01_procedural.qmd` (Level 1: Procedural Exclusions)
- **Objective**: Import raw survey responses, eliminate dropouts, derive response duration (`TIME`), and apply *a priori* procedural exclusion criteria before calculating statistical response-pattern indicators.
- **Inputs**:
  - `Data/InputData/data.csv`: Raw survey response dataset.
- **Key Steps**:
  1. Identifies and removes complete dropouts (missing `ID` or 0 valid answers in `Q1:Q26`).
  2. Derives total completion time in seconds: `TIME = as.numeric(difftime(MODIFIED_dt, CREATED_dt, units = "secs"))`.
  3. Applies Level 1 exclusion rules:
     - Response time `TIME < 208 s` (104 items × 2 s/item).
     - Quality control failures: `qc_fails >= 2` across `CQ1`, `CQ2`, and `CQ3`.
     - Missing values: `na_count > 5` across the 26 WHOQOL-Bref items (`Q1:Q26`).
- **Outputs**:
  - `Data/IntermediateData/whoqol_imported.csv`: Eligible respondent sample (N = 1,295) for Level 2 analysis.
  - `Output/DataAppendixOutput/Tables/exclusion_log.csv`: Participant-level exclusion audit log.
  - `Output/Results/Tables/tbl-level-1-summary.csv`: Summary table of procedural exclusions (`#tbl-level-1-summary`).

---

### 2. `02_posthoc.qmd` (Level 2: Post-hoc C/IER Indicators)
- **Objective**: Calculate multivariate statistical indicators of careless responding, estimate empirical cut-off thresholds via the Kneedle algorithm, evaluate multi-indicator decision scenarios, and generate the final analysis-ready dataset.
- **Inputs**:
  - `Data/IntermediateData/whoqol_imported.csv`: Prepared dataset from Level 1.
- **Key Steps**:
  1. Computes four diagnostic C/IER indices across `Q1:Q26`:
     - **Laz.R**: transition probabilities between consecutive items (`calc_lazr()`).
     - **Longstring**: maximum consecutive identical responses (`careless::longstring()`).
     - **Mahalanobis Distance (MD)**: multivariate distance accommodating missingness (`modi::MDmiss()`).
     - **Intra-individual Response Variability (IRV)**: standard deviation across items (`careless::irv()`).
  2. Estimates optimal cut-off points using the automated **Kneedle** algorithm (`kneedle()`).
  3. Flags respondents exceeding thresholds and constructs decision rules (Plan A: exclusion if flagged in ≥ 2 indicators among Laz.R, MD, IRV high, and IRV low).
  4. Generates publication-ready univariate and cumulative distribution plots.
  5. Inverts reverse-scored items (`Q3`, `Q4`, and `Q26`) only on the final retained sample.
- **Outputs**:
  - `Data/IntermediateData/whoqol_screened.csv`: Dataset with individual indicator values and flag variables.
  - `Data/AnalysisData/whoqol_analysis.csv`: Cleaned, analysis-ready sample (N = 1,233) with recoded items.
  - `Output/DataAppendixOutput/Tables/posthoc-exclusion-log.csv`: Audit log of post-hoc exclusions.
  - `Output/Results/Figures/`: 8 canonical PNG figures (`fig-viz-*.png`, `fig-cum-*.png`).
  - `Output/Results/Tables/`: 7 canonical CSV tables (`tbl-kneedle-cutoffs.csv`, `tbl-flags-overview.csv`, etc.).

## Guidelines

- **Self-Contained Execution**: All file paths use `here::here()`. Working directory is set to project root (`execute-dir: project` in `_quarto.yml`).
- **Direct Export**: All tables are written directly using `readr::write_csv2()` to guarantee exact numerical reproducibility.
- **Traceability**: All chunk names match the `#tbl-*` and `#fig-*` convention for cross-referencing and Quarto manuscript embeds.
