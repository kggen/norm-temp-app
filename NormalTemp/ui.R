library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Normal Temperature"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h3('Select the following'),
      
      h5('Please note: when measuring your heart rate you should be relaxed'),
      
      sliderInput("hr",
                   "Heart rate",
                   min = 50,
                   max = 110,
                   value = 80),
      
      radioButtons("gender", "Gender",
                   c("Female" = "2",
                     "Male" = "1")),
      
      selectInput("selection", "Choose a scale:",
                  choices = c("Fahrenheit", "Celsius"))
    ),
    
   mainPanel(
       h3(textOutput('summary')),
       plotOutput("plot1")
  )
)))
