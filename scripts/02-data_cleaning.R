#### Preamble ####
# Purpose: Cleans the raw plane data
# Author: Yuanyi (Leo) Liu
# Date: 31 March 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: raw_data.csv
# Any other information needed? -


#### Workspace setup ####
library(tidyverse)
library(arrow)


#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

cleaned_data <-
  raw_data |>
  filter(Geography == "Canada",
         `Type of work` == "Both full- and part-time",
         Wages == "Average hourly wage rate",
         `Education level` != "Some high school",
         `Education level` != "Some post-secondary",
         `Education level` != "Total, all education levels",
         `Education level` != "PSE  (5,6,7,8,9))",
         `Education level` != "No PSE  (0,1,2,3,4)",
         YEAR >= 2000) |>
  filter(`Age group` == "25-54 years") |>
  select(YEAR, `Education level`, `Age group`, `Both Sexes`) |>
  rename(Year = YEAR, `Avg hourly wage rate` = `Both Sexes`)

education_levels_ordered <- c("0 - 8  years", "High school graduate", 
                              "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                              "Community college, CEGEP", "University certificate below bachelors degree", 
                              "University degree", "Bachelor's degree", "Above bachelor's degree")

cleaned_data <- cleaned_data %>%
  mutate(`Education level` = factor(`Education level`, levels = education_levels_ordered)) %>%
  mutate(Education_numeric = as.numeric(`Education level`))


#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/analysis_data/analysis_data.parquet")