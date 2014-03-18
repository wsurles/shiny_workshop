# Finding top programming languages on Github

I have downloaded the data we will be working with today and placed it in this repo so you do not need to go through all the Google Developer set up steps. 

But if you would like to do this later. These links will help.
* [Github archive on Github](https://github.com/igrigorik/githubarchive.org/tree/master/bigquery)
* [Instructions on accessing the gihub archive](http://www.githubarchive.org/)
* [Event Types in Github timeline](http://developer.github.com/v3/activity/events/types/)

You can get setup here with your google account. 
* [GitHub timeline on Google BigQuery](https://bigquery.cloud.google.com/table/githubarchive:github.timeline)

Other things you will want to be familar with for doing big data analytics in R
* [Using Implala with R](http://blog.cloudera.com/blog/2013/12/how-to-do-statistical-analysis-with-impala-and-r/)
* [Using Hive with R](http://cran.r-project.org/web/packages/hive/hive.pdf)
* [Hadoop and R](http://blog.revolutionanalytics.com/2012/03/r-and-hadoop-step-by-step-tutorials.html)

Also, go learn SQL right after this workshop if you don't know it yet.
* http://sql.learncodethehardway.org/
* http://www.w3schools.com/sql/

This is too much for a two hour workshop but I will show you what it looks like to get the data from Google Big Query then we will get started with this App. 

Okay, Onward! Lets make this app!

## Step 1: Get, crunch, and plot data
#### Process:
1. Load the libraries
1. Load the data from a csv file
1. Summarize the event count by language
1. Subset on just the PushEvents
1. Reorder by event count
1. Make a new variable with just the top 20
1. Reorder the factors so the plot is also in order
1. Make a bar plot of the events

```s
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)

## load data
data <- read.csv("data/event_lang_day.csv", stringsAsFactor = F)

## summarize events by language
lang <- ddply(data, .(type, repository_language), summarise,
              num_event = sum(count_event))
lang <- subset(lang,type == "PushEvent")
lang <- lang[order(lang$num_event, decreasing=T),]

## find top languages and put languages in order 
top_lang <- lang[1:20,]
top_lang <- transform(top_lang, repository_language=reorder(repository_language, num_event)) 

## make a bar chart of the top languages
p <- ggplot(top_lang, aes(repository_language, num_event)) +
  geom_bar(stat="identity", fill = 'steelblue', alpha = .7) +
  coord_flip()
print(p)
```
![step1](www/step_1.png?raw=true)

----
## Step 2: Put the code into a shiny app

Add the code into the server function. Put the plot into and **renderPlot** function and assign it to an output variable
```s
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)

shinyServer(function(input, output) {
  
  ## load data
  data <- read.csv("data/event_lang_day.csv", stringsAsFactor = F)
  
  ## summarize events by language
  lang <- ddply(data, .(type, repository_language), summarise,
                num_event = sum(count_event))
  lang <- subset(lang,type == "PushEvent")
  lang <- lang[order(lang$num_event, decreasing=T),]
  
  ## find top languages and put languages in order 
  top_lang <- lang[1:20,]
  top_lang <- transform(top_lang, repository_language=reorder(repository_language, num_event)) 
  
  output$main_plot <- renderPlot({
    ## make a bar chart of the top languages
    p <- ggplot(top_lang, aes(repository_language, num_event)) +
      geom_bar(stat="identity", fill = 'steelblue', alpha = .7) +
      coord_flip()
    
    print(p)
    
  })
  
})
```

Add a chart output. 
```s
shinyUI(pageWithSidebar(
  headerPanel("Github Top Languages"),
  sidebarPanel(),
  mainPanel(
    plotOutput(outputId = "main_plot", height = "600px")
    )
  ))
  ```    

![step2](www/step_2.png?raw=true)

----
## Step 3: Link the UI and server

Add a selection input for the event type
```s
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
```

Add the top language calculation to a reactive function. This allows it to be recalculated when an input changes in the UI. Also change `"PushEvent"` to `input$event_type`. Then add a call to this function in the top of the renderPlot funciton. 

```s
getTopLang <- reactive({
    ##| Find top languages by eventtype 
  
    ## summarize events by language
    lang <- ddply(data, .(type, repository_language), summarise,
                  num_event = sum(count_event))
    lang <- subset(lang,type == input$event_type)
    lang <- lang[order(lang$num_event, decreasing=T),]
    
    ## find top languages and put languages in order 
    top_lang <- lang[1:20,]
    top_lang <- transform(top_lang, repository_language=reorder(repository_language, num_event)) 
  })
```

```s
output$main_plot <- renderPlot({        
  ## make a bar chart of the top languages

  top_lang <- getTopLang()
  p <- ggplot(top_lang, aes(repository_language, num_event)) +
    geom_bar(stat="identity", fill = 'steelblue', alpha = .7) +
    coord_flip()
  print(p)

})
```
![step3](www/step_3.png?raw=true)

----
## Step 4: Add date inputs

Add a start and end date input to the **sideBarPanel**
```s
 sidebarPanel(
    selectInput(inputId = "event_type",
                label = "Event Type:",
                choices = c("PushEvent","WatchEvent","CreateEvent"),
                selected = "PushEvent"
                ),
    dateInput("start_date", "Start Date:", value = "2014-01-01"),
    dateInput("end_date", "End Date:", value = "2014-03-16")
    ),
```
Subset on dates at the top of the **getTopLang** function
```s
getTopLang <- reactive({
    ##| Find top languages by eventtype 
  
    ## subset data by date range 
    data <- subset(data,date >= input$start_date & date <= input$end_date)
    
    ## summarize events by language
    lang <- ddply(data, .(type, repository_language), summarise,
                  num_event = sum(count_event))
    lang <- subset(lang,type == input$event_type)
    lang <- lang[order(lang$num_event, decreasing=T),]
    
    ## find top languages and put languages in order 
    top_lang <- lang[1:20,]
    top_lang <- transform(top_lang, repository_language=reorder(repository_language, num_event)) 
  })
```

![step4](www/step_4.png?raw=true)

# [Advanced]
## Step 5: Annotate your plot

Lets add some information to our plot to help us understand our data. 
```s
output$main_plot <- renderPlot({
    
    top_lang <- getTopLang()
     
    p <- ggplot(top_lang, aes(repository_language, num_event)) +
      geom_bar(stat="identity", fill = 'steelblue', alpha = .7) +
      scale_y_continuous(labels = comma, expand = c(.08,0)) +
      coord_flip() +
      geom_text(aes(label = num_event, y = num_event), size = 3, hjust = -.05) +
      geom_text(aes(label = seq(1,length(type)), y = 0), size = 3, hjust = 1.3)       
    
    print(p)

    })
```

![step5](www/step_5.png?raw=true)

I would also encourage you to checkout interactive charts that work with Shiny. 
* [rCharts](http://rcharts.io/)
* [googleVis](http://cran.r-project.org/web/packages/googleVis/index.html)
* [D3](http://d3js.org/)

----
## Step 6: Create dynamic selection input

Lets dynamically create our selection input options based on our data. Right now our inputs are hard coded, which is not the best set up.

For the event type selection input, lets just show the event types that we have in our data. This way if the event types in the query change, the selection input will still work. 

For the dates, lets only allow the user to select dates that we have in our data. And, lets set the initial date range based on what we have in our data.

Add these two **renderUI** functions to our server function. Put them between the `data <- read.csv` and `getTopLang` functions.
```s
output$dateRange <- renderUI({
    ##| Set date range input
    
    data$date <- as.Date(data$date)
    min_date <- min(data$date)
    max_date <- max(data$date)

    dateRangeInput("daterange", "Date range:",
                   start = min_date,
                   end   = max_date,
                   min   = min_date,
                   max   = max_date)
  })

  output$event_type <- renderUI({
    ##| Set list of event types
    
    event_list <- unique(data$type)

    selectInput(inputId = "event_type",
                label = "Event Type:",
                choices = event_list,
                selected = event_list[1])
    
  })
  ```

Now in the UI lets build our inputs based on this output. Update the `sidebarPanel`.
```s
sidebarPanel(
    uiOutput("event_type"),
    uiOutput("dateRange")
    ),
```

Thats pretty cool! 

There is a lot more you can add to this App. Make it your own. 
----

**You are finished! Great Job!** Thanks for joing me for this workshop!  

#### Real Shiny Apps
Here are some Shiny Apps you can try to create or use to find a bike for your ride home tonight
* [Visualizing Bike Sharing Networks](http://ramnathv.github.io/bikeshare/)
* [Shiny showcase on RStudio](http://www.rstudio.com/shiny/showcase/)


