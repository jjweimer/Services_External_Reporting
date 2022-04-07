library(shiny)
library(dplyr)
library(lubridate)
library(tidyr)
library(writexl)
#source functions
source("functions/dataprep_monthly.R")
source("functions/dataprep_digital_learning_objects.R")
source("functions/dataprep_instruction_attendees.R")
source("functions/dataprep_instruction_location.R")
source("functions/dataprep_instruction_multisession.R")
source("functions/dataprep_instruction_sessions.R")
source("functions/dataprep_instructor_program.R")
source("functions/dataprep_instructor_program_other.R")
source("functions/dataprep_outreach_attendees.R")
source("functions/dataprep_outreach_audience.R")
source("functions/dataprep_outreach_audience_other.R")
source("functions/dataprep_outreach_collaborators.R")
source("functions/dataprep_outreach_home_program.R")
source("functions/dataprep_transaction_count.R")

#big request size limit
options(shiny.maxRequestSize = 10000 * 1024 ^ 2)


shinyServer(function(input, output) {
  
  #process input file and perform preliminary filter
  dataprep <- reactive({
    inFile <- input$file1
    if (is.null(inFile)){
      return(NULL)
    }
    df <- read.csv(inFile$datapath)
    df <- df %>% 
      select(Q2, RecordedDate,
        Q38, Q156, Q16, #these three are the date categories
        Q174,Q174_8_TEXT,Q184,Q194,Q194_6_TEXT,
        Q14,Q14_10_TEXT,Q191,Q193,Q197_1,Q197_2,
        Q21,Q198,Q198_10_TEXT,Q27,Q28)
    df <- dataprep_monthly(df)
    return(df)
  })
  
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
    filename = "AnnualReport.xlsx",
    content = function(file){
      table1 <- dataprep_digital_learning_objects(dataprep())
      table2 <- dataprep_instruction_attendees(dataprep())
      table3 <- dataprep_instruction_location(dataprep())
      sheets <- mget(ls(pattern = "table"))
      names(sheets) <- paste0("sheet", seq_len(length(sheets)))
      writexl::write_xlsx(sheets, path = file)
    }
  )
  
})
