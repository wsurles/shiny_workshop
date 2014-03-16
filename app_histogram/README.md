# Your First App - App 1

## Step 1: Make a plot and display it in the main panel of the shiny page

Make a histogram of old faithful eruption durations. This will assigned to `output$main_plot`.
```s
shinyServer(function(input,output){

  output$main_plot <- renderPlot({  
    hist(faithful$eruptions,
         breaks = 20)  
  })
})
```

Output the *main_plot* in the *mainPanel*
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

