# Tests for pact_client function -----------------------------------------------

test_that("pact_client output is as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  expect_type(pact_client, "environment")
  expect_s3_class(pact_client, "depositsClient")
  expect_s4_class(pact_client, NA)
})
