# List all available outputs/assets from Pandemic PACT's Figshare repository

List all available outputs/assets from Pandemic PACT's Figshare
repository

## Usage

``` r
pact_list(pact_client)

pact_list_data(pact_client)

pact_list_download(path_to_download)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

- path_to_download:

  Path to downloaded zip file from Pandemic PACT's Figshare repository

## Value

A data.frame of available outputs/assets from Pandemic PACT's Figshare
repository.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_list(pact_client = pact_client_set())
} # }
```
