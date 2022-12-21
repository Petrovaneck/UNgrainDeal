
library(shiny)
library(rsconnect)

ui <- fluidPage(
  
  titlePanel(title = "UN grain deal"),
  
       tabsetPanel(
        tabPanel(title = 'Grain categories & shares',
                 plotOutput(outputId = 'plot1'),
                 plotOutput(outputId = 'plot2'),
                 plotOutput(outputId = 'plot3')),
        tabPanel(title = "Grain and country select",
                 sidebarPanel(
                   
                   selectInput(inputId = 'commodities',
                               label = 'Commodity',
                               choices = c(unique(p1$Commodity))),
                   selectInput(inputId = 'country',
                               label = 'Country',
                               choices = c(unique(p1$Country)),
                               selected = 'Egypt')
                   
                   
                 ),
                 mainPanel(
                 plotOutput(outputId = 'plot4'),
                 plotOutput(outputId = 'plot5')))
        
      )
    )
