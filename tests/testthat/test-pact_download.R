# Tests for pact_download functdion --------------------------------------------

## Set client ----
pact_client <- pact_client_set()

download_file <- pact_download(pact_client, id = 24763548, path = tempdir())

## Tests ----
test_that("pact_download outputs as expected", {
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

download_file_overwrite <- pact_download(
  pact_client, id = 24763548, path = tempdir(), overwrite = TRUE, quiet = FALSE
)

test_that("overwrite works", {
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
