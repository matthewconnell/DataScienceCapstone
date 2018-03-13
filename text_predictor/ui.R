library(shiny)
library(shinythemes)
* {
        font-family: Arial, sans-serif !important;


# Define UI for application that draws a histogram
shinyUI(fluidPage(
        theme = shinytheme("simplex"),
        
        # Application title
        titlePanel("Matt's text predictor"),
                
                
                         
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("Tab1",
                        
                                        textAreaInput("text", 
                                                  label = "Enter your text here",
                                                  placeholder = "Enter your text here",
                                                  value = "",
                                                  height = 100,
                                                  width = 650),
                                        
                                        
                                        
                                        actionButton(
                                                     "first_word", 
                                                     label = verbatimTextOutput("prediction1"), 
                                                     width = 160,
                                                     class = "btn-info"),
                                        actionButton("second_word", 
                                                     label = verbatimTextOutput("prediction2"), 
                                                     width = 160,
                                                     class = "btn-info"),
                                        actionButton("third_word", 
                                                     label = verbatimTextOutput("prediction3"), 
                                                     width = 160,
                                                     class = "btn-info"),
                                        actionButton("fourth_word", 
                                                     label = verbatimTextOutput("prediction4"),
                                                     width = 160,
                                                     class = "btn-info")
                        ),
                        tabPanel("Tab2", "place holding text"),
                        tabPanel("Tab3", "place text")
                        )
                )
)
)}