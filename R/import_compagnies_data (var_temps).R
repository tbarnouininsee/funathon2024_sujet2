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