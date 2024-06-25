
create_data_from_input <- function(df, a, m){
  sortie <- df %>% 
    filter(an == a & mois == m)
  return(sortie)
}

summary_stat_airport <- function(df) {
  df2 <- df %>% 
    group_by(apt, apt_nom) %>% 
    summarise(depart = sum(apt_pax_dep),
              arrivee = sum(apt_pax_arr),
              transit = sum(apt_pax_tr),
              total = depart + arrivee + transit) %>% 
    ungroup() %>% 
    arrange(-total)
  return(df2)
}