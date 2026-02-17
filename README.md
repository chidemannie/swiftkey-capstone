# SwiftKey Next-Word Prediction (Johns Hopkins Data Science Capstone)

This repository contains my completion of the Johns Hopkins Data Science Specialization Capstone (SwiftKey predictive text). A next-word prediction Shiny app using an n-gram + backoff language model trained on the HC Corpora (blogs, news, twitter).

## Live App
- Shiny app: https://chidemannie.shinyapps.io/Swiftkey_Next_Word_Predictor/

## Contents
- `app/` : Shiny application + prediction code + trained n-gram model objects
- `report/` : Exploratory Data Analysis report (R Markdown)
- `slides/` : 5-slide pitch deck (R Presentation)
- `train_model.R` : Script to train the n-gram model and save `.rds` files

## How it works (high level)
The predictor uses a frequency-based n-gram model (2-, 3-, 4-grams) with a backoff strategy:
4-gram → 3-gram → 2-gram → fallback word. It is designed for small size and fast prediction in shiny
- Slide deck: https://rpubs.com/chidemannie/SNxWoP

## How to run locally
1. Clone this repo
2. Open the project in RStudio
3. Run:
```r
shiny::runApp("app")
