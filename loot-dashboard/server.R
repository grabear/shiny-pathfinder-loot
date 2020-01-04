library(shiny)
library(shinydashboard)
library(googledrive)
library(googlesheets4)


server <- function(input, output, session) {
  # Set the login status to FALSE.
  log_status <- reactiveVal(FALSE)
  
  # When the log_status is false, show the authentication window.
  # Do not use the easy close parameteror user will not be able 
  # to authenticate properly.
  observe({
    if (log_status() == FALSE) {
      showModal(
        modalDialog( 
          actionButton(inputId = "auth",label = "Authenticate"),
          fade = TRUE,
          title = "Google Login",
          footer = textInput("gmail", label = "Gmail", value = "<your-gmail>@gmail.com")
        ))
      }
    })
  ap_data <- read_sheet("https://docs.google.com/spreadsheets/d/1gPhmI3AZ06MfTHnadZmBD5tc6-p9qAKAUekUHW5jRQU/edit?usp=sharing")
  ap_list <- unique(ap_data$`Adventure Path Name`)
  # Change the login status to FALSE if the Logout button is pressed.
  # This will trigger the authentication modal.
  observeEvent(input$logout, {
    log_status(FALSE)
  })
  
  output$`adventure-path-output` <- renderUI({
    selectInput(inputId = "adventure-path-selection", label = "Select an Adventure Path", choices = ap_list)
  })
  
  output$`adventure-output` <- renderUI({
    a_data <- dplyr::filter(ap_data, ap_data$`Adventure Path Name` == input$`adventure-path-selection`)
    selectInput(inputId = "adventure-selection", label = "Select an Adventure", choices = a_data$Adventure)
  })
  # Uses the googledrive package token with googlesheets4
  # https://googlesheets4.tidyverse.org/articles/articles/drive-and-sheets.html
  # It changes the login status and closes the modal
  observeEvent(input$auth, {
    if (log_status() == FALSE) {
      drive_auth(email = input$gmail, cache = TRUE)
      sheets_auth(token = drive_token())
      log_status(ifelse(log_status(), FALSE, TRUE))
      removeModal()
      loot_files <- try({
        drive_ls(".loot")
        }, silent = TRUE)
      if ( "try-error" %in% class(loot_files) ) {
        initialize_app()
      }
    } 
  })

  # Update welcome message for current user.
  output$currentUser <- renderUI({
    validate(
      need(log_status(),
           message = "No user is \ncurrently \nauthorized.")
    )
    x <- drive_user()
    line1 <- sprintf("Welcome </br><h>back </br><h>%s!", x$emailAddress)
    
    if(log_status()) {
      HTML(paste(line1, sep = "</br><h>"))
    }
  })
  
  # Update profile pic for current user
  output$profile <- renderUI({
    if(log_status()){
      x <- drive_user()
      tags$img(src=x$photoLink)
    }
  })
  
  # -----  Functions  -----
  # Initialize app in Google Drive
  initialize_app <- function() {
    drive_mkdir(".loot")
    drive_mkdir(".loot/campaigns")
    # 1. create home directory if it doesn't exist
    # only #1 is a part of initialization
    # 2. Campaign selection or creation
    #     * select from dropdown
    #     * create with DM name, players' name, players' characters,
    #       players' email addresses
    # 
  }

}

# Static CSV data
# 1. Adventure-Paths data
# 2. PFS adventure data
# 3. Loot data

# Google Drive data
# 1. Saved Data Workbook
#     * Campaign sheet with all campaigns
#     * New Loot sheet with any newly generated loot not in static data
# 2. Each campaign gets a workbook with standardized name
#     * Notes sheet for taking quick notes during gameplay
#     * Encounter sheet for storing items per encounter
#       * Need, Greed, Pass, or Sell
#     * Vendored Loot sheet

# # # Function used to update the shiny-pathfinder-loot directory
# update_app_folder <- function(overwrite=FALSE) {
#   if(!"shiny-loot-app" %in% googledrive::drive_find(type="folder")$name) {
#     googledrive::drive_mkdir("shiny-loot-app")
#     googledrive::drive_upload(media = "data/pathfinder-data.xlsx",
#                               path = "shiny-loot-app/",
#                               type = "spreadsheet")
#   } else if (overwrite == TRUE) {
#     googledrive::drive_trash("shiny-loot-app")
#     googledrive::drive_mkdir("shiny-loot-app")
#     googledrive::drive_upload(media = "data/pathfinder-data.xlsx",
#                               path = "shiny-loot-app/",
#                               type = "spreadsheet")
#   }
# }
