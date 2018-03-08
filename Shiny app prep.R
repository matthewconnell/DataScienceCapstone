setwd("C:/Users/matth_000/Desktop/Coursera/Month10-CapstoneProject/final/en_US/Final_tables")

library(quanteda)
library(readtext)
library(data.table)
library(sqldf)


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
                  finder_four <- grepl(new_string, fourgrams_splitted$first_words)
                  getter_four<- fourgrams_splitted$last_word[finder_four]
                  return(paste(new_string, getter_four[1:3]))
        
        
        } else if (len_string == 2) {
                  new_string = paste(splitted_string[(len_string-1):len_string], collapse = " ")
                  finder_three <- grepl(new_string, trigrams_splitted$first_words)
                  getter_three<- trigrams_splitted$last_word[finder_three]
                  return(paste(new_string, getter_three[1:4]))
            
        } else if (len_string == 1) {
                  new_string = string
                  finder_two <- grepl(new_string, bigrams_splitted$first_words)
                  getter_two<- bigrams_splitted$last_word[finder_two]
                  return(paste(new_string, getter_two[1:4]))



        }
}






## Find data
## Possibly faster???
#rows_hort <- which(  
#  rowSums(
#    `dim<-`(grepl("about his horticultural", 
#                  as.matrix(df), 
#                  fixed=TRUE), dim(df))) > 0)
