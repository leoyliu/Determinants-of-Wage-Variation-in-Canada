#### Preamble ####
# Purpose: Downloads and saves the data from FiveThirtyEight.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(tidyverse)


#### Download data ####
raw_elections_data <-
  read_csv(
    file = 
      "https://data.ontario.ca/dataset/1f14addd-e4fc-4a07-9982-ad98db07ef86/resource/7b325fa1-e9d6-4329-a501-08cdc22a79df/download/v0913_05.csv",
    show_col_types = TRUE
  )


#### Save data ####
write_csv(raw_elections_data, "data/01-raw_data/raw_data.csv") 