# Read Pandemic PACT tracker dataset from the Pandemic PACT Figshare repository

Read Pandemic PACT tracker dataset from the Pandemic PACT Figshare
repository

## Usage

``` r
pact_data_read_figshare(pact_client, latest = TRUE, version = NULL)

pact_read_figshare_dictionary(pact_client)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

- latest:

  Logical. If `TRUE` (default), the latest version of the Pandemic PACT
  dataset is read.

- version:

  A character string specifying the version of the Pandemic PACT dataset
  to read. This should be in the format "YYYY-MM-DD". If `latest` is set
  to `TRUE`, this argument is ignored. If `version` is specified, it
  must match one of the available versions in the Pandemic PACT Figshare
  repository. If it does not match, a warning will be issued and the
  latest version will be read instead. If `version` is not specified and
  `latest` is set to `FALSE`, a warning will be issued and the latest
  version will be read instead.

## Value

A data.frame of the requested dataset.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_client <- pact_client_set()
  pact_read_figshare_dictionary(pact_client)
} # }
```
