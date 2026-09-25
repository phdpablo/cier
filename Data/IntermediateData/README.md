# IntermediateData Folder

## Overview

The `IntermediateData` folder stores datasets generated during intermediate processing stages of the C/IER detection workflow. These files capture the evolution of the survey data between raw input ingestion and the final analysis-ready dataset, conforming to **Project TIER Protocol 4.0**.

## File Inventory

### 1. `whoqol_imported.csv`
- **Generating Script**: `Scripts/ProcessingScripts/01_procedural.qmd`
- **Sample Size**: 1,295 rows × 31 columns.
- **Description**: Dataset of eligible respondents retained after Level 1 procedural screening (dropouts removed, completion time `TIME >= 208 s`, quality control failures `qc_fails < 2`, and missing scale items `na_count <= 5`).
- **Variables**: `ID`, attention items (`CQ1`, `CQ2`, `CQ3`), total duration (`TIME`), and original item responses (`Q1:Q26`). Item responses remain in their raw positive/negative scale orientation.

### 2. `whoqol_screened.csv`
- **Generating Script**: `Scripts/ProcessingScripts/02_posthoc.qmd`
- **Sample Size**: 1,295 rows × 43 columns.
- **Description**: Comprehensive intermediate dataset appending all computed C/IER statistical indices (`LazR`, `Longstr`, `MD`, `IRV`), binary flags derived from Kneedle thresholds, and multi-indicator decision scenario flags.
- **Variables**: Respondent identifiers, item responses, indicator values, individual flag indicators (`*_FLAG`), pairwise combinations, and scenario indicators (`scenario_a`, `scenario_b`, `scenario_c`, `scenario_d`).

## Guidelines

- All files in this directory are programmatically generated and fully reproducible.
- Neither file should ever be modified manually.
