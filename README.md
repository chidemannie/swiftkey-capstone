# SwiftKey Next-Word Prediction (Johns Hopkins Data Science Capstone)

This repository contains my completion of the Johns Hopkins Data Science Specialization Capstone (SwiftKey predictive text).

## Live App (Task 6)
- Shiny app: https://chidemannie.shinyapps.io/Swiftkey_Next_Word_Predictor/

## Contents
- `app/` : Shiny application + prediction code + trained n-gram model objects
- `report/` : Exploratory Data Analysis report (R Markdown)
- `slides/` : 5-slide pitch deck (R Presentation)
- `train_model.R` : Script to train the n-gram model and save `.rds` files

## How it works (high level)
The predictor uses a frequency-based n-gram model (2-, 3-, 4-grams) with a backoff strategy:
4-gram → 3-gram → 2-gram → fallback word.

## Run locally
From the repo root:

```r
setwd("app")
shiny::runApp()
