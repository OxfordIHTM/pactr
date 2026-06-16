# World Health Organization (WHO) Country Information

World Health Organization (WHO) Country Information

## Usage

``` r
who_country_info
```

## Format

A data.frame with 5 columns and 194 rows:

|                  |                                             |
|------------------|---------------------------------------------|
| **Variable**     | **Description**                             |
| *country_iso3c*  | ISO-3 country code                          |
| *who_short_name* | Country short name given by WHO             |
| *formal_name*    | Country formal name                         |
| *who_region*     | WHO region name to which country belongs to |
| *un_region*      | UN region name to which country belongs to  |

## Source

Data are drawn from WHO's Data Country list found at
https://data.who.int/countries/

## Examples

``` r
who_country_info
#> # A tibble: 194 × 5
#>    country_iso3c who_short_name      formal_name            who_region un_region
#>    <chr>         <chr>               <chr>                  <chr>      <chr>    
#>  1 AFG           Afghanistan         the Islamic Republic … Eastern M… Asia > S…
#>  2 ALB           Albania             the Republic of Alban… Europe     Europe >…
#>  3 DZA           Algeria             the People’s Democrat… Africa     Africa >…
#>  4 AND           Andorra             the Principality of A… Europe     Europe >…
#>  5 AGO           Angola              the Republic of Angola Africa     Africa >…
#>  6 ATG           Antigua and Barbuda Antigua and Barbuda    Americas   Americas…
#>  7 ARG           Argentina           the Argentine Republic Americas   Americas…
#>  8 ARM           Armenia             the Republic of Armen… Europe     Asia > W…
#>  9 AUS           Australia           Australia              Western P… Oceania …
#> 10 AUT           Austria             the Republic of Austr… Europe     Europe >…
#> # ℹ 184 more rows
```
