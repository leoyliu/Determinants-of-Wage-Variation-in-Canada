# Determinants of Wage Variation in Canada

## Overview

This repository contains a study examining the relationship between education level, age group, and gender in shaping average hourly wages in Canada. Using a Bayesian linear regression model, the study analyzes data from the Labour Force Survey to quantify the effects of these predictors on wage outcomes. The results indicate that higher education levels, older age groups, and gender (male) are associated with higher hourly wages, while disparities persist between demographic categories.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains the raw data as obtained from [Government of Canada](https://open.canada.ca/data/en/dataset/1f14addd-e4fc-4a07-9982-ad98db07ef86/resource/ed8b30ed-cde4-4559-8fcb-20605182d3ff).
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions, sketches, and datasheets.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, clean, model, and test data.

## Statement on LLM usage

The ChatGPT-4 model assisted with data validation, test creation, data cleaning, simulation generation, plot generation, and the polishing of wording. The entire chat history is available in `other/llm_usage/usage.txt`.

------------------------------------------------------------------------

*Note: Our script does not include a feature for data downloading. For those interested in acquiring the datasets, please visit [Open Government Canada](https://open.canada.ca/data/en/dataset/1f14addd-e4fc-4a07-9982-ad98db07ef86/resource/ed8b30ed-cde4-4559-8fcb-20605182d3ff) to obtain the necessary datasets. The relevant file is named 'Wages by education level'. After downloading, please place the raw data into the `data/01-raw_data` directory and execute `06-install_packages.R` to ensure all necessary packages are installed. Then, you can proceed to use the read function in R to import the data for further analysis with our R scripts.*

------------------------------------------------------------------------
