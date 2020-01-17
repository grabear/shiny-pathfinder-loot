library(shinydashboard)
library(shiny)
library(googlesheets4)


# -----  Start UI -----
dashboardPage(
  dashboardHeader(title = "Loot Dashboard",
    tags$li(class = "dropdown", actionLink("logout", "Logout"))),
  dashboardSidebar(
# Sidebar Menu
    source(file.path("ui", "sidebarmenu.R"), local=TRUE)$value
  ),
  dashboardBody(
    tabItems(
      # Sidebar contents
      source(file.path("ui", "instructions-tab.R"), local=TRUE)$value,
      source(file.path("ui", "campaign-selection-tab.R"), local=TRUE)$value
      )
    )
  )

