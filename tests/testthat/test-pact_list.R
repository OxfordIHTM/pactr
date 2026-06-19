# Tests for pact_list functions ------------------------------------------------

## Tests ----
test_that("pact_list outputs as expected", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == FALSE)
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Get lists ----
  list_oxford <- pact_figshare_list(pact_client)
  list_private <- pact_figshare_list(pact_client)

  expect_s3_class(list_oxford, "data.frame")
  expect_s3_class(list_private, "data.frame")
  expect_equal(unique(list_oxford$group_id), 53043, ignore_attr = TRUE)
})
