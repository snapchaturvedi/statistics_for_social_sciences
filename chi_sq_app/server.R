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
        plot(my.df[,1],my.df[,2], xlab = names(my.df)[1], ylab = names(my.df)[1], 
             main = paste("Study on ", names(my.df)[2]), col = "red")})
    
    chitestout <- reactive({
        my.df <- Data()
        if (is.null(my.df)){return(NULL)}
        chisq.test(table(my.df[,1], my.df[,2]))
    })
    
    output$table_chi <- renderTable(
        {
            chitestout
        }
    )
    
    output$tvalue <- renderPrint({
        vals <- chitestout()
        if (is.null(vals)){return(invisible())}
        vals$statistic
    })
    
    
    output$samplemeans1 <- renderPrint({
        vals <- chitestout()
        if (is.null(vals)){return(invisible())}
        vals$estimate[1]
        
    })
    
    
    output$samplemeans2 <- renderPrint({
        vals <- chitestout()
        if (is.null(vals)){return(invisible())}
        vals$estimate[2]
        
    })
    
    
    output$pvalue <- renderPrint({
        vals <- chitestout()
        if (is.null(vals)){return(invisible())}
        vals$p.value
        
    })
    
    
    output$fivenum <- renderTable({
        my.df <- Data()
        if (is.null(my.df)){return(NULL)}
        A <- summary(table(my.df[,1], my.df[,2]))[c(1,2)]
        return(A)
    })
    
    
})

