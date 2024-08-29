# Tests for pact_get functions -------------------------------------------------

## Tests ----
test_that("group id is as expected", {
  skip_on_ci()

  pact_client <- pact_client_set()

  ## Get group id ----
  group_id <- pact_get_group_id(pact_client)
  expect_equivalent(group_id, 53043)
  expect_type(group_id, "integer")
})



## Tests ----
test_that("filename is as expected", {
  skip_on_ci()

  pact_client <- pact_client_set()

  ## Get filename ----
  filename <- pact_get_filename(pact_client, id = 24763548)

  expect_equivalent(filename, "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv")
  expect_type(filename, "character")
})
