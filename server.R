library(shiny)
library(dplyr)
library(lubridate)
library(tidyr)
#source functions
source("functions/dataprep_monthly.R")

shinyServer(function(input, output) {
  
  #process input file and perform preliminary filter
  dataprep <- reactive({
    inFile <- input$file1
    if (is.null(inFile)){
      return(NULL)
    }
    df <- read.csv(inFile$datapath)
    df <- df %>% 
      select(Q2,
        Q38, Q156, Q16, #these three are the date categories
        Q174,Q174_8_TEXT,Q184,Q194,Q194_6_TEXT,
        Q14,Q14_10_TEXT,Q191,Q193,Q197_1,Q197_2,
        Q21,Q198,Q198_10_TEXT,Q27,Q28)
    #filter out Data & GIS Lab rows
    df <- df[!(df$Q2 %in% c("Data/GIS Lab")),]
    return(df)
  })
  
  ## ----------- REPORTING BODY SPECIFIC CLEANING -----------
  
  dataprep_ACRL <- reactive({
    df <- dataprep() %>% 
      select(-Q174, -Q174_8_TEXT,-Q194,-Q194_6_TEXT,
             -Q14,-Q14_10_TEXT,-Q193)
    df <- dataprep_monthly(df)
    return(df)
  })
  
  dataprep_UCOP <- reactive({
    df <- dataprep() %>% 
      select(-Q174, -Q174_8_TEXT,-Q194,-Q194_6_TEXT,-Q14,
             -Q14_10_TEXT,-Q193, -Q198, -Q198_10_TEXT)
    df <- dataprep_monthly(df)
    return(df)
  })
  
  dataprep_ARL <- reactive({
    df <- dataprep() %>%
      select(-Q174, -Q174_8_TEXT,-Q194,-Q194_6_TEXT,
             -Q14,-Q14_10_TEXT,-Q193, -Q198, -Q198_10_TEXT)
    df <- dataprep_monthly(df)
    return(df)
  })
  
  dataprep_AnnualReport <- reactive({
    df <- dataprep() #needs all categories
    df <- dataprep_monthly(df)
    return(df)
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
