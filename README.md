# shiny-pathfinder-loot
An R shiny app used to keep up with loot tables on Google Sheets during Pathfinder/RPG sessions.

# References
* [googlesheets pkg examples](https://github.com/jennybc/googlesheets/tree/master/inst/shiny-examples)
* [Dean Attali's shiny persistent data storage example](https://deanattali.com/blog/shiny-persistent-data-storage/)

# Logic Flow:

1.  To begin please login to your gmail account.
    a. New campaign or old campaign?
2.  Campaign details:
    a.  DM name
        i. DM controlled PC
    b. Number of players
        i. Player names
        ii. PC names
    c. What game are you playing?
        i. Pathfinder, Starfinder, Other
    d. What type of adventure are you on? (if PF or SF)
        i. Adventure Path, Module, or Scenario?
        ii. Name of adventure
3. What do you want to name your campaign?
    a. Names or file paths generated from campaign details
        i. short and long version
    b. custom name
  
  