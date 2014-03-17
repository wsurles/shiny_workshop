# Finding top programming languages on Github

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

----

**You are finished! Great Job!** You can check out the advanced branch to try some more cool features or help someone else near you that is not finished. 

If you want to see some real apps in Action you can check out some of the apps on the RStudio showcase
http://www.rstudio.com/shiny/showcase/

If you need a way to get home tonight, here is a cool app to see how many bikes are at a bike share station near you. Click on the first map image to see the app in action. At the top select boulder to see our bike share program.
http://ramnathv.github.io/bikeshare/


