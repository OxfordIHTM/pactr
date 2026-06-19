# Get outputs/assets identifiers

Get outputs/assets identifiers

## Usage

``` r
pact_get_group_id(pact_client, id)

pact_get_filename(pact_client, id)

pact_get_url(pact_client, id)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

- id:

  A unique integer value identifying a specific file in the repository.

## Value

An integer or character value or vector of values for requested
identifier or information.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_client <- pact_client_set()
  pact_get_group_id(pact_client)
  pact_get_filename(pact_client, id = 24763548)
} # }
```
