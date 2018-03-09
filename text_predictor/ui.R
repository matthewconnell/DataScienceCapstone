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
                placeholder = "Enter you text here"),
      verbatimTextOutput("prediction", placeholder = TRUE),
      verbatimTextOutput("time", placeholder = TRUE)
      
    )
  )
))
