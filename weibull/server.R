# Load required packages
library(shiny)
library(ggplot2)
library(fitdistrplus)


# Define server logic
server <- function(input, output) {
  
data <- read.csv("wind_data.csv")
data$wind_speed <- data[['Wind.Speed..m.s.']]
data[['Wind.Speed..m.s.']] <- NULL

data$wind_speed <- replace(data$wind_speed, data$wind_speed==0, mean(data$wind_speed))

output$weibullPlot <- renderPlot({
  
  x <- seq(0, 10, length.out = 100)
  y <- dweibull(x, shape = input$shape, scale = input$scale)
  
  ggplot(data = data.frame(x = x, y = y), aes(x = x, y = y)) +
    geom_point() +
    geom_line() +
    labs(x = "x", y = "Density", title = "Weibull Distribution Plot")
})

fit <- fitdist(data$wind_speed, "weibull")

output$shapeParam <- renderText({
  paste("Shape Parameter:", round(fit$estimate["shape"], 2))
})

output$scaleParam <- renderText({
  paste("Scale Parameter:", round(fit$estimate["scale"], 2))
})

output$fitted_data <- renderPlot({
    
    # Fit Weibull distribution
    x <- seq(0, max(data$wind_speed), length.out = 100)
    y <- dweibull(x, shape = fit$estimate["shape"], scale = fit$estimate["scale"])
    
    p <- ggplot(data = data.frame(x = x, y = y), aes(x = x, y = y)) +
      geom_line(size=2) +
      labs(x = "Wind Speed (m/s)", y = "Density", title = "Wind Speed Weibull Distribution") +
      theme_minimal()
    
    # Add histogram and density layers
    p <- p + 
      geom_histogram(data=data, aes(x = wind_speed, y =..density..), bins = 30, alpha = 0.2, fill = "blue") +
      geom_density(data=data, aes(x = wind_speed, y =..density..), color = "red", alpha = 0.2)
    
    # Manually add legends
    p + 
      annotate("text", x = 15, y = 0.075, label = "Blue Shade: Density Histogram") +
      annotate("text", x = 15, y = 0.07, label = "Red Line: Density Plot") +
      annotate("text", x = 15, y = 0.08, label = "Black Line: Fitted Weibull")
      })

output$subtitle <- renderText({
  "Example Weibull Distribution Fitted To Wind Speed Data"
})
}
