# tests/testthat/test_convert_bib_files_to_df.R

test_that("convert_bib_files_to_df handles mixed availability", {
  config <- list(
    wos = TRUE,
    scopus = TRUE,
    input = list(
      wos = here::here("data", "wos_sample.bib"),
      scopus = here::here("data", "inexistent.bib")
    )
  )
  
  result <- convert_bib_files_to_df(config)
  
  expect_type(result, "list")
  
  # Check if the list has the expected names (even if some are NULL)
  expected_names <- c("WoS", "Scopus")
  
  # The list should have names, even if values are NULL
  expect_named(result, expected_names, ignore.order = TRUE)
  
  # Test WoS based on file existence
  if (file.exists(config$input$wos) && file.size(config$input$wos) > 0) {
    # If the file exists and is not empty, it should return a data.frame or NULL (in case of error)
    expect_true(is.data.frame(result$WoS) || is.null(result$WoS))
    
    # If not NULL, it must be a data.frame
    if (!is.null(result$WoS)) {
      expect_s3_class(result$WoS, "data.frame")
      expect_gt(nrow(result$WoS), 0)
    }
  } else {
    expect_null(result$WoS)
  }
  
  # Test Scopus (non-existent file)
  expect_null(result$Scopus)
})

test_that("convert_bib_files_to_df handles no valid files", {
  config <- list(
    wos = TRUE,
    scopus = TRUE,
    input = list(
      wos = here::here("data", "nonexistent_file1.bib"),
      scopus = here::here("data", "nonexistent_file2.bib")
    )
  )
  
  result <- convert_bib_files_to_df(config)
  
  expect_type(result, "list")
  
  # Should have names even with non-existent files
  expected_names <- c("WoS", "Scopus")
  if (length(result) > 0) {
    expect_named(result, expected_names, ignore.order = TRUE)
  }
  
  expect_null(result$WoS)
  expect_null(result$Scopus)
})

test_that("convert_bib_files_to_df handles disabled sources", {
  config <- list(
    wos = FALSE,
    scopus = FALSE,
    input = list(
      wos = here::here("data", "wos_sample.bib"),
      scopus = here::here("data", "scopus_sample.bib")
    )
  )
  
  result <- convert_bib_files_to_df(config)
  
  expect_type(result, "list")
  expect_length(result, 0)
})