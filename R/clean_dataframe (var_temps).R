clean_dataframe <- function(dataframe, var_temps) {
  dataframe <- dataframe %>% mutate(AN := str_sub({{var_temps}}, 1, 4),
                                    MOIS := str_sub({{var_temps}}, 5, 6),
                                    MOIS := ifelse(str_starts(MOIS, "0"),str_sub(MOIS, 2,2),MOIS))
  names(dataframe) <- str_to_lower(names(dataframe))
  return(dataframe)
}