# Load required libraries
library(shiny)
library(ggplot2)

# Define server logic
function(input, output) {
  output$plot <- renderPlot({
    k <- input$k
    p <- input$p
    
    # Generate sequence of number of failures
    failures <- 0:100
    
    # Calculate PMF of negative binomial distribution
    pmf <- dnbinom(failures, size = k, prob = p)
    
    # Create a data frame for plotting
    df <- data.frame(failures = failures, pmf = pmf)
    
    # Plot PMF
    ggplot(df, aes(x = failures, y = pmf)) +
      geom_point() +
      geom_line() +
      labs(x = "Number of Failures", y = "Probability") +
      ggtitle("Negative Binomial Distribution")
  })
}

