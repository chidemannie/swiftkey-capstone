library(shiny)
source("predict.R")

ui <- fluidPage(
  titlePanel("SwiftKey Next Word Predictor"),
  textInput("text", "Enter your text here:", ""),
  h3("Predicted next words:"),
  verbatimTextOutput("prediction")
)

server <- function(input, output) {
  
  output$prediction <- renderText({
    req(input$text)
    paste(predict_next(input$text), collapse = ", ")
  })
  
}

shinyApp(ui = ui, server = server)
