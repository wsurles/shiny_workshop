# Your First App - The Basics of Shiny

## Step 1: Lets start with a few basics of R.

R has built in data sets, so we can use them for Demos without any extra work. Lets play with the **faithful** dataset for a little bit before we start using shiny. 

Comment out the server code with a hash and lets use some simple R functions to explore the **faithful** dataset

```s
# shinyServer(function(input,output){})

## This is the faithful data set. Its in a dataframe. Lets look at its structure.
str(faithful)

## look at the top values
head(faithful)

## look at the last values
tail(faithful)

## look at the eruptions column
faithful$eruptions

## Look at the waiting column
faithful$waiting

## Make a table of values (counts of each) in the waiting column
table(faithful$waiting)

## Make a new variable of the first 10 values in eruptions$waiting
var <- faithful$waiting[1:10]
var

## plot a histogram faithful$waiting
hist(faithful$waiting)

## get help on the'hist' funciton
?hist

## get help on the faitful dataset
?faithful
```

Okay, onward!

## Step 2: Make a plot and display it in the main panel

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

![step2](www/step_2.png?raw=true)

----
## Step 3: Add selection input for the number of bins to show

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

Set the breaks to be the **input$n_breaks**. This value is passed from the selection input into the server file and the plot is regenerated every time the selection changes. **as.numeric** just changes the character to a number.
```s
shinyServer(function(input,output){

  output$main_plot <- renderPlot({
    hist(faithful$eruptions,
         breaks = as.numeric(input$n_breaks))
  })
})
```

Change the **number of bins** and watch the magic happen!
![step3](www/step_3.png?raw=true)

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

![step4](www/step_4.png?raw=true)

Choose your own R colors from this site, or use any hex value (like #333333).
http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
![colors](www/R_colors.png?raw=true)

Type `?hist` in the RStudio terminal for more information on plotting histograms in R.

----

**You are finished! Great Job!** You created your first Shiny App. You can check out the advanced branch to try some more cool features or help someone else near you that is not finished. We will build an app to find the top language on github soon. 


