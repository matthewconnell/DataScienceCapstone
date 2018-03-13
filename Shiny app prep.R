setwd("C:/Users/matth_000/Desktop/Coursera/Month10-CapstoneProject/final/en_US/Final_tables")


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


library(wordcloud)
wordcloud(unigrams$unique.values[1:100], freq = unigrams$nr.appearances,
          colors = brewer.pal(8, "Paired"),
          max.words = 200,
          random.order = FALSE)



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

## Define finder functions

unigram_finder <- function(number) {
        random_words <- c()
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





predictor <- function(string) {
    splitted_string <- unlist(strsplit(string, split = " "))
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


predictor("alsdkfl alskdfla")
preditcion <- predictor("it is")
predictor("some interesting things")
predictor(' I ')

if (prediction[1] == prediction[2]) {
        prediction[2] <- "potato"
}

## Find data
## Possibly faster???
#rows_hort <- which(  
#  rowSums(
#    `dim<-`(grepl("about his horticultural", 
#                  as.matrix(df), 
#                  fixed=TRUE), dim(df))) > 0)

output$prediction1 <- renderText({predictor(input$text)}[1])
output$prediction2 <- renderText({predictor(input$text)}[2])
output$prediction3 <- renderText({predictor(input$text)}[3])
output$prediction4 <- renderText({predictor(input$text)}[4])



## Source for updating text input fields https://shiny.rstudio.com/reference/shiny/latest/textAreaInput.html
## Source for dynamic buttons https://sites.temple.edu/psmgis/2017/07/26/r-shiny-task-create-an-input-select-box-that-is-dependent-on-a-previous-input-choice/
## Source for reactive variables https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r/17649022
## More reactive variables https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny/40623750
## Source for grep expression "\\<" and making n-gram table https://www.youtube.com/watch?v=0le0ijNVP5M
## Grep reference guide https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php
## Another grep reference guide http://www.ericagamet.com/wp-content/uploads/2016/04/Erica-Gamets-GREP-Cheat-Sheet.pdf
## Source for buiding a better Shiny app: https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin
## Shiny themes https://gallery.shinyapps.io/117-shinythemes/
## Shiny themes again http://rstudio.github.io/shinythemes/
## Source for wordcloud help http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know
## 








