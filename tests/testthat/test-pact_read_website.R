# Tests for pact_read_website --------------------------------------------------

test_that("pact_read_website works as expected", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == FALSE)
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pd1 <- pact_read_website()
  expect_s3_class(pd1, "tbl")
})