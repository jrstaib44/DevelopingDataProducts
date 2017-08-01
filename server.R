#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  pointsByWages <- read.csv("./pointsbywages.csv")
  pointsByWages$wagessp <- ifelse(pointsByWages$wages - 100 > 0, pointsByWages$wages-100, 0)
  model1 <- lm(points ~ wages, data = pointsByWages)
  model2 <- lm(points ~ wagessp + wages, data = pointsByWages)
  
  model1pred <- reactive({
    wagesInput <- input$sliderWages
    predict(model1, newdata = data.frame(wages = wagesInput))
  })
  
  model2pred <- reactive({
    wagesInput <- input$sliderWages
    predict(model2, newdata = data.frame(wages = wagesInput,
                                         wagessp = ifelse(wagesInput - 100 > 0, 
                                                          wagesInput - 100, 0)))
  })
  
  
  output$plot1 <- renderPlot({
    
    wagesInput <- input$sliderWages
    plot(pointsByWages$wages,pointsByWages$points, xlab="Wages", ylab="Points",
         bty="n", pch=16, xlim= c(0,250), ylim = c(0,100))
    if(input$showModel1){
      abline(model1,col="red",lwd=2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        wages = 0:250, wagessp = ifelse(0:250 - 100 > 0, 0:250 - 100, 0)
      ))
      lines(0:250, model2lines, col="blue", lwd=2)
    }
    legend(0,250, c("Model 1 Prediction", "Model 2 Prediction"), pch=16,
           col= c("red", "blue"), bty="n", cex=1.2)
    points(wagesInput, model1pred(), col="red", pch=16, cex=2)
    points(wagesInput, model2pred(), col="blue", pch=16, cex=2)
    
  })
  
  
  output$pred1  <- renderText({
    model1pred()
    
  })
  
  
  output$pred2  <- renderText({
    model2pred()
    
  })
})
