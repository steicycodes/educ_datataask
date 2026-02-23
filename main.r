# ------ Setup
# Ensure reproducibility with renv
# renv::restore() # Uncomment this to restore my versions of packages

library(tidyverse)   # Data manipulation & ggplot2
library(modelsummary) # Professional tables (Balance & Regressions)
library(fixest)       # Fast fixed-effects and clustered SEs
library(kableExtra)   # Table formatting for PDF

# ------ Paths
# Using relative paths so the code runs on any machine
data_raw    <- "01_data/raw/"
data_dirty  <- "01_data/derived/"
tabfig_out    <- "03_output/"

# ------ Run Scripts
source("02_code/01_cleaning.R")
source("02_code/02_analysis.R")
source("02_code/03_visualization.R")

print("Analysis Complete. Check 03_output folder.")