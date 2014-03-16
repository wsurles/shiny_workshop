# Your First App - App 1

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
## Step 2: Add selection input for the number of bins to show

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
## Step 3: Clean up the histogram

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

**You are finished! Great Job!** You created your first Shiny App. You can check out the advanced branch to try some more cool features or help someone else near you that is not finished. 

# [Advanced]
## Step 4: Add more plots with conditional selection

Add two more plots. One of the waiting period between old faithful eruptions. One of the correlation bewteen wait time and eruption duration.
```s
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
```

Add **checkboxInput** to select which plots to show. In the main panel change the output to be conditional on a checkbox value of true.
```s
shinyUI(pageWithSidebar(
  headerPanel("Simple Histogram App"),
  sidebarPanel(
    selectInput(inputId = "n_breaks",
                label = "Number of bins",
                choices = c(10, 20, 25, 30, 50),
                selected = 20),
    h5("Choose plots to show:"),
    checkboxInput("main_plot", "duration", value = TRUE),
    checkboxInput("second_plot", "wait", value = FALSE),
    checkboxInput("third_plot", "duration vs wait", value = FALSE)
    ),
  mainPanel(
    conditionalPanel(condition = "input.main_plot == true", plotOutput(outputId = "main_plot")),
    conditionalPanel(condition = "input.second_plot == true", plotOutput(outputId = "second_plot")),
    conditionalPanel(condition = "input.third_plot == true", plotOutput(outputId = "third_plot"))
    )
  ))
```

![step4](www/step_4.png?raw=true)
