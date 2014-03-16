##| ui.R

shinyUI(pageWithSidebar(
  headerPanel("My first Shiny App"),
  sidebarPanel(
    h2("Data Inputs"),
    p("This is where we will put widgets that allow us to select and interact with the data
      so that anyone who uses our app can see exactly what they need to see."),
    code("install.packages(Shiny)"),
    br(),
    br(),
    
    p("This workshop is brought to you by", span(strong("Rally Software"), style = "color:red")),
    img(src = "rally_logo.png", height = 200, width = 200)
    ),
  mainPanel(
    h1("Introducing Shiny"),
    p("Shiny is a new package from RStudio that makes it incredibly easy to build interactive web
      applications with R."),
    br(),
    p("For an introduction and live examples , visit the ", 
      a("Shiny homepage.", href = "http://www.rstudio.com/shiny")),
    br(),
    h2("Features"),
    p("* Build useful web applications with only a few lines of code-no HavaScript required."),
    p("* Shiny applications are automatically 'live' in the same way that ", 
      strong("spreadsheets"),
      " are live. Outputs change instantly as users modify inputs, 
      without requiring a reload of the browser."),
    p("* Go to ", a("http://www.rstudio.com/shiny/lessons/Intro/", 
                    href = "http://www.rstudio.com/shiny/lessons/Intro/"),
      " for more fun tutorials and to see where I learned to make this")
    )
  ))

