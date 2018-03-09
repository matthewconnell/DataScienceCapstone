setwd("C:/Users/matth_000/Desktop/Coursera/Month10-CapstoneProject/final/en_US/Final_tables")


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

## Define finder functions


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
                word <- unigrams$unique.values[sample(1:30, 1)]
                random_words <- c(random_words, word)
        }
        return(random_words)
}


predictor <- function(string) {
  
    splitted_string <- unlist(strsplit(string, split = " "))
    len_string = length(splitted_string)  
  
        if (len_string >= 3) {
                results <- fourgram_finder(splitted_string)
                if (sum(is.na(results)) == 0) {
                        return(results)
                } else if (sum(is.na(results)) == 1) {
                        results2 <- trigram_finder(splitted_string[2:3])
                        return(c(results[1:3], results2[1]))
                } else if (sum(is.na(results)) == 2) {
                        results3 <- trigram_finder(splitted_string[2:3])
                        return(c(results[1:2], results3[1:2]))
                } else if (sum(is.na(results)) == 3) {
                        results4 <- trigram_finder(splitted_string[2:3])
                        return(c(results[1], results4[1:3]))
                } else if (sum(is.na(results)) == 4) {
                        results5 <- trigram_finder(splitted_string[2:3])
                        return(results5[1:4])
                }
               
        
        
       
        
      } else if (len_string == 2) {
                results <- trigram_finder(splitted_string)
                if (sum(is.na(results)) == 0) {
                        return(results)
                } else if (sum(is.na(results)) == 1) {
                        results2 <- bigram_finder(splitted_string[2])
                        return(c(results[1:3], results2[1]))
                } else if (sum(is.na(results)) == 2) {
                        results3 <- bigram_finder(splitted_string[2])
                        return(c(results[1:2], results3[1:2]))
                } else if (sum(is.na(results)) == 3) {
                        results4 <- bigram_finder(splitted_string[2])
                        return(c(results[1], results4[1:3]))
                } else if (sum(is.na(results)) == 4) {
                        results5 <- bigram_finder(splitted_string[2])
                        return(results5[1:4])
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


replace_i <- function(column) {
        column <- gsub("^i$", "I", column)
        column <- gsub("^i'm$", "I'm", column)
        return(column)
}



unigrams$unique.values <- replace_i(unigrams$unique.values)
bigrams_splitted$last_word <- replace_i(bigrams_splitted$last_word)
trigrams_splitted$last_word <- replace_i(trigrams_splitted$last_word)
fourgrams_splitted$last_word <- replace_i(fourgrams_splitted$last_word)

write.table(unigrams, "unigrams.txt")
write.table(bigrams_splitted, "bigrams_splitted.txt")
write.table(trigrams_splitted, "trigrams_splitted.txt")
write.table(fourgrams_splitted, "fourgrams_splitted.txt")


## Find data
## Possibly faster???
#rows_hort <- which(  
#  rowSums(
#    `dim<-`(grepl("about his horticultural", 
#                  as.matrix(df), 
#                  fixed=TRUE), dim(df))) > 0)
