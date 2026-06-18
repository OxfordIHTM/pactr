# List all available outputs/assets from Pandemic PACT's Figshare repositories.

List all available outputs/assets from Pandemic PACT's Figshare
repositories.

## Usage

``` r
pact_figshare_list(pact_client)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of available outputs/assets from the Pandemic PACT Figshare repository.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_figshare_list(pact_client = pact_client_set())
} # }
```
