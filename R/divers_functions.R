
create_data_from_input <- function(df, a, m){
  sortie <- df %>% 
    filter(an == a & mois == m)
  return(sortie)
}

