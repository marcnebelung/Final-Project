# Define server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    failures <- 0:100
    pmf <- dnbinom(failures, size = input$k, prob = input$p)
    plot(failures, pmf, type = "b", xlab = "Number of Failures", ylab = "Probability", 
         main = "Negative Binomial Distribution")
  })
}

