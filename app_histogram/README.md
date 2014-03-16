# Your First App - App 1
----
## Step 1: Make a plot and display it in the main panel

Make a histogram of old faithful eruption durations. This will be assigned to `output$main_plot`.
```s
shinyServer(function(input,output){

  output$main_plot <- renderPlot({  
    hist(faithful$eruptions,
         breaks = 20)  
  })
})
```

Output the **main_plot** in the **mainPanel**
```s
shinyUI(pageWithSidebar(
  headerPanel("Simple Histogram App"),
  sidebarPanel(),
  mainPanel(
    plotOutput(outputId = "main_plot")
    )
  ))
```

![step1](www/step_1.png?raw=true)

----
## Step 2

Add a selection input to the sidebar panel. Give it the id of "n_breaks". Label it. Set selection choices. Choose a default selection.
```s
shinyUI(pageWithSidebar(
  headerPanel("Simple Histogram App"),
  sidebarPanel(
    selectInput(inputId = "n_breaks",
                label = "Number of bins",
                choices = c(10, 20, 25, 30, 50),
                selected = 20)
    ),
  mainPanel(
    plotOutput(outputId = "main_plot")
    )
  ))
```

Set the breaks to be the **input$n_breaks**. This value is passed from the selection input into the server file and the plot is regenerated everytime the selection changes. **as.numeric** just changes the character a to number. 
```s
shinyServer(function(input,output){

  output$main_plot <- renderPlot({  
    hist(faithful$eruptions,
         breaks = as.numeric(input$n_breaks))  
  })
})
```

Change the selection and watch the magic happen!
![step2](www/step_2.png?raw=true)

----
## Step 3

Clean up your plot with some color and labels
```s
shinyServer(function(input,output){

  output$main_plot <- renderPlot({  
    hist(faithful$eruptions,
         breaks = as.numeric(input$n_breaks),
         col = "green",
         xlab = "Duration (minutes)")  
  })
})
```

![step3](www/step_3.png?raw=true)

Choose your own R colors from this site. 
http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
![colors](www/R_colors.png?raw=true)

Type `?hist` in the RStudio terminal for more information on plotting histograms in R.

----

You are finished! Great Job! You created your first Shiny App. You can check out the advanced branch to try some more cool features or help someone else near you that is not finished. 


