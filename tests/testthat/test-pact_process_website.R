# Tests for pact_process_website -----------------------------------------------

test_that("website data processing works as expected", {
  pact_data <- pact_read_website() |>
    (\(x) x[c(seq_len(1000), 9527), ])()
  df1 <- pact_process_website(pact_data)
  df2 <- pact_process_website(pact_data, col_list = FALSE, fix = FALSE)

  expect_s3_class(df1, "tbl")
  expect_s3_class(df2, "tbl")
  expect_true(all(lapply(df1[ , nested_vars], FUN = class) == "list"))
  expect_false(all(lapply(df2[ , nested_vars], FUN = class) == "list"))
  expect_identical(
    df1[df1$GrantID == "P22196", ]$Disease |> unlist(), "Zika virus disease"
  )
  expect_identical(df2[df2$GrantID == "P22196", ]$Disease, "")
})