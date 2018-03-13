library(shiny)
library(data.table)
library(wordcloud)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
        
        
        
        
        
       
        
        ## Load and 'characterize' the tables
        unigrams <- as.data.table(read.table("unigrams.txt"))
        unigrams$unique.values <- as.character(unigrams$unique.values)
        
        bigrams_splitted <- as.data.table(read.table("bigrams_splitted.txt"))
        bigrams_splitted$first_words <- as.character(bigrams_splitted$first_words)
        bigrams_splitted$last_word <- as.character(bigrams_splitted$last_word)
        
        trigrams_splitted <- as.data.table(read.table("trigrams_splitted.txt"))
        trigrams_splitted$first_words <- as.character(trigrams_splitted$first_words)
        trigrams_splitted$last_word <- as.character(trigrams_splitted$last_word)
        
        fourgrams_splitted <- as.data.table(read.table("fourgrams_splitted.txt"))
        fourgrams_splitted$first_words <- as.character(fourgrams_splitted$first_words)
        fourgrams_splitted$last_word <- as.character(fourgrams_splitted$last_word)
        
        
        
        
        
        ## Early prediction function
        ## Takes a string
        ## Finds length
        ## If the string is greater than three words, trim it to three and search in the fourgram table
        ## If the string is two words, search the trigram table
        ## If the string is one words, search the bigram table
        ## 
        ## 
        ##
        
        unigram_finder <- function(number) {
                words <- unigrams$unique.values[1:number]
                return(words)
        }
        
        
        bigram_finder <- function(splitted_string) {
                new_string = splitted_string
                finder_two <- grepl(paste0("\\<", new_string, "\\>"), bigrams_splitted$first_words, ignore.case = TRUE)
                getter_two<- bigrams_splitted$last_word[finder_two]
                sum_na <- sum(is.na(getter_two[1:4]))
                if (sum_na < 4)  {
                        getter_two <- c(getter_two[1:(4-sum_na)], unigram_finder(sum_na))
                        return(getter_two[1:4])
                } else {
                        getter_two <- unigram_finder(sum_na)
                        return(getter_two[1:4])
                } 
                return(getter_two[1:4])
                
        }
        
        
        trigram_finder <- function(splitted_string) {
                new_string = paste(splitted_string[1:2], collapse = " ")
                finder_three <- grepl(paste0("\\<", new_string, "\\>"), trigrams_splitted$first_words, ignore.case = TRUE)
                getter_three<- trigrams_splitted$last_word[finder_three]
                sum_na <- sum(is.na(getter_three[1:4]))
                if (sum_na < 4)  {
                        getter_three <- c(getter_three[1:(4-sum_na)], bigram_finder(splitted_string[2]))
                        return(getter_three[1:4])
                } else {
                        getter_three <- bigram_finder(splitted_string[2])
                        return(getter_three[1:4])
                } 
                
        }
        
        
        
        
        
        
        
        fourgram_finder <- function(splitted_string) {
                new_string = paste(splitted_string[1:3], collapse = " ")
                finder_four <- grepl(paste0("\\<", new_string, "\\>"), fourgrams_splitted$first_words, ignore.case = TRUE)
                getter_four<- fourgrams_splitted$last_word[finder_four]
                sum_na <- sum(is.na(getter_four[1:4]))
                if (sum_na < 4)  {
                        getter_four <- c(getter_four[1:(4-sum_na)], trigram_finder(splitted_string[2:3]))
                        return(getter_four[1:4])
                } else {
                        getter_four <- trigram_finder(splitted_string[2:3])
                        return(getter_four[1:4])
                } 
                
        }
        
        strip_text <- function(string) {
                string2 <- gsub("(\\[|\\]|\\(|\\)|\\{|\\}|\\+|\\*)+", "", string)
                return(string2)
        }
        
        
        
        predictor <- function(string) {
                string2 <- strip_text(string)
                splitted_string <- unlist(strsplit(string2, split = " "))
                len_string = length(splitted_string)  
                if (len_string >= 3) {
                        splitted_string <- splitted_string[(len_string - 2):len_string]
                        results <- fourgram_finder(splitted_string)
                        return(results[1:4])
                        
                } else if (len_string == 2) {
                        results <- trigram_finder(splitted_string)
                        return(results[1:4])
                        
                        
                } else if (len_string == 1) {
                        results <- bigram_finder(splitted_string)
                        return(results[1:4])
                } 
        }
        
        
        
        
        
        ## Outputs
        prediction <- reactive({prediction <-predictor(input$text)})
        
        
        prediction1 <- reactive({ if (length(prediction()[1]) == 0) {
                "The"
        } else { prediction()[1]}
                })
        
        
        prediction2 <- reactive({ if (length(prediction()[2]) == 0) {
                "When"
                } else if (prediction1() == prediction()[2]) {
                        "potato"
                } else {
                        prediction()[2]
                }
        })
        
        
        prediction3 <- reactive({ if (length(prediction()[3]) == 0) {
                "I"
                } else if (prediction1() == prediction()[3]) {
                        "squanchy"
                } else if (prediction2() == prediction()[3]) {
                        "summer"
                } else {
                        prediction()[3]}
        })
        
        prediction4 <- reactive({ if (length(prediction()[4]) == 0) {
                "Hello"
                } else if (prediction1() == prediction()[4]) {
                        "pickle rick"
                } else if (prediction2() == prediction()[4]) {
                        "Mortimer"
                } else if (prediction3() == prediction()[4]) {
                        "Birdperson"
                } else {
                        prediction()[4]}
        })
        
        
        output$prediction1 <- renderText(prediction1())
        output$prediction2 <- renderText(prediction2())
        output$prediction3 <- renderText(prediction3())
        output$prediction4 <- renderText(prediction4())
        

        observeEvent(input$first_word, {updateTextAreaInput(session, 
                                                            "text", 
                                                            value = paste(input$text, 
                                                                          prediction1()))})
        observeEvent(input$second_word, {updateTextAreaInput(session, 
                                                            "text", 
                                                            value = paste(input$text,
                                                                          prediction2()))})
        observeEvent(input$third_word, {updateTextAreaInput(session, 
                                                            "text", 
                                                            value = paste(input$text, 
                                                                          prediction3()))})
        observeEvent(input$fourth_word, {updateTextAreaInput(session, 
                                                            "text", 
                                                            value = paste(input$text, 
                                                                          prediction4()))})
        
        output$wordcloud <- renderPlot({wordcloud(unigrams$unique.values[(input$num_words[1]):(input$num_words[2])], 
                                                   freq = unigrams$nr.appearances,
                                                   scale = c(12, 1),
                                                   colors = brewer.pal(8, input$color),
                                                   max.words = 200,
                                                   random.order = FALSE)
        })
        
        output$documentation_text <- reactive({if (input$documentation == "about_the_app") {
                
               
                        HTML(paste("About the app",
        
                "This app uses an algorithm based on the Katz's Backoff Model of word prediction.
                        It works by taking the most recent three words and finding the most likely next four words.
                        If it cannot find a suitable word, it will look at the previous two words and try to predict based on them.
                        Similarly, if it cannot find a word based on those two, it will look at the individual most recent word typed.
                        When it cannot find any good words at all, it returns one of the top four most common words.
                        If there are dupicates in the returned word list, a placeholder word is used.",
                
                "Some choices being made when developing the algorithm and the app were difficult. 
                        I decided to leave in swear words as they are legitimate words the people commly use and I did not believe any children would be using this app.
                        If I were porting the application onto a smartphone app or for the general public, I would remove the bad words.",

        
                "There was also deliberation about whether to keep what are called 'stop words'. 
                        These are words that are so common they can cause problems for prediction and search algorithms.
                        In English, these are words like 'a', 'the', 'you', 'I', and so on. 
                        I opted to keep them in as I found they made for better predictions.",
                
                
                "Punctuation was also removed (except for apostrophes) to clean the inputted text and to not end sentences prematurely.
                        A next step may be to try to predict the end of sentences, but that is outside the scope of this app.
                        As it stands, the app will only make a run-on sentence.", sep = "<br/><br/>"))
                
                
        } else if (input$documentation == "limitations") {
                        HTML(paste("Limitations",
                        
                        "The application has been built for speed. 
                        In the case of some n-gram searches, this will result some accuracy loss. 
                        This is due to the file size limitations.
                        Only 20% of the data was sampled and of that, the least common n-gram combinations were dropped from the table.",
                        
                        "Furthermore, the build is currently only available for the English language.", sep = "<br/><br/>"))
        } else if (input$documentation == "next_steps") {
                        HTML(paste("Next Steps",

                                "The next steps would be to add another language. 
                                Russian or German would be the best choices as the data has already been made available as part of this project.
                                It would also be interesting to have more words come up as choices for the next word.
                                I would also like to try adding 5-gram and 6-gram tables to the app to see how much that improves accuracy.
                                I don't believe it would make a great difference in the overall accuracy but it might reduce the speed a lot. 
                                ", sep = "<br/><br/>"))
        } else if (input$documentation == "sources") {
                        HTML(paste("Sources",
                                "Source for updating text input fields https://shiny.rstudio.com/reference/shiny/latest/textAreaInput.html",
                                "Source for dynamic buttons https://sites.temple.edu/psmgis/2017/07/26/r-shiny-task-create-an-input-select-box-that-is-dependent-on-a-previous-input-choice/",
                                "Source for reactive variables https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r/17649022",
                                "More reactive variables https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny/40623750",
                                "Source for grep expression '\\<' and making n-gram table https://www.youtube.com/watch?v=0le0ijNVP5M",
                                "Grep reference guide https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php",
                                "Another grep reference guide http://www.ericagamet.com/wp-content/uploads/2016/04/Erica-Gamets-GREP-Cheat-Sheet.pdf",
                                "Source for buiding a better Shiny app: https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin",
                                "Shiny themes https://gallery.shinyapps.io/117-shinythemes/",
                                "Shiny themes again http://rstudio.github.io/shinythemes/",
                                "Source for wordcloud help http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know",
                                "Source for plot output https://shiny.rstudio.com/reference/shiny/latest/plotOutput.html", sep = "<br/>"))
        }
        
        }
)
}

)