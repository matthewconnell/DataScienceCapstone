# From https://cran.r-project.org/web/packages/readtext/vignettes/readtext_vignette.html

# DOWNLOAD FILES ###################

#######################


# Set Working Directory
setwd("C:/Users/matth_000/Desktop/Coursera/Month 10 - Capstone Project/final/")

# Load packages

library(readtext) 
library(tm)         # for text mining
library(SnowballC)  # for stemming
library(wordcloud)  # for wordclouds
library(RColorBrewer) # for more color options


# Reading the data into R

# (From R-bloggers.com)

data_twitter <- readLines("en_US/en_US.twitter.txt")
df_twitter <- data.frame(data_twitter)

data_news <- readLines("en_US/en_US.news.txt")
df_news <- data.frame(data_news)

data_blogs <- readLines("en_US/en_US.blogs.txt")
df_blogs <- data.frame(data_blogs)

# Exploratory Data Analysis
# File sizes in MB

file.info("en_US/en_US.twitter.txt")$size/1024/1024
file.info("en_US/en_US.news.txt")$size/1024/1024
file.info("en_US/en_US.blogs.txt")$size/1024/1024

# Numbers of words, length, etc.
# Number of rows:

nrow(df_twitter)
nrow(df_news)
nrow(df_blogs)

num_words_twitter <- sum(grepl(" ", data_twitter))
num_words_blogs <- sum(grepl(" ", data_blogs))
num_words_news <- sum(grepl(" ", data_news))

# Summarize the datasets











# Love vs. hate on Twitter

love <- sum(grepl("love", data_twitter))
hate <- sum(grepl("hate", data_twitter))
love / hate



# find the longest string in the blogs corpus

longest <- which.max(nchar(data_blogs))
nchar(data_blogs[longest])

