# Load required packages
library(shiny)
library(ggplot2)
library(fitdistrplus)

# Define server logic
server <- function(input, output) {
  data <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  output$weibullPlot <- renderPlot({
    wind_speeds <- data()$wind_speed
    
    # Fit Weibull distribution
    fit <- fitdist(wind_speeds, "weibull")
    x <- seq(0, max(wind_speeds), length.out = 100)
    y <- dweibull(x, shape = fit$estimate["shape"], scale = fit$estimate["scale"])
    
    ggplot(data = data.frame(x = x, y = y), aes(x = x, y = y)) +
      geom_line() +
      labs(x = "Wind Speed (m/s)", y = "Density", title = "Wind Speed Weibull Distribution") +
      theme_minimal() +
      geom_histogram(data = data(), aes(x = wind_speeds, y = ..density..), bins = 30, alpha = 0.5, fill = "blue") +
      geom_density(data = data(), aes(x = wind_speeds, y = ..density..), color = "red")
  })
}
