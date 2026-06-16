# Cite an output/asset available from the Pandemic PACT Figshare repository

Cite an output/asset available from the Pandemic PACT Figshare
repository

## Usage

``` r
pact_cite(pact_client, id)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

- id:

  A unique integer value identifying a specific file in the repository.

## Value

A string for recommended bibliographic citation for specific Pandemic
PACT output/asset in DateCite bibliographic style.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_client <- pact_client_set()
  pact_cite(pact_client, id = 24763548)
} # }
```
