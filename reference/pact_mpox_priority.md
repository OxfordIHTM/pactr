# Pandemic PACT Mpox Priorities

Pandemic PACT Mpox Priorities

## Usage

``` r
pact_mpox_priority
```

## Format

A data.frame with 4 columns and 23 rows:

|                         |                                   |
|-------------------------|-----------------------------------|
| **Variable**            | **Description**                   |
| *mpox_priority_code*    | Two digit Mpox priority code      |
| *mpox_priority*         | Mpox priority name                |
| *mpox_subpriority_code* | Four digit Mpox sub-priority code |
| *mpox_subpriority*      | Mpox sub-priority name            |

## Source

Pandemic PACT website https://www.pandemicpact.org/

## Examples

``` r
pact_mpox_priority
#> # A tibble: 23 × 4
#>    mpox_priority_code mpox_priority       mpox_subpriority_code mpox_subpriority
#>    <chr>              <chr>               <chr>                 <chr>           
#>  1 01                 Pathogen: natural … 0101                  Development of …
#>  2 01                 Pathogen: natural … 0102                  Research for en…
#>  3 01                 Pathogen: natural … 0103                  Viral evolution…
#>  4 02                 Animal and environ… 0201                  Investigation o…
#>  5 03                 Epidemiological st… 0301                  Epidemiology & …
#>  6 03                 Epidemiological st… 0302                  Disease epidemi…
#>  7 03                 Epidemiological st… 0303                  Transmission dy…
#>  8 03                 Epidemiological st… 0304                  Transmission dy…
#>  9 03                 Epidemiological st… 0305                  Ongoing assessm…
#> 10 04                 Clinical character… 0401                  Promote improve…
#> # ℹ 13 more rows
```
