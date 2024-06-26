MONTHS_LIST = 1:12

# pACKAGES
library(readr)
library(dplyr)
library(stringr)
library(sf)
library(plotly)
library(ggplot2)
library(gt)

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



