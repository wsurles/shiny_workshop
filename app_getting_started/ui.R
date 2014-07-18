shinyUI(pageWithSidebar(
  headerPanel("Simple Histogram App"),
  sidebarPanel(
    selectInput(inputId = "n_breaks",
                label = "Bumber of Bins",
                choices = c(10, 20, 25, 30, 50),
                selected = 20)
    ),
  mainPanel(
    plotOutput(outputId = "main_plot")
    )
  )
)
