
library(shiny)

ui <- fluidPage(titlePanel("BC Liquor Store Prices"),
                sidebarLayout(
                        sidebarPanel("inputs"),
                        mainPanel("results here")
                
                )
                )
 



server <- function(input, output) {
   
   
}

# Run the application 
shinyApp(ui = ui, server = server)

