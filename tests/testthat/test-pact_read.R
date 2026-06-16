# Tests for pact_read functions ------------------------------------------------

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

test_that("pact_read_figshare requests the correct deposit_id per tracker_type", {
  client <- make_fake_client()
  read_url <- NULL
  
  local_mocked_bindings(
    read.csv = function(file, ...) {
      read_url <<- file
      data.frame(GrantID = 1)
    },
    .package = "utils"
  )

  data_labelled <- pact_read_figshare(client)
  expect_equal(client$last_id, 24763548)
  expect_identical(read_url, "https://figshare.test/files/24763548.csv")
  expect_s3_class(data_labelled, "data.frame")

  pact_read_figshare(client, tracker_type = "raw")
  expect_equal(client$last_id, 24786258)

  expect_error(pact_read_figshare(client, tracker_type = "bogus"))
})

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


## Tier 1: download-from-zip, REAL but offline (no Figshare at all) ----
## Build a tiny fixture zip on the fly; exercises both csv and xlsx branches.

test_that("pact_read_figshare_download reads csv and xlsx from a local zip", {
  dir <- withr::local_tempdir()
  
  write.csv(
    data.frame(GrantID = 1:2), file.path(dir, "demo.csv"), row.names = FALSE
  )
  
  openxlsx2::write_xlsx(data.frame(GrantID = 1:2), file.path(dir, "demo.xlsx"))
  
  zip <- file.path(dir, "bundle.zip")
  
  withr::with_dir(dir, utils::zip(zip, c("demo.csv", "demo.xlsx")))

  expect_s3_class(pact_read_figshare_download(zip, "demo.csv"),  "data.frame")
  expect_s3_class(pact_read_figshare_download(zip, "demo.xlsx"), "data.frame")
})


## Tier 2: ONE real Figshare round-trip, opt-in & cached ----
## Fetch once, reuse across assertions, instead of 3 separate downloads.

test_that("[integration] Figshare reads return data frames", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == "")
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  client <- pact_client_set()

  # Smoke-test each entry point once. If you want to go further and assert on
  # downstream processing, fetch a single dataset here and pass the cached
  # data.frame into those tests rather than re-reading from Figshare.
  expect_s3_class(pact_read_figshare(client), "data.frame")
  expect_s3_class(pact_read_figshare(client, "raw"), "data.frame")
  expect_s3_class(pact_read_figshare_dictionary(client), "data.frame")
})
