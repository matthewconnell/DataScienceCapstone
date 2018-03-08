# From https://cran.r-project.org/web/packages/readtext/vignettes/readtext_vignette.html


#load packages

library(readtext) 
library(tm)

#get data directory from readtext

DATA_DIR <- system.file("extdata/", package = "readtext")  

readtext(paste0("en_US/*"))

readtext(paste0("en_Us/*.txt"), 
         docvarsfrom = "filenames", 
         docvarnames = c("Language", "Country"), 
         dvsep = "_")


# From R-bloggers.com

data_twitter <- readLines("en_US/en_US.twitter.txt")
df_twitter <- data.frame(data)

data_news <- readLines("en_US/en_US.news.txt")
df_news <- data.frame(data_news)

data_blogs <- readLines("en_US/en_US.blogs.txt")
df_blogs <- data.frame(data_blogs)

# Love vs. hate on Twitter

love <- sum(grepl("love", data))
hate <- sum(grepl("hate", data))
love / hate



# find the longest string in the blogs corpus

longest <- which.max(nchar(data_blogs))
nchar(data_blogs[longest])
