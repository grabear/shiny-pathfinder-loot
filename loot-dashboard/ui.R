library(shinydashboard)
library(shiny)
library(googleAuthR)
options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/plus.me")
options(googleAuthR.webapp.client_id =  "498958135112-hd4udv449lprp85j5e5qr1ugvg8on3v0.apps.googleusercontent.com")
options(googleAuthR.webapp.client_secret = "xo58T9kE442ckGCWJkmzEP-F")
#googlesheets::gs_auth(new_user = TRUE)

dashboardPage(
  dashboardHeader(title = "Loot Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      id = "menu",
      menuItem("Loot Overview", tabName = "loot-overivew", icon = icon("table")),
      menuItem("New Encounter", tabName = "new-encounter", icon = icon("dice")),
      menuItem("Claim Your Loot", tabName = "loot-claimer", icon = icon("hand-holding-usd"))
    )
  ),
  dashboardBody(uiOutput("loginButton"),uiOutput("logoutButton"))
)

