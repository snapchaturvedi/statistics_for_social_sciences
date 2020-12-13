library(shiny)

shinyUI(fluidPage(
  titlePanel("One way ANOVA"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
    ),
    mainPanel(
      tabsetPanel(
        
        tabPanel("Your data",  
                 h1("Check if we read your data correctly"),
                 tableOutput('contents')
                 ),
        
        tabPanel("Data Summary",
                 h1("This displays a box plot of your data"),
                 plotOutput('plot'),
                 h4("The sizes of the boxes repersent respective group-wise variance of your data")),
        
        tabPanel("Inference",
                 h2("ANOVA Table"),
                 verbatimTextOutput('tvalue'),
                 p(),
                 p(),
                 p("NOTE: A smaller p-value means that there is stronger evidence in favor of the alternative hypothesis. One commonly used p-value is 0.05. If the investor concludes that the p-value is less than 0.05, there is strong evidence against the null hypothesis. Conversely, if the p-value is greater than 0.05, that indicates that there is weak evidence against the conjecture.")
                 
        ))))))

