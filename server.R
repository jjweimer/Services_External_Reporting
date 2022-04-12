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
source("functions/dataprep_desk_question_type.R")
source("functions/dataprep_desk_question_others.R")

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
        Q21,Q198,Q198_10_TEXT,Q27,Q28,Q31)
    df <- dataprep_monthly(df)
    return(df)
  })
  
  # ------- FILE DOWNLOADS -----------------------------------
  
  output$downloadACRL <- downloadHandler(
    filename = "ACRL.xlsx",
    content = function(file){
      ACRL_list <- list(
        "outreach_attendees" = dataprep_outreach_attendees(dataprep()),    
        "instruction_multisession" = dataprep_instruction_multisession(dataprep()),
        "instruction_sessions" = dataprep_instruction_sessions(dataprep()),
        "instruction_attendees" = dataprep_instruction_attendees(dataprep()),
        "instruction_locations" = dataprep_instruction_location(dataprep()),
        "desk_transaction_count" = dataprep_transaction_count(dataprep()),
        "desk_research_questions" = dataprep_desk_question_type(dataprep()),
        "desk_other_questions" = dataprep_desk_question_others(dataprep())
      )
      writexl::write_xlsx(ACRL_list, path = file)
    }
  )
  
  output$downloadUCOP <- downloadHandler(
    filename = "UCOP.xlsx",
    content = function(file){
      UCOP_list <- list(
        "outreach_attendees" = dataprep_outreach_attendees(dataprep()),    
        "instruction_multisession" = dataprep_instruction_multisession(dataprep()),
        "instruction_sessions" = dataprep_instruction_sessions(dataprep()),
        "instruction_attendees" = dataprep_instruction_attendees(dataprep()),
        "desk_transaction_count" = dataprep_transaction_count(dataprep()),
        "desk_research_questions" = dataprep_desk_question_type(dataprep()),
        "desk_other_questions" = dataprep_desk_question_others(dataprep())
      )
      writexl::write_xlsx(UCOP_list, path = file)
    }
  )
  
  output$downloadARL <- downloadHandler(
    filename = "ARL.xlsx",
    content = function(file){
      ARL_list <- list(
        "outreach_attendees" = dataprep_outreach_attendees(dataprep()),    
        "instruction_multisession" = dataprep_instruction_multisession(dataprep()),
        "instruction_sessions" = dataprep_instruction_sessions(dataprep()),
        "instruction_attendees" = dataprep_instruction_attendees(dataprep()),
        "desk_transaction_count" = dataprep_transaction_count(dataprep()),
        "desk_research_questions" = dataprep_desk_question_type(dataprep()),
        "desk_other_questions" = dataprep_desk_question_others(dataprep())
      )
      writexl::write_xlsx(ARL_list, path = file)
    }
  )
  
  output$downloadAnnualReport <- downloadHandler(
    filename = "AnnualReport.xlsx",
    content = function(file){
      AnnualReport_list <- list(
        "digital_learning_objects" = dataprep_digital_learning_objects(dataprep()),
        "instruction_attendees" = dataprep_instruction_attendees(dataprep()),
        "instruction_locations" = dataprep_instruction_location(dataprep()),
        "instruction_multisession" = dataprep_instruction_multisession(dataprep()),
        "instruction_sessions" = dataprep_instruction_sessions(dataprep()),
        "instruction_program_area" = dataprep_instructor_program(dataprep()),
        "instruction_program_area_other" = dataprep_instructor_program_other(dataprep()),
        "outreach_attendees" = dataprep_outreach_attendees(dataprep()),    
        "outreach_audience" = dataprep_outreach_audience(dataprep()),
        "outreach_audience_other" = dataprep_outreach_audience_other(dataprep()),
        "outreach_collaborators" = dataprep_outreach_collaborators(dataprep()),
        "outreach_home_program" = dataprep_outreach_home_program(dataprep()),
        "desk_transaction_count" = dataprep_transaction_count(dataprep()),
        "desk_research_questions" = dataprep_desk_question_type(dataprep()),
        "desk_other_questions" = dataprep_desk_question_others(dataprep())
      )
      writexl::write_xlsx(AnnualReport_list, path = file)
    }
  )
  
})
