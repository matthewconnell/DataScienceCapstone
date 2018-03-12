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
                        
                        
                        textAreaInput("text", 
                                  label = "Enter your text here",
                                  placeholder = "Enter your text here",
                                  height = 100,
                                  width = 650),
                        
                        
                        
                        actionButton("first_word", 
                                     label = verbatimTextOutput("prediction1"), 
                                     width = 160),
                        actionButton("second_word", 
                                     label = verbatimTextOutput("prediction2"), 
                                     width = 160),
                        actionButton("third_word", 
                                     label =  verbatimTextOutput("prediction3"), 
                                     width = 160),
                        actionButton("fourth_word", 
                                     label = verbatimTextOutput("prediction4"),
                                     width = 160)
                        
                       
                        
                        
                        
                        
                        
                )
        )
))
