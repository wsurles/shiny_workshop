# Getting Started - App 0

* You don't need to know HTML, CSS, or JavaScript. 

* A webpage is a document written in HTML maintained by server.
The server sends your browser the html document. It tells the browser how to draw the page.

* Shiny handles setting up server and the HTML for you. Many web pages are static. What you see is what you get. Shiny however lets you interact with the server through the UI. This allows for interative data analysis. The user can decide what they want to see and change the charts and tables based on what they click. So cool.

* You must write two files to make this work.  **server.R** and **ui.R**

**server.R** says what to do with the data

**ui.R** say how to show the data

Pretty simple eh?

## Lets do it!

#### Get R
http://cran.cnr.berkeley.edu/

If you are not here at the workshop in Colorado you can choose the closest CRAN mirror to you here
http://www.r-project.org/

#### Get R Studio desktop
http://www.rstudio.com/ide/download/desktop

Launch R studio 

Install packages we will be using
```s
install.packages("shiny")
install.packages("plyr")
install.packages("ggplot2")
install.packages("reshape2")
install.packages("lubridate")
```
Load the packages
```s
library(shiny)
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)
```

Add two files to the directory **app_getting_started**

![logo](www/directory.png?raw=true)

#### server.R
Set up your server file
```s
shinyServer(function(input,output) {})
```


#### ui.R
Set up your UI file. We will make a spot for a title, inputs, and outputs.
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

Cool. Now set your working directory to the location of the file
![logo](www/setwd.png?raw=true)

And then back up one level
setwd('../')

Now you should be in the shiny_workshop directory. Type `getwd()` to see your working directory.

## Run your shiny App
Type `runApp("app_getting_started")` in the Rstudio terminal.

Your default browser should open with an instance of your shiny app. It will look like this.
![logo](www/app.png?raw=true)

