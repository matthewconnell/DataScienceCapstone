con <- file("en_US.twitter.txt", "r") 


total_lines <- 200
probability <- 0.5

selection <- rbinom(total_lines, 1, probability)



for (i in 1:10) {
  tester2 <- c()
  tester2 <- c(tester2, readLines(con, i, skip = selection[i]))
}

for (i in 1:20) {
  print(i)
}



twitter_sample <- sample(data_twitter, length(data_twitter)*0.00001)
news_sample <- sample(data_news, length(data_news)*0.00001)
blogs_sample <- sample(data_blogs, length(data_blogs)*0.00001)

all_samples = c(twitter_sample, news_sample, blogs_sample)