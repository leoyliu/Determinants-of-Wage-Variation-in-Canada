#### Preamble ####
# Purpose: Tests structure of the analysis data.
# Author: Yuanyi (Leo) Liu
# Date: 26 November 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `testthat` packages must be installed and loaded
#   - 02-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Determinants-of-Wage-Variation-in-Canada` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 1080 rows
test_that("dataset has 1080 rows", {
  expect_equal(nrow(analysis_data), 1080)
})

# Test that the dataset has 5 columns
test_that("dataset has 5 columns", {
  expect_equal(ncol(analysis_data), 5)
})

# Test that the 'Education_level' column is character type
test_that("'Education_level' is character", {
  expect_type(analysis_data$Education_level, "character")
})

# Test that the 'Age_group' column is character type
test_that("'Age_group' is character", {
  expect_type(analysis_data$Age_group, "character")
})

# Test that the 'Gender' column is character type
test_that("'Gender' is character", {
  expect_type(analysis_data$Gender, "character")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test that the 'Education_level' column contains valid education levels
valid_education_levels <- c("0 - 8  years", "High school graduate", 
                            "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                            "Community college, CEGEP", "University certificate below bachelors degree", 
                            "University degree", "Bachelor's degree", "Above bachelor's degree")
test_that("'Education_level' column contains valid education levels", {
  expect_true(all(analysis_data$Education_level %in% valid_education_levels))
})

# Test that there are no empty strings in 'Education_level', 'Age_group', and 'Gender' columns
test_that("no empty strings in 'Education_level', 'Age_group', and 'Gender'", {
  expect_true(all(analysis_data$Education_level != "" & analysis_data$Age_group != "" & analysis_data$Gender != ""))
})

# Test that the 'Age_group' column has 3 unique values
test_that("'Age_group' column contains 3 unique values", {
  expect_gte(n_distinct(analysis_data$Age_group), 3)
})

# Test that 'Gender' contains only "Male" and "Female"
valid_genders <- c("Male", "Female")
test_that("'Gender' column contains only 'Male' and 'Female'", {
  expect_true(all(analysis_data$Gender %in% valid_genders))
})

# Test that 'Year' falls within a realistic range (e.g., 2000 to 2019)
test_that("'Year' values are within the range 2000 to 2019", {
  expect_true(all(analysis_data$Year >= 2000 & analysis_data$Year <= 2019))
})

# Test that 'Average_hourly_wages' is non-negative and reasonable (e.g., no more than 200 dollars)
test_that("'Average_hourly_wages' is non-negative and not exceeding 200 dollars", {
  expect_true(all(analysis_data$Average_hourly_wages >= 0 & analysis_data$Average_hourly_wages <= 200))
})

# Test that there is at least one unique combination of 'Year', 'Education_level', 'Age_group', and 'Gender'
test_that("Dataset contains unique combinations of 'Year', 'Education_level', 'Age_group', and 'Gender'", {
  expect_equal(nrow(analysis_data), n_distinct(analysis_data$Year, analysis_data$Education_level, analysis_data$Age_group, analysis_data$Gender))
})