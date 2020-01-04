library(shinydashboard)
library(shiny)
library(googlesheets4)


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
      menuItem("New Encounter", tabName = "new-encounter", icon = icon("dice")),
      menuItem("Claim Your Loot", tabName = "loot-claimer", icon = icon("hand-holding-usd")),
      menuItem("Manage Your Loot"),
      menuItem("Manage Group Loot"),
      menuItem("Liquid Asset Table"),
      menuItem("Loot Table", tabName = "loot-overivew", icon = icon("table")),
      menuItem("Trading Post"),
      wellPanel(span(h5(uiOutput("currentUser")), style = "color:black", align="center"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "instructions",
              fluidRow(
              box(
                p("Welcome to the Pathfinder Loot app.  This app is used to help you keep up with your loot, 
                  while playing the Pathfinder RPG by Piazo.  After completing the authentication sequence for 
                  the first time, the app will create a folder in your Google drive for storing data provided by
                  the app.  After creating a campaign new files will also be created to store this information."),
                strong(h3("**Important:**  Please do not manually edit the google drive files/folders.  This will
                          corrupt your campaigns and the general functioning of the application.")),
                h2("Instructions:"),
                hr(),
                p("Here is a basic set of instructions for using the application:"),
                tags$ol(tags$li("Authenticate with your Gmail address.  This app can ONLY be used with Gmail."),
                        tags$li("Select or Create a campaign in the Campaign Selection tab."),
                        tags$li("If you want to add more loot to the Loot Table, navigate to the New Encounter tab."),
                        tags$li("Loot can be rolled on in the Claim Your Loot tab.  Here you can vote NEED, GREED, or PASS.
                                NEED and GREED will generate a random number between 1 and 100 to settle multiple NEED/GREED
                                rolls.  If everyone selects PASS, then the loot will be added to the Group Loot Table."),
                        tags$li("You can manage your own loot by selling your items, posting your items for trade, and keeping
                                track of consumed items.  You can similarly manage group loot the same way, and you can add
                                custom purposes for items on this tab."),
                        tags$li("Any loot that needs to be sold to a vendor will be kept up with on the Liquid Assets Table.  This
                                tab will also help everyone keep up with the amount of money each item is worth and how much each
                                player should recieve.")
                        )
                )
              )
              ),
      tabItem(tabName = "campaign-selection", 
              fluidRow(
                box(strong(h2("New Campaign")),
                    htmlOutput("adventure-path-output"),
                    htmlOutput("adventure-output"))
              ))
      )
    )
  )

