library(shiny)
library(shinydashboard)
library(googledrive)
library(googlesheets4)


server <- function(input, output, session) {
    log_status <- reactiveVal(FALSE)
  # Initialize reactive values


  # Display a modal asking for the use to login to Google
  # `footer=NULL` prevents a dismiss button from being displayed
  # so this is currently hard coded.
 
 observe({
   if (log_status() == FALSE) {
     showModal(
               modalDialog( 
                 actionButton(inputId = "auth",label = "Authenticate"),
                 easyClose = TRUE,
                 fade = TRUE,
                 title = "Google Login",
                 footer = textInput("gmail", label = "Gmail", value = "<your-gmail>@gmail.com")
               ))
   }
 })
  
  observeEvent(input$logout, {
    log_status(ifelse(log_status(), FALSE, TRUE))
    showModal(
      modalDialog( 
        actionButton(inputId = "auth",label = "Authenticate"),
        easyClose = TRUE,
        fade = TRUE,
        title = "Google Login",
        footer = textInput("gmail", label = "Gmail", value = "<your-gmail>@gmail.com")
      ))
  })
  observeEvent(input$auth, {
    if (log_status() == FALSE) {
      drive_auth(email = input$gmail, cache = TRUE)
      sheets_auth(email = input$gmail, cache = TRUE)
      log_status(ifelse(log_status(), FALSE, TRUE))
      removeModal()
      #   update_app_folder()
    } 
  })


}

