# Load required libraries
library(shiny)
library(ggplot2)
library(foreign)
library(fitdistrplus)

# Define server logic
function(input, output) {
  output$plot <- renderPlot({
    k <- input$k
    p <- input$p
    
    # Generate sequence of number of failures
    failures <- 0:100
    
    # Calculate PMF of negative binomial distribution
    pmf <- dbinom(failures, size = k, prob = p)
    
    # Create a data frame for plotting
    df <- data.frame(failures = failures, pmf = pmf)
    
    # Plot PMF
    ggplot(df, aes(x = failures, y = pmf)) +
      geom_point() +
      geom_line() +
      labs(x = "Number of Failures", y = "Probability") +
      ggtitle("Negative Binomial Distribution")
  })
  
  
  output$fitted_dist <- renderPlot({
    
    data <- read.dta("https://stats.idre.ucla.edu/stat/stata/dae/nb_data.dta")
    
    fit <- fitdist(data$daysabs, "nbinom")
    x <- seq(0, max(data$daysabs), length.out = max(data$daysabs)+1)
    y <- dnbinom(x, size = fit$estimate["size"], mu = fit$estimate["mu"])
    
    p <- ggplot(data = data.frame(x = x, y = y), aes(x = x, y = y)) +
      geom_line(size=2) +
      labs(x = "Days Absent", y = "Density", title = "Student Absences Neg. Binomial Distribution") +
      theme_minimal()
    
    # Add histogram and density layers
    p <- p + 
      geom_histogram(data=data, aes(x = daysabs, y =..density..), binwidth = 1, alpha = 0.2, fill = "blue") +
      geom_density(data=data, aes(x = daysabs, y =..density..), color = "red", alpha = 0.2)
    
    # Manually add legends
    p + 
      annotate("text", x = 15, y = 0.085, label = "Black Line: Fitted N. Binomial") +
      annotate("text", x = 15, y = 0.075, label = "Blue Shade: Density Histogram") +
      annotate("text", x = 15, y = 0.065, label = "Red Line: Density Plot")
    
  })
  
  output$subtitle <- renderText({
    "Example Negative Binomial Distribution Fitted To Student Absence Data"
  })
  
}

