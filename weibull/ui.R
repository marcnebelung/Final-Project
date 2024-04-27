library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Wind Speed Weibull Distribution"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose CSV File:",
                accept = c(".csv")),
      sliderInput("shape", "Shape Parameter (k):", min = 0.1, max = 5, value = 1, step = 0.1),
      sliderInput("scale", "Scale Parameter (λ):", min = 0.1, max = 50, value = 10, step = 0.1)
    ),
    
    mainPanel(
      plotOutput("weibullPlot")
    )
  )
)
