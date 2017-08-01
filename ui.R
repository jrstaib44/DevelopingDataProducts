#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict English Premier League Points from Wages"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderWages",
                   "How much does the team spend on player wages?:",
                   min = 20,
                   max = 250,
                   value = 50),
       checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
       checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Model",br(),  plotOutput("plot1"),
                           h3("Predicted Points from Model 1:"),
                           textOutput("pred1"),
                           h3("Predicted Points from Model 2:"),
                           textOutput("pred2")),
                  tabPanel("Help",br(),
                           includeMarkdown("Pointsbywages.Rmd")
                           )
                  )
      
     
    )
  )
))
