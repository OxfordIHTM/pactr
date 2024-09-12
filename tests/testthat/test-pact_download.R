# Tests for pact_download functdion --------------------------------------------

## Tests ----
test_that("pact_download outputs as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Download file ----
  download_file <- pact_download(pact_client, id = 24763548, path = tempdir())

  expect_equal(
    download_file,
    file.path(
      tempdir(), "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv"
    )
  )
  expect_type(download_file, "character")
  expect_true(
    "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv" %in% list.files(tempdir())
  )
})

test_that("overwrite works", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  download_file_overwrite <- pact_download(
    pact_client, id = 24763548, path = tempdir(), overwrite = TRUE, quiet = FALSE
  )

  expect_equal(
    download_file_overwrite,
    file.path(
      tempdir(), "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv"
    )
  )
  expect_type(download_file_overwrite, "character")
  expect_true(
    "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv" %in% list.files(tempdir())
  )
})
