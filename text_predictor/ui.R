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
                        tabPanel("Documentation",
                                 sidebarLayout(
                                         sidebarPanel(
                                                 selectInput("documentation",
                                                             label = "",
                                                             choices = c("About the App" = "about_the_app",
                                                                         "Limitations" = "limitations",
                                                                         "Next Steps" = "next_steps",
                                                                         "Sources" = "sources"),
                                                             selected = "About the App")
                                         ),
                                         mainPanel(
                                               fluidRow(column = 8,
                                          offset = 5,
                                          align = "left",
                                          tags$h1("Documentation"),
                                          br(),
                                          htmlOutput("documentation_text")
                                         
                                         )
                                 )
                                 
                        )
                        ),
                        
                        
                        
                        
                        
                        tabPanel("Visualization", 
                                 tags$h1("Word cloud"),
                                 sidebarLayout(
                                         sidebarPanel(
                                                 sliderInput("num_words",
                                                             label = "Choose the range of unigrams for your wordcloud",
                                                             min = 1,
                                                             max = 200,
                                                             value = c(1,50)),
                                                 selectInput("color",
                                                             label = "Choose the color scheme",
                                                             choices = c("Set 1" = "Set1", 
                                                                         "Set 2"= "Set2", 
                                                                         "Set 3" = "Set3", 
                                                                         "Pastel 1" = "Pastel1", 
                                                                         "Pastel 2" = "Pastel2", 
                                                                         "Paired" = "Paired", 
                                                                         "Dark" = "Dark2", 
                                                                         "Accent"= "Accent"),
                                                             selected = "Set 1")
                                         ),
                                         mainPanel(
                                                 plotOutput("wordcloud",
                                                            width = 600,
                                                            height = 600)
                                 )
                        ))
)
)
)
)
)
