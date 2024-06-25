MONTHS_LIST = 1:12

# pACKAGES
library(readr)
library(dplyr)
library(stringr)
library(sf)
library(plotly)
library(ggplot2)

# Load data ----------------------------------

source("R/create_data_list.R")
source("R/import_data.R")  
source("R/clean_dataframe (var_temps).R")

urls <- create_data_list("./sources.yml")


airport <- import_airport_data(unlist(urls$airports))
compagnies <- import_compagnies_data(unlist(urls$compagnies))
liaisons <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)

liste_aeroports <- unique(airport$apt)
default_airport <- liste_aeroports[1]

airport <- airport %>% mutate(trafic=apt_pax_dep+apt_pax_tr+apt_pax_arr)

donnes_def <- airport %>% filter(apt==default_airport) %>% 
  mutate(date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d"))

ggplot(data = donnes_def, aes(x=date, y = trafic)) +
  geom_line()







