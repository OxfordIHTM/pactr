# Tests for pact_list functions ------------------------------------------------

## Tests ----
test_that("pact_list outputs as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Get lists ----
  list_all <- pact_list(pact_client)
  list_data <- pact_list_data(pact_client)

  expect_s3_class(list_all, "data.frame")
  expect_s3_class(list_data, "data.frame")
  expect_equal(unique(list_all$group_id), 53043, ignore_attr = TRUE)
  expect_equal(unique(list_data$group_id), 53043, ignore_attr = TRUE)
})
