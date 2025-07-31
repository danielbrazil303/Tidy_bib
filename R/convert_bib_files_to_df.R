#' Convert multiple bibliographic .bib files into bibliometrix data frames
#'
#' Wrapper around bibliometrix::convert2df for WoS and Scopus sources.
#'
#' @param config A list containing logical flags for `wos`, `scopus`, and file paths in `input`.
#' @return A named list of bibliometrix data frames (e.g., list(WoS = ..., Scopus = ...))
#' @export
convert_bib_files_to_df <- function(config) {
  M_list <- list()
  
  if (isTRUE(config$wos)) {
    wos_path <- here::here(config$input$wos)
    wos_format <- config$format$wos %||% "bibtex"
    wos_result <- safe_convert2df(
      file = wos_path,
      dbsource = "wos",
      format = wos_format
    )
    M_list[["WoS"]] <- wos_result
  }
  
  if (isTRUE(config$scopus)) {
    scopus_path <- here::here(config$input$scopus)
    scopus_format <- config$format$scopus %||% "bibtex"
    scopus_result <- safe_convert2df(
      file = scopus_path,
      dbsource = "scopus",
      format = scopus_format
    )
    M_list[["Scopus"]] <- scopus_result
  }
  
  # Ensure the list always contains the expected names, even if some are NULL
  expected_names <- character(0)
  if (isTRUE(config$wos)) expected_names <- c(expected_names, "WoS")
  if (isTRUE(config$scopus)) expected_names <- c(expected_names, "Scopus")
  
  # Fill missing names with NULL
  for (name in expected_names) {
    if (is.null(M_list[[name]])) {
      M_list[[name]] <- NULL
    }
  }
  
  # Reorder to match expected_names
  M_list <- M_list[expected_names]
  names(M_list) <- expected_names
  
  return(M_list)
}