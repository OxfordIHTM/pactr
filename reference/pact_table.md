# Process variable of interest from Pandemic PACT website data by a grouping variable

Process variable of interest from Pandemic PACT website data by a
grouping variable

## Usage

``` r
pact_table_topic_group(
  pact_data_list_cols,
  topic,
  group = NULL,
  na_values = NULL
)

pact_table_disease(pact_data_list_cols, group = NULL, na_values = NULL)

pact_table_category(
  pact_data_list_cols,
  topic = c("ResearchCat", "ResearchSubcat"),
  na_values = NULL
)

pact_table_location_funder(
  pact_data_list_cols,
  topic = c("FunderRegion", "FunderCountry"),
  na_values = NULL
)

pact_table_location_institution(
  pact_data_list_cols,
  topic = c("ResearchInstitutionRegion", "ResearchInstitutionCountry"),
  na_values = NULL
)

pact_table_location_research(
  pact_data_list_cols,
  topic = c("ResearchLocationRegion", "ResearchLocationCountry"),
  na_values = NULL
)
```

## Arguments

- pact_data_list_cols:

  A data.frame for the Pandemic PACT dataset read from the Pandemic PACT
  website that has already been pre-processed to have list columns for
  nested variables. This is usually obtained via a call to
  [`pact_process_website()`](https://oxford-ihtm.io/pactr/reference/pact_process_website.md)
  with `col_list = TRUE`.

- topic:

  A character value of the variable name in `pact_data` for the topic of
  interest.

- group:

  A character value or vector of up to two values of the variable name/s
  in `pact_data_list_cols` to use as grouping variable/s. When specified
  as NULL (default), no grouping is applied to the tabulation based on
  the `topic` of interest and `group` specified.

- na_values:

  A character value or vector of values for strings to be considered as
  NA for `topic` and `group`. If NULL (default), `topic` and `group` are
  kept as is.

## Value

A data.frame structured based on specification. If `group` is NULL, the
data.frame presents values for `topic` as first column and then either
frequencies/counts of grants per `topic` value or sum of monetary amount
of grants per `topic`. if `group` has one value, the data.frame presents
values for `group` as first column followed by either frequencies/counts
of grants per `group` or sum of monetary amount of grants per `group`
then followed by the `topics` within each `group` followed by either
frequencies/counts of grants per `topic` by `group` or sum of monetary
amount of grants per `topic` by `group`.

## Examples

``` r
if (FALSE) { # \dontrun{
  df <- pact_read_website() |> pact_process_website()
  pact_table_topic_group(df, topic = "Disease")
} # }
```
