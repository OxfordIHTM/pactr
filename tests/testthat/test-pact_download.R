# Tests for pact_download function ---------------------------------------------

## Tier 1: wrapper logic, fully offline ----
## Mock the internal pact_download_url() so NO download ever happens; just
## capture what each wrapper asked it to download and where.

test_that("pact_download_website builds the correct URL and destfile", {
  captured <- NULL

  local_mocked_bindings(
    pact_download_url = function(.url, destfile, overwrite = FALSE, quiet = TRUE, ...) {
      captured <<- list(
        url = .url, destfile = destfile, overwrite = overwrite, quiet = quiet
      )
      
      destfile
    }
  )

  out <- pact_download_website(path = tempdir())

  expect_identical(
    captured$url,
    "https://pandemicpact.org/export/grants/pandemic-pact-grants.csv"
  )
  expect_identical(
    captured$destfile, file.path(tempdir(), "pandemic-pact-grants.csv")
  )
  expect_false(captured$overwrite)
  expect_identical(out, file.path(tempdir(), "pandemic-pact-grants.csv"))
})

test_that("pact_download_website forwards overwrite/quiet flags", {
  captured <- NULL
  
  local_mocked_bindings(
    pact_download_url = function(.url, destfile, overwrite = FALSE, quiet = TRUE, ...) {
      captured <<- list(overwrite = overwrite, quiet = quiet)
      destfile
    }
  
  )
  pact_download_website(path = tempdir(), overwrite = TRUE, quiet = FALSE)
  expect_true(captured$overwrite)
  expect_false(captured$quiet)
})

test_that("pact_download_figshare resolves URL/filename from the client", {
  # Fake client: no token, no network. Mimics the deposits R6 client surface
  # that pact_download_figshare touches (deposit_retrieve + hostdata).
  retrieved_id <- NULL
  
  fake_client <- local({
    e <- new.env()
    e$hostdata <- list(
      files = list(
        download_url = "https://figshare.com/ndownloader/files/123",
        name = "demo.csv"
      )
    )

    e$deposit_retrieve <- function(deposit_id) retrieved_id <<- deposit_id
    e
  })

  captured <- NULL
  
  local_mocked_bindings(
    pact_download_url = function(.url, destfile, ...) {
      captured <<- list(url = .url, destfile = destfile)
      destfile
    }
  )

  out <- pact_download_figshare(fake_client, id = 24763548, path = tempdir())

  expect_equal(retrieved_id, 24763548)
  expect_identical(
    captured$url,
    "https://figshare.com/ndownloader/files/123"
  )
  expect_identical(captured$destfile, file.path(tempdir(), "demo.csv"))
  expect_identical(out, file.path(tempdir(), "demo.csv"))
})


## Tier 2: pact_download_url() itself, network mocked ----

test_that("pact_download_url skips the download when file exists", {
  dest <- withr::local_tempfile(fileext = ".csv")
  writeLines("cached", dest)

  calls <- 0
  local_mocked_bindings(
    req_perform = function(req, path = NULL, ...) { calls <<- calls + 1; path },
    .package = "httr2"
  )

  out <- pact_download_url(
    .url = "https://example.com/x.csv", destfile = dest, overwrite = FALSE
  )

  expect_equal(calls, 0L)            # <-- the key assertion: zero downloads
  expect_identical(out, dest)
})

test_that("pact_download_url performs exactly one request and returns destfile", {
  dest <- withr::local_tempfile(fileext = ".csv")

  calls <- 0
  local_mocked_bindings(
    req_perform = function(req, path = NULL, ...) {
      calls <<- calls + 1
      writeLines("downloaded", path)
      path
    },
    .package = "httr2"
  )

  out <- pact_download_url(.url = "https://example.com/x.csv", destfile = dest)

  expect_equal(calls, 1L)
  expect_identical(out, dest)
  expect_true(file.exists(dest))
})

test_that("pact_download_url re-downloads when overwrite = TRUE", {
  dest <- withr::local_tempfile(fileext = ".csv")
  writeLines("old", dest)

  calls <- 0
  local_mocked_bindings(
    req_perform = function(req, path = NULL, ...) { calls <<- calls + 1; path },
    .package = "httr2"
  )

  pact_download_url(
    .url = "https://example.com/x.csv", destfile = dest, overwrite = TRUE
  )
  expect_equal(calls, 1L)
})


## Tier 3: real downloads — opt-in, rare ----
## Only run when PACTR_INTEGRATION_TESTS is set AND online AND not on CRAN.
## This is the ONLY place an actual file is pulled from Figshare / the website.

test_that("[integration] pact_download_website pulls the real CSV once", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == "")

  dest <- file.path(withr::local_tempdir(), "pandemic-pact-grants.csv")
  out  <- pact_download_website(path = dirname(dest))

  expect_true(file.exists(out))
  expect_gt(file.size(out), 0)
})

test_that("[integration] pact_download_figshare pulls a real file once", {
  skip_on_cran()
  skip_if_offline()
  skip_if(Sys.getenv("PACTR_INTEGRATION_TESTS") == FALSE)
  skip_if(Sys.getenv("FIGSHARE_TOKEN") == "")

  client <- pact_client_set()
  out <- pact_download_figshare(
    client, id = 24763548, path = withr::local_tempdir()
  )

  expect_true(file.exists(out))
  expect_match(basename(out), "\\.csv$")
})
