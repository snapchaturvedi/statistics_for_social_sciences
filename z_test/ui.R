library(shiny)

shinyUI(fluidPage(
  
    titlePanel("Z-test"),
        
        mainPanel(
          tabsetPanel(
            tabPanel("One sample",
                     tabsetPanel(
                       
                                 tabPanel("Enter parameters",
                                          numericInput("x", "Enter x value (observation)", 190),
                                          numericInput("xbar1", "Enter x̄ value (Sample mean)", 150),
                                          numericInput("var", "Enter \U03C3\U00B2 value (Population variance)", 25)
                                ),
                                 
                                 
                                 tabPanel("Calculations",
                                          h2("Details on the Z-test"),
                                          p("We are testing the null hypothesis that in the population both means are the same"),
                                          p("Z-VALUE:"),
                                          textOutput('zvalue_1')
                                )
                            )),
            
            tabPanel("Std error of the mean",
                     tabsetPanel(
                       tabPanel("Enter parameters",
                                numericInput("x1", "Enter x value (observation)", 70),
                                numericInput("xbar11", "Enter x̄ value (Sample mean)", 65),
                                numericInput("var1", "Enter \U03C3\U00B2 value (Population variance)", 3.5),
                                numericInput("n1", "Enter n value (Sample size)", 50)
                       ),
                       
                       
                       tabPanel("Calculations",
                                h2("Details on the Z-test"),
                                p("Z-VALUE:"),
                                textOutput('zvalue_2')
                       )
                     )
                    
                    )
            )
            )
          )
    )