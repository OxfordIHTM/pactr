# Tests for pact_read_website --------------------------------------------------

test_that("pact_read_website works as expected", {
  pd1 <- pact_read_website()
  pd2 <- pact_read_website(
    .url = system.file("extdata", "pandemic-pact-grants.csv", package = "pactr")
  )

  expect_s3_class(pd1, "tbl")
  expect_s3_class(pd2, "tbl")
  expect_true(
    any("pandemic-pact-grants.csv" %in% list.files(tempdir()))
  )
})