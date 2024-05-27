# Load required libraries
library(shiny)
library(ggplot2)

##Define UI
fluidPage(
  titlePanel("Negative Binomial Distribution"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("k", "Number of Successes (k):", min = 1, max = 50, value = 10),
      sliderInput("p", "Probability of Success (p):", min = 0.01, max = 1, value = 0.5)
    ),
    
    mainPanel(
      plotOutput("plot"),
      h2(style = "font-size: 20px;", textOutput("subtitle")),
      plotOutput("fitted_dist")
    )
  )
)


