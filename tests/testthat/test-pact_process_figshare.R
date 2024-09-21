# Tests for pact_process functions ---------------------------------------------

## Perform tests ----
test_that("function output is as expected", {
  ## Read data from inst ----
  df <- read.csv(
    system.file("extdata/pact_data_test_labelled.csv", package = "pactr")
  )

  tidy_df <- pact_process_figshare(df)

  expect_s3_class(tidy_df, "tbl")
})
