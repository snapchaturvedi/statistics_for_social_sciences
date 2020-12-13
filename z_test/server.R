library(shiny)

shinyServer(function(input, output) {
    

    z1testout <- reactive({
        z_val <- (input$x-input$xbar1)/input$var
    })
    
    z2testout <- reactive({
        z_val <- (input$x1-input$xbar11)/input$var1/(input$n1)*0.5
    })
    
    output$zvalue_1 <- renderPrint({
        z_val <- z1testout()
        z_val
    })
    
    output$zvalue_2 <- renderPrint({
        z_val <- z2testout()
        z_val
    })
})

