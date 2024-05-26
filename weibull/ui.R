library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Wind Speed Weibull Distribution"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("shape", "Shape Parameter (k):", min = 0, max = 10, value = 1, step = 0.1),
      sliderInput("scale", "Scale Parameter (λ):", min = 0, max = 10, value = 1, step = 0.1)
    ),
    
    mainPanel(
      plotOutput("weibullPlot"),
      h2(style = "font-size: 20px;", textOutput("subtitle")),
      textOutput("shapeParam"),
      textOutput("scaleParam"),
      plotOutput("fitted_data")
    )
  )
)
