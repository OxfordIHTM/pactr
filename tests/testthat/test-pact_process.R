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

  ## Check that output is of the correct class ----
  expect_s3_class(topic_group_df1, "tbl")
  expect_s3_class(topic_group_df2, "tbl")
  expect_s3_class(topic_group_df3, "tbl")
  expect_s3_class(topic_group_df4, "tbl")
  expect_s3_class(topic_group_df5, "tbl")

  ## Check that output is of the correct structure ----
  expect_named(topic_group_df1, c("Disease", "n"))
})