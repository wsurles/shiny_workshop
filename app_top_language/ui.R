shinyUI(pageWithSidebar(
  headerPanel("Github Top Languages"),
  sidebarPanel(
    selectInput(inputId = "event_type",
                label = "Event Type:",
                choices = c("PushEvent","WatchEvent","CreateEvent"),
                selected = "Push Event"
              ),
    dateInput("start_date", "Start Date", value = "2014-01-01"),
    dateInput("end_date", "End Date", value = "2014-03-16")
  ),
  mainPanel(
    plotOutput(outputId = "main_plot", height = "600px")
  )
))
