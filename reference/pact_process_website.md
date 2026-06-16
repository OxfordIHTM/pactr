# Process Pandemic PACT dataset retrieved from the website

Process Pandemic PACT dataset retrieved from the website

## Usage

``` r
pact_process_website(pact_data, col_list = TRUE, fix = TRUE)
```

## Arguments

- pact_data:

  A data.frame for the Pandemic PACT dataset read from the Pandemic PACT
  website. This is usually obtained via a call to
  [`pact_read_website()`](https://oxford-ihtm.io/pactr/reference/pact_read_website.md).

- col_list:

  Logical. Should variable/fields with multiple values be made into
  column lists? Default to TRUE.

- fix:

  Logical. Should fixes be applied to the dataset based on known issues?
  Default to TRUE.

## Value

A tibble of the dataset from the website structured based on `col_list`
and \`fix“ specifications.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_data <- pact_read_website()
  pact_process_website(pact_data)
} # }
```
