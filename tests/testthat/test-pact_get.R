# Tests for pact_get functions -------------------------------------------------

## Tests ----
test_that("group id is as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Get group id ----
  group_id <- pact_get_group_id(pact_client)
  expect_equal(group_id, 53043, ignore_attr = TRUE)
  expect_type(group_id, "integer")
})



## Tests ----
test_that("filename is as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Get filename ----
  filename <- pact_get_filename(pact_client, id = 24763548)

  expect_equal(filename, "PandemicPACT-GloPIDRAndUKC_DemoData-Label_21-11-23.csv")
  expect_type(filename, "character")
})
