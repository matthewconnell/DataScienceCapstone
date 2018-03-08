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
                "Enter your text here"),
      verbatimTextOutput("default"),
      verbatimTextOutput("placeholder", placeholder = TRUE)
    )
  )
))
