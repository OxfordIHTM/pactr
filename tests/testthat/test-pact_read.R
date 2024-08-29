# Tests for pact_read functions ------------------------------------------------

skip_on_ci()

## Read various data
data_labelled <- pact_read_data_tracker(pact_client)
data_raw <- pact_read_data_tracker(pact_client, tracker_type = "raw")
data_dictionary <- pact_read_data_dictionary(pact_client)

## Tests ----
test_that("data output is as expected", {
  expect_s3_class(data_labelled, "data.frame")
  expect_s3_class(data_raw, "data.frame")
  expect_s3_class(data_dictionary, "data.frame")
})
