
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pactr: An Interface to the Pandemic PACT Repository <img src='man/figures/logo.png' width='200px' align='right' />

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/OxfordIHTM/pactr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/pactr/actions/workflows/R-CMD-check.yaml)
[![test-coverage.yaml](https://github.com/OxfordIHTM/pactr/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/OxfordIHTM/pactr/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

The [Pandemic PACT](https://www.pandemicpact.org/) monitors and analyses
global funding and research evidence related to diseases with pandemic
potential, as well as broader research preparedness efforts, and is
equipped to pivot in response to outbreaks. It collects, curates, codes,
and analyses data in alignment with WHO priority diseases and other
selected illnesses, including pandemic influenza, mpox, and plague.
Pandemic PACT aims to guide policy and decision-making for research
funders, policymakers, researchers, multilateral agencies. The database
is publicly available for download from its website and from
[Figshare](https://portal.sds.ox.ac.uk/pandemicpact). This package
interfaces with the project’s
[Figshare](https://portal.sds.ox.ac.uk/pandemicpact) repository to
provide programmatic access to its publicly available tracker data along
with other data products provided by the project.

## What does `pactr` do?

`pactr` provides functions to interface with Pandemic PACT’s
[Figshare](https://portal.sds.ox.ac.uk/pandemicpact) repository for
programmatic access to its contents. These functions are wrappers to
specific functions of the [`deposits`
package](https://docs.ropensci.org/deposits/index.html) which provides
the underlying universal interface to various online research data
deposition services including Figshare. Current functionalities
available in `pactr` are:

1.  Lists outputs/assets available from the Panedmic PACT Figshare
    repository;

2.  Downloads outputs/assets available from the Pandemic PACT Figshare
    repository; and,

3.  Reads dataset outputs/assets available from the Pandemic PACT
    Figshare repository.

## Installation

`pactr` is not yet on CRAN but can be installed through the [Oxford IHTM
r-universe](https://oxfordihtm.r-universe.dev) with:

``` r
install.packages(
  "pactr",
  repos = c("https://oxfordihtm.r-universe.dev", "https://cloud.r-project.org")
)
```

Alternatively, `pactr` can be installed directly from
[GitHub](https://github.com/OxfordIHTM/pactr) with the following
command:

``` r
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("OxfordIHTM/pactr")
```

`pactr` can then be loaded for use with:

``` r
library(pactr)
```

## Usage

### List outputs/assets

To list available outputs/assets from the Pandemic PACT Figshare
repository, issue the following command:

``` r
pact_list()
#>   project_id       id
#> 1         NA 25827649
#> 2         NA 25368136
#> 3     189177 25368070
#> 4     189177 25352839
#> 5     189168 24786258
#> 6     189168 24773787
#> 7     189168 24763548
#>                                                                                                                                                      title
#> 1                                                                                                                                      Scoping Review Data
#> 2                                                                                                                                                     test
#> 3                                                                                                                                   Pandemic PACT DataFlow
#> 4 Extended data for: 'A protocol for a living mapping review of global research funding for infectious diseases with a pandemic potential – PANDEMIC PACT'
#> 5                                                                                                                        Pandemic PACT Grant Tracker (raw)
#> 6                                                                                                                            Pandemic PACT data dictionary
#> 7                                                                                                                   Pandemic PACT Grant Tracker (labelled)
#>                           doi handle
#> 1 10.25446/oxford.25827649.v1       
#> 2 10.25446/oxford.25368136.v1       
#> 3 10.25446/oxford.25368070.v1       
#> 4 10.25446/oxford.25352839.v1       
#> 5 10.25446/oxford.24786258.v4       
#> 6 10.25446/oxford.24773787.v1       
#> 7 10.25446/oxford.24763548.v1       
#>                                             url       published_date
#> 1 https://api.figshare.com/v2/articles/25827649 2024-05-15T12:31:25Z
#> 2 https://api.figshare.com/v2/articles/25368136 2024-03-08T11:07:21Z
#> 3 https://api.figshare.com/v2/articles/25368070 2024-03-08T10:46:00Z
#> 4 https://api.figshare.com/v2/articles/25352839 2024-03-06T15:52:55Z
#> 5 https://api.figshare.com/v2/articles/24786258 2023-12-15T11:18:24Z
#> 6 https://api.figshare.com/v2/articles/24773787 2023-12-11T11:56:40Z
#> 7 https://api.figshare.com/v2/articles/24763548 2023-12-11T11:52:22Z
#>                                                                               thumb
#> 1                                                                                  
#> 2 https://s3-eu-west-1.amazonaws.com/ppreviews-oxford-5644276415/44933728/thumb.png
#> 3 https://s3-eu-west-1.amazonaws.com/ppreviews-oxford-5644276415/44933584/thumb.png
#> 4                                                                                  
#> 5                                                                                  
#> 6                                                                                  
#> 7                                                                                  
#>   defined_type    defined_type_name group_id
#> 1            3              dataset    53043
#> 2            1               figure    53043
#> 3            1               figure    53043
#> 4            6 journal contribution    53043
#> 5            3              dataset    53043
#> 6            3              dataset    53043
#> 7            3              dataset    53043
#>                                         url_private_api
#> 1 https://api.figshare.com/v2/account/articles/25827649
#> 2 https://api.figshare.com/v2/account/articles/25368136
#> 3 https://api.figshare.com/v2/account/articles/25368070
#> 4 https://api.figshare.com/v2/account/articles/25352839
#> 5 https://api.figshare.com/v2/account/articles/24786258
#> 6 https://api.figshare.com/v2/account/articles/24773787
#> 7 https://api.figshare.com/v2/account/articles/24763548
#>                                  url_public_api
#> 1 https://api.figshare.com/v2/articles/25827649
#> 2 https://api.figshare.com/v2/articles/25368136
#> 3 https://api.figshare.com/v2/articles/25368070
#> 4 https://api.figshare.com/v2/articles/25352839
#> 5 https://api.figshare.com/v2/articles/24786258
#> 6 https://api.figshare.com/v2/articles/24773787
#> 7 https://api.figshare.com/v2/articles/24763548
#>                                 url_private_html
#> 1 https://figshare.com/account/articles/25827649
#> 2 https://figshare.com/account/articles/25368136
#> 3 https://figshare.com/account/articles/25368070
#> 4 https://figshare.com/account/articles/25352839
#> 5 https://figshare.com/account/articles/24786258
#> 6 https://figshare.com/account/articles/24773787
#> 7 https://figshare.com/account/articles/24763548
#>                                                                                                                                                                                                           url_public_html
#> 1                                                                                                                                               https://portal.sds.ox.ac.uk/articles/dataset/Scoping_Review_Data/25827649
#> 2                                                                                                                                                               https://portal.sds.ox.ac.uk/articles/figure/test/25368136
#> 3                                                                                                                                             https://portal.sds.ox.ac.uk/articles/figure/Pandemic_PACT_DataFlow/25368070
#> 4 https://portal.sds.ox.ac.uk/articles/journal_contribution/Extended_data_for_A_protocol_for_a_living_mapping_review_of_global_research_funding_for_infectious_diseases_with_a_pandemic_potential_PANDEMIC_PACT_/25352839
#> 5                                                                                                                                  https://portal.sds.ox.ac.uk/articles/dataset/Pandemic_PACT_Grant_Tracker_raw_/24786258
#> 6                                                                                                                                     https://portal.sds.ox.ac.uk/articles/dataset/Pandemic_PACT_data_dictionary/24773787
#> 7                                                                                                                             https://portal.sds.ox.ac.uk/articles/dataset/Pandemic_PACT_Grant_Tracker_labelled_/24763548
#>       timeline.posted timeline.firstOnline        resource_title
#> 1 2024-05-15T12:31:25  2024-05-15T12:31:25                      
#> 2 2024-03-08T11:07:21  2024-03-08T11:07:21                      
#> 3 2024-03-08T10:46:00  2024-03-08T10:46:00                      
#> 4 2024-03-06T15:52:55  2024-03-06T15:52:55                      
#> 5 2023-12-15T11:18:24  2023-12-11T11:51:56 Pandemic PACT website
#> 6 2023-12-11T11:56:40  2023-12-11T11:56:40                      
#> 7 2023-12-11T11:52:22  2023-12-11T11:52:22 Pandemic PACT website
#>                              resource_doi
#> 1                                        
#> 2                                        
#> 3                                        
#> 4                                        
#> 5 https://www.glopid-r.org/pandemic-pact/
#> 6                                        
#> 7 https://www.glopid-r.org/pandemic-pact/
```

## Citation

If you find the `pactr` package useful please cite using the suggested
citation provided by a call to the `citation()` function as follows:

``` r
citation("pactr")
#> To cite package 'pactr' in publications use:
#> 
#>   Guevarra E (2024). _pactr: An Interface to the Pandemic PACT
#>   Database_. R package version 0.0.0.9000,
#>   https://oxford-ihtm.io/pactr/, <https://github.com/OxfordIHTM/pactr>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {pactr: An Interface to the Pandemic PACT Database},
#>     author = {Ernest Guevarra},
#>     year = {2024},
#>     note = {R package version 0.0.0.9000, https://oxford-ihtm.io/pactr/},
#>     url = {https://github.com/OxfordIHTM/pactr},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/pactr/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://oxford-ihtm.io/pactr/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://OxfordIHTM/pactr/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.
