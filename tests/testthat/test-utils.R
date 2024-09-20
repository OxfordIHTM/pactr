# Tests for utility functions --------------------------------------------------

## Process author names ----
test_that("process_author_names works as expected", {
  authors <- c("John Doe", "Jane Doe")

  expect_type(
    process_author_names(authors),
    "expression"
  )
})

## Detect mismatch ----
test_that("detect_mismatch works as expected", {
  country <- "United Kingdom | Italy | Spain"
  region1 <- "Europe"
  region2 <- "Europe | Europe | Europe"

  expect_true(all(detect_mismatch(country, region1)))
  expect_false(all(detect_mismatch(country, region2)))
})

## Get WHO regions ----
test_that("get_who_regions give the correct output", {
  country <- "United Kingdom | Italy | Spain"

  expect_vector(
    get_who_regions(country),
    ptype = character(),
    size = 1
  )
  expect_equal(get_who_regions(country), "Europe | Europe | Europe")
  expect_true(stringr::str_detect(get_who_region(country), pattern = " \\| "))
})

## Get research category and mpox priority ----
test_that("categories and priorities are correctly matched", {
  pact_data <- pact_read_website()

  expect_s3_class(
    get_research_category(pact_data),
    "tbl"
  )
  expect_false(
    all(detect_mismatch(pact_data$ResearchSubcat, pact_data$ResearchCat))
  )

  expect_s3_class(
    get_mpox_priority(pact_data),
    "tbl"
  )
  expect_false(
    all(
      detect_mismatch(
        pact_data$MPOXResearchSubPriority, pact_data$MPOXResearchPriority
      )
    )
  )
})