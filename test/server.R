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
  ##
  ##
  ##
  
  predictor <- function(string) {
    
    
    splitted_string <- unlist(strsplit(string, split = " "))
    len_string = length(splitted_string)  
    
    if (len_string >= 3) {
      new_string = paste(splitted_string[(len_string-2):len_string], collapse = " ")
      finder_four <- grepl(new_string, fourgrams_splitted$first_words, ignore.case = TRUE)
      getter_four<- fourgrams_splitted$last_word[finder_four]
      return(getter_four[1:3])
      
      
    } else if (len_string == 2) {
      new_string = paste(splitted_string[(len_string-1):len_string], collapse = " ")
      finder_three <- grepl(new_string, trigrams_splitted$first_words, ignore.case = TRUE)
      getter_three<- trigrams_splitted$last_word[finder_three]
      return(getter_three[1:4])
      
    } else if (len_string == 1) {
      new_string = unlist(strsplit(string, " "))
      finder_two <- grepl(new_string, bigrams_splitted$first_words, ignore.case = TRUE)
      getter_two<- bigrams_splitted$last_word[finder_two]
      return(getter_two[1:4])
      
      
      
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
