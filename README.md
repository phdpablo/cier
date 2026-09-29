# Careless/Insufficient Effort Responding (C/IER)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23002392.svg)](https://doi.org/10.5281/zenodo.23002392)
[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](LICENSE.md)

**Author:** [Pablo Rogers](https://orcid.org/0000-0002-0093-3834) — Universidade Federal de Uberlândia (UFU)  
**Online Tutorial:** [https://phdpablo.github.io/cier/](https://phdpablo.github.io/cier/)  
**DOI:** [10.5281/zenodo.23002392](https://doi.org/10.5281/zenodo.23002392)

---

### 📌 Citation

If you use or adapt this compendium, code, or methodology in your research, please cite:

> Rogers, P. (2026). *Careless/Insufficient Effort Responding (C/IER) Detection* (Version v1.0) [Computer software]. Zenodo. https://doi.org/10.5281/zenodo.23002392

```bibtex
@software{rogers2026cier,
  author       = {Rogers, Pablo},
  title        = {{Careless/Insufficient Effort Responding (C/IER) Detection}},
  year         = {2026},
  version      = {v1.0},
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.23002392},
  url          = {https://doi.org/10.5281/zenodo.23002392}
}
```

---

This repository presents a reproducible tutorial on detecting
**Careless/Insufficient Effort Responding (C/IER)** in self-report
questionnaires.

Using responses to the **WHOQOL-Bref** scale as an example, the tutorial
demonstrates a two-stage data quality control workflow in R and Quarto:
procedural criteria defined before the analysis and statistical indicators
calculated after data collection.

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
│   ├── InputData/            # raw survey data and metadata/codebook
│   ├── IntermediateData/     # intermediate processed datasets (whoqol_imported, whoqol_screened)
│   └── AnalysisData/         # final analysis-ready dataset (whoqol_analysis)
├── Scripts/
│   ├── ProcessingScripts/    # companion notebooks (01_procedural.qmd, 02_posthoc.qmd)
│   ├── AnalysisScripts/      # destination for prospective substantive analyses
│   └── DataAppendixScripts/  # companion hub (03_resources.qmd) and automated lifecycle hooks (.R)
├── Output/
│   ├── Results/              # published canonical tables (tbl-*.csv) and figures (fig-*.png)
│   └── DataAppendixOutput/   # procedural audit logs (exclusion_log.csv, posthoc-exclusion-log.csv)
├── Resources/                # pedagogical companion assets (interactive HTML widgets, media presentation, slides)
│   ├── Interactive/          # standalone interactive HTML explorers (lazyR, kneedle_sim, kneedle_real)
│   ├── Media/                # HTML master presentation (cier_presentation.html)
│   └── Slides/               # visual slide deck image gallery (*.jpg)
├── index.qmd                 # main Quarto Manuscript article
├── _quarto.yml               # Quarto manuscript configuration and lifecycle hooks
├── references.bib            # bibliographic references
├── LICENSE.md                # Creative Commons Attribution-NonCommercial 4.0 (CC BY-NC 4.0)
└── renv.lock                 # locked R package environment (R 4.5.2)
```

The `Data`, `Scripts`, and `Output` directories include their own documentation,
organized according to the recommendations of the
[TIER Protocol 4.0](https://www.projecttier.org/tier-protocol/).

## ♻️ Reproducibility

To reproduce the project, install:

- [R](https://cran.r-project.org/) (version 4.5.2);
- [Quarto CLI](https://quarto.org/) (version 1.9.37);
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

### Rendering the Manuscript

Render the complete manuscript and companion notebooks from the project root:

```bash
# Render to all configured formats (HTML, PDF, DOCX)
quarto render

# Or render to a specific target format:
quarto render --to html
quarto render --to pdf
quarto render --to docx
```

The Quarto build pipeline incorporates automated, lightweight Base R lifecycle hooks registered in `_quarto.yml`:
1. **Pre-render** (`Scripts/DataAppendixScripts/pre_render_prepare.R`): validates raw data inputs and directory scaffolding.
2. **Post-render** (`Scripts/DataAppendixScripts/post_render_figures.R` & `post_render_tables.R`): dynamically mirrors published assets to `docs/Output/` and synchronizes notebook preview assets.


## 📄 License

This research compendium and all associated materials (manuscript text, companion notebooks, data documentation, tables, and figures) are licensed under the **Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0)**. See [LICENSE.md](LICENSE.md) for full terms.

---

If this material is useful for teaching or research, please consult and cite
the methodological references provided in the tutorial.
