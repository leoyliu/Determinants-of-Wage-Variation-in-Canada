#### Preamble ####
# Purpose: Tests the structure and validity of the simulated dataset.
# Author: Yuanyi (Leo) Liu
# Date: 26 November 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `testthat` packages must be installed and loaded
#   - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `Determinants-of-Wage-Variation-in-Canada` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
test_that("dataset was successfully loaded", {
  expect_true(exists("simulated_data"))
})


#### Test data ####
# Check if the dataset has 1080 rows
test_that("dataset has 1080 rows", {
  expect_equal(nrow(simulated_data), 1080)
})

# Check if the dataset has 5 columns
test_that("dataset has 5 columns", {
  expect_equal(ncol(simulated_data), 5)
})

# Check if the 'Education_level' column contains valid education levels
valid_education_levels <- c("0 - 8 years", "High school graduate", 
                      "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                      "Community college, CEGEP", "University certificate below bachelors degree", 
                      "University degree", "Bachelor's degree", "Above bachelor's degree")
test_that("'Education_level' column contains valid education levels", {
  expect_true(all(simulated_data$Education_level %in% valid_education_levels))
})

# Check if there are any missing values in the dataset
test_that("dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)))
})

# Check if there are no empty strings in 'Education_level', 'Age_group', and 'Gender' columns
test_that("no empty strings in 'Education_level', 'Age_group', and 'Gender'", {
  expect_true(all(simulated_data$Education_level != "" & simulated_data$Age_group != "" & simulated_data$Gender != ""))
})

# Check if the 'Age_group' column has 3 unique values
test_that("'Age_group' column contains 3 unique values", {
  expect_gte(n_distinct(simulated_data$Age_group), 3)
})

# Check if 'Gender' contains only "Male" and "Female"
valid_genders <- c("Male", "Female")
test_that("'Gender' column contains only 'Male' and 'Female'", {
  expect_true(all(simulated_data$Gender %in% valid_genders))
})

# Check if 'Year' falls within a realistic range (e.g., 2000 to 2019)
test_that("'Year' values are within the range 2000 to 2019", {
  expect_true(all(simulated_data$Year >= 2000 & simulated_data$Year <= 2019))
})

# Check if 'Avg_hourly_wage_rate' is non-negative and reasonable (e.g., no more than 200 dollars)
test_that("'Avg_hourly_wage_rate' is non-negative and not exceeding 200 dollars", {
  expect_true(all(simulated_data$Avg_hourly_wage_rate >= 0 & simulated_data$Avg_hourly_wage_rate <= 200))
})

# Check if there is at least one unique combination of 'Year', 'Education_level', 'Age_group', and 'Gender'
test_that("Dataset contains unique combinations of 'Year', 'Education_level', 'Age_group', and 'Gender'", {
  expect_equal(nrow(simulated_data), n_distinct(simulated_data$Year, simulated_data$Education_level, simulated_data$Age_group, simulated_data$Gender))
})
