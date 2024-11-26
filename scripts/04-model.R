#### Preamble ####
# Purpose: Models the dataset with simple linear regression
# Author: Yuanyi (Leo) Liu
# Date: 31 March 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-data_cleaning.R
# Any other information needed? -


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)
library(modelsummary)


#### Read data ####
analysis_data <- read.csv(file = "data/analysis_data/analysis_data.csv")


### Model data ####
first_model <-
  stan_glm(
    formula = Avg.hourly.wage.rate ~ Education_numeric,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/linear_model.rds"
)