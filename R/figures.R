plot_airport_line <- function(dataframe, code_apt) {
  dataframe <- dataframe %>% mutate(trafic=apt_pax_dep+apt_pax_tr+apt_pax_arr)
  
  donnes_def <- dataframe %>% filter(apt==code_apt) %>% 
    mutate(date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d"))
  
  return(plot_ly(donnes_def, x = ~date, y = ~trafic, type = 'scatter', mode = 'lines'))
}