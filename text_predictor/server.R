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
                        "me"
                } else {
                        prediction()[2]
                }
        })
        
        
        prediction3 <- reactive({ if (length(prediction()[3]) == 0) {
                "I"
                } else if (prediction1() == prediction()[3]) {
                        "you"
                } else if (prediction2() == prediction()[3]) {
                        "her"
                } else {
                        prediction()[3]}
        })
        
        prediction4 <- reactive({ if (length(prediction()[4]) == 0) {
                "Hello"
                } else if (prediction1() == prediction()[4]) {
                        "because"
                } else if (prediction2() == prediction()[4]) {
                        "just"
                } else if (prediction3() == prediction()[4]) {
                        "if"
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
        
        
        wordcloud_values1 <- eventReactive(input$go, {
                input$num_words[1]
        })
        wordcloud_values2 <- eventReactive(input$go, {
                input$num_words[2]
        })
        wordcloud_color <- eventReactive(input$go, {
                input$color
        })
        
        
        
        
        output$wordcloud <- renderPlot({wordcloud(unigrams$unique.values[wordcloud_values1():wordcloud_values2()],
                                         freq = unigrams$nr.appearances,
                                         scale = c(12, 1),
                                         colors = brewer.pal(8, wordcloud_color()),
                                         max.words = 150,
                                         random.order = FALSE)
        })
        
        output$doc_text <- renderText(input$documentation)
                
                
         
        
        
        
        
        

}

)