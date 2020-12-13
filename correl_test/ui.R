library(shiny)

shinyUI(fluidPage(
    titlePanel("Correlation test"),
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
                         '"'),
            radioButtons("statistic", "Choose the test statistic",
                         c("Spearman's Rho"="spearman", "Pearson's r"="pearson"))
        ),
        mainPanel(
            tabsetPanel(
                
                tabPanel("Your data",  
                         h1("Check if we read your data correctly"),
                         tableOutput('contents')),
                
                tabPanel("Data Summary",
                         h1("This displays a scatter plot of your data"),
                         plotOutput('plot'),
                         
                         h2("Five-number summary"),
                         p("The five number summary for the groups (here, A and B resp.) are:"),
                         tableOutput('fivenum')),
                
                tabPanel("Inference",
                         h2("Details on the chosen test statistic"),
                         p("We are testing the null hypothesis that in the population both means are the same"),
                         p("TEST STATISTIC: The observed test statistic: "),
                         textOutput('tvalue'),
                         p("If the statistic's value is closer to 1, it signifies high positive correlation; if closer to -1, negative correlaion. If the statistic's value is close to 0, it signifies slight/no correlation between the two variables"),
                         p(),
                         p("P-VALUE: Significance of strength of the relationship and calculated statistic"),
                         textOutput('pvalue')
                ))))))

