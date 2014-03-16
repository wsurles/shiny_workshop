# Getting Started - App 0

You only need to write **two** files to make this work.

**server.R** says what to do with the data

**ui.R** say how to show the data

Pretty simple eh?

## Lets do it!

Okay, first, lets get set up with R, Rstudio, and Shiny.

#### Get R
http://cran.cnr.berkeley.edu/

If you are not here at the workshop in Colorado you can choose the closest CRAN mirror to you here
http://www.r-project.org/

#### Get R Studio desktop
http://www.rstudio.com/ide/download/desktop

#### Launch R studio 

#### Install packages we will be using
Just type this into the Rstudio terminal
```s
install.packages("shiny")
install.packages("plyr")
install.packages("ggplot2")
install.packages("reshape2")
install.packages("lubridate")
```
If you aleady have the package you will see a message about "updating loaded packages". Just click "cancel".

Go ahead and load the packages by typing this into the Rstudio terminal
```s
library(shiny)
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)
```

## Now lets make a shiny app!

#### Create the server and UI files
Crete a new R script. 

![logo](www/new_rscript.png?raw=true  =100x20)

## server.R
Put this code it in
```s
shinyServer(function(input,output) {})
```

## ui.R
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
Now save these files to the directory **app_getting_started**

![logo](www/directory.png?raw=true)

Cool. Now set your working directory to the location of the file

![logo](www/setwd.png?raw=true)

And then back up one level by typing `setwd('../')` in the Rstudio terminal

Now you should be in the shiny_workshop directory. Type `getwd()` to see your working directory.

## Run your shiny App
Type `runApp("app_getting_started")` in the Rstudio terminal.

Your default browser should open with an instance of your shiny app. It will look like this.

![logo](www/app.png?raw=true)

