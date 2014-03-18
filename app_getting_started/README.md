# Getting Started - App 0

You only need to write **two** files to make this work.

**server.R** says what to do with the data

**ui.R** say how to show the data

Pretty simple eh?

## First, lets set up R and Shiny

#### Get R
http://cran.cnr.berkeley.edu/

If you are not here at the workshop in Colorado you can choose the closest CRAN mirror to you here
http://www.r-project.org/

#### Get R Studio desktop
http://www.RStudio.com/ide/download/desktop

#### Launch R studio

#### Install packages we will be using. 

Shiny is a package for R. We will use other packages also. These and other packages are what make R so great for data analysis. Props go to [the RStudio team](http://www.rstudio.com/about/) and [Hadley Wickham](https://github.com/hadley) for making all of this possible. 

Just type this into the RStudio terminal
```s
install.packages("shiny")
install.packages("plyr")
install.packages("ggplot2")
install.packages("reshape2")
install.packages("lubridate")
```
If you aleady have the package you will see a message about 'updating loaded packages'. Click 'Cancel'.

Go ahead and load the packages by typing this into the RStudio terminal
```s
library(shiny)
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)
```

## Now lets make a shiny app!

We will create a **server.R** and **ui.R** file and save these files to the directory **app_getting_started**

![logo](www/directory.png?raw=true)

You can create a new R script in the top left of RStudio.

![logo](www/new_rscript.png?raw=true  =100x20)

Put this code in the **server.R** file
```s
shinyServer(function(input,output) {})
```

Put this code in the **ui.R** file. We make a spot for a title, inputs, and outputs.
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
#### Set working directory
Cool. Now set your working directory to the location of the file by choosing Session -> Set Working Directory -> To Source File Location.

![logo](www/setwd.png?raw=true)

And then back up one level by typing `setwd('../')` in the RStudio terminal so you are in the **shiny_workshop** directory. Type `getwd()` to see your working directory.

## Run your shiny App
Type `runApp("app_getting_started")` in the RStudio terminal.

Your default browser should open with an instance of your shiny app. It will look like this.

![logo](www/app.png?raw=true)

----

**You are finished! Great Job!** You created the framework for a shiny app. You are all set up with the software and are ready to make your first Shiny App. Now you can check out the advanced branch to try a few more cool features or help someone else near you that is not finished. We will start building our first app, **app_historgam** together soon.


