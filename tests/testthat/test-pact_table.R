# Tests for pact_table functions -----------------------------------------------

unzip(
  zipfile = system.file("extdata", "pandemic-pact-grants.zip", package = "pactr"),
  junkpaths = TRUE,
  exdir = tempdir()
)

pact_data <- pact_read_website(
  .url = file.path(tempdir(), "pandemic-pact-grants.csv")
)

pact_data_list_cols <- pact_data |>
  (\(x) x[c(seq_len(500), which(x$GrantID == "P22196")), ])() |> 
  pact_process_website()

topic_group_df1 <- pact_table_topic_group(
  pact_data_list_cols, topic = "Diseases"
)

topic_group_df2 <- pact_table_topic_group(
  pact_data_list_cols, topic = "Diseases", group = "StudySubject"
)

topic_group_df3 <- pact_table_disease(pact_data_list_cols)

topic_group_df4 <- pact_table_disease(
  pact_data_list_cols, group = "StudySubject" 
)

topic_group_df5 <- pact_table_topic_group(
  pact_data_list_cols, topic = "GrantEndYear"
)

topic_group_df6 <- pact_table_topic_group(
  pact_data_list_cols, topic = "Diseases", 
  group = c("GrantStartYear", "GrantEndYear")
)

pact_data_non_list <- pact_data |>
  (\(x) x[c(seq_len(500), which(x$GrantID == "P22196")), ])() |>
  pact_process_website(col_list = FALSE)

test_that("pact_table works as expected", {
  ## Check that output is of the correct class ----
  expect_s3_class(topic_group_df1, "tbl")
  expect_s3_class(topic_group_df2, "tbl")
  expect_s3_class(topic_group_df3, "tbl")
  expect_s3_class(topic_group_df4, "tbl")
  expect_s3_class(topic_group_df5, "tbl")
  expect_s3_class(topic_group_df6, "tbl")

  ## Check that output is of the correct structure ----
  expect_named(topic_group_df1, 
    c("Diseases", "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df2, 
    c("StudySubject", "Diseases", 
    "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df3, 
    c("Diseases", "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df4,
    c("StudySubject", "Diseases", 
    "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df5, 
    c("GrantEndYear", "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(
    topic_group_df6, 
    c("GrantStartYear", "GrantEndYear", "Diseases", 
      "n_grants", "n_grants_specified", "grant_amount_total"
    )
  )

  ## Check that error is spotted ----
  expect_error(
    pact_table_topic_group(pact_data_non_list, topic = "Diseases")
  )

  expect_error(
    pact_table_topic_group(
      pact_data_list_cols, topic = "Diseases", 
      group = c("StudySubject", "StudyType", "Pathogens")
    )
  )

  expect_error(
    pact_process_topic_group(
      pact_data_list_cols, 
      topic = "Diseases", group = c("Diseases", "StudySubject")
    )
  )
})