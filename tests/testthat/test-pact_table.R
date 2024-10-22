# Tests for pact_table functions -----------------------------------------------

test_that("pact_table works as expected", {
  pact_data_list_cols <- pact_read_website() |>
    (\(x) x[c(seq_len(500), which(x$GrantID == "P22196")), ])() |> 
    pact_process_website()
  
  topic_group_df1 <- pact_table_topic_group(
    pact_data_list_cols, topic = "Disease"
  )
  
  topic_group_df2 <- pact_table_topic_group(
    pact_data_list_cols, topic = "Disease", group = "StudySubject"
  )
  
  topic_group_df3 <- pact_table_disease(pact_data_list_cols)
  
  topic_group_df4 <- pact_table_disease(
    pact_data_list_cols, group = "StudySubject" )
  
  topic_group_df5 <- pact_table_topic_group(
    pact_data_list_cols, topic = "GrantEndYear"
  )
  
  topic_group_df6 <- pact_table_topic_group(
    pact_data_list_cols, topic = "Disease", 
    group = c("GrantStartYear", "GrantEndYear")
  )

  pact_data_non_list <- pact_read_website() |> 
    (\(x) x[c(seq_len(500), which(x$GrantID == "P22196")), ])() |>
    pact_process_website(col_list = FALSE)


  ## Check that output is of the correct class ----
  expect_s3_class(topic_group_df1, "tbl")
  expect_s3_class(topic_group_df2, "tbl")
  expect_s3_class(topic_group_df3, "tbl")
  expect_s3_class(topic_group_df4, "tbl")
  expect_s3_class(topic_group_df5, "tbl")
  expect_s3_class(topic_group_df6, "tbl")

  ## Check that output is of the correct structure ----
  expect_named(topic_group_df1, 
    c("Disease", "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df2, 
    c("StudySubject", "Disease", 
    "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df3, 
    c("Disease", "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df4,
    c("StudySubject", "Disease", 
    "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(topic_group_df5, 
    c("GrantEndYear", "n_grants", "n_grants_specified", "grant_amount_total")
  )
  expect_named(
    topic_group_df6, 
    c("GrantStartYear", "GrantEndYear", "Disease", 
      "n_grants", "n_grants_specified", "grant_amount_total"
    )
  )

  ## Check that error is spotted ----
  expect_error(
    pact_table_topic_group(pact_data_non_list, topic = "Disease")
  )

  expect_error(
    pact_table_topic_group(
      pact_data_list_cols, topic = "Disease", 
      group = c("StudySubject", "StudyType", "Pathogen")
    )
  )

  expect_error(
    pact_process_topic_group(
      pact_data_list_cols, 
      topic = "Disease", group = c("Disease", "StudySubject")
    )
  )
})