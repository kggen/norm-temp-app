library(shiny)


shinyServer(function(input, output) {
  
  fun1<-function(x,y){
    normtemp<-UsingR::normtemp
    mod1<-lm(temperature ~ as.factor(gender) + hr, data=normtemp)
    newdata<-data.frame("hr"=x, "gender"=y)
    prediction<-predict(mod1, newdata = newdata)
  }
  
  output$summary <- renderText({
    paste("Being a ",
                  ifelse(input$gender==1, "Male", "Female"),
                  " at a heart rate of ",
                  input$hr,
                  " your normal temperature is estimated to be ",
                  ifelse(input$selection=="Fahrenheit",
                         round(fun1(input$hr, input$gender),2),
                         (round((fun1(input$hr, input$gender)-32)*5/9,2))),
                  " ",
                  input$selection,
                  "."
    )
  })
  
  output$plot1<-renderPlot({
    normtemp<-UsingR::normtemp
    normtemp[normtemp$gender==1,]$gender<-c("Male")
    normtemp[normtemp$gender==2,]$gender<-c("Female")
    normtemp$gender<-as.factor(normtemp$gender)
    
    if(input$selection=="Celsius"){
      normtemp$temperature=(normtemp$temperature-32)*5/9
      }
    
    prediction_temp<-fun1(input$hr, input$gender)
    
    if(input$selection=="Celsius"){
      prediction_temp=(prediction_temp-32)*5/9
      }
    
    library(ggplot2)
    ggplot(normtemp, aes(x=temperature, y=hr))+
      geom_point(aes(col=gender))+
      geom_point(aes(x=prediction_temp, y=input$hr), size=7, col='black', pch=19)+
      geom_text(aes(x=prediction_temp, y=input$hr, label=c("Estimation"), hjust=-0.2), col='Black')+
      theme_bw()+
      labs(title="Temperature estimation",
           y="Heart rate",
           x="Temperature")
  })
})