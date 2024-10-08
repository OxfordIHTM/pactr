# Tets for pact_cite function --------------------------------------------------

## Tests ----
test_that("pact_cite outputs as expected", {
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  pact_client <- pact_client_set()

  ## Create citation ----
  pact_citation <- pact_cite(pact_client, id = 24763548)

  expect_type(pact_citation, "list")
  expect_s3_class(pact_citation, "citation")
  expect_s3_class(pact_citation, "bibentry")
  expect_true("CITATION" %in% list.files(tempdir()))
})
