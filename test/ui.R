library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Matt's text predictor"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
    ),
    # Show a plot of the generated distribution
    mainPanel(
      
      textInput("text", 
                label = "Enter your text here",
                placeholder = "Enter your text here"),
      
      actionButton("first_word", label = verbatimTextOutput("prediction1"), width = 125),
      actionButton("second_word", label = verbatimTextOutput("prediction2"), width = 125),
      actionButton("third_word", label =  verbatimTextOutput("prediction3"), width = 125),
      actionButton("fourth_word", label = verbatimTextOutput("prediction4"), width = 125),
      verbatimTextOutput("time", placeholder = TRUE)
     
      
    )
  )
))
