
library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(titlePanel("BC Liquor Store Prices"),
                sidebarLayout(
                        sidebarPanel(
                                sliderInput(inputId = "priceInput",
                                            label = "Price",
                                            min = 0,
                                            max = 100,
                                            value = c(25,40),
                                            pre = "$"),
                                radioButtons(inputId = "typeInput",
                                             label ="Product type",
                                             choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                                             selected = "WINE"),
                                uiOutput("countryOutput")
                        ),
                        mainPanel(
                                plotOutput("coolplot"),
                                br(), br(),
                                DT::dataTableOutput("results")
                        )
                
                )
                )
 



server <- function(input, output) {
        
        
        filtered <- reactive({
                if (is.null(input$countryInput)) {
                        return(NULL)
                }
                bcl %>%
                filter(Price >= input$priceInput[1],
                       Price <= input$priceInput[2],
                       Type == input$typeInput, 
                       Country == input$countryInput
                )
        })
        
        
        output$coolplot <- renderPlot({
                if (is.null(filtered())) {
                        return()
                }
                ggplot(filtered(), aes(Alcohol_Content)) + 
                        geom_histogram()
        })
        
        
        output$results <- DT::renderDataTable({
                filtered() 
        })
        
        
        output$countryOutput <- renderUI({
                selectInput("countryInput", "Country",
                            sort(unique(bcl$Country)),
                            selected = "CANADA")
        })
        
        priceDiff <- reactive({
                input$priceInput
        })
        
        observe({ print(priceDiff()) })
        
        
   
}

# Run the application 
shinyApp(ui = ui, server = server)

