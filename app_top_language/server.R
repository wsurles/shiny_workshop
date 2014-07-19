##| server.R
library(plyr)
library(ggplot2)
library(reshape2)
library(lubridate)

shinyServer(function(input, output) {


  ## load data
  eventLangData <- read.csv("data/event_lang_day.csv", stringsAsFactor = F)

  getTopLang <- reactive({

    ## subset eventLangData by date range
    eventLangData <- subset(eventLangData,date >= input$start_date & date <= input$end_date)

    ## summarize events by language
    lang <- ddply(eventLangData, .(type, repository_language), summarize,
                  num_event = sum(count_event))
    lang <- subset(lang,type == input$event_type)
    lang <- lang[order(lang$num_event, decreasing=T),]

    ## find top languages and put languages in order
    top_lang <- lang[1:100,]
    top_lang <- transform(top_lang, repository_language=reorder(repository_language, num_event))

    })

    output$main_plot <- renderPlot({

      top_lang <-  getTopLang()

      ## make a bar chart of the top languages
      p <- ggplot(top_lang, aes(repository_language, num_event)) +
        geom_bar(stat="identity", fill = 'steelblue', alpha = .7) +
        coord_flip()
      print(p)

      })

})
