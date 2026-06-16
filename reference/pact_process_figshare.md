# Process Pandemic PACT data

Process Pandemic PACT data

## Usage

``` r
pact_process_figshare(df)

pact_process_figshare_category(df, category, other = NULL, nest = FALSE)

pact_process_figshare_category_pathogen(df)

pact_process_figshare_category_funder(df)
```

## Arguments

- df:

  A data.frame of the Pandemic PACT dataset from the Figshare repository
  or from the website.

- category:

  A character value for the variable category to look for in the fields
  for `df` for collapsing multiple fields into one.

- other:

  A character value for the name of the variable in `df` for values for
  other for fields that have an other option. Default to NULL to
  indicate that field `category` has no other option.

- nest:

  Logical. Should variable/fields with multiple values be nested?
  Default to FALSE.

## Value

A tibble of processed Pandemic PACT dataset.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_data <- pact_read_figshare(pact_client_set())
  pact_process_figshare(df = pact_data)
} # }
```
