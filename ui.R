library(shiny)
library(bslib)
library(shinycssloaders)

#max file size 30mb for upload
options(shiny.maxRequestSize = 30*1024^2)
#spinner options
options(spinner.type = 3,
        spinner.color.background  = "#ffffff",
        spinner.color = "#00629B")

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
        ),
      selectInput(
        "year","Fiscal Year",
        c("2022/2023" = "2022/2023",
          "2021/2022" = "2021/2022")
      )
    )
  ),
  
  tags$hr(),
  
  #tabset panels
  fluidRow(
    column(
      12,
      align = "center",
      tabsetPanel(type = "pills",
                  tabPanel("ACRL",
                           tags$hr(),
                           fluidRow(
                             column(
                               4,
                               offset = 4,
                               allign = "center",
                               downloadButton("downloadACRL","Export ACRL")
                             )
                           )
                           ),
                  tabPanel("UCOP",
                           tags$hr(),
                           fluidRow(
                             column(
                               4,
                               offset = 4,
                               allign = "center",
                               downloadButton("downloadUCOP","Export UCOP")
                             )
                           )
                           ),
                  tabPanel("ARL",
                           tags$hr(),
                           fluidRow(
                             column(
                               4,
                               offset = 4,
                               allign = "center",
                               downloadButton("downloadARL","Export ARL")
                             )
                           )
                           ),
                  tabPanel("Annual Report",
                           tags$hr(),
                           fluidRow(
                             column(
                               4,
                               offset = 4,
                               allign = "center",
                               downloadButton("downloadAnnualReport","Export Annual Report")
                             )
                           )
                           )
                  )
    ) # end column 12
  ) #end tabset panels
  
))
