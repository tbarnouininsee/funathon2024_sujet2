plot_airport_line <- function(dataframe, code_apt) {
  
  donnes_def <- dataframe %>% filter(apt==code_apt) %>% 
    mutate(date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d"))
  
  return(plot_ly(donnes_def, x = ~date, y = ~trafic_m, type = 'scatter', mode = 'lines'))
}

map_leaflet_airport <- function(df, a_l, month, year){
  palette <- c("green", "orange", "red")
  
  trafic_date <- df %>% filter(mois == month & an == year)
  
  trafic_aeroports <- a_l %>% left_join(trafic_date, by = c("Code.OACI" = "apt"))
  trafic_aeroports <- trafic_aeroports %>% 
    mutate(volume = case_when(
      trafic_m <= quantile(trafic_aeroports$trafic_m, 1/3) ~palette[1],
      trafic_m <= quantile(trafic_aeroports$trafic_m, 2/3) ~palette[2],
      T ~palette[3]))
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$volume
  )
  
  return(leaflet(trafic_aeroports) %>% addTiles() %>%
    addAwesomeMarkers(icon = icons, popup = ~paste0(Nom, "<br>", trafic_m)))
}
