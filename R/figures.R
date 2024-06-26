plot_airport_line <- function(dataframe, code_apt) {
  
  donnes_def <- dataframe %>% filter(apt_nom==code_apt) %>% 
    mutate(date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d"),
           text_trafic = case_when(
             trafic_m > 1000000 ~paste0(round(trafic_m/1000000, 1), "M"),
             trafic_m > 1000 ~paste0(round(trafic_m/1000, 0), "k"),
             T~paste0(trafic_m)
           ))
  m <- list(
    l = 0,
    r = 0,
    b = 0,
    t = 0)
    
  return(plot_ly(donnes_def, x = ~date, y = ~trafic_m, type = 'scatter', mode = 'lines', color = "darkorange",
                 text = ~paste0(month(date, label = T)," ", an," : ", text_trafic, ' voyageur', ifelse(trafic_m<2,"","s")),
                 hoverinfo = "text") %>% 
           layout(yaxis = list(title = ''),
                  xaxis = list(title = ''),
                  margin = m)
  )
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
      volume = ifelse(is.na(volume), "white",palette[volume]),
      trafic_m = ifelse(is.na(trafic_m), 0, trafic_m)) 
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$volume
  )
  
  return(leaflet(trafic_aeroports) %>% addTiles() %>%
    addAwesomeMarkers(icon = icons, popup = ~paste0("<center>", Nom, " :<br>", trafic_m, " voyageur",
    ifelse(trafic_m<2,"","s"),"</center>")))
}
