library(shiny)
library(googlesheets4)
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggplot2)
library(rsconnect)

server <- function(input, output){
  
  data1 <- reactive({ r2 })
  
  # chart showing the total grain exported to a country to date.
  
  output$plot1 <- renderPlot({
    ggplot(data1()) + 
      geom_col(aes(x = Country, 
                   y = totalTon)) +
      theme_classic() +
      theme(axis.text.x = element_text(angle=90,
                                       hjust=1, 
                                       vjust=0.5)) +
      labs(x = NULL, 
           y = 'Metric tonnes',
           title = 'Metric tonnes of grain received from Ukraine since August 3',
           subtitle = 'UN Black Sea trade deal',
           caption = "Source: United Nations")
    
  })
  
  data2 <- reactive({ p1 })


  # Chart showing the grain in categories
  output$plot2 <- renderPlot({
    ggplot(data2()) +
      geom_col(aes(x = Country, 
                   y = totals, 
                   fill = Commodity)) +
      theme_classic() +
      theme(axis.text.x=element_text(angle=90,
                                     hjust=1, 
                                     vjust=0.5)) +
      labs(x = NULL, 
           y = 'Metric tonnes',
           title = 'Metric tonnes of grain received from Ukraine since August 3 according to type of grain',
           subtitle = 'UN Black Sea trade deal',
           caption = "Source: United Nations")

  })
  
  output$plot3 <- renderPlot({
    ggplot(data2()) +
      geom_col(aes(x = Country, 
                   y = totals, 
                   fill = Commodity),
               position = "fill",
               colour = 'black')  +
      scale_y_continuous(labels = scales::percent) +
      theme_classic() +
      theme(axis.text.x=element_text(angle=90,
                                     hjust=1, 
                                     vjust=0.5)) +
      labs(x = NULL, 
           y = 'Percentage',
           title = 'Percentage share of grain types received from Ukraine since August 3',
           subtitle = 'UN Black Sea trade deal',
           caption = "Source: United Nations")

  })


  data3 <- reactive({ p1 %>% filter(Commodity %in% input$commodities) })
  
  output$plot4 <- renderPlot({
    
    ggplot(data3()) +
      geom_col(aes(x = Country, 
                   y = totals, 
                   fill = Commodity), 
               fill = 'blue') +
      ggtitle("Grain exports received. UN trade deal.") +
      theme_classic() +
      theme(axis.text.x=element_text(angle=90,
                                     hjust=1, 
                                     vjust=0.5)) +
      
      labs(x = NULL, 
           y = 'Metric tonnes',
           title    = 'Metric tonnes of certain grain exported and the countries to where it got exported',
           subtitle = 'UN Black Sea trade deal',
           caption  = "Source: United Nations")
  })
  
  
  data4 <- reactive({ p1 %>% filter(Country %in% input$country) })
  
  output$plot5 <- renderPlot({
    ggplot(data4()) +
      geom_col(aes(x = Commodity, 
                   y = totals), 
               fill = 'red') +
      ggtitle("Grain exports received by a certain country. UN trade deal.") +
      theme_classic() +
      theme(axis.text.x=element_text(angle=90,
                                     hjust=1, 
                                     vjust=0.5)) +
      labs(x = NULL, 
           y = 'Metric tonnes',
           title = paste0('Metric tonnes of certain grains exported to ', input$country),
           subtitle = 'UN Black Sea trade deal',
           caption = "Source: United Nations") +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
  })
  
}



