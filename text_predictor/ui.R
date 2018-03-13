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
                                         ),
                                         mainPanel(
                                               fluidRow(column = 8,
                                          offset = 5,
                                          align = "left",
                                          tags$h1("Documentation"),
                                         br(),
                                         tags$h2("About the app"),
                                         br(),
                                         tags$h4("This app uses an algorithm based on the Katz's Backoff Model of word prediction.
                                                 It works by taking the most recent three words and finding the most likely next four words.
                                                 If it cannot find a suitable word, it will look at the previous two words and try to predict based on them.
                                                 Similarly, if it cannot find a word based on those two, it will look at the individual most recent word typed.
                                                 When it cannot find any good words at all, it returns one of the top four most common words.
                                                 If there are dupicates in the returned word list, a placeholder word is used."),
                                         tags$h2("Limitations"),
                                         tags$h4("The application has been built for speed. 
                                                 In the case of some n-gram searches, this will result some accuracy loss. 
                                                 This is due to the file size limitations.
                                                 Only 20% of the data was sampled and of that, the least common n-gram combinations were dropped from the table. 
                                                 "),
                                                br(),
                                         tags$h4("Furthermore, the build is currently only available for the English language."),
                                         tags$h2("Next Steps"),
                                         tags$h4("The next steps would be to add another language. 
                                                 Russian or German would be the best choices as the data has already been made available as part of this project."),
                                         tags$h2("Sources")  
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
