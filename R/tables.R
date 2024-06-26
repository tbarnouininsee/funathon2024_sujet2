create_table_airports <- function(df){
  df2 <- df %>%
    mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
    ) %>%
    select(name_clean, everything()) %>% select(-apt, -apt_nom)
  tableau_interactif <- gt(df2) %>%
  fmt_number(decimals = 0, suffixing = TRUE) %>%
  fmt_markdown(columns = name_clean) %>%
  cols_label(
    name_clean = "Nom",
    depart = "Départs",
    arrivee = "Arrivées",
    transit = "Transits",
    total = "Total"
  ) %>%
  tab_header(
    title = md("**Statistiques de fréquentation**"),
    subtitle = md("Classement des aéroports")
  ) %>%
  tab_source_note(source_note = md("_Source: DGAC, à partir des données sur data.gouv.fr_")) %>% 
  opt_interactive()
  return(tableau_interactif)
}
