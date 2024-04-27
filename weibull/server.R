library(shiny)
library(ggplot2)

function(input, output) {
  output$weibullPlot <- renderPlot({
    x <- seq(0, 10, length.out = 100)
    y <- dweibull(x, shape = input$shape, scale = input$scale)
    
    ggplot(data = data.frame(x = x, y = y), aes(x = x, y = y)) +
      geom_line() +
      labs(x = "x", y = "Density", title = "Weibull Distribution Plot") +
      theme_minimal()
  })
}