library(shinydashboard)
library(shiny)


# -----  Start UI -----
dashboardPage(
  dashboardHeader(title = "Loot Dashboard",
    htmlOutput("profile"),
    tags$li(class = "dropdown", actionLink("logout", "Logout"))),
  dashboardSidebar(
    sidebarMenu(
      id = "menu",
      menuItem("Instructions", tabName = "instructions"),
      menuItem("Campaign Selection", tabName = "campaign-selection"),
      menuItem("Loot Overview", tabName = "loot-overivew", icon = icon("table")),
      menuItem("New Encounter", tabName = "new-encounter", icon = icon("dice")),
      menuItem("Claim Your Loot", tabName = "loot-claimer", icon = icon("hand-holding-usd")),
      wellPanel(span(h5(uiOutput("currentUser")), style = "color:black", align="center"))
    )
  ),
  dashboardBody()
)

