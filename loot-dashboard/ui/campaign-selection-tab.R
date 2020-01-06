tabItem(tabName = "campaign-selection", 
        fluidRow(
          box(strong(h2("New Campaign")),
              htmlOutput("adventure-path-output"),
              htmlOutput("adventure-output"),
              textInput(inputId = "campaign-name", label = "Campaign Name")
              )
          )
        )