# Changelog

## pactr v0.0.0.9006 (development version)

This is a pre-release, development version. In this release:

### New features

- created
  [`pact_download_figshare_private()`](https://oxford-ihtm.io/pactr/reference/pact_download.md)
  function for downloading private datasets from the Pandemic PACT
  Figshare repository.

### Bug fixes and improvements

- `pact_download_*()` functions for downloading data from the Pandemic
  PACT Figshare repository or from the Pandemic PACT website now use
  `httr2` for HTTP requests rather than
  [`download.file()`](https://rdrr.io/r/utils/download.file.html) base
  function. This allows for more robust and flexible handling of HTTP
  requests and addition of request options such as timeouts, retries,
  and throttling. This change also supports easier implementation of
  mock tests.

- [`pact_process_website()`](https://oxford-ihtm.io/pactr/reference/pact_process_website.md)
  function for processing data from the Pandemic PACT website has been
  refactored to take into account the new data structure of the Pandemic
  PACT dataset available from the website.

- [`pact_read_website()`](https://oxford-ihtm.io/pactr/reference/pact_read_website.md)
  function for reading data from the Pandemic PACT website has been
  updated to reflect the new URL used in the website for accessing the
  dataset.

- `pact_table_*()` functions for creating tables from the Pandemic PACT
  data have been updated to reflect the new data structure.

- package tests have been refactored so as to limit API calls and
  network calls through use of mock tests whenever possible.
