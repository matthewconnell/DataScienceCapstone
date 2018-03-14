Text Prediction App
========================================================
author: Matthew Connell
date: March 14th, 2018
autosize: true

About the Algorithm
========================================================

 - This app uses an algorithm based on the Katz's Backoff Model of word prediction. 
It takes the most recent words and finds the four most likely next words.

 - It was constructed using data from twitter, blogs, and news sites. This textual data was put together in a corpus, tokenized into 1-, 2-, 3-, and 4-word groups.
 These groups were aggregated by their frequency.

 - When you type a phrase, the app searches through the table of text for that phrase and returns what it thinks will be the next word. 

 - When it cannot find any words, it returns one of the top four most common words.


Limitations and Next Steps
========================================================


 - To make the app more responsive, file size had to be reduced. 
 This will result in some accuracy loss.

 - Only 20% of the data was sampled and of that, the least common n-gram combinations were dropped from the tables.
Furthermore, the build is currently only available in English.

 - One next step would be to add another language. 
Russian or German would be the best choices as the data has already been made available as part of this project.

 - I would also like to try adding 5-gram and 6-gram tables to the app to see how much that improves accuracy.
 
 
Using the App
========================================================

 - The app is available at <a href>http://mconnell.shinyapps.io/text_predictor</a>

 - The code can be found at <a href>http://github.com/matc84/DataScienceCapstone</a>
 
 - Here is a screenshot: 
 
 ![screenshot](text_app_shot.png)


Sources
========================================================


 - Grep expressions and making n-gram table: <a href> https://www.youtube.com/watch?v=0le0ijNVP5M</a>
 - Grep reference guide: <a href>https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php</a>
 - Buiding a better Shiny app: <a href>https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin</a>
 - Wordcloud: <a href>http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know</a>
 - Plot output: <a href>https://shiny.rstudio.com/reference/shiny/latest/plotOutput.html</a>
 - More sources can be found on the app's site
 


