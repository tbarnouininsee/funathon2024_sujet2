
# pACKAGES
library(readr)
library(dplyr)
library(stringr)
library(sf)
library(plotly)
library(ggplot2)
library(gt)
library(leaflet)
library(bslib)
library(lubridate)

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

liste_aeroports <- unique(airport$apt_nom)
default_airport <- 	"PARIS-CHARLES DE GAULLE"

YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- 1:12
mois <- sample(MONTHS_LIST,1) 
an <- sample(YEARS_LIST, 1)

trafic_aeroports <- airport %>%
  filter(apt %in% default_airport) %>%
  mutate(
    date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
  )






