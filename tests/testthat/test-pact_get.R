# Tests for pact_get functions -------------------------------------------------

## Tests ----
test_that("group id is as expected", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == FALSE)
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Get group id ----
  group_id <- pact_get_group_id(pact_client, id = 43544916)
  expect_equal(group_id, 53043, ignore_attr = TRUE)
  expect_type(group_id, "integer")
})


## Tests ----
test_that("filename is as expected", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == "")
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Get filename ----
  filename <- pact_get_filename(pact_client, id = 43544916)

  expect_equal(filename, "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv")
  expect_type(filename, "character")
})



local_fig_setup <- function(env = parent.frame()) {
  f2025 <- withr::local_tempfile(fileext = ".csv", .local_envir = env)

  utils::write.csv(
    data.frame(GrantID = 1L, release = "2025-01-15"), f2025, row.names = FALSE
  )

  ## Only `id`,`group_id`, `download_url`, and `filename` are consumed by
  ## pact_get_group_id().
  fig_list <- tibble::tibble(
    name = "PandemicPACT-Dataset-2025-01-15.csv",
    download_url = "f2025",
    group_id = 53043,
    id = 1L
  )

  testthat::local_mocked_bindings(
    pact_get_group_id = function(pact_client, id) fig_list, .env = env
  )

  testthat::local_mocked_bindings(
    pact_get_filename = function(pact_client, id) fig_list, .env = env
  )

  testthat::local_mocked_bindings(
    pact_get_url = function(pact_client, id) fig_list, .env = env
  )
}

test_that("correct group id is returned", {
  local_fig_setup()
  out <- pact_get_group_id(pact_client = NULL, id = 1L)
  expect_s3_class(out, "data.frame")
  expect_identical(out$group_id, 53043)
})

test_that("correct filename is returned", {
  local_fig_setup()
  out <- pact_get_filename(pact_client = NULL, id = 1L)
  expect_s3_class(out, "data.frame")
  expect_identical(out$name, "PandemicPACT-Dataset-2025-01-15.csv")
})

test_that("correct url is returned", {
  local_fig_setup()
  out <- pact_get_url(pact_client = NULL, id = 1L)
  expect_s3_class(out, "data.frame")
  expect_identical(out$download_url, "f2025")
})
