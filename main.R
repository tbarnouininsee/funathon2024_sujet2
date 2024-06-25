MONTHS_LIST = 1:12

# Load data ----------------------------------
urls <- create_data_list("./sources.yml")

source("R/create_data_list.R")
source("R/import_data.R")  
source("R/clean_dataframe (var_temps).R")


pax_apt_all <- import_airport_data(unlist(urls$airports))
pax_cie_all <- import_compagnies_data(unlist(urls$compagnies))
pax_lsn_all <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)
