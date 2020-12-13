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
  
  output$plot1 <- renderPlot({
    my.df <- Data()
    if (is.null(my.df)){return(NULL)}

    boxplot(my.df[,1] ~ my.df[,2], col = c("blue", "gold", "green", "magenta", "red"), main = paste("Study on ", names(my.df)[2]), xlab = "Groups", ylab = "Observations")})
  output$plot2 <- renderPlot({
    my.df <- Data()
    if (is.null(my.df)){return(NULL)}
    
    boxplot(my.df[,1] ~ my.df[,3], col = c("red", "steelblue", "pink", "yellow", "teal"), main = paste("Study on ", names(my.df)[3]), xlab = "Groups", ylab = "Observations")})
  
  ttestout <- reactive({
    my.df <- Data()
    if (is.null(my.df)){return(NULL)}
    anova(lm(data = my.df, my.df[,1] ~ my.df[,2] * my.df[,3]))
    
    #A <- as.name(names(my.df)[1])
    #B <- as.name(names(my.df)[2])
    #C <- as.name(names(my.df)[3])
    
    #anova(lm(data = my.df, A ~ B * C)))
    #anova(lm(names(my.df)[1] ~ names(my.df)[2] * names(my.df)[3], data = my.df))
  })
  
  
  output$tvalue <- reactivePrint(function(){
    vals <- ttestout()
    if (is.null(vals)){return(invisible())}
    vals
  })
  
  
})

