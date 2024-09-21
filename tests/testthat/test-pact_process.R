# Tests for pact_process function ----------------------------------------------

test_that("pact_process works as expected", {
  pact_data <- pact_read_website() |> pact_process_website()
  topic_group_df1 <- pact_process_topic_group(pact_data, topic = "Disease")
  topic_group_df2 <- pact_process_topic_group(
    pact_data, topic = "Disease", group = "StudySubject"
  )
  topic_group_df3 <- pact_process_topic_group(
    pact_data, topic = "Disease", outcome = "money"
  )
  topic_group_df4 <- pact_process_disease(pact_data)
  topic_group_df5 <- pact_process_disease(
    pact_data, group = "StudySubject", outcome = "money"
  )
  topic_group_df6 <- pact_process_topic_group(pact_data, topic = "GrantEndYear")
  topic_group_df7 <- pact_process_topic_group(
    pact_data, topic = "Disease", group = c("GrantStartYear", "GrantEndYear")
  )

  pact_data_non_list <- pact_read_website() |> 
    pact_process_website(col_list = FALSE)


  ## Check that output is of the correct class ----
  expect_s3_class(topic_group_df1, "tbl")
  expect_s3_class(topic_group_df2, "tbl")
  expect_s3_class(topic_group_df3, "tbl")
  expect_s3_class(topic_group_df4, "tbl")
  expect_s3_class(topic_group_df5, "tbl")
  expect_s3_class(topic_group_df6, "tbl")
  expect_s3_class(topic_group_df7, "tbl")

  ## Check that output is of the correct structure ----
  expect_named(topic_group_df1, c("Disease", "n"))
  expect_named(topic_group_df2, c("StudySubject", "Disease", "n"))
  expect_named(topic_group_df3, c("Disease", "total_grant_amount"))
  expect_named(topic_group_df4, c("Disease", "n"))
  expect_named(
    topic_group_df5, c("StudySubject", "Disease", "total_grant_amount")
  )
  expect_named(topic_group_df6, c("GrantEndYear", "n"))
  expect_named(
    topic_group_df7, c("GrantStartYear", "GrantEndYear", "Disease", "n")
  )

  ## Check that error is spotted ----
  expect_error(
    pact_process_topic_group(pact_data_non_list, topic = "Disease")
  )

  expect_error(
    pact_process_topic_group(
      pact_data, topic = "Disease", 
      group = c("StudySubject", "StudyType", "Pathogen")
    )
  )

  expect_error(
    pact_process_topic_group(
      pact_data, topic = "Disease", group = c("Disease", "StudySubject")
    )
  )
})