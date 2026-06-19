# pactr: An Interface to the Pandemic PACT Data Repository

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
provides an application programming interface (API) to both the research
programme’s Figshare repository and website data download facility to
provide programmatic access to its publicly available tracker data along
with its other data products.

## What does `{pactr}` do?

[pactr](https://github.com/OxfordIHTM/pactr) provides functions to
interface programmatically with Pandemic PACT’s data products either
through its Figshare repository or its website.

The functions for Figshare interface are wrappers to specific functions
of the [`{deposits}`
package](https://docs.ropensci.org/deposits/index.html) which provides
the underlying universal interface to various online research data
deposition services including Figshare. Current Figshare-specific
functionalities available in
[pactr](https://github.com/OxfordIHTM/pactr) are:

1.  Listing of outputs/assets available from the Pandemic PACT Figshare
    repository (*experimental*);

2.  Downloading of outputs/assets available from the Pandemic PACT
    Figshare repository (*experimental*);

3.  Reading of dataset outputs/assets available from the Pandemic PACT
    Figshare repository (*experimental*); and,

4.  Processing of Pandemic PACT data (*experimental*).

The functions for interfacing with the data available from the Pandemic
PACT website allow for downloading, reading, and processing. Current
website data-specific functionalities available in
[pactr](https://github.com/OxfordIHTM/pactr) are:

1.  Downloading of Pandemic PACT dataset available from the website
    (*stable*);

2.  Reading of Pandemic PACT dataset available from the website
    (*stable*); and,

3.  Processing of Pandemic PACT dataset available from the website
    (*experimental*).

## Motivation

The main motivation for the development of
[pactr](https://github.com/OxfordIHTM/pactr) is to create a standardised
programmatic interface to Pandemic PACT’s data for those performing
research or investigation relevant to Pandemic PACT’s objectives.
Standardised programmatic interface, in turn, allow for reproducible
scientific workflows based on the Pandemic PACT dataset.

## Installation

[pactr](https://github.com/OxfordIHTM/pactr) is not yet on
[CRAN](https://cran.r-project.org) but can be installed through the
[Oxford iHealth R Universe](https://oxfordihtm.r-universe.dev) with:

``` r

install.packages(
  "pactr",
  repos = c("https://oxfordihtm.r-universe.dev", "https://cloud.r-project.org")
)
```

## Usage - Figshare workflow

### Set a Figshare client

The [pactr](https://github.com/OxfordIHTM/pactr) Figshare workflow
always starts with the setting up of a Figshare client. This requires
creating a Figshare account and then creating a personal access token
[here](https://figshare.com/account/applications).

Once a Figshare token is created, it needs to be stored as a local
environment variable. This can be done using the following command in R:

``` r

Sys.setenv("FIGSHARE_TOKEN"="YOUR_TOKEN_HERE")
```

Once this token has been set as described above, the following command
can be run to setup a Figshare client:

``` r

pact_client <- pact_client_set()
```

Once a Figshare client has been setup, you can now perform the
functionalities provided by the
[pactr](https://github.com/OxfordIHTM/pactr) package.

### List outputs/assets

To list available outputs/assets from the Pandemic PACT Figshare
repository, issue the following command:

``` r

pact_figshare_list(pact_client)
```

The output is a `data.frame` containing metadata regarding contents of
the Figshare Pandemic PACT group. The information within the metadata
are those provided by [Figshare’s application programming interface
(API)](https://docs.figshare.com/) and are either set by the Pandemic
PACT data team or by Figshare. The data.frame would look as follows:

``` R
#> # A tibble: 133 × 12
#>    deposit_id       id name          size is_link_only download_url supplied_md5
#>         <int>    <int> <chr>        <int> <lgl>        <chr>        <chr>       
#>  1   26937448 49007725 PandemicPA… 4.74e4 FALSE        https://ndo… 2cca47b50c0…
#>  2   26937448 49007743 Mpox - Map… 1.15e4 FALSE        https://ndo… 99c03bed91c…
#>  3   26937448 49007755 research-c… 6.86e3 FALSE        https://ndo… b3d92f5954d…
#>  4   26937448 49506642 PandemicPA… 4.88e4 FALSE        https://ndo… a6b309ee2c8…
#>  5   26937448 49550799 PandemicPA… 7.07e7 FALSE        https://ndo… a139502ed97…
#>  6   26937448 51875285 PandemicPA… 5.08e4 FALSE        https://ndo… 7d7b44270ca…
#>  7   26937448 52153913 PandemicPA… 5.27e4 FALSE        https://ndo… 30f52675091…
#>  8   26937448 52661744 PandemicPA… 6.92e4 FALSE        https://ndo… f90b7282611…
#>  9   26937448 53222348 PandemicPA… 6.97e4 FALSE        https://ndo… 78cde9c0779…
#> 10   26937448 54135791 Covid_Gran… 1.61e4 FALSE        https://ndo… 8db01bd6c13…
#> # ℹ 123 more rows
#> # ℹ 5 more variables: computed_md5 <chr>, mimetype <chr>, group_id <int>,
#> #   project_id <int>, title <chr>
```

This function is useful in getting an overview of what is currently
available in the Pandemic PACT Figshare repository.

### Download outputs/assets

To download a specific output/asset - say the scoping review data - from
the Pandemic PACT Figshare repository, issue the following commands:

``` r

## Get the unique identifier for the scoping review data from Figshare ----
file_id <- pact_list(pact_client) |>
  subset(title == "Scoping Review Data", select = id) |>
  unlist()

pact_download_figshare(id = file_id, path = ".")
```

This will download the file `Scoping_Review-Data.xlsx` from the Pandemic
PACT Figshare repository into the current working directory.

### Read the Pandemic PACT tracker dataset and data dictionary

To read the Pandemic PACT tracker dataset into R, issue the following
command:

``` r

pact_read_figshare(pact_client)
```

which outputs a data.frame with 4637 records and 860 fields.

``` R
#> # A tibble: 4,637 × 860
#>    PactID Grant.Number Grant.Title.Original                      Grant.Title.Eng
#>    <chr>  <chr>        <chr>                                     <chr>          
#>  1 C00153 unknown      Serological studies to quantify SARS-CoV… "Serological s…
#>  2 C00154 unknown      African COVID-19 Preparedness (AFRICO19)  "African COVID…
#>  3 C00155 unknown      COVID-19 Intervention Modelling for East… "COVID-19 Inte…
#>  4 C00156 unknown      The African coaLition for Epidemic Resea… "The African c…
#>  5 C00157 unknown      Characterization of SARS-CoV-2 transmiss… "Characterizat…
#>  6 C00158 unknown      Investigation of pre-existing immunity t… "Investigation…
#>  7 C00159 unknown      A comprehensive study of immunopathogene… ""             
#>  8 C00160 MC_PC_19012  Centre for Global Infectious Disease Ana… "Centre for Gl…
#>  9 C00161 MC_PC_19025  ISARIC - Coronavirus Clinical Characteri… "ISARIC - Coro…
#> 10 C00162 MC_PC_19026  MRC Centre for Virus Research (MRC CVR) … "MRC Centre fo…
#> # ℹ 4,627 more rows
#> # ℹ 856 more variables: Award.Amount.Converted <dbl>, Abstract.Eng <chr>,
#> #   Laysummary <chr>, ODA.funding.used <chr>, Grant.Type <chr>,
#> #   Grant.Start.Year <int>, Study.Subject..choice.Animals. <chr>,
#> #   Study.Subject..choice.Bacteria. <chr>,
#> #   Study.Subject..choice.Human.Populations. <chr>,
#> #   Study.Subject..choice.Disease.Vectors. <chr>, …
```

This function reads the *labelled* tracker dataset by default. If the
raw dataset is required, then issue the following command:

``` r

pact_read_figshare(pact_client, tracker_type = "raw")
```

which outputs a data.frame with 4638 records and 860 fields.

``` R
#> # A tibble: 4,638 × 860
#>    pactid grant_number grant_title_original                      grant_title_eng
#>    <chr>  <chr>        <chr>                                     <chr>          
#>  1 SDS001 unknown      Dummy record                              "Dummy record" 
#>  2 C00153 unknown      Serological studies to quantify SARS-CoV… "Serological s…
#>  3 C00154 unknown      African COVID-19 Preparedness (AFRICO19)  "African COVID…
#>  4 C00155 unknown      COVID-19 Intervention Modelling for East… "COVID-19 Inte…
#>  5 C00156 unknown      The African coaLition for Epidemic Resea… "The African c…
#>  6 C00157 unknown      Characterization of SARS-CoV-2 transmiss… "Characterizat…
#>  7 C00158 unknown      Investigation of pre-existing immunity t… "Investigation…
#>  8 C00159 unknown      A comprehensive study of immunopathogene… ""             
#>  9 C00160 MC_PC_19012  Centre for Global Infectious Disease Ana… "Centre for Gl…
#> 10 C00161 MC_PC_19025  ISARIC - Coronavirus Clinical Characteri… "ISARIC - Coro…
#> # ℹ 4,628 more rows
#> # ℹ 856 more variables: award_amount_converted <dbl>, abstract <chr>,
#> #   laysummary <chr>, oda_funding_used <int>, grant_type <int>,
#> #   grant_start_year <int>, study_subject___1 <int>, study_subject___2 <int>,
#> #   study_subject___3 <int>, study_subject___4 <int>, study_subject___5 <int>,
#> #   study_subject___6 <int>, study_subject____88 <int>,
#> #   study_subject____99 <int>, study_subject____9999 <int>, …
```

### Process the Pandemic PACT tracker dataset

``` r

pact_read_figshare(pact_client) |>
  pact_process_figshare()
```

``` R
#> # A tibble: 4,637 × 37
#>    PactID Grant.Number Grant.Title.Original                      Grant.Title.Eng
#>    <chr>  <chr>        <chr>                                     <chr>          
#>  1 C00153 unknown      Serological studies to quantify SARS-CoV… "Serological s…
#>  2 C00154 unknown      African COVID-19 Preparedness (AFRICO19)  "African COVID…
#>  3 C00155 unknown      COVID-19 Intervention Modelling for East… "COVID-19 Inte…
#>  4 C00156 unknown      The African coaLition for Epidemic Resea… "The African c…
#>  5 C00157 unknown      Characterization of SARS-CoV-2 transmiss… "Characterizat…
#>  6 C00158 unknown      Investigation of pre-existing immunity t… "Investigation…
#>  7 C00159 unknown      A comprehensive study of immunopathogene… ""             
#>  8 C00160 MC_PC_19012  Centre for Global Infectious Disease Ana… "Centre for Gl…
#>  9 C00161 MC_PC_19025  ISARIC - Coronavirus Clinical Characteri… "ISARIC - Coro…
#> 10 C00162 MC_PC_19026  MRC Centre for Virus Research (MRC CVR) … "MRC Centre fo…
#> # ℹ 4,627 more rows
#> # ℹ 33 more variables: Award.Amount.Converted <dbl>, Abstract.Eng <chr>,
#> #   Laysummary <chr>, ODA.funding.used <chr>, Grant.Type <chr>,
#> #   Grant.Start.Year <int>, Study.Subject <list>, Ethnicity <list>,
#> #   Age.Groups <list>, Rurality <list>, Vulnerable.Population <list>,
#> #   Occupational.Groups <list>, Study.Type <list>, Clinical.Trial <list>,
#> #   report <chr>, Pathogen <list>, Pathogen.Specific <list>, Disease <list>, …
```

For a more detailed discussion of the usage and limitations of the
[pactr](https://github.com/OxfordIHTM/pactr) Figshare functions, see
this
[vignette](https://oxford-ihtm.io/pactr/articles/figshare-workflow.html).

## Usage - website data workflow

### Download the Pandemic PACT tracker dataset from the website

To download the Pandemic PACT tracker dataset available from its
website, the following command can be used:

``` r

## Save the dataset from website to a temporary directory ----
pact_download_website(path = tempdir())
```

which will return the path to the downloaded dataset:

``` R
#> [1] "/tmp/RtmpqWKUwZ/pandemic-pact-grants.csv"
```

### Read the Pandemic PACT tracker dataset from the website

Instead of downloading, the Pandemic PACT dataset available from its
website can be read into R directly as follows:

``` r

pact_read_website()
```

which results in the following:

``` R
#> # A tibble: 29,583 × 50
#>    GrantID PubMedGrantId            OutbreakIds GrantTitleOriginal GrantTitleEng
#>    <chr>   <chr>                    <lgl>       <chr>              <chr>        
#>  1 C00018  unknown                  NA          "Mathematical mod… "Mathematica…
#>  2 C00019  CCP-nCoV                 NA          "Cohort follow-up… "Cohort foll…
#>  3 C00020  THERAMAB                 NA          "Identification a… "Identificat…
#>  4 C00021  None                     NA          "Using social sci… "Using socia…
#>  5 C00022  CoV-CONTACT              NA          "Follow-up of sub… "Follow-up o…
#>  6 C00023  Réplicon                 NA          "Development of a… "Development…
#>  7 C00024  A Toolbox for SARS-CoV-… NA          "Potentiating exi… "Potentiatin…
#>  8 C00025  NHP Model                NA          "Establishment of… "Establishme…
#>  9 C00026  SARS-CoV2-LIPS           NA          "Antibody profili… "Antibody pr…
#> 10 C00027  SARS-CoV-2_EVOLSERO      NA          "Evolution of SAR… "Evolution o…
#> # ℹ 29,573 more rows
#> # ℹ 45 more variables: AbstractOriginal <chr>, Abstract <chr>,
#> #   GrantStartYear <int>, PublicationYearOfAward <int>, GrantEndYear <chr>,
#> #   ResearchInstitutionName <chr>, HundredDaysMissionFlag <int>,
#> #   GrantAmountConverted <dbl>, StudySubject <chr>, Ethnicity <chr>,
#> #   AgeGroups <chr>, Rurality <chr>, VulnerablePopulations <chr>,
#> #   OccupationalGroups <chr>, StudyType <chr>, ClinicalTrial <chr>, …
```

### Process the Pandemic PACT tracker dataset from the website

The package includes functions that will process the Pandemic PACT
tracker dataset into specific structures and aggregations that will
allow for further plotting and reporting of similar outputs that are
currently presented in the Pandemic PACT website.

For example, the following will process the Pandemic PACT tracker
dataset into an aggregated dataset structure that can be used to create
a similar plot to the one presented in the
[website](https://www.pandemicimpact.org/visualise#disease).

``` r

pact_read_website() |>
  pact_process_website() |>
  pact_table_topic_group(topic = "Diseases", group = "GrantStartYear")
```

which produces the following output:

``` R
#> # A tibble: 237 × 5
#>    GrantStartYear Diseases        n_grants n_grants_specified grant_amount_total
#>             <int> <chr>              <int>              <int>              <dbl>
#>  1           2020 Bacterial infe…       62                 62          30158411.
#>  2           2020 COVID-19           12507               9681       13000159989.
#>  3           2020 Chikungunya ha…       53                 53          41394597.
#>  4           2020 Cholera               42                 42          30913343.
#>  5           2020 Congenital inf…       21                 20           9896921.
#>  6           2020 Crimean-Congo …       39                 39          27760800.
#>  7           2020 Dengue               145                145         113728877.
#>  8           2020 Disease X            180                176         408947570.
#>  9           2020 Disorder cause…       12                 12           6696306 
#> 10           2020 Ebola                127                124          78097439.
#> # ℹ 227 more rows
```

which in turn can be plotted as follows:

![](reference/figures/README-usage-website-3c-1.png)

or alternatively:

![](reference/figures/README-usage-website-3d-1.png)

For a more detailed discussion of the usage and limitations of the
[pactr](https://github.com/OxfordIHTM/pactr) website dataset functions,
see this
[vignette](https://oxford-ihtm.io/pactr/articles/website-dataset-workflow.html).

## Citation

To cite the [pactr](https://github.com/OxfordIHTM/pactr) package, please
use the suggested citation provided by a call to the
[`citation()`](https://rdrr.io/r/utils/citation.html) function as
follows:

``` r

citation("pactr")
#> To cite pactr in publications use:
#> 
#>   Ernest Guevarra (2026). _pactr: An Interface to the Pandemic PACT
#>   Repository_. R package version 0.0.9009,
#>   <https://oxford-ihtm.io/pactr/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {pactr: An Interface to the Pandemic PACT Repository},
#>     author = {{Ernest Guevarra}},
#>     year = {2026},
#>     note = {R package version 0.0.9009},
#>     url = {https://oxford-ihtm.io/pactr/},
#>   }
```

To cite the Pandemic PACT Tracker dataset, please use the suggested
citation provided by a call to the
[`pact_cite()`](https://oxford-ihtm.io/pactr/reference/pact_cite.md)
function as follows:

``` r

## cite the labelled version of the tracker dataset
pact_cite(pact_client, id = 24763548)  
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

## Disclaimer

This project is an independent effort by [Oxford
iHealth](https://oxford-ihtm.io) in support of related analytics and
research using the Pandemic PACT dataset. This project is not recognised
by the Pandemic PACT project. Any issues or problems arising from using
the [pactr](https://github.com/OxfordIHTM/pactr) package or from
participating or contributing to the development of this project are the
responsibility of the authors and maintainers of this project and should
be addressed to them accordingly and not to the Pandemic PACT project.

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/OxfordIHTM/pactr/issues). If you
would like to contribute to the package, please see our [contributing
guidelines](https://oxford-ihtm.io/pactr/CONTRIBUTING.html).

This project is released with a [Contributor Code of
Conduct](https://oxford-ihtm/pactr/CODE_OF_CONDUCT.html). By
participating in this project you agree to abide by its terms.

If you are interested in [Oxford iHealth](https://oxford-ihtm.io)’s work
and would like to join the community or contribute to it’s various
projects, visit the [Oxford iHealth website](https://oxford-ihtm.io) and
its [community page](https://oxford-ihtm.io/community/) to learn more.

 

[![This is a project under the Oxford iHealth initiative of the MSc in
International Health and Tropical Medicine of the Nuffield Department of
Medicine, University of
Oxford](https://github.com/OxfordIHTM/ihealth-images/blob/main/ihealth/ihealth_footer.png?raw=true)](https://oxford-ihtm.io)
