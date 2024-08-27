# Tests for pact_client function -----------------------------------------------

test_that("pact_client output is as expected", {
  expect_type(pact_client, "environment")
  expect_s3_class(pact_client, "depositsClient")
  expect_s4_class(pact_client, NA)
})
