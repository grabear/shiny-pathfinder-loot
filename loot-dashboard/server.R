library(shiny)
library(shinydashboard)
#library(googleAuthR)
library(googlesheets)
# Update Google Auth options
## rstudio-creds
#options(googlesheets.scopes.selected = c('https://spreadsheets.google.com/feeds', "https://www.googleapis.com/auth/drive"))
# options("googlesheets.webapp.client_id" =  "498958135112-hd4udv449lprp85j5e5qr1ugvg8on3v0.apps.googleusercontent.com")
# options("googlesheets.webapp.client_secret" = "xo58T9kE442ckGCWJkmzEP-F")
## Shiny Loot
#options("googlesheets.webapp.client_id" =  "498958135112-73skuk874afbk9sdc63tosrppi5lio4n.apps.googleusercontent.com")
#options("googlesheets.webapp.client_secret" = "cSX61CJ_PrebbAMX06KNK6mU")
# #options(googlesheets.httr_oauth_cache = FALSE)
#options("googlesheets.webapp.redirect_uri" = "http://127.0.0.1:4642")
options(shiny.port = 4642)
server <- function(input, output, session) {
  # Initialize reactive values
  log_status <- reactiveValues(logged_in = FALSE)

  # Display a modal asking for the use to login to Google
  # `footer=NULL` prevents a dismiss button from being displayed
  # so this is currently hard coded.
  observe({
    if (is.null(isolate(access_token()))) {
      showModal(modalDialog(HTML("This app uses your Google Drive and Google Sheets.</br><h>
                                  You must authenticate your Google account to use this app.</br><h></br><h>"),
      tags$a("Authenticate",
             href = drive_auth(),
             class = "btn btn-default"), 
      title = "Google Login"
      ,footer = NULL))
    } else {
      return()
    }
    log_status$logged_in <- TRUE
   # googledrive::drive_auth(oauth_token = )
    
    })
  auth_gd <- function() {
    pars <- parseQueryString(session$clientData$url_search)
    tok <- gs_webapp_get_token(auth_code = pars$code)
    print('yes')
    print(class(tok))
    tok_rds <- "tkn.rds"
    saveRDS(tok, tok_rds)
    print(tok_rds)
    googledrive::drive_auth(tok_rds)
  }
  # Render a logout button if the user is logged in
  output$logoutButton <- renderUI({
    if (!is.null(access_token())) {
      # Revoke the token too? use access_token$revoke()
      x <- access_token()
      saveRDS(x, "tkn.rds")
      googledrive::drive_auth("tkn.rds")
      update_app_folder()
      # pars <- parseQueryString(session$clientData$url_search)
      # tok <- gs_webapp_get_token(auth_code = pars$code)
      # print('yes')
      # print(class(tok))
      # tok_rds <- tempfile(pattern = "token",fileext = ".rds",tmpdir = tempdir(check = TRUE))
      # saveRDS(tok, tok_rds)
      # print(tok_rds)
      # y <- googledrive::drive_auth(tok)
      # print(y)
      # update_app_folder()
      tags$a("Logout",
             href = getOption("googlesheets.webapp.redirect_uri"),
             class = "btn btn-default")
    } else {
      log_status$logged_in <- FALSE
      return()
    }
  })
  
  ## Make a button to link to Google auth screen
  ## If auth_code is returned then don't show login button
  ## Get auth code from return URL
  access_token  <- reactive({
    ## gets all the parameters in the URL. The auth code should be one of them.
    pars <- parseQueryString(session$clientData$url_search)
    
    if (length(pars$code) > 0) {
      ## extract the authorization code
      x <- gs_webapp_get_token(auth_code = pars$code)
      print(x)
      x
    } else {
      NULL
    }
  })
  
  # Function used to update the shiny-pathfinder-loot directory
  update_app_folder <- function(overwrite=FALSE) {
    #googledrive::drive_auth(oauth_token = access_token())
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
  
  # Get user information
  user_info <- reactive({
    validate(
      need(!is.null(access_token()), message = FALSE)
    )
    gs_user()
  })
  
  # Generate UI output for the current user
  output$currentUser <- renderUI({
    validate(
      need(!is.null(access_token()),
           message = "No user is \ncurrently \nauthorized.")
    )
    x <- user_info()
    line1 <- sprintf("Welcome </br><h>back </br><h>%s!", x$user$displayName)

    
    HTML(paste(line1, sep = "</br><h>"))
  })

  
}