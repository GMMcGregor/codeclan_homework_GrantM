
library(tidyverse)
library(shiny)
library(CodeClanData)


ui <- fluidPage(
  
  titlePanel("Five Country Medal Comparison"),
  sidebarLayout(
    sidebarPanel(
      
      radioButtons(
        inputId = "Season",
        label = "Summer or Winter Olympics?",
        choices =  c("Summer", "Winter")
      ),
      
      radioButtons(
        inputId = "Medal",
        label = "Bronze, Silver or Gold?",
        choices = c("Bronze", "Silver", "Gold")
      )
      
      
    ),
    mainPanel(
      plotOutput(outputId = "medal_plot")    
    )
  )
)


server <- function(input, output){
  
  output$medal_plot <- renderPlot({
    
    
    olympics_overall_medals %>%
      filter(team %in% c("United States",
                         "Soviet Union",
                         "Germany",
                         "Italy",
                         "Great Britain")) %>%
      filter(medal == input$Medal) %>%
      filter(season == input$Season) %>%
      ggplot() +
      aes(x = team, y = count, fill = medal) +
      geom_col() +
      scale_fill_manual(
        values = c( "Bronze" = "#cc6600",
                    "Silver" = "#b3b3b3",
                    "Gold"  =  "#998200")
      )
  })
}

shinyApp(ui = ui, server = server)
