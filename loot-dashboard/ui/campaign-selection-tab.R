tabItem(tabName = "campaign-selection", 
        fluidRow(
          box(strong(h2("New Campaign")),
              textInput(inputId = "campaign-name", label = "Campaign Name"),
              textInput(inputId = "dm-name", label = "Dungeon Master Name"),
              htmlOutput("adventure-path-output"),
              htmlOutput("adventure-output"),
              actionButton(inputId = "create-campaign", "Create Campaign")
              ),
          box(strong(h2("Add Characters")),
              htmlOutput("campaign-output-add"),
              textInput(inputId = "added-first-name", label = "Player's First Name"),
              textInput(inputId = "added-last-name", label = "Player's Last Name"),
              textInput(inputId = "added-pc", label = "Player's Character"),
              actionButton(inputId = "add-player-button", "Add")
              ),
          ),
        fluidRow(
          box(strong(h2("Load Campaign")),
              htmlOutput("campaign-output-load"),
              actionButton(inputId = "load-campaign-button", "Load")
              )
        )
        )