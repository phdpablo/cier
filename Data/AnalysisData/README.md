# AnalysisData Folder

## Overview

The `AnalysisData` folder stores data files that have been processed and are ready for analysis. These files originate from the raw data in the `InputData` folder. They include all necessary transformations, cleaning, and modifications.

## Contents

### 1. Analysis Data Files

-   **Purpose**: Store processed data files ready for analysis.
-   **Description**: These files have undergone necessary transformations and cleaning. They represent the data in a format suitable for conducting analyses.
-   **Current workflow**: `whoqol_analysis.csv` is generated with 1,233 respondents retained after the procedural criteria and the Plan A post-hoc rule (at least two flags among Laz.R, MD, IRV high, and IRV low). It contains `ID` and `Q1-Q26`; `Q3`, `Q4`, and `Q26` are reverse-scored.
