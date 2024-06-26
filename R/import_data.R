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

import_compagnies_data <- function(list_file, ...) {
  temp_df <- readr::read_csv2(list_file,
                              col_types = cols(
                                ANMOIS = col_character(),
                                CIE = col_character(),
                                CIE_NOM = col_character(),
                                CIE_NAT = col_character(),
                                CIE_PAYS = col_character(),
                                .default = col_double())) %>% 
    clean_dataframe(...)
  return(temp_df)}

import_liaisons_data <- function(list_file, ...) {
  temp_df <- readr::read_csv2(list_file,
                              col_types = cols(
                                ANMOIS = col_character(),
                                LSN = col_character(),
                                LSN_DEP_NOM = col_character(),
                                LSN_ARR_NOM = col_character(),
                                LSN_SCT = col_character(),
                                LSN_FSC = col_character(),
                                .default = col_double())) %>% 
    clean_dataframe(...)
  return(temp_df)}

