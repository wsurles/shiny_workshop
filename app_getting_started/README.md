# Getting Started - App 0

* You don't need to know HTML, CSS, or JavaScript. 

* A webpage is a document written in HTML maintained by server.
The server sends your browser the html document. It tells the browser how to draw the page.

* Shiny handles setting up server and the HTML for you. Many web pages are static. What you see is what you get. Shiny however lets you interact with the server through the UI. This allows for interative data analysis. The user can decide what they want to see and change the charts and tables based on what they click. So cool.

* You must write two files to make this work. 
**server.R** says what to do with the data
**ui.R** say how to show the data
pretty simple eh?

![logo](www/directory.png?raw=true)

Lets do it!
```s
shinyServer(function(input,output) {})
```

```s
shinyUI(pageWithSidebar(
  headerPanel("Just Getting Started"),
  sidebarPanel(
    h4("Selection input will go here")
    ),
  mainPanel(
    h4("Charts and tables will go here")
    )
  ))
```

![logo](www/app.png?raw=true)

