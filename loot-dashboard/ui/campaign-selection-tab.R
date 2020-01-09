tabItem(tabName = "campaign-selection", 
        fluidRow(
          box(strong(h2("New Campaign")),
              textInput(inputId = "pc-name", label = "Player Character Name"),
              textInput(inputId = "dm-name", label = "Dungeon Master Name"),
              textInput(inputId = "campaign-name", label = "Campaign Name"),
              htmlOutput("adventure-path-output"),
              htmlOutput("adventure-output"),
              actionButton(inputId = "create-campaign", "Create Campaign")
              
              )
          )
        )