setwd("C:/Users/matth_000/Desktop/Coursera/Month 10 - Capstone Project/final/en_US")

##library(parallel)
##numCores <- detectCores()
##cl <- makeCluster(numCores)


library(ggplot2)
library(readtext) 
library(tm)           # for text mining
library(SnowballC)    # for stemming
library(wordcloud)    # for wordclouds
library(RColorBrewer) # for more color options

# Reading in the data
# Commenting out everything but twitter data while doing 
# exploratory stuff

data_twitter <- readLines("en_US.twitter.txt", encoding = "UTF-8")


data_news <- readLines("en_US.news.txt", encoding = "UTF-8")


data_blogs <- readLines("en_US.blogs.txt", encoding = "UTF-8")


con <- file("en_US.twitter.txt", "r") 
readLines(con, 1) ## Read the first line of text 
readLines(con, 1) ## Read the next line of text 
readLines(con, 5) ## Read in the next 5 lines of text 
close(con) ## It's important to close the connection when you are done



#Sample
set.seed(514)
twitter_sample <- sample(twit_corpus, length(twit_corpus)*0.2)
news_sample <- sample(news_corpus, length(news_corpus)*0.2)
blogs_sample <- sample(blogs_corpus, length(blogs_corpus)*0.2)

## (help from http://www.sthda.com/english/wiki/text-mining-and-
# word-cloud-fundamentals-in-r-5-simple-steps-you-should-know)


# Processing text:
# make all lower case
# remove numbers
# remove whitespace

## create a toSpace transformer:
  toSpace <- content_transformer(function(x, pattern) {return (gsub(pattern," ", x))})
  all_corpus<- tm_map(all_corpus,toSpace,"[^[:graph:]]")

## Reference: https://eight2late.wordpress.com/2015/05/27/a-gentle-introduction-to-text-mining-using-r/
## Refenece 2: https://stackoverflow.com/a/40769188/8243865
  

process_text <- function(some_corpus) {
  some_corpus <- tm_map(some_corpus, content_transformer(tolower))
  some_corpus <- tm_map(some_corpus, removeNumbers)
  some_corpus <- tm_map(some_corpus, stripWhitespace)
}

## Perform the function on the twitter data

processed_corpus <- process_text(all_corpus)

processed_twitter <- process_text(twitter_sample)
processed_news <- process_text(news_sample)
processed_blogs <- process_text(blogs_sample)

# List of swear words from bannedwordlist.com/lists/swearWords.txt

swearWords1 <- read.table("swearWords.txt", header = FALSE, sep = "\n")

tt <- tm_map(tt, removeWords, swearWords1[,1])








## N-grams

library(RWeka)
library(ngram)

twitter_string <- paste(processed_twitter, collapse = '/', sep = ' ')
news_string <- paste(processed_news, collapse = '/', sep = " ")
blogs_string <- paste(process_blogs, collapse = '/', sep = ' ')

bigrams<- ngram(one_string, n = 2)

trigrams<- ngram(one_string, n = 3)

four_grams <- ngram(one_string, n = 4)

five_grams <- ngram(twitter_string, n = 5)
five_grams_news <- ngram(news_string, n = 5)
five_grams_blog <- ngram(blogs_string, n = 5)

six_grams <- ngram(one_string, n = 6)

five_grams_test <- c()
five_grams_test <- c(five_grams_test, get.ngrams(five_grams), get.ngrams(five_grams_blog), get.ngrams(five_grams_news))


six_grams_test <- c()
six_grams_test <- c(six_grams_test, get.ngrams(six_grams))

#4
length(grep("the players", five_grams_test))
length(grep("but the referees", five_grams_test))
length(grep("the defense", five_grams_test))
length(grep("the crowd", five_grams_test))

#5
length(grep("at the beach", five_grams_test))
length(grep("at the grocery", five_grams_test))
length(grep("at the movies", five_grams_test))
length(grep("at the mall", five_grams_test))

#8
length(grep("toes", five_grams_test))
length(grep("eyes", five_grams_test))
length(grep("ears", five_grams_test))
length(grep("fingers", five_grams_test))

#9
length(grep("during the hard", five_grams_test))
length(grep("during the sad", five_grams_test))
length(grep("during the worse", five_grams_test))
length(grep("during the bad", five_grams_test))






##################################
1 case of beer
2 would mean the world
3 make me the happiest
4 defense
5 beach
6 be on my way
7 quite some time
8 fingers 
9 bad
10 you must be insane


##### This is not a good way of getting the answers
##### Overtraining and it doesn't work for question 9
probability of:
  eyes <- 11567/85411
  ears <-  66931/85411
  fingers<- 3014/85411
  
  the_crowd <- 1576
  the_defense <- 569
  the_players <- 858
  
grepped_terms <- c(the_crowd, the_defense, the_players)

sum_final_terms <- sum(grepped_terms)

chance_the_crowd <- 1576/sum_final_terms
chance_the_defense <- 569/sum_final_terms
chance_the_players <- 858/sum_final_terms

probablity_but_the_crowd <- length(grep("but the crowd", five_grams_test))*(1/chance_the_crowd)
probablity_but_the_defense <-length(grep("but the defense", five_grams_test))*(1/chance_the_defense)
probablity_but_the_players <-length(grep("but the players", five_grams_test))*(1/chance_the_players)

probs <- c(probablity_but_the_crowd, probablity_but_the_defense, probablity_but_the_players)

maximum <- which.max(probs)
answer <- probs[maximum]




  ##################################














