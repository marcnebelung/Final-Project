library(shiny)
library(ggplot2)

fluidPage(
  titlePanel("Weibull Distribution Plot"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("shape", "Shape Parameter (k):", min = 0.1, max = 5, value = 1, step = 0.1),
      sliderInput("scale", "Scale Parameter (λ):", min = 0.1, max = 5, value = 1, step = 0.1)
    ),
    
    mainPanel(
      plotOutput("weibullPlot")
    )
  )
)