library(shiny)
library(dplyr)

shinyServer(function(input, output) {
  
  #process input file and perform prelilminary filter
  dataprep <- reactive({
    inFile <- input$file1
    if (is.null(inFile)){
      return(NULL)
    }
    df <- read.csv(inFile$datapath)
    df <- df %>% 
      select(
        Q38, Q156, Q16, #these three are the date categories
        Q174,Q174_8_TEXT,Q184,Q194,Q194_6_TEXT,
        Q14,Q14_10_TEXT,Q191,Q193,Q197_1,Q197_2,
        Q21,Q198,Q198_10_TEXT,Q27,Q28)
    #filter for fiscal year
    if (input$year == "2022/2023"){
      df <- df
    } else if (input$year == "2021/2022"){
      df <- df
    }
    return(df)
  })
  
  output$test <- renderTable(dataprep(),
                             width = "100%")
})
