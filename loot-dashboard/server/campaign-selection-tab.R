# An input for the user to select the adventure path.
output$`adventure-path-output` <- renderUI({
  selectInput(inputId = "adventure-path-selection", label = "Select an Adventure Path", choices = ap_list)
})

# An input for the user to select an adventure based on the adventure path that was selected.
output$`adventure-output` <- renderUI({
  a_data <- dplyr::filter(ap_data, ap_data$`Adventure Path Name` == input$`adventure-path-selection`)
  selectInput(inputId = "adventure-selection", label = "Select an Adventure", choices = c(a_data$Adventure, "Unknown"))
})

output$`campaign-output-load` <- renderUI({
  player_camps <- dplyr::filter(players, player$emailAddress %in% players$`Email Address`)
  player_camps <- dplyr::filter(campaigns, campaigns$ID %in% player_camps$`Campaign ID`)
  selectInput(inputId = "players-campaign-load", "Select a Campaign", choices = player_camps$`Campaign Name`)
})

output$`campaign-output-add` <- renderUI({
  player_camps <- dplyr::filter(campaigns, campaigns$`Owner Email` %in% player$emailAddress)
  selectInput(inputId = "players-campaign-add", "Select a Campaign", choices = player_camps$`Campaign Name`)
})


observeEvent(input$`create-campaign`, {
  
})