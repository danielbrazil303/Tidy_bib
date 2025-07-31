
# 📚 Tidy_bib

> A modular and reproducible pipeline for cleaning and organizing
> bibliographic data using R.

------------------------------------------------------------------------

## 🎯 Purpose

`Tidy_bib` automates the preprocessing of `.bib` files exported from
databases like **Web of Science** and **Scopus**, preparing the data for
analysis in `biblioshiny` or for enrichment via APIs (Crossref,
OpenAlex, ROR).

------------------------------------------------------------------------

## 🗂️ Project Structure

``` text
Tidy_bib/
├── R/               # Function scripts (e.g., safe_convert2df.R)
├── data/            # Raw files (.bib)
├── output/          # Cleaned data, spreadsheets, logs
├── tests/           # Unit tests with testthat
├── config.yaml      # Configuration file
├── README.Rmd       # This file
├── .gitignore       # Files to ignore in version control
```

------------------------------------------------------------------------

## ⚙️ How to Run the Pipeline

### 1. Install required packages:

``` r
install.packages(c("bibliometrix", "yaml", "here", "fs", "dplyr"))
```

### 2. Run the pipeline:

``` r
source("R/convert_bib_files_to_df.R")
source("R/safe_convert2df.R")
source("run_pipeline.R")

initialize_pipeline("config.yaml")
```

------------------------------------------------------------------------

## 🧪 Testing

This project uses `testthat`. To run the tests:

``` r
devtools::test()
```

------------------------------------------------------------------------

## 👥 Contributing

1.  Fork the repository
2.  Create a branch: `git checkout -b new-feature`
3.  Commit your changes: `git commit -m "feat: add new feature"`
4.  Push to your branch: `git push origin new-feature`
5.  Open a pull request

------------------------------------------------------------------------

## 🔒 License

This project is licensed under the MIT License. See the `LICENSE` file
for details.

------------------------------------------------------------------------

## 📌 Citation

If you use this project, please cite as:

    Arraes, D. (2025). Tidy_bib: A modular bibliographic cleaning pipeline in R. https://github.com/danielbrazil303/Tidy_bib
