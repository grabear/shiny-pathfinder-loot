# An input for the user to select the adventure path.
output$`adventure-path-output` <- renderUI({
  selectInput(inputId = "adventure-path-selection", label = "Select an Adventure Path", choices = loot_data$ap_names)
})

# An input for the user to select an adventure based on the adventure path that was selected.
output$`adventure-output` <- renderUI({
  a_data <- dplyr::filter(loot_data$ap_table, loot_data$ap_table$`Adventure Path Name` == input$`adventure-path-selection`)
  selectInput(inputId = "adventure-selection", label = "Select an Adventure", choices = c(a_data$Adventure, "Unknown"))
})

output$`campaign-output-load` <- renderUI({
  player_camps <- dplyr::filter(loot_data$players_table, loot_data$drive_user$emailAddress %in% loot_data$players_table$`Email Address`)
  player_camps <- dplyr::filter(loot_data$campaigns_table, loot_data$campaigns_table$ID %in% player_camps$`Campaign ID`)
  selectInput(inputId = "players-campaign-load", "Select a Campaign", choices = player_camps$`Campaign Name`)
})

output$`campaign-output-add` <- renderUI({
  player_camps <- dplyr::filter(loot_data$campaigns_table, loot_data$campaigns_table$`Owner Email` %in% loot_data$drive_user$emailAddress)
  selectInput(inputId = "players-campaign-add", "Select a Campaign", choices = player_camps$`Campaign Name`)
})


observeEvent(input$`create-campaign`, {
  
})