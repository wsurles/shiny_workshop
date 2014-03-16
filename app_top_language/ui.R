##| ui.R

shinyUI(pageWithSidebar(
  headerPanel("Github Top Languages"),
  sidebarPanel(
    uiOutput("event_type"),
    uiOutput("dateRange")
    ),
  mainPanel(
    plotOutput(outputId = "main_plot", height = "600px")
    )
  ))