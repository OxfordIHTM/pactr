# Detect one-to-one mismatch in variables

Detect one-to-one mismatch in variables

## Usage

``` r
detect_mismatch(x, y)
```

## Arguments

- x:

  A vector of values from the Pandemic PACT dataset.

- y:

  A vector of values from the Pandemic PACT dataset to match `x`
  against.

## Value

A logical vector indicating whether `x` and `y` have matching values
(TRUE) or not (FALSE).

## Examples

``` r
if (FALSE) { # \dontrun{
  detect_mismatch(ResearchInstitutionCountry, ResearchInstitutionRegion)
} # } 
```
