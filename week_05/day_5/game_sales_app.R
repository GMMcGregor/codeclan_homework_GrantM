library(tidyverse)
library(shiny)

library(CodeClanData)

game_sales <- read_csv(game_sales)



ui <- fluidPage()

server <- function(input, output) {
}



shinyApp(ui = ui, server = server)

