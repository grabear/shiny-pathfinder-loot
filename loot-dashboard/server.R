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
      update_app_folder()
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
    
    if(log_status) {
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

}

# # Function used to update the shiny-pathfinder-loot directory
update_app_folder <- function(overwrite=FALSE) {
  if(!"shiny-loot-app" %in% googledrive::drive_find(type="folder")$name) {
    googledrive::drive_mkdir("shiny-loot-app")
    googledrive::drive_upload(media = "data/pathfinder-data.xlsx",
                              path = "shiny-loot-app/",
                              type = "spreadsheet")
  } else if (overwrite == TRUE) {
    googledrive::drive_trash("shiny-loot-app")
    googledrive::drive_mkdir("shiny-loot-app")
    googledrive::drive_upload(media = "data/pathfinder-data.xlsx",
                              path = "shiny-loot-app/",
                              type = "spreadsheet")
  }
}
