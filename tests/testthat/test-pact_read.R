# Tests for pact_read functions ------------------------------------------------

## Tests ----
test_that("data output is as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Read various data
  data_labelled <- pact_read_figshare(pact_client)
  data_raw <- pact_read_figshare(pact_client, tracker_type = "raw")
  data_dictionary <- pact_read_figshare_dictionary(pact_client)

  expect_s3_class(data_labelled, "data.frame")
  expect_s3_class(data_raw, "data.frame")
  expect_s3_class(data_dictionary, "data.frame")
})
