#### Preamble ####
# Purpose: Simulates data
# Author: Yuanyi (Leo) Liu
# Email: leoy.liu@mail.utoronto.ca
# Date: 31 March 2024
# License: MIT
# Pre-requisites: -
# Any other information needed? -


#### Workspace setup ####
library(tidyverse)
library(dplyr)


#### Simulate data ####
set.seed(853)

# Set parameters for simulation
years <- 2000:2019
education_levels <- c("0 - 8 years", "High school graduate", 
                      "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                      "Community college, CEGEP", "University certificate below bachelors degree", 
                      "University degree", "Bachelor's degree", "Above bachelor's degree")
age_group <- "25-54 years"

# Simulate data
simulated_data <- expand.grid(Year = years, 
                              Education_level = education_levels, 
                              Age_group = age_group)

# Assign education_numeric based on order in education_levels
simulated_data$Education_numeric <- as.integer(factor(simulated_data$Education_level, levels = education_levels))

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
  arrange(Year, Education_level) %>%
  select(Year, Education_level, Age_group, Avg_hourly_wage_rate, Education_numeric)

# View the first few rows of the simulated dataset
head(simulated_data)