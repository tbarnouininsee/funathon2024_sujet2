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

