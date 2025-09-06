# Text Prediction App

Link to app: http://mconnell.shinyapps.io/text_predictor   

This repo contains code for a shiny app that predicts text input. This is the final project for Coursera's Data Science Specialization. The app uses an algorithm based on Katz's Stupid-Backoff Model of word prediction. It works by taking the most recent three words and finding the most likely next four words. If it cannot find a suitable word, it will look at the previous two words and try to predict based on them. Similarly, if it cannot find a word based on those two, it will look at the individual most recent word typed. When it cannot find any good words at all, it returns one of the top four most common words. If there are duplicates in the returned word list, a placeholder word is used.

Some choices being made when developing the algorithm and the app were difficult. I decided to leave in swear words as they are legitimate words people commonly use and I did not believe any children would be using this app. If I were porting the application onto a smartphone app or for the general public, I would remove the curse words.
                                                                         
There was also deliberation about whether to keep what are called 'stop words'. These are words that are so common they can cause problems for prediction and search algorithms. In English, these are words like 'a', 'the', 'you', 'I', and so on. I opted to keep them in as I found they made for better predictions.

Punctuation was also removed (except for apostrophes) to clean the inputted text and to not end sentences prematurely. A next step may be to try to predict the end of sentences, but that is outside the scope of this app. As it stands, the app will only make a run-on sentence.
                                                                         
## Limitations

The application has been built for speed. In the case of some n-gram searches, this will result some accuracy loss. This is due to the file size limitations. Only 20% of the data was sampled and of that, the least common n-gram combinations were dropped from the table.
                                                                         
Furthermore, the build is currently only available for the English language.                   

## Next Steps
          
The next steps would be to add another language. Russian or German would be the best choices as the data has already been made available as part of this project. It would also be interesting to have more words come up as choices for the next word. I would also like to try adding 5-gram and 6-gram tables to the app to see how much that improves accuracy. I don't believe it would make a great difference in the overall accuracy but it might reduce the speed a lot.

## Sources

Grep expressions and making n-gram table: https://www.youtube.com/watch?v=0le0ijNVP5M                                                                                                             
Dan Jurafsky's NLP course on YouTube: https://www.youtube.com/watch?v=dkUtavsPqNA&t=1s

Grep reference guide: https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php

Another grep reference guide: http://www.ericagamet.com/wp-content/uploads/2016/04/Erica-Gamets-GREP-Cheat-Sheet.pdf

Buiding a better Shiny app: https://deanattali.com/blog/building-shiny-apps-tutorial/#1-before-we-begin
 
Shiny themes: https://gallery.shinyapps.io/117-shinythemes/
 
Shiny themes again: http://rstudio.github.io/shinythemes/

Wordcloud: http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know

Plot output: 'https://shiny.rstudio.com/reference/shiny/latest/plotOutput.html

Shiny inputSelector: http://shiny.rstudio.com/gallery/selectize-vs-select.html

Updating text input fields: https://shiny.rstudio.com/reference/shiny/latest/textAreaInput.html

Dynamic buttons: https://sites.temple.edu/psmgis/2017/07/26/r-shiny-task-create-an-input-select-box-that-is-dependent-on-a-previous-input-choice/

Reactive variables:https://stackoverflow.com/questions/17002160/shiny-tutorial-error-in-r/17649022

More reactive variables: https://stackoverflow.com/questions/40623749/what-is-object-of-type-closure-is-not-subsettable-error-in-shiny/40623750



## Contact

LinkedIn: http://www.linkedin.com/in/matthew-connell-a815b9157

Twitter: https://twitter.com/atc84                                                                                   
