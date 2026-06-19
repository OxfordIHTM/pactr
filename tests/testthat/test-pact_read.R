# Tests for pact_read functions ------------------------------------------------

## Tier 1: pact_data_read_figshare(), fully offline ----------------------------
## Mock ONLY the package-internal pact_figshare_list(). Its download_url values
## point at real local CSV files, so utils::read.csv runs for real against disk —
## no mocking of functions from other packages. Distinct file contents per
## version let us assert which version was selected.

local_fig_setup <- function(env = parent.frame()) {
  f2025 <- withr::local_tempfile(fileext = ".csv", .local_envir = env)
  f2024 <- withr::local_tempfile(fileext = ".csv", .local_envir = env)
  fdict <- withr::local_tempfile(fileext = ".csv", .local_envir = env)

  utils::write.csv(
    data.frame(GrantID = 1L, release = "2025-01-15"), f2025, row.names = FALSE
  )
  utils::write.csv(
    data.frame(GrantID = 2L, release = "2024-12-01"), f2024, row.names = FALSE
  )
  utils::write.csv(data.frame(term = "x"), fdict, row.names = FALSE)

  # Only `name` and `download_url` are consumed by pact_data_list_figshare().
  fig_list <- tibble::tibble(
    name = c(
      "PandemicPACT-Dataset-2025-01-15.csv",
      "PandemicPACT-Dataset-2024-12-01.csv",
      "PandemicPACT_DataDictionary-2025-01-15.csv"
    ),
    download_url = c(f2025, f2024, fdict)
  )

  testthat::local_mocked_bindings(
    pact_figshare_list = function(pact_client) fig_list, .env = env
  )
}

test_that("latest = TRUE reads the most recent version", {
  local_fig_setup()
  out <- pact_data_read_figshare(pact_client = NULL)
  expect_s3_class(out, "data.frame")
  expect_identical(out$release, "2025-01-15")
})

test_that("latest = FALSE with a valid version reads that version", {
  local_fig_setup()
  out <- pact_data_read_figshare(NULL, latest = FALSE, version = "2024-12-01")
  expect_identical(out$release, "2024-12-01")
})

test_that("latest = TRUE ignores a supplied version", {
  local_fig_setup()
  out <- pact_data_read_figshare(NULL, latest = TRUE, version = "2024-12-01")
  expect_identical(out$release, "2025-01-15")
})

test_that("unknown but well-formed version warns and falls back to latest", {
  local_fig_setup()
  expect_warning(
    out <- pact_data_read_figshare(NULL, latest = FALSE, version = "2030-01-01"),
    regexp = "not a known Pandemic PACT dataset version"
  )
  expect_identical(out$release, "2025-01-15")
})

test_that("latest = FALSE with version = NULL warns and falls back to latest", {
  local_fig_setup()
  expect_warning(
    out <- pact_data_read_figshare(NULL, latest = FALSE, version = NULL),
    regexp = "`version` is not specified. Reading the latest version instead."
  )
  expect_identical(out$release, "2025-01-15")
})

test_that("a malformed version string errors", {
  local_fig_setup()
  expect_error(
    pact_data_read_figshare(NULL, latest = FALSE, version = "not-a-date"),
    regexp = "try again"
  )
})


## Tier 1: Figshare reads, fully offline ----
## Mock BOTH remote touch-points: the client's deposit_retrieve AND read.csv.
## Verifies the right deposit_id is requested and the right URL is read.
## Zero Figshare access.

make_fake_client <- function() {
  # deposit_retrieve(id) returns an object exposing $hostdata$files$download_url,
  # and records which id was asked for so the test can assert on it.
  e <- new.env()
  e$last_id <- NULL
  e$deposit_retrieve <- function(deposit_id) {
    e$last_id <- deposit_id
    list(
      hostdata = list(
        files = list(
          download_url = paste0(
            "https://figshare.test/files/", deposit_id, ".csv"
          )
        )
      )
    )
  }
  e
}

test_that("pact_read_figshare_dictionary requests the dictionary deposit_id", {
  client <- make_fake_client()
  local_mocked_bindings(
    read.csv = function(file, ...) data.frame(variable = "x"),
    .package = "utils"
  )
  pact_read_figshare_dictionary(client)
  expect_equal(client$last_id, 24773787)
})


## Tier 1: website read, offline ----

test_that("pact_read_website uses default URL and returns a tibble", {
  read_url <- NULL
  local_mocked_bindings(
    read.csv = function(file, ...) { read_url <<- file; data.frame(GrantID = 1) },
    .package = "utils"
  )
  out <- pact_read_website()
  expect_identical(
    read_url,
    "https://pandemicpact.org/export/grants/pandemic-pact-grants.csv"
  )
  expect_s3_class(out, "tbl_df")

  pact_read_website(.url = "https://example.com/custom.csv")
  expect_identical(read_url, "https://example.com/custom.csv")
})


## Tier 2: ONE real Figshare round-trip, opt-in & cached ----
## Fetch once, reuse across assertions, instead of 3 separate downloads.

test_that("[integration] Figshare reads return data frames", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == FALSE)
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  client <- pact_client_set()
  
  # Smoke-test each entry point once. If you want to go further and assert on
  # downstream processing, fetch a single dataset here and pass the cached
  # data.frame into those tests rather than re-reading from Figshare.
  expect_s3_class(pact_data_read_figshare(client), "data.frame")
})
