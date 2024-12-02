#### Preamble ####
# Purpose: Models average hourly wages by using stan_glm.
# Author: Yuanyi (Leo) Liu
# Date: 26 November 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `rstanarm`, `arrow` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Determinants-of-Wage-Variation-in-Canada` rproj


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)


#### Read data ####
analysis_data <- read.csv(file = "data/02-analysis_data/analysis_data.csv")


### Model data ####
model <-
  stan_glm(
    formula = Average_hourly_wages ~ Education_level + Age_group + Gender,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  model,
  file = "models/linear_model.rds"
)