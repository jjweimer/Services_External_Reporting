library(shiny)
library(dplyr)
library(lubridate)
library(tidyr)
library(writexl)
library(bslib)
library(shinycssloaders)

# ----- DEFINE OPTIONS ---------------------------------------

#spinner options from shinycssloaders and 100mb upload limit
options(shiny.maxRequestSize = 100*1024^2,
        spinner.type = 3,
        spinner.color.background  = "#ffffff",
        spinner.color = "#00629B")

#----------------------------------------------------------

shinyUI(fixedPage(

  #load custom css from file
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
  ),
  
  #bslib theming
  #SEE https://brand.ucsd.edu/using-the-brand/web/index.html for brand guidelines
  theme = bslib::bs_theme(
    bg = "#FFFFFF",
    fg = "#000000",
    primary = "#00629B",
    secondary = "#FFCD00",
    base_font = font_google("Roboto")
  ),
  
  #header
  fluidRow(
    column(
      12,
      align = "center",
      h1("Service Statistics External Reporting Tool")
    ) 
  ),
  
  #top row
  fluidRow(
    column(
      4,
      offset = 4,
      align = "center",
      fileInput(
        "file1","Upload Qualtrics Export",
        accept  = c("text/csv","text/comma-separated-values,text/plain",".csv")
        )
    )
  ),
  fluidRow(
    column(
      12,
      align = "center",
      HTML("This application imports a Qualtrics library service statistics Excel file and cleans and aggregates data relevant for external reporting bodies (number of instruction activities, info desk interactions, etc.). Data are currently aggregated to the monthly level."),
      HTML("<p> Check the <a href='https://ucsdlibrary.atlassian.net/wiki/spaces/LST/pages/60369935/Library+Statistics'>LiSN page for Library Statistics </a> for information on exporting data from Qualtrics.</p>"),
      tags$hr()
    )
  ),
  tags$br(),
  #export buttons row
  fluidRow(
    column(
      3,
      downloadButton("downloadACRL","Export ACRL")
    ),
    column(
      3,
      downloadButton("downloadUCOP","Export UCOP")
    ),
    column(
      3,
      downloadButton("downloadARL","Export ARL")
    ),
    column(
      3,
      downloadButton("downloadAnnualReport","Export Annual Report")
    )
  ),
  tags$br(),
  tags$hr(),
  tags$br(),
  fluidRow(
    column(
      10,
      offset = 1,
      align = "center",
      uiOutput("confirm_text") %>% withSpinner()
    )
  )
  
))
