#### Preamble ####
# Purpose: Tests for dataset
# Author: Yuanyi (Leo) Liu
# Date: 31 March 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-data_cleaning.R
# Any other information needed? -


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Load dataset
analysis_data <- read.csv("data/analysis_data/analysis_data.csv", check.names = FALSE)

# Test 1: Check for missing values in simulated_data
test1_result <- !any(is.na(analysis_data))
print(paste("Test 1 Passed:", test1_result))

# Test 2: Check for duplicated rows in simulated_data
test2_result <- !any(duplicated(analysis_data))
print(paste("Test 2 Passed:", test2_result))

# Test 3: Check that there are exactly 9 unique education levels
expected_levels <- c("0 - 8  years", "High school graduate", 
                     "Post-secondary certificate or diploma", "Trade certificate or diploma", 
                     "Community college, CEGEP", "University certificate below bachelors degree", 
                     "University degree", "Bachelor's degree", "Above bachelor's degree")

actual_levels <- unique(analysis_data$`Education level`)
test3_result <- length(actual_levels) == 9 && all(actual_levels %in% expected_levels)
print(paste("Test 3 Passed:", test3_result))

# Test 4: Check that Education_numeric matches the levels of Education_level
test4_result <- all(analysis_data$Education_numeric == as.integer(factor(analysis_data$Education_level, levels = education_levels)))
print(paste("Test 4 Passed:", test4_result))

# Test 5: Check that all years are within the specified range (2000-2019)
test5_result <- all(analysis_data$Year >= 2000 & analysis_data$Year <= 2019)
print(paste("Test 5 Passed:", test5_result))

# Test 6: Check that all age groups are "25-54 years"
test6_result <- all(analysis_data$`Age group` == "25-54 years")
print(paste("Test 6 Passed:", test6_result))