# Tests for pact_read_website --------------------------------------------------

test_that("pact_read_website works as expected", {
  pd1 <- pact_read_website()
  expect_s3_class(pd1, "tbl")
})