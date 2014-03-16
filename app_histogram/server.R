##| server.R

shinyServer(function(input,output){

  output$main_plot <- renderPlot({  
    hist(faithful$eruptions,
           breaks = as.numeric(input$n_breaks),
           col = "green",
           xlab = "Duration (minutes)")  
  })
  
  output$second_plot <- renderPlot({
    hist(faithful$waiting,
         breaks = as.numeric(input$n_breaks),
         col = "darkorange2",
         xlab = "Wait (minutes)")
  })
  
  output$third_plot <- renderPlot({
    plot(faithful$waiting,faithful$eruptions,
         col = "darkblue"
         )
  })
})