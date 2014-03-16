##| server.R
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)

shinyServer(function(input, output) {
  
  getData <- reactive({
    data <- read.csv("data/event_lang_day.csv", stringsAsFactor = F)
    return(data)
  })
  
  output$dateRange <- renderUI({
    ##| Set date range input
#     data <- getData()
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
#     data <- getData()
    event_list <- unique(data$type)

    selectInput(inputId = "event_type",
                label = "Event Type:",
                choices = event_list,
                selected = event_list[1])
    
  })
  
  getTopLang <- reactive({
    ##| Find top languages by eventtype 
    
    data <- getData()
    data <- subset(data, date >= min(input$daterange) & date <= max(input$daterange))
    
    lang <- ddply(data, .(type, repository_language), summarise,
                  num_event = sum(count_event)
                  )
    lang <- subset(lang,type == input$event_type)
    lang <- lang[order(lang$num_event, decreasing=T),]
    
    top_lang <- lang[1:20,]
    top_lang <- transform(top_lang, repository_language=reorder(repository_language, num_event)) 
    return(top_lang)
    
    })
  
  output$main_plot <- renderPlot({
    
    top_lang <- getTopLang()
     
    p <- ggplot(top_lang, aes(repository_language, num_event)) +
      geom_bar(stat="identity", fill = 'steelblue', alpha = .7) +
      scale_y_continuous(labels = comma, expand = c(.08,0)) +
      coord_flip() +
      geom_text(aes(label = num_event, y = num_event), size = 3, hjust = -.05) +
      geom_text(aes(label = seq(1,length(type)), y = 0), size = 3, hjust = 1.3)       
    
    print(p)

#     p1 <- ggplot(data, aes(date,count_event)) +
#             geom_line()
#     
#     print(p1)

    })
})