
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pactr: An Interface to the Pandemic PACT Data Repository <img src='man/figures/logo.png' width='200px' align='right' />

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/OxfordIHTM/pactr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/OxfordIHTM/pactr/actions/workflows/R-CMD-check.yaml)
[![test-coverage.yaml](https://github.com/OxfordIHTM/pactr/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/OxfordIHTM/pactr/actions/workflows/test-coverage.yaml)
[![Codecov test
coverage](https://codecov.io/gh/OxfordIHTM/pactr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/OxfordIHTM/pactr?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/OxfordIHTM/pactr/badge)](https://www.codefactor.io/repository/github/OxfordIHTM/pactr)
[![DOI](https://zenodo.org/badge/847474685.svg)](https://zenodo.org/badge/latestdoi/847474685)
<!-- badges: end -->

The [Pandemic PACT](https://www.pandemicpact.org/) monitors and analyses
global funding and research evidence related to diseases with pandemic
potential, as well as broader research preparedness efforts, and is
equipped to pivot in response to outbreaks. It collects, curates, codes,
and analyses data in alignment with WHO priority diseases and other
selected illnesses, including pandemic influenza, mpox, and plague.
Pandemic PACT aims to guide policy and decision-making for research
funders, policymakers, researchers, multilateral agencies. The Pandemic
PACT data is publicly available for download from its
[website](https://www.pandemicpact.org/) and from
[Figshare](https://portal.sds.ox.ac.uk/pandemicpact). This package
provides an application programming interface (API) to the research
programme’s [Figshare](https://portal.sds.ox.ac.uk/pandemicpact)
repository to provide programmatic access to its publicly available
tracker data along with it’s other data products.

## What does `{pactr}` do?

`{pactr}` provides functions to interface with Pandemic PACT’s
[Figshare](https://portal.sds.ox.ac.uk/pandemicpact) repository for
programmatic access to its contents. These functions are wrappers to
specific functions of the [`{deposits}`
package](https://docs.ropensci.org/deposits/index.html) which provides
the underlying universal interface to various online research data
deposition services including Figshare. Current Figshare-specific
functionalities available in `{pactr}` are:

1.  Listing of outputs/assets available from the Panedmic PACT Figshare
    repository;

2.  Download of outputs/assets available from the Pandemic PACT Figshare
    repository; and,

3.  Reading of dataset outputs/assets available from the Pandemic PACT
    Figshare repository.

## Installation

`{pactr}` is not yet on CRAN but can be installed through the [Oxford
IHTM r-universe](https://oxfordihtm.r-universe.dev) with:

``` r
install.packages(
  "pactr",
  repos = c("https://oxfordihtm.r-universe.dev", "https://cloud.r-project.org")
)
```

Alternatively, `{pactr}` can be installed directly from
[GitHub](https://github.com/OxfordIHTM/pactr) using the `{remotes}`
package with the following command:

``` r
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("OxfordIHTM/pactr")
```

`pactr` can then be loaded for use with:

``` r
library(pactr)
```

## Usage

### 1\. List outputs/assets

To list available outputs/assets from the Pandemic PACT Figshare
repository, issue the following command:

``` r
pact_list()
```

The output is a `data.frame` containing metadata regarding contents of
the Figshare Pandemic PACT group. The information within the metadata
are those provided by [Figshare’s application programming interface
(API)](https://docs.figshare.com/) and are either set by the Pandemic
PACT data team or by Figshare. The data.frame would have the following
fields:

    #>  [1] "project_id"        "id"                "title"            
    #>  [4] "doi"               "handle"            "url"              
    #>  [7] "published_date"    "thumb"             "defined_type"     
    #> [10] "defined_type_name" "group_id"          "url_private_api"  
    #> [13] "url_public_api"    "url_private_html"  "url_public_html"  
    #> [16] "timeline"          "resource_title"    "resource_doi"

This function is useful in getting an overview of what is currently
available in the Pandemic PACT Figshare repository.

### 2\. Download outputs/assets

To download a specific output/asset - say the scoping review data - from
the Pandemic PACT Figshare repository, issue the following commands:

``` r
## Get the unique identifier for the scoping review data from Figshare ----
file_id <- pact_list() |>
  subset(title == "Scoping Review Data", select = id) |>
  unlist()

pact_download(id = file_id, path = ".")
```

This will download the file `Scoping_Review-Data.xlsx` from the Pandemic
PACT Figshare repository into the current working directory.

### 3\. Read the Pandemic PACT tracker dataset and data dictionary

To read the Pandemic PACT tracker dataset into R, issue the following
command:

``` r
pact_read_data_tracker()
```

which outputs a data.frame with 4637 records and 860 fields.

    #> 'data.frame':    4637 obs. of  860 variables:
    #>  $ PactID                                                                                                                                       : chr  "C00153" "C00154" "C00155" "C00156" ...
    #>  $ Grant.Number                                                                                                                                 : chr  "unknown" "unknown" "unknown" "unknown" ...
    #>  $ Grant.Title.Original                                                                                                                         : chr  "Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand" "African COVID-19 Preparedness (AFRICO19)" "COVID-19 Intervention Modelling for East Africa  (CIMEA)" "The African coaLition for Epidemic Research, Response and Training, Clinical Characterization Protocol (ALERRT CCP)" ...
    #>  $ Grant.Title.Eng                                                                                                                              : chr  "Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand" "African COVID-19 Preparedness (AFRICO19)" "COVID-19 Intervention Modelling for East Africa  (CIMEA)" "The African coaLition for Epidemic Research, Response and Training, Clinical Characterization Protocol (ALERRT CCP)" ...
    #>  $ Award.Amount.Converted                                                                                                                       : num  1043108 2462448 1699974 1742202 2484600 ...
    #>  $ Abstract.Eng                                                                                                                                 : chr  "We propose a prospective serological study to investigate the incidence of SARS-CoV-2 infection in the general "| __truncated__ "Our project, AFRICO19, will enhance capacity to understand SARS-CoV-2/hCoV-19 infection in three regions of Afr"| __truncated__ "COVID-19 is a global threat to health, with many countries reporting extended outbreaks. To date 9 countries in"| __truncated__ "As part of the response to the emergence of COVID-19, the World Health Organization Africa Regional Office is o"| __truncated__ ...
    #>  $ Laysummary                                                                                                                                   : chr  "" "" "" "" ...
    #>  $ ODA.funding.used                                                                                                                             : chr  "Pending" "Pending" "Pending" "Pending" ...
    #>  $ Grant.Type                                                                                                                                   : chr  "Pending" "New Grant" "Pending" "Pending" ...
    #>  $ Grant.Start.Year                                                                                                                             : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
    #>  $ Study.Subject..choice.Animals.                                                                                                               : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Bacteria.                                                                                                              : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Human.Populations.                                                                                                     : chr  "Checked" "Checked" "Checked" "Checked" ...
    #>  $ Study.Subject..choice.Disease.Vectors.                                                                                                       : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Viruses.                                                                                                               : chr  "Unchecked" "Checked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Environment.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Other.                                                                                                                 : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Unspecified.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Subject..choice.Not.applicable.                                                                                                        : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ If..Study.Subject..Please.Specific.                                                                                                          : chr  "" "" "" "" ...
    #>  $ Ethnicity..choice.Asian.                                                                                                                     : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Ethnicity..choice.Black.                                                                                                                     : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Ethnicity..choice.White.                                                                                                                     : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Ethnicity..choice.Mixed.                                                                                                                     : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Ethnicity..choice.Other.                                                                                                                     : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Ethnicity..choice.Unspecified.                                                                                                               : chr  "Checked" "Checked" "Checked" "Checked" ...
    #>  $ Ethnicity..choice.Not.applicable.                                                                                                            : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ If..Other.Ethnicity..Please.Specific.                                                                                                        : chr  "" "" "" "" ...
    #>  $ Age.Groups..choice.Adolescent..em..font.color.blue..13.years.to.17.years...font...em..                                                       : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Adults..em..font.color.blue..18.and.older...font...em..                                                                   : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Children..em..font.color.blue..1.year.to.12.years...font...em..                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Infants..em..font.color.blue..1.month.to.1.year...font...em..                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Newborns..em..font.color.blue..birth.to.1.month...font...em..                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Older.adults..em..font.color.blue..65.and.older...font...em..                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Other.                                                                                                                    : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Age.Groups..choice.Unspecified.                                                                                                              : chr  "Checked" "Checked" "Checked" "Checked" ...
    #>  $ Age.Groups..choice.Not.Applicable.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ If..Other.AgeGroups..Please.Specific.                                                                                                        : chr  "" "" "" "" ...
    #>  $ Rurality..choice.Rural.Population.Setting.                                                                                                   : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Rurality..choice.Suburban.Population.Setting.                                                                                                : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Rurality..choice.Urban.Population.Setting.                                                                                                   : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Rurality..choice.Other.                                                                                                                      : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Rurality..choice.Unspecified.                                                                                                                : chr  "Checked" "Checked" "Checked" "Unchecked" ...
    #>  $ Rurality..choice.Not.applicable.                                                                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ If..Other.Rurality..Please.Specific.                                                                                                         : chr  "" "" "" "" ...
    #>  $ Vulnerable.Population..choice.Disabled.persons.                                                                                              : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Drug.users.                                                                                                    : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Internally.Displaced.and.Migrants.                                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Indigenous.People.                                                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Sexual.and.gender.minorities.                                                                                  : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Prisoners.                                                                                                     : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Sex.workers.                                                                                                   : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Smokers.                                                                                                       : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Women.                                                                                                         : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Pregnant.women.                                                                                                : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Individuals.with.multimorbidity.                                                                               : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Minority.communities.unspecified.                                                                              : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Vulnerable.populations.unspecified.                                                                            : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Other.                                                                                                         : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Vulnerable.Population..choice.Unspecified.                                                                                                   : chr  "Checked" "Checked" "Checked" "Checked" ...
    #>  $ Vulnerable.Population..choice.Not.applicable.                                                                                                : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ If..Other.Vulnerable.Population..Please.Specific.                                                                                            : chr  "" "" "" "" ...
    #>  $ Occupational.Groups..choice.Farmers.                                                                                                         : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Emergency.Responders.                                                                                            : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Military.Personnel.                                                                                              : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Social.Workers.                                                                                                  : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Caregivers.                                                                                                      : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Health.Personnel.                                                                                                : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Hospital.personnel.                                                                                              : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Nurses.and.Nursing.Staff.                                                                                        : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Physicians.                                                                                                      : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Dentists.and.dental.staff.                                                                                       : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Veterinarians.                                                                                                   : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Volunteers.                                                                                                      : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Other.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Occupational.Groups..choice.Unspecified.                                                                                                     : chr  "Checked" "Checked" "Checked" "Checked" ...
    #>  $ Occupational.Groups..choice.Not.applicable.                                                                                                  : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ If..Other.OccupationalGroups..Please.Specific.                                                                                               : chr  "" "" "" "" ...
    #>  $ Study.Type..choice.Biological.Specimen.Banks.                                                                                                : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Case.Reports.                                                                                                             : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Clinical.Conference.                                                                                                      : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Clinical.Study.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Clinical.Trial.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Comparative.Study.                                                                                                        : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Consensus.Development.Conference.                                                                                         : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Evaluation.Study.                                                                                                         : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Laboratory.work.                                                                                                          : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Meta.Analysis.                                                                                                            : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Observational.Study.                                                                                                      : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Policy.report.                                                                                                            : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Review.                                                                                                                   : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Secondary.Data.Analysis.                                                                                                  : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Study..design.unspecified.                                                                                                : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Systematic.Review.                                                                                                        : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Validation.Study.                                                                                                         : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Other.                                                                                                                    : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Unspecified.                                                                                                              : chr  "Checked" "Checked" "Checked" "Checked" ...
    #>  $ Study.Type..choice.Not.applicable.                                                                                                           : chr  "Unchecked" "Unchecked" "Unchecked" "Unchecked" ...
    #>  $ Study.Type..choice.Clinical.                                                                                                                 : chr  "Unchecked" "Checked" "Unchecked" "Unchecked" ...
    #>   [list output truncated]

This function reads the *labelled* tracker dataset by default. If the
raw dataset is required, then issue the following command:

``` r
pact_read_data_tracker(tracker_type = "raw")
```

which outputs a data.frame with 4638 records and 860 fields.

    #> 'data.frame':    4638 obs. of  860 variables:
    #>  $ pactid                                     : chr  "SDS001" "C00153" "C00154" "C00155" ...
    #>  $ grant_number                               : chr  "unknown" "unknown" "unknown" "unknown" ...
    #>  $ grant_title_original                       : chr  "Dummy record" "Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand" "African COVID-19 Preparedness (AFRICO19)" "COVID-19 Intervention Modelling for East Africa  (CIMEA)" ...
    #>  $ grant_title_eng                            : chr  "Dummy record" "Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand" "African COVID-19 Preparedness (AFRICO19)" "COVID-19 Intervention Modelling for East Africa  (CIMEA)" ...
    #>  $ award_amount_converted                     : num  1234567 1043108 2462448 1699974 1742202 ...
    #>  $ abstract                                   : chr  "A dummy record to simulate a version update" "We propose a prospective serological study to investigate the incidence of SARS-CoV-2 infection in the general "| __truncated__ "Our project, AFRICO19, will enhance capacity to understand SARS-CoV-2/hCoV-19 infection in three regions of Afr"| __truncated__ "COVID-19 is a global threat to health, with many countries reporting extended outbreaks. To date 9 countries in"| __truncated__ ...
    #>  $ laysummary                                 : chr  "N/A" "" "" "" ...
    #>  $ oda_funding_used                           : int  -77 -77 -77 -77 -77 -77 -77 -77 -77 -77 ...
    #>  $ grant_type                                 : int  -77 -77 1 -77 -77 -77 1 1 -77 -77 ...
    #>  $ grant_start_year                           : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
    #>  $ study_subject___1                          : int  0 0 0 0 0 0 0 1 0 0 ...
    #>  $ study_subject___2                          : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_subject___3                          : int  1 1 1 1 1 1 1 1 1 1 ...
    #>  $ study_subject___4                          : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_subject___5                          : int  0 0 1 0 0 0 0 0 0 0 ...
    #>  $ study_subject___6                          : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_subject____88                        : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_subject____99                        : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_subject____9999                      : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_subject_other                        : chr  "" "" "" "" ...
    #>  $ ethnicity___1                              : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ ethnicity___2                              : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ ethnicity___3                              : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ ethnicity___4                              : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ ethnicity____88                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ ethnicity____99                            : int  1 1 1 1 1 1 1 1 1 1 ...
    #>  $ ethnicity____9999                          : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ ethnicity_other                            : chr  "" "" "" "" ...
    #>  $ age_groups___1                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ age_groups___2                             : int  0 0 0 0 0 0 1 0 1 0 ...
    #>  $ age_groups___5                             : int  0 0 0 0 0 0 1 0 0 0 ...
    #>  $ age_groups___6                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ age_groups___7                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ age_groups___3                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ age_groups____88                           : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ age_groups____99                           : int  1 1 1 1 1 1 0 1 0 1 ...
    #>  $ age_groups____9999                         : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ agegroups_other                            : chr  "" "" "" "" ...
    #>  $ rurality___1                               : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ rurality___2                               : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ rurality___3                               : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ rurality____88                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ rurality____99                             : int  1 1 1 1 0 1 1 1 0 1 ...
    #>  $ rurality____9999                           : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ rurality_other                             : chr  "" "" "" "" ...
    #>  $ vulnerable_population___1                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___2                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___3                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___4                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___5                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___6                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___7                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___8                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___9                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___10                 : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___13                 : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___11                 : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population___12                 : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population____88                : int  0 0 0 0 0 1 0 0 0 0 ...
    #>  $ vulnerable_population____99                : int  1 1 1 1 1 0 1 1 1 1 ...
    #>  $ vulnerable_population____9999              : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ vulnerable_population_other                : chr  "" "" "" "" ...
    #>  $ occupational_groups___1                    : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups___2                    : int  0 0 0 0 0 0 0 0 1 0 ...
    #>  $ occupational_groups___3                    : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups___4                    : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups___5                    : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups___6                    : int  0 0 0 0 0 0 0 0 1 0 ...
    #>  $ occupational_groups___7                    : int  0 0 0 0 0 0 0 0 1 0 ...
    #>  $ occupational_groups___8                    : int  0 0 0 0 0 0 0 0 1 0 ...
    #>  $ occupational_groups___9                    : int  0 0 0 0 0 0 0 0 1 0 ...
    #>  $ occupational_groups___10                   : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups___11                   : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups___12                   : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups____88                  : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupational_groups____99                  : int  1 1 1 1 1 1 1 1 0 1 ...
    #>  $ occupational_groups____9999                : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ occupationalgroups_other                   : chr  "" "" "" "" ...
    #>  $ study_type___1                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___2                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___3                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___4                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___5                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___6                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___7                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___8                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___9                             : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___10                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___11                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___12                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___13                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___14                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___15                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___16                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type___17                            : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type____88                           : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type____99                           : int  1 1 1 1 1 1 1 1 1 1 ...
    #>  $ study_type____9999                         : int  0 0 0 0 0 0 0 0 0 0 ...
    #>  $ study_type_main___5                        : int  0 0 1 0 0 1 1 0 0 1 ...
    #>   [list output truncated]

## Citation

To cite the `{pactr}` package, please use the suggested citation
provided by a call to the `citation()` function as follows:

``` r
citation("pactr")
#> To cite pactr in publications use:
#> 
#>   Ernest Guevarra (2024). _pactr: An Interface to the Pandemic PACT
#>   Repository_. R package version 0.0.9000,
#>   <https://oxford-ihtm.io/pactr/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {pactr: An Interface to the Pandemic PACT Repository},
#>     author = {{Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.0.9000},
#>     url = {https://oxford-ihtm.io/pactr/},
#>   }
```

To cite the Pandemic PACT Tracker dataset, please use the suggested
citation provided by a call to the `pact_cite()` function as follows:

``` r
pact_cite(id = 24763548)  ## cite the labelled version of the tracker dataset
#> To cite Pandemic PACT Grant Tracker (labelled) in publications use:
#> 
#>   Pandemic PACT team (2023). "Pandemic PACT Grant Tracker (labelled).
#>   dataset version 1." doi:10.25446/oxford.24763548.v1
#>   <https://doi.org/10.25446/oxford.24763548.v1>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{,
#>     title = {Pandemic PACT Grant Tracker (labelled). dataset version 1},
#>     author = {{Pandemic PACT team}},
#>     year = {2023},
#>     doi = {10.25446/oxford.24763548.v1},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/pactr/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://oxford-ihtm.io/pactr/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://oxford-ihtm/pactr/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.