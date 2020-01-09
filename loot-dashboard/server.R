library(shiny)
library(shinydashboard)
library(googledrive)
library(googlesheets4)


server <- function(input, output, session) {
                    
  # Authentication Window and Login Sequence
  source(file.path("server", "authentication.R"), local=TRUE)$value

  
  # Commented code for displaying and "admin" page for the owner of the game
  # https://stackoverflow.com/questions/45356096/dynamic-menu-in-shinydashboard-with-conditionalpanel
  # output$`owner-page` <- renderMenu({
  #   
  # })
  
  # Logic for the campaign selection tab
  output$registration1 <- renderMenu({
    players <- get_data("players")
    player <- drive_user()
    if (!(player$emailAddress %in% players$`Email Address`)) {
      if (log_status() == TRUE) {
        sidebarMenu(
        menuItem("Registration", tabName = "registra")
      )
      }
    }
  })
  
  source(file.path("server", "campaign-selection-tab.R"), local=TRUE)$value
  

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
