library(shiny)
library(shinythemes)
        


# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("slate"),
                  fluidRow(
                          column(8, align = "left", offset = 0,
        
        
                titlePanel("Matt's Text Predictor",
                           windowTitle = "Matt's Text Predictor"
                           )
                          ),
                
                         
                
                mainPanel(
                        tabsetPanel(
                                tabPanel("The App",
                                         fluidRow(
                                                 column(width = 3, align = "left", offset = 0),
                                                 column(width = 7, align = "center", offset = 0,
                                                        
                                                        br(),
                                                        br(),
                                                        br(),
                                         
                        
                                                        textAreaInput("text", 
                                                                  label = "",
                                                                  placeholder = "Enter your text here",
                                                                  value = "",
                                                                  height = 100,
                                                                  width = 700)
                                                        ),
                                                 column(width = 1, align = "left", offset = 2)
                                                  ),
                                         
                                         
                                         fluidRow(
                                                column(width = 5, align = "right", offset = 0),
                                                column(width = 2,
                                                       actionLink(
                                                                     "first_word", 
                                                                     label = textOutput("prediction1")
                                                                     )
                                                       ),                                   
                                                column(width = 2,
                                                       actionLink("second_word", 
                                                                     label = textOutput("prediction2")
                                                                     
                                                                     )),
                                                column(width = 2, 
                                                       actionLink("third_word", 
                                                                     label = textOutput("prediction3"),
                                                                     width = 2
                                                                     )),
                                                column(width = 1, 
                                                       actionLink("fourth_word", 
                                                                     label = textOutput("prediction4"),
                                                                     width = 2
                                                                     ))
                                                )
                        ),
                        tabPanel("Documentation",
                                 sidebarLayout(
                                         sidebarPanel(
                                                 selectInput("documentation",
                                                             label = "",
                                                             choices = c("About the App" = paste("<h3>About the app</h3>",
        
                                                                         "<h4>This app uses an algorithm based on the Katz's Backoff Model of word prediction.
                                                                         It works by taking the most recent three words and finding the most likely next four words.
                                                                         If it cannot find a suitable word, it will look at the previous two words and try to predict based on them.
                                                                         Similarly, if it cannot find a word based on those two, it will look at the individual most recent word typed.
                                                                         When it cannot find any good words at all, it returns one of the top four most common words.
                                                                         If there are duplicates in the returned word list, a placeholder word is used.",
                                                                         
                                                                         "Some choices being made when developing the algorithm and the app were difficult. 
                                                                         I decided to leave in swear words as they are legitimate words people commonly use and I did not believe any children would be using this app.
                                                                         If I were porting the application onto a smartphone app or for the general public, I would remove the bad words.",
                                                                         
                                                                         
                                                                         "There was also deliberation about whether to keep what are called 'stop words'. 
                                                                         These are words that are so common they can cause problems for prediction and search algorithms.
                                                                         In English, these are words like 'a', 'the', 'you', 'I', and so on. 
                                                                         I opted to keep them in as I found they made for better predictions.",
                                                                         
                                                                         
                                                                         "Punctuation was also removed (except for apostrophes) to clean the inputted text and to not end sentences prematurely.
                                                                         A next step may be to try to predict the end of sentences, but that is outside the scope of this app.
                                                                         As it stands, the app will only make a run-on sentence.", sep = "<br/><br/>"),
                                                                         

                                                                        "Limitations" = paste("<h3>Limitations</h3>",
                                                                                              "<h4>The application has been built for speed. 
                                                                        In the case of some n-gram searches, this will result some accuracy loss. 
                                                                         This is due to the file size limitations.
                                                                         Only 20% of the data was sampled and of that, the least common n-gram combinations were dropped from the table.",
                                                                         
                                                                         "Furthermore, the build is currently only available for the English language.", sep = "<br/><br/>"),
                                                                         
                                                                        
                                                                        
                                                                        "Next Steps" = paste("<h3>Next Steps</h3>",
                                                                                             
                                                                                             "<h4>The next steps would be to add another language. 
                                                                                             Russian or German would be the best choices as the data has already been made available as part of this project.
                                                                                             It would also be interesting to have more words come up as choices for the next word.",
                                                                                             "I would also like to try adding 5-gram and 6-gram tables to the app to see how much that improves accuracy.
                                                                                             I don't believe it would make a great difference in the overall accuracy but it might reduce the speed a lot. 
                                                                                             ", sep = "<br/><br/>"),
                                                                         
                                                                        
                                                                        
                                                                        "Sources" = paste("<h3>Sources</h3>",
                                                                                          "<h5>Grep expressions and making n-gram table: <a href = 'https://www.youtube.com/watch?v=0le0ijNVP5M'>here</a>",
                                                                                          "Dan Jurafsky's NLP course on YouTube: <a href='https://www.youtube.com/watch?v=dkUtavsPqNA&t=1s'>here</a>",
                                                                                          "Grep reference guide: <a href='https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php'>here</a>",
                                                                                          "Another grep reference guide: <a href='http://www.ericagamet.com/wp-content/uploads/2016/04/Erica-Gamets-GREP-Cheat-Sheet.pdf'>here</a>",
                                                                                          "Buiding a better Shiny app: <a href='https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin'>here</a>",
                                                                                          "Shiny themes: <a href= 'https://gallery.shinyapps.io/117-shinythemes/'>here</a>",
                                                                                          "Shiny themes again: <a href='http://rstudio.github.io/shinythemes/'>here</a>",
                                                                                          "Wordcloud: <a href='http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know'>here</a>",
                                                                                          "Plot output: <a href= 'https://shiny.rstudio.com/reference/shiny/latest/plotOutput.html'>here</a>",
                                                                                          "Shiny inputSelector: <a href='http://shiny.rstudio.com/gallery/selectize-vs-select.html'>here</a>",
                                                                                          "Updating text input fields: <a href= 'https://shiny.rstudio.com/reference/shiny/latest/textAreaInput.html'>here</a>",
                                                                                          "Dynamic buttons: <a href= 'https://sites.temple.edu/psmgis/2017/07/26/r-shiny-task-create-an-input-select-box-that-is-dependent-on-a-previous-input-choice/'>here</a>",
                                                                                          "Reactive variables: <a href= 'https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r/17649022'>here</a>",
                                                                                          "More reactive variables: <a href= 'https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny/40623750'>here</a>",
                                                                                          sep = "<br/><br/>"),
                                                                        "Contact" = paste("<h3>Contact</h3>",
                                                                                          "<h4><a href = 'http://www.linkedin.com/in/matthew-connell-a815b9157'>LinkedIn</a>",
                                                                                          "Twitter: <a href = 'https://twitter.com/atc84'>@atc84</a>",
                                                                                          "<a href = 'https://github.com/matc84'>github</a>",
                                                                                          sep = "<br/><br/>")),
                                                             
                                                             selected = "About the App")
                                                 
                                         ),
                                         
                                         mainPanel(
                                               fluidRow(column = 8,
                                          offset = 5,
                                          align = "left",
                                          tags$h1("Documentation"),
                                          br(),
                                          htmlOutput("doc_text")
                                         
                                         )
                                 )
                                 
                        )
                        ),
                        
                        
                        
                        
                        
                        tabPanel("Visualization", 
                                 tags$h1("Word cloud"),
                                 sidebarLayout(
                                         sidebarPanel(
                                                 
                                                 sliderInput("num_words",
                                                             label = "Make a wordcloud of the 500 most common words",
                                                             min = 1,
                                                             max = 500,
                                                             value = c(1,50)),
                                                 selectInput("color",
                                                             label = "Choose the 'brewer.pal' color scheme",
                                                             choices = c("Set 1" = "Set1", 
                                                                         "Set 2"= "Set2", 
                                                                         "Set 3" = "Set3", 
                                                                         "Pastel 1" = "Pastel1", 
                                                                         "Pastel 2" = "Pastel2", 
                                                                         "Paired" = "Paired", 
                                                                         "Dark" = "Dark2", 
                                                                         "Accent"= "Accent"),
                                                             selected = "Set 1",
                                                             selectize = TRUE
                                                             ),
                                                 actionButton(inputId = "go", label = " Submit", icon("refresh"), class ="btn-info")
                                                 
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
