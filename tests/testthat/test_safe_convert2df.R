# tests/testthat/test_safe_convert2df.R

test_that("safe_convert2df returns NULL for nonexistent file", {
  result <- safe_convert2df("data/arquivo_inexistente.bib", "wos", "bibtex")
  expect_null(result)
})

test_that("safe_convert2df returns data frame for valid file", {
  path <- "data/wos_sample.bib"
  if (file.exists(path)) {
    result <- safe_convert2df(path, "wos", "bibtex")
    expect_s3_class(result, "data.frame")
    expect_true(nrow(result) > 0)
  } else {
    skip("Arquivo de teste 'wos_sample.bib' não encontrado.")
  }
})
