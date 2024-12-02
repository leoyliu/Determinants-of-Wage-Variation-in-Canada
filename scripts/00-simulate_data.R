#### Preamble ####
# Purpose: Simulates a dataset of Canadian average hourly wages from 2000 to 2019 to explore what values might appear in the dataset.
# Author: Yuanyi (Leo) Liu
# Date: 26 November 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Determinants-of-Wage-Variation-in-Canada` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####

# Set parameters for simulation
years <- 2000:2019
education_levels <- c("0 - 8 years", "High school graduate", 
                      "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                      "Community college, CEGEP", "University certificate below bachelors degree", 
                      "University degree", "Bachelor's degree", "Above bachelor's degree")
age_groups <- c("15-24 years", "25-54 years", "55 years and over")
genders <- c("Male", "Female")

# Create the base structure of the dataset
simulated_data <- expand.grid(
  Year = years,
  Education_level = education_levels,
  Age_group = age_groups,
  Gender = genders
)

# Define the wage rate ranges for each education level
wage_rate_ranges <- list(
  `0 - 8 years` = c(11, 13),
  `High school graduate` = c(12, 14),
  `Post-secondary certificate or diploma` = c(13, 15),
  `Trade certificate or diploma` = c(14, 16),  
  `Community college, CEGEP` = c(16, 18),
  `University certificate below bachelors degree` = c(18, 20),
  `University degree` = c(21, 24),
  `Bachelor's degree` = c(24, 27),
  `Above bachelor's degree` = c(28, 32))

# Apply the wage rate ranges to the Avg_hourly_wage_rate column based on Education_level
simulated_data <- simulated_data %>%
  rowwise() %>%
  mutate(Avg_hourly_wage_rate = round(runif(1, min = wage_rate_ranges[[Education_level]][1], 
                                            max = wage_rate_ranges[[Education_level]][2]), 2))

# Reset the order of the rows and remove the row names
simulated_data <- simulated_data %>%
  ungroup() %>%
  arrange(Year, Education_level, Age_group, Gender) %>%
  select(Year, Education_level, Age_group, Gender, Avg_hourly_wage_rate)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
