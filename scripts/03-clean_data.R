#### Preamble ####
# Purpose: Cleans the raw data.
# Author: Yuanyi (Leo) Liu
# Date: 26 November 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `arrow` packages must be installed and loaded
#   - The raw data must be manually downloaded prior to running this script
# Any other information needed? Make sure you are in the `Determinants-of-Wage-Variation-in-Canada` rproj


#### Workspace setup ####
library(tidyverse)
library(arrow)


#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

raw_data <- raw_data |>
  rename(
    Year = YEAR,
    Education_level = `Education level`,
    Age_group = `Age group`,
    Average_hourly_wages = Wages
  )

cleaned_data <-
  raw_data |>
  filter(Geography == "Canada",
         `Type of work` == "Both full- and part-time",
         Average_hourly_wages == "Average hourly wage rate",
         !Education_level %in% c(
           "Some high school", "Some post-secondary", 
           "Total, all education levels", "PSE  (5,6,7,8,9))", 
           "No PSE  (0,1,2,3,4)"
         ),
         Year >= 2000,
         Age_group %in% c("15-24 years", "25-54 years", "55 years and over")) |>
  select(Year, Education_level, Age_group, Male, Female) |> 
  pivot_longer(
    cols = c(Male, Female), 
    names_to = "Gender", 
    values_to = "Average_hourly_wages"
  )

education_levels_ordered <- c("0 - 8  years", "High school graduate", 
                              "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                              "Community college, CEGEP", "University certificate below bachelors degree", 
                              "University degree", "Bachelor's degree", "Above bachelor's degree")

cleaned_data <- cleaned_data |>
  mutate(
    Education_level = factor(Education_level, levels = education_levels_ordered),
    Education_numeric = as.numeric(Education_level)
  )


#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")