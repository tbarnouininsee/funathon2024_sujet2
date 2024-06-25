#' Création de liste
#'
#' @param sources.file 
#'
#' @return 1 liste
#' @export
#'
#' @examples create_data_list("sources.yml")
create_data_list <- function(sources.file) {yaml::read_yaml(sources.file)}