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
                                         br(),
                                         tags$h4("Some choices being made when developing the algorithm and the app were difficult. 
                                                 I decided to leave in swear words as they are legitimate words the people commly use and I did not believe any children would be using this app.
                                                 If I were porting the application onto a smartphone app or for the general public, I would remove the bad words."),
                                         br(),
                                         tags$h4("There was also deliberation about whether to keep what are called 'stop words'. 
                                                 These are words that are so common they can cause problems for prediction and search algorithms.
                                                 In English, these are words like 'a', 'the', 'you', 'I', and so on. 
                                                 I opted to keep them in as I found they made for better predictions"
                                                 ),
                                         br(),
                                         tags$h4("Punctuation was also removed (except for apostrophes) to clean the inputted text and to not end sentences prematurely.
                                                 A next step may be to try to predict the end of sentences, but that is outside the scope of this app.
                                                 As it stands, the app will only make a run-on sentence."),
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
                                                 Russian or German would be the best choices as the data has already been made available as part of this project.
                                                 It would also be interesting to have more words come up as choices for the next word.
                                                 I would also like to try adding 5-gram and 6-gram tables to the app to see how much that improves accuracy.
                                                 I don't believe it would make a great difference in the overall accuracy but it might reduce the speed a lot. 
                                                 "),
                                         tags$h2("Sources"),
                                         tags$h4("Source for updating text input fields https://shiny.rstudio.com/reference/shiny/latest/textAreaInput.html
                                                 Source for dynamic buttons https://sites.temple.edu/psmgis/2017/07/26/r-shiny-task-create-an-input-select-box-that-is-dependent-on-a-previous-input-choice/
                                                 Source for reactive variables https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r/17649022
                                                 More reactive variables https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny/40623750
                                                 Source for grep expression '\\<' and making n-gram table https://www.youtube.com/watch?v=0le0ijNVP5M
                                                 Grep reference guide https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php
                                                 Another grep reference guide http://www.ericagamet.com/wp-content/uploads/2016/04/Erica-Gamets-GREP-Cheat-Sheet.pdf
                                                 Source for buiding a better Shiny app: https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin
                                                 Shiny themes https://gallery.shinyapps.io/117-shinythemes/
                                                 Shiny themes again http://rstudio.github.io/shinythemes/
                                                 Source for wordcloud help http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know
                                                 Source for plot output https://shiny.rstudio.com/reference/shiny/latest/plotOutput.html")
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
