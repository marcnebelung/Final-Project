# Load required libraries
library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Negative Binomial Distribution"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("k", "Number of Successes (k):", min = 1, max = 50, value = 10),
      sliderInput("p", "Probability of Success (p):", min = 0.01, max = 1, value = 0.5)
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    k <- input$k
    p <- input$p
    
    # Generate sequence of number of failures
    failures <- 0:25
    
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

# Run the application
shinyApp(ui = ui, server = server)

