library(shiny)

shinyServer(function(input, output) {

  Data <- reactive({

    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)[1]
  })

output$contents <- renderTable({ 
  my.df <- Data()
  if (is.null(my.df)){return(NULL)} 
  my.df})

output$plot <- renderPlot({
  my.df <- Data()
  if (is.null(my.df)){return(NULL)}
  boxplot(my.df[,1], xlab = names(my.df)[1], ylab = names(my.df)[1], 
          main = paste("Study on ", names(my.df)[1]), col = "steelblue")})

ttestout <- reactive({
  my.df <- Data()
  if (is.null(my.df)){return(NULL)}
  t.test(my.df[,1], mu = input$mu1, var.equal = FALSE)
})


output$tvalue <- renderPrint({
  vals <- ttestout()
  if (is.null(vals)){return(invisible())}
  vals$statistic[["t"]]
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
  
  A <- summary(my.df)[1:5]
  fivenum <- data.frame(A)
  
  
    return(fivenum)
})

})

