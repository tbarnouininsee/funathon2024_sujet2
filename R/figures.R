plot_airport_line <- function(dataframe, code_apt) {
  
  donnes_def <- dataframe %>% filter(apt==code_apt) %>% 
    mutate(date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d"))
  
  return(plot_ly(donnes_def, x = ~date, y = ~trafic_m, type = 'scatter', mode = 'lines'))
}

map_leaflet_airport <- function(df, a_l, month, year){
  palette <- c("green", "orange", "red")
  
  trafic_date <- df %>% filter(mois == month & an == year)
  
  trafic_aeroports <- a_l %>% left_join(trafic_date, by = c("Code.OACI" = "apt"))
  
  trafic_aeroports <- trafic_aeroports <- trafic_aeroports %>%
    mutate(
      volume = ntile(trafic_m, 3)
    ) %>%
    mutate(
      volume = ifelse(is.na(volume), "white",palette[volume])) 
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$volume
  )
  
  return(leaflet(trafic_aeroports) %>% addTiles() %>%
    addAwesomeMarkers(icon = icons, popup = ~paste0(Nom, "<br>", trafic_m)))
}
