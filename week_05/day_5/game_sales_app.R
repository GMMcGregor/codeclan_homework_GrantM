library(tidyverse)
library(shiny)
library(CodeClanData)

game_sales <- game_sales

ui <- fluidPage(
#looking at how publishers and developers sales and critic/user scores 
#compare by genre and platform .
  #platforms and genres performed positively.
    titlePanel("Video Games Publisher/Developer Analysis by Genre and Platform"),

    sidebarLayout(
      sidebarPanel(
                    
        selectInput("genre",
                    "Genre",
                    label = h4("Genre"),
                    choices = unique(game_sales$genre),
                    width = 100
                    ),
        
        selectInput("platform",
                     "Platform",
                      label = h4("Platform"),
                      choices = unique(game_sales$platform),
                      width = 100
                    ),
                    
        actionButton("go", "Create Plots and Data", width = 165),
        width = 2
        ),
      
        
      mainPanel(
          tabsetPanel(
            tabPanel("Plots",
                     fluidRow(
                       column(6, plotOutput("sales_publisher")),
                       column(6, plotOutput("sales_developer")),
                       column(6, plotOutput("user_score")),
                       column(6, plotOutput("critic_score"))
                      ),
                     ),
            tabPanel("Data",
                     dataTableOutput("table") 
                    )
       ),
       width = 9
     )
   )
 )

server <- function(input, output) {
    
    filtered_data <- eventReactive(input$go, {
      game_sales %>%
        filter(genre == input$genre) %>%
        filter(platform == input$platform) %>% 
        select(
            developer,
            publisher,
            critic_score,
            user_score,
            sales,
            year_of_release
        )
    })
    #looking at relationship between sales by publisher and developer
    #sales by year of release and publisher
    output$sales_publisher <- renderPlot({
      ggplot(filtered_data()) +
        aes(x = year_of_release, y =sales, fill = publisher) +
        geom_col()
    })
    #sales by year of release and developer
    output$sales_developer <- renderPlot({
      ggplot(filtered_data()) +
        aes(x = year_of_release, y = sales, fill = developer) +
        geom_col()
    })
    #looking at relationship between sales by critic_score and user_score. 
    #user_score by year of release and sales
    output$user_score <- renderPlot({
      ggplot(filtered_data()) +
        aes(x = year_of_release, y = user_score, fill = publisher) +
        geom_col()
    })
    #critic_score by year of release and sales
    output$critic_score <- renderPlot({
      ggplot(filtered_data()) +
        aes(x = year_of_release, y = critic_score, fill = developer) +
        geom_col()
    })
    
    output$table <- renderDataTable({
      filtered_data()
    })
    
}

shinyApp(ui = ui, server = server)
