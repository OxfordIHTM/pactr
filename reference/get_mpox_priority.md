# Get Pandemic PACT Mpox priority - Global and WHO Research Priority

Get Pandemic PACT Mpox priority - Global and WHO Research Priority

## Usage

``` r
get_mpox_priority_who(pact_data)

get_mpox_priority_global(pact_data)
```

## Arguments

- pact_data:

  A data.frame for the Pandemic PACT dataset read from the Pandemic PACT
  website. This is usually obtained via a call to
  [`pact_read_website()`](https://oxford-ihtm.io/pactr/reference/pact_read_website.md).

## Value

A data.frame of same structure as `pact_data` but with
`WHOMpoxResearchPriorities` and `WHOMpoxResearchSubPriorities` variables
or `GlobalMpoxResearchPriorities` and `GlobalMpoxResearchSubPriorities`
variables processed/cleaned.

## Examples

``` r
if (FALSE) { # \dontrun{
  get_mpox_priority_who(pact_data)
  get_mpox_priority_global(pact_data)
} # }
```
