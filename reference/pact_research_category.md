# Pandemic PACT Research Categories

Pandemic PACT Research Categories

## Usage

``` r
pact_research_category
```

## Format

A data.frame with 4 columns and 70 rows:

|  |  |
|----|----|
| **Variable** | **Description** |
| *research_category_code* | Two digit research category code |
| *research_category* | Research category name |
| *research_subcategory_code* | Four digit research sub-category code |
| *research_subcategory* | Research sub-category name |
| *code* | Concatenated research category and sub-category code |

## Source

Pandemic PACT website https://www.pandemicpact.org/

## Examples

``` r
pact_research_category
#> # A tibble: 70 × 5
#>    research_category_code research_category               research_subcategory…¹
#>    <chr>                  <chr>                           <chr>                 
#>  1 1                      Pathogen: natural history, tra… a                     
#>  2 1                      Pathogen: natural history, tra… b                     
#>  3 1                      Pathogen: natural history, tra… c                     
#>  4 1                      Pathogen: natural history, tra… d                     
#>  5 1                      Pathogen: natural history, tra… e                     
#>  6 1                      Pathogen: natural history, tra… f                     
#>  7 2                      Animal and environmental resea… a                     
#>  8 2                      Animal and environmental resea… b                     
#>  9 2                      Animal and environmental resea… c                     
#> 10 3                      Epidemiological studies         a                     
#> # ℹ 60 more rows
#> # ℹ abbreviated name: ¹​research_subcategory_code
#> # ℹ 2 more variables: research_subcategory <chr>, code <chr>
```
