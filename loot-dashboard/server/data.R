get_link <- function(table) {
 return(switch(table,
         adventure_paths = "https://docs.google.com/spreadsheets/d/1gPhmI3AZ06MfTHnadZmBD5tc6-p9qAKAUekUHW5jRQU/edit?usp=sharing",
         campaigns = "https://docs.google.com/spreadsheets/d/18s5Bf2IbPXvyFnJJpmdRtzdQFARtcyO7uZu4_MhjKSk/edit?usp=sharing",
         equipment = "https://docs.google.com/spreadsheets/d/199y9RfOfk0B3kwH6m9uBWsXw_RX0CkcJtfsGZmiz5kE/edit?usp=sharing"
         )
        )
  }

get_data <- function(table) {
  
  return(switch(table,
         adventure_paths = read_sheet(get_link(table)),
         campaigns = read_sheet(get_link("campaigns"), sheet = table),
         players = read_sheet(get_link("campaigns"), sheet = table),
         equipment = read_sheet(get_link(table))
         )
  )
  }
withProgress(message = "Loading Data", value = 0, {
  incProgress(amount = 0.33, detail="Loading Adventure Paths")
  loot_data$ap_table <- get_data("adventure_paths")
  loot_data$ap_names <- unique(loot_data$ap_table$`Adventure Path Name`)
  incProgress(amount = 0.33, detail = "Loading Player Data")
  loot_data$players_table <- get_data("players")
  loot_data$drive_user <- drive_user()
  incProgress(amount = 0.33, detail = "Loading Campaign Data")
  loot_data$campaigns_table <- get_data("campaigns")
})