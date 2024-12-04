#### Preamble ####
# Purpose: Exploratory data analyis on cleaned data.
# Author: Yuanyi (Leo) Liu
# Date: 26 November 2024
# Contact: leoy.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `rstanarm` packages must be installed and loaded
#   - 02-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Determinants-of-Wage-Variation-in-Canada` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# General overview of the dataset
glimpse(analysis_data)
summary(analysis_data)


#### Summary Statistics ####
# Summary of numeric columns
analysis_data %>%
  select_if(is.numeric) %>%
  summary()

# Count unique values in categorical columns
analysis_data %>%
  select_if(is.character) %>%
  summarise_all(~ n_distinct(.))

#### Missing Values Analysis ####
# Check for missing values in each column
analysis_data %>%
  summarise_all(~ sum(is.na(.)))


#### Univariate Analysis ####
# Distribution of Average Hourly Wages
ggplot(analysis_data, aes(x = Average_hourly_wages)) +
  geom_histogram(bins = 20, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Average Hourly Wages", x = "Average Hourly Wages (CAD)", y = "Count")

# Distribution of Education Levels
ggplot(analysis_data, aes(x = reorder(Education_level, Average_hourly_wages, median))) +
  geom_bar(fill = "lightgreen") +
  coord_flip() +
  labs(title = "Distribution of Education Levels", x = "Education Level", y = "Count")

# Distribution of Age Groups
ggplot(analysis_data, aes(x = Age_group)) +
  geom_bar(fill = "coral") +
  labs(title = "Distribution of Age Groups", x = "Age Group", y = "Count")

# Distribution of Gender
ggplot(analysis_data, aes(x = Gender)) +
  geom_bar(fill = "purple") +
  labs(title = "Distribution of Gender", x = "Gender", y = "Count")


#### Bivariate Analysis ####
# Education Level vs Average Hourly Wages
ggplot(analysis_data, aes(x = reorder(Education_level, Average_hourly_wages, median), y = Average_hourly_wages)) +
  geom_boxplot(fill = "lightblue") +
  coord_flip() +
  labs(title = "Education Level vs Average Hourly Wages", x = "Education Level", y = "Average Hourly Wages (CAD)")

# Age Group vs Average Hourly Wages
ggplot(analysis_data, aes(x = Age_group, y = Average_hourly_wages)) +
  geom_boxplot(fill = "lightcoral") +
  labs(title = "Age Group vs Average Hourly Wages", x = "Age Group", y = "Average Hourly Wages (CAD)")

# Gender vs Average Hourly Wages
ggplot(analysis_data, aes(x = Gender, y = Average_hourly_wages)) +
  geom_boxplot(fill = "mediumpurple") +
  labs(title = "Gender vs Average Hourly Wages", x = "Gender", y = "Average Hourly Wages (CAD)")

# Age Group and Education Level vs Average Hourly Wages
ggplot(analysis_data, aes(x = reorder(Education_level, Average_hourly_wages, median), y = Average_hourly_wages, fill = Age_group)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Age Group and Education Level vs Average Hourly Wages", x = "Education Level", y = "Average Hourly Wages (CAD)", fill = "Age Group")


#### Time Series Analysis ####
# Average hourly wages by year
analysis_data %>%
  group_by(Year) %>%
  summarize(avg_wage = mean(Average_hourly_wages, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = avg_wage)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Average Hourly Wages by Year", x = "Year", y = "Average Hourly Wages (CAD)")

# Gender Wage Gap Over Time
analysis_data %>%
  group_by(Year, Gender) %>%
  summarize(avg_wage = mean(Average_hourly_wages, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = avg_wage, color = Gender)) +
  geom_line(size = 1) +
  labs(title = "Gender Wage Gap Over Time", x = "Year", y = "Average Hourly Wages (CAD)", color = "Gender")

