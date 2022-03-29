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
        Q2, Q174,Q174_8_TEXT,Q184,Q194,Q194_6_TEXT,
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
  
  ## ----------- REPORTING BODY SPECIFIC CLEANING -----------
  
  dataprep_ACRL <- reactive({
    return(
      dataprep() %>% 
        select(-Q174, -Q174_8_TEXT,-Q194,-Q194_6_TEXT,
               -Q14,-Q14_10_TEXT,-Q193))
  })
  
  dataprep_UCOP <- reactive({
    return(
      dataprep() %>% 
        select(
          -Q174, -Q174_8_TEXT,-Q194,-Q194_6_TEXT,
          -Q14,-Q14_10_TEXT,-Q193, -Q198, -Q198_10_TEXT))
  })
  
  dataprep_ARL <- reactive({
    return(
      dataprep() %>%
        select(
          -Q174, -Q174_8_TEXT,-Q194,-Q194_6_TEXT,
          -Q14,-Q14_10_TEXT,-Q193, -Q198, -Q198_10_TEXT))
  })
  
  dataprep_AnnualReport <- reactive({
    return(dataprep()) #needs all categories
  })
  
  
  # ------------------ OUTPUTS --------------------------------
  
  output$test <- renderTable(dataprep(),
                             width = "100%")
  
  # ------- FILE DOWNLOADS -----------------------------------
  
  output$downloadACRL <- downloadHandler(
    filename = "ACRL.csv",
    content = function(file){
      write.csv(dataprep_ACRL(),file,row.names = FALSE)
    }
  )
  
  output$downloadUCOP <- downloadHandler(
    filename = "UCOP.csv",
    content = function(file){
      write.csv(dataprep_UCOP(),file,row.names = FALSE)
    }
  )
  
  output$downloadARL <- downloadHandler(
    filename = "ARL.csv",
    content = function(file){
      write.csv(dataprep_ARL(),file,row.names = FALSE)
    }
  )
  
  output$downloadAnnualReport <- downloadHandler(
    filename = "AnnualReport.csv",
    content = function(file){
      write.csv(dataprep_AnnualReport(),file,row.names = FALSE)
    }
  )
  
})
