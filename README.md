# Impact of In-Kind Transfers on Educational and Demographic Outcomes
This repository contains a complete data task evaluating a school-based in-kind transfer program using a matched-pair Randomized Controlled Trial (RCT). The analysis investigates the program's effect on student dropout, teen pregnancy, and early marriage over a five-year horizon.

# 📌 Project Overview
The study evaluates a three-year intervention (2010–2012) targeting a cohort of 6th-grade students in public schools. Utilizing pairwise randomization at the school level, the study tracks outcomes at the end of the intervention (Year 3) and two years post-program (Year 5).Key FindingsDropout Reduction: The intervention reduced student dropout by 4.0 percentage points ($p < 0.001$).+1Demographic Spillovers: Significant reductions were observed in teen pregnancy (4.1 pp) and early marriage (1.7 pp).Gender Disparity: While the program was effective for all students, a structural 7.6 pp gender gap in dropout persists.

# 🛠 Tech Stack & Methods
Language: R (utilizing fixest for high-dimensional fixed effects and ggplot2 for visualizations).

## Econometric Specifications:
* Intent-to-Treat (ITT) estimation.
* High-Dimensional Fixed Effects: Stratum (pair) and Year fixed effects.
* Inference: Standard errors clustered at the student level to account for the panel data structure.
* Heterogeneity Analysis: Testing for differential impacts by gender and age cohort.

# 📂 Repository Structure
01_data/: Raw school and student-level CSV files.
02_code/: R scripts for data cleaning, balance checks, and regression analysis.03_output/: Final tables (built with gt) and descriptive graphs.

# 🚀 How to Reproduce
1. Clone the repository: git clone https://github.com/steicycodes/educ_datataask.git
2. Open the R project and run 02_code/main.R.
3. The script will automatically clean the data and populate the 03_output/ folder with the results used in the final memo.


CHAT GPT LINK: https://chatgpt.com/share/699cf07a-9394-8004-9cb7-174656af0292