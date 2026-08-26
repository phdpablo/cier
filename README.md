# Respostas descuidadas e esforço insuficiente (C/IER)

Este repositório apresenta um tutorial reproduzível sobre a identificação de
**respostas descuidadas ou com esforço insuficiente** (*Careless/Insufficient
Effort Responding*, C/IER) em questionários de autorrelato.

O exemplo utiliza respostas à escala **WHOQOL-Bref** para demonstrar, em R e
Quarto, um fluxo de controle de qualidade em duas etapas: critérios
procedimentais definidos antes da análise e indicadores estatísticos calculados
após a coleta.

> 📖 **Tutorial:** [acesse a versão publicada no GitHub Pages](https://phdpablo.github.io/cier/)

## 🎯 Objetivo

O projeto foi desenvolvido com finalidade didática. Ele mostra como:

- documentar exclusões procedimentais sem perder a rastreabilidade;
- calcular diferentes indicadores de C/IER;
- estimar pontos de corte com o algoritmo Kneedle;
- produzir tabelas, figuras e bases intermediárias de forma reproduzível;
- separar dados de entrada, dados processados, scripts e resultados.

O tutorial não pretende cobrir todas as estratégias disponíveis na literatura.
Os procedimentos apresentados devem ser avaliados à luz do instrumento, da
população e do desenho de cada pesquisa.

## 🔎 Fluxo da análise

### 1. Critérios procedimentais

A primeira etapa identifica:

- abandono do questionário;
- tempo total de resposta inferior a 208 segundos;
- duas ou mais falhas entre três questões de controle de qualidade;
- mais de cinco respostas ausentes nos 26 itens do WHOQOL-Bref.

As exclusões e seus respectivos motivos são registradas em um log. Em seguida,
os itens de pontuação reversa (`Q3`, `Q4` e `Q26`) são recodificados.

### 2. Indicadores pós-hoc

Para as respostas elegíveis, são calculados quatro indicadores:

- **Laz.R**;
- **Longstring**;
- **distância de Mahalanobis**, com tratamento de valores ausentes;
- **Intra-Individual Response Variability (IRV)**.

Os pontos de corte são estimados com o algoritmo **Kneedle**. Nesta etapa, os
indicadores têm função **diagnóstica**: as sinalizações não produzem exclusões
automáticas e devem ser examinadas em conjunto com outras evidências.

## 🗂️ Estrutura do repositório

```text
.
├── Data/
│   ├── InputData/          # dados originais e metadados
│   ├── IntermediateData/   # produtos intermediários do processamento
│   └── AnalysisData/       # base preparada para análises
├── Scripts/
│   └── ProcessingScripts/  # exclusões procedimentais e indicadores pós-hoc
├── Output/
│   └── DataAppendixOutput/ # tabelas e figuras geradas
├── docs/                   # versão renderizada para o GitHub Pages
├── index.qmd               # texto principal do tutorial
├── _quarto.yml             # configuração do projeto Quarto
├── references.bib          # referências bibliográficas
└── renv.lock               # versões das dependências de R
```

As pastas `Data`, `Scripts` e `Output` possuem documentação própria, organizada
com base nas recomendações do [TIER Protocol](https://www.projecttier.org/tier-protocol/).

## ♻️ Reprodutibilidade

Para reproduzir o projeto, é necessário ter instalados:

- [R](https://cran.r-project.org/);
- [Quarto](https://quarto.org/);
- o pacote R [`renv`](https://rstudio.github.io/renv/).

Clone o repositório:

```bash
git clone https://github.com/phdpablo/cier.git
cd cier
```

Restaure o ambiente de pacotes no console do R:

```r
renv::restore()
```

Depois, renderize o manuscrito a partir da raiz do projeto:

```bash
quarto render
```

Os arquivos renderizados são gravados em `docs/`. Os notebooks de processamento
também podem ser consultados a partir do manuscrito Quarto.

## 👤 Autor

**Pablo Rogers**  
Universidade Federal de Uberlândia  
[ORCID 0000-0002-0093-3834](https://orcid.org/0000-0002-0093-3834)

---

Se este material for útil em ensino ou pesquisa, consulte e cite as referências
metodológicas apresentadas no próprio tutorial.
