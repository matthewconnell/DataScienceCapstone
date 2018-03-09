setwd("C:/Users/matth_000/Desktop/Coursera/Month 10 - Capstone Project/final/")

library(parallel)
numCores <- detectCores()
cl <- makeCluster(numCores)


library(ggplot2)
library(readtext) 
library(tm)           # for text mining
library(SnowballC)    # for stemming
library(wordcloud)    # for wordclouds
library(RColorBrewer) # for more color options

# Reading in the data
# Commenting out everything but twitter data while doing 
# exploratory stuff

data_twitter <- readLines("en_US/en_US.twitter.txt")
#df_twitter <- data.frame(data_twitter)
twit_corpus <- Corpus(VectorSource(data_twitter))


data_news <- readLines("en_US/en_US.news.txt")
#df_news <- data.frame(data_news)
news_corpus <- Corpus(VectorSource(data_news))

data_blogs <- readLines("en_US/en_US.blogs.txt")
#df_blogs <- data.frame(data_blogs)
blogs_corpus <- Corpus(VectorSource(data_blogs))



#Sample
set.seed(514)
twitter_sample <- sample(twit_corpus, length(twit_corpus)*0.1)
news_sample <- sample(news_corpus, length(news_corpus)*0.1)
blogs_sample <- sample(blogs_corpus, length(blogs_corpus)*0.1)

## (help from http://www.sthda.com/english/wiki/text-mining-and-
# word-cloud-fundamentals-in-r-5-simple-steps-you-should-know)


# Processing text:
# make all lower case
# remove numbers
# remove punctuation
# remove whitespace

process_text <- function(data, language = "english") {
        lower_data <- tm_map(data, content_transformer(tolower))
        no_numbers <- tm_map(lower_data, removeNumbers)
        no_punc <- tm_map(no_numbers, removePunctuation)
        no_white <- tm_map(no_punc, stripWhitespace)
}

## Perform the function on the twitter data

processed_twitter <- process_text(twitter_sample)
processed_news <- process_text(news_sample)
process_blogs <- process_text(blogs_sample)

# List of swear words from bannedwordlist.com/lists/swearWords.txt

swearWords1 <- read.table("swearWords.txt", header = FALSE, sep = "\n")

tt <- tm_map(tt, removeWords, swearWords1[,1])



dtm <- TermDocumentMatrix(tt)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)

dtm <- TermDocumentMatrix(tt, control = list(tokenize = ))
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)

### Barplot

barplot(d[50:60,]$freq, las = 2, names.arg = d[50:60,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")

## Wordcloud stuff

wordcloud(words = d$word, 
          freq = d$freq, 
          min.freq = 1, 
          max.words = 100,
          random.order = FALSE, 
          rot.per = 0.35, 
          colors = brewer.pal(12, "Set3"))

## brewer.pal
# For qualitative palettes, the lowest number of distinct values available 
# always is 3, but the largest number is different for different 
# palettes. It is given together with the palette names in the following table.
        
#        Accent	   8
#        Dark2	   8
#        Paired	   12
#        Pastel1	 9
#        Pastel2	 8
# ``     Set1	     9
#        Set2	     8
#        Set3	     12
        



        
        
#### Probably not necessary
## DATA_DIR <- system.file("extdata/", package = "readtext")  
## readtext(paste0("en_US/*"))
## readtext(paste0("en_Us/*.txt"), 
##         docvarsfrom = "filenames", 
##         docvarnames = c("Language", "Country"), 
##         dvsep = "_")





## N-grams

library(RWeka)
library(ngram)

all_processed_corpora <- paste(processed_twitter, process_blogs, processed_news, sep = ", ")
one_string <- paste(tt, collapse = '')


bigrams<- ngram(one_string, n = 2)

trigrams<- ngram(one_string, n = 3)

four_grams <- ngram(one_string, n = 4)

five_grams <- ngram(one_string, n = 5)

six_grams <- ngram(one_string, n = 6)

df <- as.data.frame(table(weka_trigram))
library(dplyr)
df2 <- arrange(df, desc(Freq))

six_grams_test <- c()
six_grams_test <- c(six_grams_test, get.ngrams(six_grams))