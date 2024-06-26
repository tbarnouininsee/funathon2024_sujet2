import_airport_data <- function(list_files, ...){
  
  pax_apt_all <- readr::read_csv2(
    list_files, 
    col_types = cols(
      ANMOIS = col_character(),
      APT = col_character(),
      APT_NOM = col_character(),
      APT_ZON = col_character(),
      .default = col_double()
    )
  ) %>% 
    clean_dataframe(...)
  
  pax_apt_all <- pax_apt_all %>% mutate(trafic_m=apt_pax_dep+apt_pax_tr+apt_pax_arr)
  
  return(pax_apt_all)
  
}
