
sidebarMenu(
  id = "menu",
  menuItem("Instructions", tabName = "instructions"),
  # sidebarMenuOutput("owner-page"),
  sidebarMenuOutput("registration1"),
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