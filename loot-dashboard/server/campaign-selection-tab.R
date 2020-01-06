# An input for the user to select the adventure path.
output$`adventure-path-output` <- renderUI({
  selectInput(inputId = "adventure-path-selection", label = "Select an Adventure Path", choices = ap_list)
})

# An input for the user to select an adventure based on the adventure path that was selected.
output$`adventure-output` <- renderUI({
  a_data <- dplyr::filter(ap_data, ap_data$`Adventure Path Name` == input$`adventure-path-selection`)
  selectInput(inputId = "adventure-selection", label = "Select an Adventure", choices = c(a_data$Adventure, "Unknown"))
})