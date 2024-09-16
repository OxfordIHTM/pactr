# Tests for pact_process functions ---------------------------------------------

## Read data from inst ----
df <- read.csv(
  system.file("extdata/pact_data_test_labelled.csv", package = "pactr")
)

tidy_df <- pact_process_figshare(df)

## Perform tests ----
test_that("function output is as expected", {
  expect_s3_class(tidy_df, "tbl")
})
