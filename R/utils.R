#' Safely source an R script if it exists
#'
#' Checks if the file exists before sourcing it.
#'
#' @param path A character string with the path to the R script.
#' @return NULL (invisible); used for side effects.
#' @export
safe_source <- function(path) {
  if (file.exists(path)) {
    cli::cli_alert_info("📄 Loading {path}")
    source(path)
  } else {
    cli::cli_alert_danger("❌ File not found: {path}")
  }
}