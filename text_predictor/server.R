library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
        
        
        
        
        
        library(data.table)
        
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
        
        bigram_finder <- function(splitted_string) {
                new_string = splitted_string
                finder_two <- grepl(paste0(" ", new_string), bigrams_splitted$first_words, ignore.case = TRUE)
                getter_two<- bigrams_splitted$last_word[finder_two]
                return(getter_two[1:4])
        }
        
        
        trigram_finder <- function(splitted_string) {
                new_string = paste(splitted_string[1:2], collapse = " ")
                finder_three <- grepl(paste0(" ", new_string), trigrams_splitted$first_words, ignore.case = TRUE)
                getter_three<- trigrams_splitted$last_word[finder_three]
                return(getter_three[1:4])
        }
        
        fourgram_finder <- function(splitted_string) {
                new_string = paste(splitted_string[1:3], collapse = " ")
                finder_four <- grepl(paste0(" ", new_string), fourgrams_splitted$first_words, ignore.case = TRUE)
                getter_four<- fourgrams_splitted$last_word[finder_four]
                return(getter_four[1:4])
        }
        
        unigram_finder <- function(number) {
                random_words <- c()
                for (i in 1:number) {
                        word <- unigrams$unique.values[i]
                        random_words <- c(random_words, word)
                }
                return(random_words)
        }
        
        
        
        predictor <- function(string) {
                splitted_string <- unlist(strsplit(string, split = " "))
                len_string = length(splitted_string)  
                if (len_string >= 3) {
                        splitted_string <- splitted_string[(len_string - 2):len_string]
                        results <- fourgram_finder(splitted_string)
                        
                        if (sum(is.na(results[1:4])) == 0) {
                                return(results[1:4])
                                
                        } else if (sum(is.na(results[1:4])) == 1) {
                                results2 <- trigram_finder(splitted_string[2:3])
                                if (sum(is.na(results2[1])) == 0) {
                                        return(c(results[1:3], results2[1]))
                                } else if (sum(is.na(results2[1])) == 1) {
                                        results2_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results2_sub[1])) == 0) {
                                                return(c(results[1:3], results2_sub[1]))
                                        } else {
                                                results2_sub_sub <- unigram_finder(1)
                                                return(c(results[1:3]), results2_sub_sub[1])
                                        }
                                } 
                        } else if (sum(is.na(results[1:4])) == 2) {
                                results3 <- trigram_finder(splitted_string[2:3])
                                if (sum(is.na(results3[1:2])) == 0) {
                                        return(c(results[1:2], results3[1:2]))
                                } else if (sum(is.na(results3[1:2])) == 1) {
                                        results3_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results3_sub)) == 0) {
                                                return(c(results[1:2], results3_sub[1:2]))
                                        } else {
                                                results3_sub_sub <- unigram_finder(2)
                                                return(c(results[1:2]), results3_sub_sub[1:2])
                                        }
                                }
                        }
                        else if (sum(is.na(results[1:4])) == 3) {
                                results4 <- trigram_finder(splitted_string[2:3])
                                if (sum(is.na(results4[1:3])) == 0) {
                                        return(c(results4[1], results4[1:3]))
                                } else if (sum(is.na(results4[1:3])) == 1) {
                                        results4_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results4_sub)) == 0) {
                                                return(c(results[1], results4_sub[1:3]))
                                        } else {
                                                results4_sub_sub <- unigram_finder(3)
                                                return(c(results[1]), results4_sub_sub[1:3])
                                        }
                                } else if (sum(is.na(results4[1:3])) == 1) {
                                        results4_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results4_sub)) == 0) {
                                                return(c(results[1], results4_sub[1:3]))
                                        } 
                                } else if (sum(is.na(results4[1:3])) == 2) {
                                        results4_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results4_sub)) == 0) {
                                                return(c(results[1], results4[1], results4_sub[1:2]))
                                        }
                                } else if (sum(is.na(results4[1:3])) == 3) {
                                        results4_sub <- unigram_finder(3)
                                        return(c(results[1], results4_sub[1:2]))
                                        
                                }
                        }
                        else if (sum(is.na(results[1:4])) == 4) {
                                results5 <- trigram_finder(splitted_string[2:3])
                                if (sum(is.na(results5[1:4])) == 0) {
                                        return(results5[1:4])
                                } else if (sum(is.na(results5[1:4])) == 1) {
                                        results5_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results5_sub)) == 0) {
                                                return(results5_sub[1:4])
                                        } else {
                                                results5_sub_sub <- unigram_finder(4)
                                                return(c(results5[1:3], results5_sub_sub[1]))
                                        }
                                } else if (sum(is.na(results5[1:4])) == 2) {
                                        results6_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results6_sub)) == 0) {
                                                return(c(results5[1:2], results6_sub[1:2]))
                                        } else {
                                                results6_sub_sub <- unigram_finder(2)
                                                return(c(results5[1:2], results6_sub_sub[1:4]))
                                        }
                                } else if (sum(is.na(results5[1:4])) == 3) {
                                        results7_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results7_sub)) == 0) {
                                                return(c(results5[1], results7_sub[1:3]))
                                        } else {
                                                results7_sub_sub <- unigram_finder(4)
                                                return(c(results5[1], results7_sub_sub[1]))
                                        } 
                                } else if (sum(is.na(results5[1:4])) == 4) {
                                        results8_sub <- bigram_finder(splitted_string[3])
                                        if (sum(is.na(results8_sub)) == 0) {
                                                return(results8_sub[1:4])
                                        } else {
                                                results8_sub_sub <- unigram_finder(4)
                                                return(results8_sub_sub[1:4])
                                        }
                                }
                        }
                } else if (len_string == 2) {
                        results <- trigram_finder(splitted_string)
                        if (sum(is.na(results[1:4])) == 0) {
                                return(results[1:4])
                        } else if (sum(is.na(results[1:4])) == 1) {
                                results2 <- bigram_finder(splitted_string[2])
                                return(c(results[1:3], results2[1]))
                        } else if (sum(is.na(results[1:4])) == 2) {
                                results3 <- bigram_finder(splitted_string[2])
                                return(c(results[1:2], results3[1:2]))
                        } else if (sum(is.na(results[1:4])) == 3) {
                                results4 <- bigram_finder(splitted_string[2])
                                return(c(results[1], results4[1:3]))
                        } else if (sum(is.na(results[1:4])) == 4) {
                                results5 <- bigram_finder(splitted_string[2])
                                if (sum(is.na(results5[1:4])) == 0) {
                                        return(results5[1:4])
                                } else if (sum(is.na(results5[1:4])) == 1) {
                                        results5_sub <- unigram_finder(1)
                                        return(c(results5[1:3], results5_sub[1]))
                                } else if (sum(is.na(results5[1:4])) == 2) {
                                        results6_sub <- unigram_finder(2)
                                        return(c(results5[1:2], results5_sub[2]))
                                } else if (sum(is.na(results5[1:4])) == 3) {
                                        results7_sub <- unigram_finder(3)
                                        return(c(results5[1], results5_sub[1:3]))
                                } else if (sum(is.na(results5[1:4])) == 4) {
                                        results8_sub <- unigram_finder(4)
                                        return(results8_sub[1:4])
                                } 
                        }
                        
                        
                } else if (len_string == 1) {
                        results <- bigram_finder(splitted_string)
                        if (sum(is.na(results)) == 0) {
                                return(results)
                        } else if (sum(is.na(results)) == 1) {
                                results2 <- unigram_finder(1)
                                return(c(results[1:3], results2[1]))
                        } else if (sum(is.na(results)) == 2) {
                                results3 <- unigram_finder(2)
                                return(c(results[1:2], results3[1:2]))
                        } else if (sum(is.na(results)) == 3) {
                                results4 <- unigram_finder(3)
                                return(c(results[1], results4[1:3]))
                        } else if (sum(is.na(results)) == 4) {
                                results5 <- unigram_finder(4)
                                return(results5[1:4])
                        } 
                }
        }
        
        
        
        
        ## Outputs
        
        
        
        output$prediction <- renderText(c("    ", {predictor(input$text)}[1],
                                          "           ", {predictor(input$text)}[2], 
                                          "           ", {predictor(input$text)}[3],
                                          "           ", {predictor(input$text)}[4]))
        output$time <- renderText({c("Your search took", 
                                     {round(as.numeric(system.time(result <- predictor(input$text)))[1],3)}, 
                                     "seconds.")})
        
        output$prediction1 <- renderText({predictor(input$text)}[1])
        output$prediction2 <- renderText({predictor(input$text)}[2])
        output$prediction3 <- renderText({predictor(input$text)}[3])
        output$prediction4 <- renderText({predictor(input$text)}[4])
        
        observeEvent(input$first_word, {
                updateTextAreaInput(session, "text", 
                                    value = paste(input$text, predictor(input$text)[1]))
        })
        observeEvent(input$second_word, {
                updateTextAreaInput(session, "text", 
                                    value = paste(input$text, predictor(input$text)[2]))
        })
        observeEvent(input$third_word, {
                updateTextAreaInput(session, "text", 
                                    value = paste(input$text, predictor(input$text)[3]))
        })
        observeEvent(input$fourth_word, {
                updateTextAreaInput(session, "text", 
                                    value = paste(input$text, predictor(input$text)[4]))
        })
        
        
}
)
