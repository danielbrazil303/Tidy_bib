# ========================================
# Run Pipeline — Tidy_bib (v1)
# Only using: convert_bib_files_to_df(), safe_convert2df()
# ========================================

suppressPackageStartupMessages({
  library(cli)
  library(here)
  library(yaml)
})

source(here::here("R", "utils.R"))

# Load required scripts
safe_source("R/convert_bib_files_to_df.R")
safe_source("R/safe_convert2df.R")

# Read and validate config
load_config <- function(path = "config.yaml") {
  if (!file.exists(path)) stop("❌ config.yaml not found.")
  config <- yaml::read_yaml(path)
  required <- c("wos", "scopus", "input")
  missing <- setdiff(required, names(config))
  if (length(missing) > 0) stop("❌ Missing required fields: ", paste(missing, collapse = ", "))
  return(config)
}

# Parse command-line argument
args <- commandArgs(trailingOnly = TRUE)
config_path <- "config.yaml"
config_arg <- grep("^--config=", args, value = TRUE)
if (length(config_arg) == 1) {
  config_path <- sub("^--config=", "", config_arg)
  cli::cli_alert_info("📂 Using configuration file: {config_path}")
} else {
  cli::cli_alert_info("ℹ️ No --config= argument found. Using default: config.yaml")
}

# Run pipeline
cli::cli_h1("🚀 Tidy_bib — Running convert_bib_files_to_df()")
start <- Sys.time()

result <- tryCatch({
  config <- load_config(config_path)
  df_list <- convert_bib_files_to_df(config)
  
  output_dir <- here::here("output")
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
  
  save_path <- file.path(output_dir, "converted_bibs.RData")
  save(df_list, file = save_path)
  cli::cli_alert_success("💾 Results saved to {save_path}")
  
  TRUE
}, error = function(e) {
  cli::cli_alert_danger("❌ Pipeline failed: {e$message}")
  FALSE
})

end <- Sys.time()
cli::cli_alert_info("⏱️ Duration: {round(difftime(end, start, units = 'secs'), 2)} seconds")

if (!result) quit(status = 1)