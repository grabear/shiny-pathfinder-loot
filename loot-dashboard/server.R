library(shiny)
library(shinydashboard)
library(googleAuthR)
library(googlesheets)

server <- function(input, output, session) {
  ## Make a button to link to Google auth screen
  ## If auth_code is returned then don't show login button
  ## Get auth code from return URL
  access_token  <- reactive({
    ## gets all the parameters in the URL. The auth code should be one of them.
    pars <- parseQueryString(session$clientData$url_search)
    
    if (length(pars$code) > 0) {
      ## extract the authorization code
      gs_webapp_get_token(auth_code = pars$code)
    } else {
      NULL
    }
  })
  
  observeEvent(input$menu,{
    if (is.null(isolate(access_token()))) {
      showModal(modalDialog(
      tags$a("Login",
             href = gs_webapp_auth_url(),
             class = "btn btn-default"), 
      title = "Google Login"
      ))
    } else {
      return()
    }
  },
  ignoreNULL = TRUE)
  
  output$logoutButton <- renderUI({
    if (!is.null(access_token())) {
      # Revoke the token too? use access_token$revoke()
      tags$a("Logout",
             href = getOption("googlesheets.webapp.redirect_uri"),
             class = "btn btn-default")
    } else {
      return()
    }
  })
  
  ## Get auth code from return URL
  access_token  <- reactive({
    ## gets all the parameters in the URL. The auth code should be one of them.
    pars <- parseQueryString(session$clientData$url_search)
    
    if (length(pars$code) > 0) {
      ## extract the authorization code
      gs_webapp_get_token(auth_code = pars$code)
    } else {
      NULL
    }
  })
  
  gsLs <- reactive({
    gs_ls()
  })
  
  user_info <- reactive({
    validate(
      need(!is.null(access_token()), message = FALSE)
    )
    gs_user()
  })
  
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