## Quanteda
setwd("C:/Users/matth_000/Desktop/Coursera/Month 10 - Capstone Project/final/en_US")

library(quanteda)
library(readtext)


twitter <- readtext("en_US.twitter.txt")
news <- readtext("en_US.news.txt")

twitter_corpus <- corpus(twitter)
news_corpus <- corpus(news)

twitter_and_news <- twitter_corpus + news_corpus

kwic(twitter_corpus, "beach", valuetype = "regex")