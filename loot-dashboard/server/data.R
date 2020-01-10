# Google Drive shared links
ap_link <- 
campaign_link <- 

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
  ap_data <- get_data("adventure_paths")
  ap_list <- unique(ap_data$`Adventure Path Name`)
  incProgress(amount = 0.33, detail = "Loading Player Data")
  players <- get_data("players")
  player <- drive_user()
  incProgress(amount = 0.33, detail = "Loading Campaign Data")
  campaigns <- get_data("campaigns")
})