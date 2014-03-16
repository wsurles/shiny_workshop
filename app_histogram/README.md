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

![logo](www/step_1.png?raw=true)

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

![logo](www/step_2.png?raw=true)

## Step 3
## Step 4
## Step 5
## Step 6
## Step 7
## Step 8
## Step 9
## Step 10
## Step 11







Choose your own colors
http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
![logo](www/R_colors.png?raw=true)

