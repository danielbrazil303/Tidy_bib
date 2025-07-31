#' Safely convert bibliographic file to bibliometrix data frame
#'
#' Uses bibliometrix::convert2df with error handling and validation.
#'
#' @param file Path to the .bib file.
#' @param dbsource One of "isi", "scopus", "wos", etc.
#' @param format Format of the file, usually "bibtex".
#' @return A bibliometrix data frame or NULL on failure.
#' @export
safe_convert2df <- function(file, dbsource, format) {
  # Check if the file exists
  if (!file.exists(file)) {
    warning(paste("⚠️ File does not exist:", file))
    return(NULL)
  }
  
  # Check if the file is not empty
  if (file.size(file) == 0) {
    warning(paste("⚠️ File is empty:", file))
    return(NULL)
  }
  
  tryCatch({
    # Load required data from bibliometrix before conversion
    if (!exists("bibtag", envir = .GlobalEnv)) {
      data("bibtag", package = "bibliometrix", envir = .GlobalEnv)
    }
    
    # Attempt to convert the file
    result <- bibliometrix::convert2df(
      file = file,
      dbsource = dbsource,
      format = format
    )
    
    # Check if the result is valid
    if (is.null(result) || nrow(result) == 0) {
      warning(paste("⚠️ Conversion resulted in empty dataframe for", dbsource, "file"))
      return(NULL)
    }
    
    return(result)
    
  }, error = function(e) {
    warning(paste("⚠️ Failed to convert", dbsource, "file:", e$message))
    return(NULL)
  })
}