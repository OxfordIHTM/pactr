# Tests for pact_list functions ------------------------------------------------

## Get lists ----
list_all <- pact_list(pact_client)
list_data <- pact_list_data(pact_client)

## Tests ----
test_that("pact_list outputs as expected", {
  expect_s3_class(list_all, "data.frame")
  expect_s3_class(list_data, "data.frame")
  expect_equivalent(unique(list_all$group_id), 53043)
  expect_equivalent(unique(list_data$group_id), 53043)
})
