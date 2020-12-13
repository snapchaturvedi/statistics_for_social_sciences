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
    
    boxplot(my.df[,1]~my.df[,2], col = 'steelblue', main = "Your data", xlab = "Groups", ylab = "Observations")})
  
  ttestout <- reactive({
    my.df <- Data()
    if (is.null(my.df)){return(NULL)}
    anova(lm(my.df[,1]~my.df[,2], data = my.df))
  })
  
  
  output$tvalue <- reactivePrint(function(){
    vals <- ttestout()
    if (is.null(vals)){return(invisible())}
    vals
  })
  
  
})

