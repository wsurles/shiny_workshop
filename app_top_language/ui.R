##| ui.R

shinyUI(pageWithSidebar(
  headerPanel("Github Top Languages"),
  sidebarPanel(
    selectInput(inputId = "event_type",
                label = "Event Type:",
                choices = c("PushEvent","WatchEvent","CreateEvent"),
                selected = "PushEvent"
                )
    ),
  mainPanel(
    plotOutput(outputId = "main_plot", height = "600px")
    )
  ))