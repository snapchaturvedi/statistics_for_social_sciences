library(shiny)

shinyServer(function(input, output) {
    
    Data <- reactive({
        
        inFile <- input$file1
        
        if (is.null(inFile))
            return(NULL)
        
        read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                 quote=input$quote)
        
        
        
    })
    
    
    
    
    output$contents <- renderTable({ 
        my.df <- Data()
        if (is.null(my.df)){return(NULL)} 
        my.df})
    
    output$plot <- renderPlot({
        my.df <- Data()
        if (is.null(my.df)){return(NULL)}
        plot(my.df[,1],my.df[,2], xlab = names(my.df)[1], ylab = names(my.df)[2], 
             main = paste("Study on ", names(my.df)[2]), col = "black")})
    
    ttestout <- reactive({
        my.df <- Data()
        if (is.null(my.df)){return(NULL)}
        cor.test(my.df[,1],my.df[,2], method = input$statistic)
    })
    
    
    output$tvalue <- renderPrint({
        vals <- ttestout()
        if (is.null(vals)){return(invisible())}
        vals$estimate
    })
    
    
    output$samplemeans1 <- renderPrint({
        vals <- ttestout()
        if (is.null(vals)){return(invisible())}
        vals$estimate[1]
        
    })
    
    
    output$samplemeans2 <- renderPrint({
        vals <- ttestout()
        if (is.null(vals)){return(invisible())}
        vals$estimate[2]
        
    })
    
    
    output$pvalue <- renderPrint({
        vals <- ttestout()
        if (is.null(vals)){return(invisible())}
        vals$p.value
        
    })
    
    
    output$fivenum <- renderTable({
        my.df <- Data()
        if (is.null(my.df)){return(NULL)}
        
        A <- summary(my.df)[1:6]
        B <- summary(my.df)[7:12]
        fivenum <- data.frame(A, B)
        
        
        return(fivenum)
    })
    
    
})

