MONTHS_LIST = 1:12

# pACKAGES
library(readr)
library(dplyr)
library(stringr)
library(sf)
library(plotly)
library(ggplot2)
library(gt)
library(leaflet)

# Load data ----------------------------------

source("R/create_data_list.R")
source("R/import_data.R")  
source("R/clean_dataframe (var_temps).R")
source("R/figures.R")
source("R/divers_functions.R")
source("R/tables.R")

urls <- create_data_list("./sources.yml")


airport <- import_airport_data(unlist(urls$airports))
compagnies <- import_compagnies_data(unlist(urls$compagnies))
liaisons <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)

liste_aeroports <- unique(airport$apt)
default_airport <- liste_aeroports[1]

plot_airport_line(airport, "LFOT")

YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- 1:12

apt_m_y <- airport %>% filter(mois == sample(MONTHS_LIST,1) & an == sample(YEARS_LIST, 1))

stats_aeroports <- summary_stat_airport(airport)
stats_aeroports_table <- stats_aeroports %>%
  mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
  ) %>%
  select(name_clean, everything())

create_table_airports(stats_aeroports_table)

mois <- sample(MONTHS_LIST,1) 
an <- sample(YEARS_LIST, 1)

palette <- c("green", "orange", "red")

trafic_date <- airport %>% filter(mois == sample(MONTHS_LIST,1) & an == sample(YEARS_LIST, 1)) %>% 
  distinct()

trafic_aeroports <- airports_location %>% left_join(trafic_date, by = c("Code.OACI" = "apt"))

leaflet(trafic_aeroports) %>% addTiles() %>%
  addMarkers(popup = ~paste0(Nom, "<br>", trafic)) #A mettre en centré

quantile(trafic_aeroports$trafic_m, c(1/3, 2/3))

trafic_aeroports <- trafic_aeroports %>% 
  mutate(volume = case_when(
    trafic_m <= quantile(trafic_aeroports$trafic_m, 1/3) ~palette[1],
    trafic_m <= quantile(trafic_aeroports$trafic_m, 2/3) ~palette[2],
    T ~palette[3]))

icons <- awesomeIcons(
  icon = 'plane',
  iconColor = 'black',
  library = 'fa',
  markerColor = trafic_aeroports$volume
)

leaflet(trafic_aeroports) %>% addTiles() %>%
  addAwesomeMarkers(icon = icons, popup = ~paste0(Nom, "<br>", trafic))

map_leaflet_airport(airport, airports_location, mois, an)



