# Tests for pact_read_website --------------------------------------------------

test_that("pact_read_website works as expected", {
  unzip(
    zipfile = system.file("extdata", "pandemic-pact-grants.zip", package = "pactr"),
    junkpaths = TRUE,
    exdir = tempdir()
  )

  pd1 <- pact_read_website()
  pd2 <- pact_read_website(
    .url = file.path(tempdir(), "pandemic-pact-grants.csv")
  )

  expect_s3_class(pd1, "tbl")
  expect_s3_class(pd2, "tbl")
  expect_true(
    any("pandemic-pact-grants.csv" %in% list.files(tempdir()))
  )
})