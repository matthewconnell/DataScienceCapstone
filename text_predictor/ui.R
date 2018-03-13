library(shiny)
library(shinythemes)
        


# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("simplex"),
                  fluidRow(
                          column(8, align = "center", offset = 0,
        
        
                titlePanel("Matt's text predictor")
                          ),
                
                         
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("The App",
                                         fluidRow(
                                                 column(width = 2, align = "left", offset = 0),
                                                 column(width = 8, align = "center", offset = 0,
                                         
                        
                                                        textAreaInput("text", 
                                                                  label = "",
                                                                  placeholder = "Enter your text here",
                                                                  value = "",
                                                                  height = 100,
                                                                  width = 700)
                                                        ),
                                                 column(width = 2, align = "right", offset = 0)
                                                  ),
                                         
                                         fluidRow(
                                                column(width = 2, align = "right", offset = 0),
                                                column(width = 8, align = "center", offset = 2,

                                                        actionButton(
                                                                     "first_word", 
                                                                     label = textOutput("prediction1"), 
                                                                     width = 160,
                                                                     class = "btn-info"),
                                                        actionButton("second_word", 
                                                                     label = textOutput("prediction2"), 
                                                                     width = 160,
                                                                     class = "btn-info"),
                                                        actionButton("third_word", 
                                                                     label = textOutput("prediction3"), 
                                                                     width = 160,
                                                                     class = "btn-info"),
                                                        actionButton("fourth_word", 
                                                                     label = textOutput("prediction4"),
                                                                     width = 160,
                                                                     class = "btn-info")
                                                       ),
                                                column(width = 2, align = "right", offset = 0)
                                                )
                        ),
                        tabPanel("Documentation", "place holding text"),
                        tabPanel("Visualizations", "place text")
                        ))
)
)
)
