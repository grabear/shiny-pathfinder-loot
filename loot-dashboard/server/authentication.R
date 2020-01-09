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

# Change the login status to FALSE if the Logout button is pressed.
# This will trigger the authentication modal.
observeEvent(input$logout, {
  log_status(FALSE)
})

# Uses the googledrive package token with googlesheets4
# https://googlesheets4.tidyverse.org/articles/articles/drive-and-sheets.html
# It changes the login status and closes the modal
observeEvent(input$auth, {
  if (log_status() == FALSE) {
    drive_auth(email = input$gmail, cache = TRUE)
    sheets_auth(token = drive_token())
    
    # create objects from Google Sheets data
    source(file.path("server", "data.R"), local=TRUE)$value
    
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