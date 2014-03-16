##| ui.R

shinyUI(pageWithSidebar(
  headerPanel("Simple Histogram App"),
  sidebarPanel(
    selectInput(inputId = "n_breaks",
                label = "Number of bins",
                choices = c(10, 20, 25, 30, 50),
                selected = 20),
    h5("Choose plots to show:"),
    checkboxInput("main_plot", "duration", value = TRUE),
    checkboxInput("second_plot", "wait", value = FALSE),
    checkboxInput("third_plot", "duration vs wait", value = FALSE)
    ),
  mainPanel(
    conditionalPanel(condition = "input.main_plot == true", plotOutput(outputId = "main_plot")),
    conditionalPanel(condition = "input.second_plot == true", plotOutput(outputId = "second_plot")),
    conditionalPanel(condition = "input.third_plot == true", plotOutput(outputId = "third_plot"))
    )
  ))