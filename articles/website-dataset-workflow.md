# Website dataset workflow

The Pandemic PACT data is publicly available for download from its
[website](https://www.pandemicpact.org/).
[pactr](https://github.com/OxfordIHTM/pactr) provides an application
programming interface (API) to the research programme’s dataset
available from its website data download facility allowing for
programmatic access to its publicly available funder tracker dataset.

## Website data interface

The functions for interfacing with the data available from the Pandemic
PACT website allow for *downloading*, *reading*, and *processing*.
Current website data-specific functionalities available in
[pactr](https://github.com/OxfordIHTM/pactr) are:

1.  Downloading of Pandemic PACT dataset available from the website
    (*stable*);

2.  Reading of Pandemic PACT dataset available from the website
    (*stable*); and,

3.  Processing of Pandemic PACT dataset available from the website
    (*experimental*).

## Website data workflow

### Download data available from website

To download the Pandemic PACT tracker dataset available from its
website, the following command can be used:

``` r

## Save the dataset from website to a temporary directory ----
pact_download_website(path = tempdir())
```

which will return the path to the downloaded dataset:

    #> [1] "/tmp/RtmpcEw5vk/pandemic-pact-grants.csv"

### Read the Pandemic PACT tracker dataset from the website

Instead of downloading, the Pandemic PACT dataset available from its
website can be read into R directly as follows:

``` r

pact_read_website()
```

which results in the following:

    #> Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, : URL
    #> 'https://www.pandemicpact.org/export/grants/pandemic-pact-grants.csv': Timeout of 60 seconds
    #> was reached
    #> Error in `scan()`:
    #> ! cannot read from connection
    #> # A tibble: 29,583 × 50
    #>    GrantID PubMedGrantId         OutbreakIds GrantTitleOriginal GrantTitleEng AbstractOriginal
    #>    <chr>   <chr>                 <lgl>       <chr>              <chr>         <chr>           
    #>  1 C00018  unknown               NA          "Mathematical mod… "Mathematica… "Mathematical m…
    #>  2 C00019  CCP-nCoV              NA          "Cohort follow-up… "Cohort foll… "Cohort follow-…
    #>  3 C00020  THERAMAB              NA          "Identification a… "Identificat… "Identification…
    #>  4 C00021  None                  NA          "Using social sci… "Using socia… "Using social s…
    #>  5 C00022  CoV-CONTACT           NA          "Follow-up of sub… "Follow-up o… "Follow-up of s…
    #>  6 C00023  Réplicon              NA          "Development of a… "Development… "Development of…
    #>  7 C00024  A Toolbox for SARS-C… NA          "Potentiating exi… "Potentiatin… "Potentiating e…
    #>  8 C00025  NHP Model             NA          "Establishment of… "Establishme… "Establishment …
    #>  9 C00026  SARS-CoV2-LIPS        NA          "Antibody profili… "Antibody pr… "Antibody profi…
    #> 10 C00027  SARS-CoV-2_EVOLSERO   NA          "Evolution of SAR… "Evolution o… "Evolution of S…
    #> # ℹ 29,573 more rows
    #> # ℹ 44 more variables: Abstract <chr>, GrantStartYear <int>, PublicationYearOfAward <int>,
    #> #   GrantEndYear <chr>, ResearchInstitutionName <chr>, HundredDaysMissionFlag <int>,
    #> #   GrantAmountConverted <dbl>, StudySubject <chr>, Ethnicity <chr>, AgeGroups <chr>,
    #> #   Rurality <chr>, VulnerablePopulations <chr>, OccupationalGroups <chr>, StudyType <chr>,
    #> #   ClinicalTrial <chr>, Families <chr>, FundingOrgName <chr>, FunderCountry <chr>,
    #> #   FunderRegion <chr>, ResearchInstitutionRegion <chr>, ResearchLocationRegion <chr>, …

### Process the Pandemic PACT tracker dataset from the website

The package includes functions that will process the Pandemic PACT
tracker dataset into specific structures and aggregations that will
allow for further plotting and reporting of similar outputs that are
currently presented in the Pandemic PACT website.

For example, the following will process the Pandemic PACT tracker
dataset into an aggregated dataset structure that can be used to create
a similar plot to the one presented in the
[website](https://www.pandemicpact.org/visualise#disease).

``` r

pact_read_website() |>
  pact_process_website() |>
  pact_process_topic_group(topic = "Diseases", group = "GrantStartYear")
```

which produces the following output:

    #> # A tibble: 237 × 5
    #>    GrantStartYear Diseases                      n_grants n_grants_specified grant_amount_total
    #>             <int> <chr>                            <int>              <int>              <dbl>
    #>  1           2020 Bacterial infection caused b…       62                 62          30158411.
    #>  2           2020 COVID-19                         12507               9681       13000159989.
    #>  3           2020 Chikungunya haemorrhagic fev…       53                 53          41394597.
    #>  4           2020 Cholera                             42                 42          30913343.
    #>  5           2020 Congenital infection caused …       21                 20           9896921.
    #>  6           2020 Crimean-Congo haemorrhagic f…       39                 39          27760800.
    #>  7           2020 Dengue                             145                145         113728877.
    #>  8           2020 Disease X                          180                176         408947570.
    #>  9           2020 Disorder caused by Venezuela…       12                 12           6696306 
    #> 10           2020 Ebola                              127                124          78097439.
    #> # ℹ 227 more rows
