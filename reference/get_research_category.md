# Get Pandemic PACT research category

Get Pandemic PACT research category

## Usage

``` r
get_research_category(pact_data)
```

## Arguments

- pact_data:

  A data.frame for the Pandemic PACT dataset read from the Pandemic PACT
  website. This is usually obtained via a call to
  [`pact_read_website()`](https://oxford-ihtm.io/pactr/reference/pact_read_website.md).

## Value

A data.frame of same structure as `pact_data` but with `ResearchCat` and
`ResearchSubcat` variables processed/cleaned.

## Examples

``` r
if (FALSE) { # \dontrun{
  get_research_category(pact_data)
} # }
```
