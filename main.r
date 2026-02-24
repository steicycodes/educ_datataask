# ------ Setup
# Ensure reproducibility with renv
# Uncomment this to restore my versions of packages
# renv::restore() 

# CHAT GPT LINK https://chatgpt.com/share/699cf07a-9394-8004-9cb7-174656af0292

library(tidyverse)   # Data manipulation & ggplot2
library(modelsummary) # Professional tables (Balance & Regressions)
library(fixest)       # Fast fixed-effects and clustered SEs
library(kableExtra)   # Table formatting for PDF
library(gt) # More table formatting

# ------ Paths
# Using relative paths so the code runs on any machine
data_raw    <- "01_data/raw/"
data_clean  <- "01_data/clean/"
tabfig_out    <- "03_output/"

# ------ Run Scripts
source("02_code/01_cleaning.R")
source("02_code/02_analysis.R")
source("02_code/03_visualization.R")

print("Analysis Complete. Check 03_output folder.")