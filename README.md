# Careless/Insufficient Effort Responding (C/IER)

This repository presents a reproducible tutorial on detecting
**Careless/Insufficient Effort Responding (C/IER)** in self-report
questionnaires.

Using responses to the **WHOQOL-Bref** scale as an example, the tutorial
demonstrates a two-stage data quality control workflow in R and Quarto:
procedural criteria defined before the analysis and statistical indicators
calculated after data collection.

> 📖 **Tutorial:** [view the published version on GitHub Pages](https://phdpablo.github.io/cier/)

## 🎯 Objective

This project was developed for educational purposes. It demonstrates how to:

- document procedural exclusions while preserving traceability;
- calculate different C/IER indicators;
- estimate cut-off points using the Kneedle algorithm;
- produce tables, figures, and intermediate datasets reproducibly;
- separate input data, processed data, scripts, and outputs.

The tutorial does not aim to cover every strategy available in the literature.
The procedures presented here should be evaluated in light of the instrument,
population, and design of each study.

## 🔎 Analysis workflow

### 1. Procedural criteria

The first stage identifies:

- questionnaire dropout;
- total response time below 208 seconds;
- two or more failures across three quality control items;
- more than five missing responses across the 26 WHOQOL-Bref items.

Each exclusion and its corresponding reason are recorded in a log. Original
item responses are preserved for the response-pattern indicators.

### 2. Post-hoc indicators

Four indicators are calculated for eligible responses:

- **Laz.R**;
- **Longstring**;
- **Mahalanobis distance**, adjusted for missing values;
- **Intra-Individual Response Variability (IRV)**.

Cut-off points are estimated using the **Kneedle** algorithm. At this stage,
the indicators first serve a **diagnostic** purpose. The final analysis data
exclude respondents with at least two flags among Laz.R, Mahalanobis distance,
IRV high, and IRV low; Longstring remains descriptive and does not enter the
composite decision rule.

Only after all C/IER indicators have been calculated are the reverse-scored
items (`Q3`, `Q4`, and `Q26`) recoded in the final analysis dataset.

## 🗂️ Repository structure

```text
.
├── Data/
│   ├── InputData/          # original data and metadata
│   ├── IntermediateData/   # intermediate processing products
│   └── AnalysisData/       # analysis-ready dataset
├── Scripts/
│   └── ProcessingScripts/  # procedural exclusions and post-hoc indicators
├── Output/
│   └── DataAppendixOutput/ # generated tables and figures
├── docs/                   # rendered version for GitHub Pages
├── index.qmd               # main tutorial manuscript
├── _quarto.yml             # Quarto project configuration
├── references.bib          # bibliographic references
└── renv.lock               # locked R package versions
```

The `Data`, `Scripts`, and `Output` directories include their own documentation,
organized according to the recommendations of the
[TIER Protocol](https://www.projecttier.org/tier-protocol/).

## ♻️ Reproducibility

To reproduce the project, install:

- [R](https://cran.r-project.org/);
- [Quarto](https://quarto.org/);
- the R package [`renv`](https://rstudio.github.io/renv/).

Clone the repository:

```bash
git clone https://github.com/phdpablo/cier.git
cd cier
```

Restore the package environment from the R console:

```r
renv::restore()
```

Then render the manuscript from the project root:

```bash
quarto render
```

Rendered files are written to `docs/`. The processing notebooks can also be
accessed through the Quarto manuscript.

## 👤 Author

**Pablo Rogers**<br>
Federal University of Uberlândia<br>
[ORCID 0000-0002-0093-3834](https://orcid.org/0000-0002-0093-3834)

---

If this material is useful for teaching or research, please consult and cite
the methodological references provided in the tutorial.
