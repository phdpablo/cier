# AnalysisScripts Folder

## Overview

The `AnalysisScripts` folder is reserved for prospective substantive analyses that utilize the final, screened dataset produced by the C/IER screening pipeline.

## Architectural Context (TIER Protocol 4.0)

In the Project TIER Protocol 4.0 architecture:
- **`ProcessingScripts/`**: Handles data ingestion, cleaning, procedural exclusions, and diagnostic post-hoc screening of Careless/Insufficient Effort Responding (C/IER). Its final analytical deliverable is `Data/AnalysisData/whoqol_analysis.csv`.
- **`AnalysisScripts/`**: Houses subsequent substantive models—such as Confirmatory Factor Analysis (CFA), Exploratory Structural Equation Modeling (ESEM), or regression models—that estimate substantive parameters on the clean sample.

## Current Project Scope

Because this repository serves as a focused tutorial and methodological template on **C/IER detection and screening**, the core data transformation and diagnostic indicators reside entirely within `Scripts/ProcessingScripts/`.

Researchers extending this project with downstream psychometric or empirical analyses should place their modeling scripts in this directory, adhering to the same self-contained and reproducible standards:
1. Load data directly from `Data/AnalysisData/whoqol_analysis.csv`.
2. Use `here::here()` for cross-platform path resolution.
3. Export downstream results to `Output/Results/` or `Output/AnalysisOutput/`.
