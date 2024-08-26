
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

which outputs the following:

    #>   PactID Grant.Number
    #> 1 C00153      unknown
    #> 2 C00154      unknown
    #> 3 C00155      unknown
    #> 4 C00156      unknown
    #> 5 C00157      unknown
    #> 6 C00158      unknown
    #>                                                                                                                             Grant.Title.Original
    #> 1                                      Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand
    #> 2                                                                                                       African COVID-19 Preparedness (AFRICO19)
    #> 3                                                                                       COVID-19 Intervention Modelling for East Africa  (CIMEA)
    #> 4                            The African coaLition for Epidemic Research, Response and Training, Clinical Characterization Protocol (ALERRT CCP)
    #> 5 Characterization of SARS-CoV-2 transmission dynamics, clinical features and disease impact in South Africa, a setting with high HIV prevalence
    #> 6              Investigation of pre-existing immunity to coronaviruses; implications for immunopathology and pathophysiology of COVID-19 disease
    #>                                                                                                                                  Grant.Title.Eng
    #> 1                                      Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand
    #> 2                                                                                                       African COVID-19 Preparedness (AFRICO19)
    #> 3                                                                                       COVID-19 Intervention Modelling for East Africa  (CIMEA)
    #> 4                            The African coaLition for Epidemic Research, Response and Training, Clinical Characterization Protocol (ALERRT CCP)
    #> 5 Characterization of SARS-CoV-2 transmission dynamics, clinical features and disease impact in South Africa, a setting with high HIV prevalence
    #> 6              Investigation of pre-existing immunity to coronaviruses; implications for immunopathology and pathophysiology of COVID-19 disease
    #>   Award.Amount.Converted
    #> 1                1043108
    #> 2                2462448
    #> 3                1699974
    #> 4                1742202
    #> 5                2484600
    #> 6                1551892
    #>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Abstract.Eng
    #> 1                                                                                                                                                                                                                                                                                              We propose a prospective serological study to investigate the incidence of SARS-CoV-2 infection in the general population in three Asian settings: Singapore, Hong Kong and Thailand. The study will aim to measure the age-specific seroprevalence and incidence of SARS-CoV-2 infection at 3 time points, each 6 months apart. Age-specific incidence estimates will be applied to the census population to obtain numbers of infections in the population at each time point. These estimates will be compared with external data on COVID-19 hospitalisations and deaths in each setting, to calculate age-specific infection-hospitalisation and infection-fatality ratios. SARS-CoV-2 antibody kinetics will be defined by studying changes in antibody titres over time. Risk factors for infection will be studied by comparing SARS-CoV-2 seroconverters and non-seroconverters with respect to epidemiological exposures. This study will provide crucial information regarding population exposure and SARS-CoV-2 transmission dynamics, and will provide a complete picture of the relationship between clinically apparent and asymptomatic infections.
    #> 2 Our project, AFRICO19, will enhance capacity to understand SARS-CoV-2/hCoV-19 infection in three regions of Africa and globally. Building on existing infrastructures and collaborations we will create a network to share knowledge on next generation sequencing (NGS), including Oxford Nanopore Technology (MinION), coronavirus biology and COVID-19 disease control. Our consortium links three African sites combined with genomics and informatics support from the University of Glasgow to achieve the following key goals: 1. Support East and West African capacities for rapid diagnosis and sequencing of SARS-CoV-2 to help with contact tracing and quarantine measures. Novel diagnostic tools optimized for this virus will be deployed. An African COVID-19 case definition will be refined using machine learning for identification of SARS-CoV-2 infections. 2. Surveillance of SARS-CoV-2 will be performed in one cohort at each African site. This will use established cohorts to ensure that sampling begins quickly. A sampling plan optimized to detect initial moderate and severe cases followed by household contact tracing will be employed to obtain both mild to severe COVID-19 cases. 3. Provide improved understanding of SARS-CoV-2 biology/evolution using machine learning and novel bioinformatics analyses. Our results will be shared via a real-time analysis platform using the newly developed CoV-GLUE resource.
    #> 3     COVID-19 is a global threat to health, with many countries reporting extended outbreaks. To date 9 countries in Africa have recorded infection and it seems imminent that East Africa will have introductions and onward transmission. The SARS-CoV-2 virus (the aetiological agent of COVID-19) spreads rapidly (R0~2, serial interval about 1 week), and hence control will be difficult.  National plans for dealing with this public health emergency will benefit from predictions of the expected rate, distribution and extent of spread in countries throughout the region, and on the likely impact and feasibility of isolation and contact tracing interventions. We will support the emergency preparations through bespoke modelling, incorporating known demographic population structure, age-related contact patterns and existing mobile phone population movement data. In Uganda and Kenya we will collect epidemiological, genomic and behavioural data through health facility surveillance, household follow-up and contact studies to quantify uncertainties of SARS-CoV-2  virus epidemiology and contact patterns in well and unwell individuals. Results from the study will be rapidly communicated to the relevant authorities, and modelling code and analysis, and data including sequences, placed in the public domain in near real-time. This project could have lasting impact on the role of research in policy decisions.
    #> 4                                                                                                      As part of the response to the emergence of COVID-19, the World Health Organization Africa Regional Office is organizing various Infection Prevention and Control (IPC) and critical care training activities targeted at Low and Middle-Income countries (LMICs) in Africa. While the initiatives taken by WHO/AFRO are critical, training for research into the disease also needs to be targeted at the same LMICs, because being an Emerging Infectious Disease, we need to ??????learn-as-we-go?????. Clinical research on COVID-19 will have to be closely integrated with the IPC, clinical care, and epidemiological training activities, including use of the WHO First Few X (FFX) Cases and contact investigation protocol for COVID-19. ALERRT proposes to work closely with the WHO/AFRO and Africa CDC and existing networks and structures across Africa and globally to provide the forementioned clinical research training and support. ALERRT is a member of the Global Federation - ISARIC, which has developed a Clinical Characterization protocol for COVID-19. This protocol been endorsed by the WHO and is currently being used in China and across the UK and Europe.Being already established and conducting activities in sub-Sahara Africa, the ALERRT network has the capacity to effectively implement the proposed project.
    #> 5    Factors prevalent in Africa such as malnutrition, HIV, tuberculosis and limited access to healthcare, among others, may impact both transmission dynamics and disease progression associated with SARS-CoV-2 infection as well as the burden on the healthcare system and society.We aim to characterize key transmissibility and clinical features of and the antibody response to SARS-CoV-2 as well as to enhance surveillance for COVID-19, identify groups at increased risk of severe illness, estimate the disease burden of medically- and non-medically attended mild, severe-non-fatal and fatal illness and forecast the impact of the outbreak on the healthcare system and the society in South Africa. Particular emphasis will be given to HIV-infected individuals. The aims will be achieved through the implementation of shedding and household transmission studies, collection of sequential serum samples, enhanced facility-based (hospitals and clinics) surveillance among patients with mild and severe respiratory illness in well-established population-based surveillance sites where incidence can be calculated, and healthcare utilization and serological surveys in selected communities. In addition, digital surveillance (based on Google searches) will be used to complement virological surveillance and nowcasting and short-term forecasting (up to 4 weeks) will be implemented over the duration of the epidemic.
    #> 6     Background; It is unknown how prior exposure to commonly circulating human coronaviruses (HCoV) impacts immunity against highly-pathogenic species (SARS, SARS-CoV-2 & MERS). There are limited data, across Europe, Asia and Africa, on the prevalence of infection and seroconversion against widely circulating and mildly symptomatic HCoVs (229E, NL63, OC43, and HKU1). There is a current supposition that antibody-dependent-enhancement (ADE) may play a role in the pathophysiology of COVID-19. ADE occurs when non-neutralizing antiviral proteins facilitate virus entry into host cells, leading to increased infectivity in the cells. In such cases, higher viremia has been measured and the clinical course of disease can be more severe. In preclinical animal models, immunopathology was observed after challenge following vaccination with some SARS vaccines. Therefore, concerns have been raised regarding the impact of immunopathology and ADE on prophylactic vaccination against SARS and possibly SARS-CoV-2. Goals: to perform detailed systems serology of pre-existing immunity, in children and adults, from the UK and Africa, towards novel and commonly circulating coronaviruses. Impact: These studies highlight the limited knowledge in the field and a need for a systematic approach to investigate cross-reactive humoral immunity against HCoV to  inform the immunopathology and pathophysiology of COVID-19.
    #>   Laysummary ODA.funding.used Grant.Type Grant.Start.Year
    #> 1                     Pending    Pending             2020
    #> 2                     Pending  New Grant             2020
    #> 3                     Pending    Pending             2020
    #> 4                     Pending    Pending             2020
    #> 5                     Pending    Pending             2020
    #> 6                     Pending  New Grant             2020
    #>   Study.Subject..choice.Animals. Study.Subject..choice.Bacteria.
    #> 1                      Unchecked                       Unchecked
    #> 2                      Unchecked                       Unchecked
    #> 3                      Unchecked                       Unchecked
    #> 4                      Unchecked                       Unchecked
    #> 5                      Unchecked                       Unchecked
    #> 6                      Unchecked                       Unchecked
    #>   Study.Subject..choice.Human.Populations.
    #> 1                                  Checked
    #> 2                                  Checked
    #> 3                                  Checked
    #> 4                                  Checked
    #> 5                                  Checked
    #> 6                                  Checked
    #>   Study.Subject..choice.Disease.Vectors. Study.Subject..choice.Viruses.
    #> 1                              Unchecked                      Unchecked
    #> 2                              Unchecked                        Checked
    #> 3                              Unchecked                      Unchecked
    #> 4                              Unchecked                      Unchecked
    #> 5                              Unchecked                      Unchecked
    #> 6                              Unchecked                      Unchecked
    #>   Study.Subject..choice.Environment. Study.Subject..choice.Other.
    #> 1                          Unchecked                    Unchecked
    #> 2                          Unchecked                    Unchecked
    #> 3                          Unchecked                    Unchecked
    #> 4                          Unchecked                    Unchecked
    #> 5                          Unchecked                    Unchecked
    #> 6                          Unchecked                    Unchecked
    #>   Study.Subject..choice.Unspecified. Study.Subject..choice.Not.applicable.
    #> 1                          Unchecked                             Unchecked
    #> 2                          Unchecked                             Unchecked
    #> 3                          Unchecked                             Unchecked
    #> 4                          Unchecked                             Unchecked
    #> 5                          Unchecked                             Unchecked
    #> 6                          Unchecked                             Unchecked
    #>   If..Study.Subject..Please.Specific. Ethnicity..choice.Asian.
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Ethnicity..choice.Black. Ethnicity..choice.White. Ethnicity..choice.Mixed.
    #> 1                Unchecked                Unchecked                Unchecked
    #> 2                Unchecked                Unchecked                Unchecked
    #> 3                Unchecked                Unchecked                Unchecked
    #> 4                Unchecked                Unchecked                Unchecked
    #> 5                Unchecked                Unchecked                Unchecked
    #> 6                Unchecked                Unchecked                Unchecked
    #>   Ethnicity..choice.Other. Ethnicity..choice.Unspecified.
    #> 1                Unchecked                        Checked
    #> 2                Unchecked                        Checked
    #> 3                Unchecked                        Checked
    #> 4                Unchecked                        Checked
    #> 5                Unchecked                        Checked
    #> 6                Unchecked                        Checked
    #>   Ethnicity..choice.Not.applicable. If..Other.Ethnicity..Please.Specific.
    #> 1                         Unchecked                                      
    #> 2                         Unchecked                                      
    #> 3                         Unchecked                                      
    #> 4                         Unchecked                                      
    #> 5                         Unchecked                                      
    #> 6                         Unchecked                                      
    #>   Age.Groups..choice.Adolescent..em..font.color.blue..13.years.to.17.years...font...em..
    #> 1                                                                              Unchecked
    #> 2                                                                              Unchecked
    #> 3                                                                              Unchecked
    #> 4                                                                              Unchecked
    #> 5                                                                              Unchecked
    #> 6                                                                              Unchecked
    #>   Age.Groups..choice.Adults..em..font.color.blue..18.and.older...font...em..
    #> 1                                                                  Unchecked
    #> 2                                                                  Unchecked
    #> 3                                                                  Unchecked
    #> 4                                                                  Unchecked
    #> 5                                                                  Unchecked
    #> 6                                                                    Checked
    #>   Age.Groups..choice.Children..em..font.color.blue..1.year.to.12.years...font...em..
    #> 1                                                                          Unchecked
    #> 2                                                                          Unchecked
    #> 3                                                                          Unchecked
    #> 4                                                                          Unchecked
    #> 5                                                                          Unchecked
    #> 6                                                                            Checked
    #>   Age.Groups..choice.Infants..em..font.color.blue..1.month.to.1.year...font...em..
    #> 1                                                                        Unchecked
    #> 2                                                                        Unchecked
    #> 3                                                                        Unchecked
    #> 4                                                                        Unchecked
    #> 5                                                                        Unchecked
    #> 6                                                                        Unchecked
    #>   Age.Groups..choice.Newborns..em..font.color.blue..birth.to.1.month...font...em..
    #> 1                                                                        Unchecked
    #> 2                                                                        Unchecked
    #> 3                                                                        Unchecked
    #> 4                                                                        Unchecked
    #> 5                                                                        Unchecked
    #> 6                                                                        Unchecked
    #>   Age.Groups..choice.Older.adults..em..font.color.blue..65.and.older...font...em..
    #> 1                                                                        Unchecked
    #> 2                                                                        Unchecked
    #> 3                                                                        Unchecked
    #> 4                                                                        Unchecked
    #> 5                                                                        Unchecked
    #> 6                                                                        Unchecked
    #>   Age.Groups..choice.Other. Age.Groups..choice.Unspecified.
    #> 1                 Unchecked                         Checked
    #> 2                 Unchecked                         Checked
    #> 3                 Unchecked                         Checked
    #> 4                 Unchecked                         Checked
    #> 5                 Unchecked                         Checked
    #> 6                 Unchecked                       Unchecked
    #>   Age.Groups..choice.Not.Applicable. If..Other.AgeGroups..Please.Specific.
    #> 1                          Unchecked                                      
    #> 2                          Unchecked                                      
    #> 3                          Unchecked                                      
    #> 4                          Unchecked                                      
    #> 5                          Unchecked                                      
    #> 6                          Unchecked                                      
    #>   Rurality..choice.Rural.Population.Setting.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Rurality..choice.Suburban.Population.Setting.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Rurality..choice.Urban.Population.Setting. Rurality..choice.Other.
    #> 1                                  Unchecked               Unchecked
    #> 2                                  Unchecked               Unchecked
    #> 3                                  Unchecked               Unchecked
    #> 4                                  Unchecked               Unchecked
    #> 5                                  Unchecked               Unchecked
    #> 6                                  Unchecked               Unchecked
    #>   Rurality..choice.Unspecified. Rurality..choice.Not.applicable.
    #> 1                       Checked                        Unchecked
    #> 2                       Checked                        Unchecked
    #> 3                       Checked                        Unchecked
    #> 4                     Unchecked                        Unchecked
    #> 5                       Checked                        Unchecked
    #> 6                       Checked                        Unchecked
    #>   If..Other.Rurality..Please.Specific.
    #> 1                                     
    #> 2                                     
    #> 3                                     
    #> 4                                     
    #> 5                                     
    #> 6                                     
    #>   Vulnerable.Population..choice.Disabled.persons.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Vulnerable.Population..choice.Drug.users.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Vulnerable.Population..choice.Internally.Displaced.and.Migrants.
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Vulnerable.Population..choice.Indigenous.People.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Vulnerable.Population..choice.Sexual.and.gender.minorities.
    #> 1                                                   Unchecked
    #> 2                                                   Unchecked
    #> 3                                                   Unchecked
    #> 4                                                   Unchecked
    #> 5                                                   Unchecked
    #> 6                                                   Unchecked
    #>   Vulnerable.Population..choice.Prisoners.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Vulnerable.Population..choice.Sex.workers.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Vulnerable.Population..choice.Smokers. Vulnerable.Population..choice.Women.
    #> 1                              Unchecked                            Unchecked
    #> 2                              Unchecked                            Unchecked
    #> 3                              Unchecked                            Unchecked
    #> 4                              Unchecked                            Unchecked
    #> 5                              Unchecked                            Unchecked
    #> 6                              Unchecked                            Unchecked
    #>   Vulnerable.Population..choice.Pregnant.women.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Vulnerable.Population..choice.Individuals.with.multimorbidity.
    #> 1                                                      Unchecked
    #> 2                                                      Unchecked
    #> 3                                                      Unchecked
    #> 4                                                      Unchecked
    #> 5                                                      Unchecked
    #> 6                                                      Unchecked
    #>   Vulnerable.Population..choice.Minority.communities.unspecified.
    #> 1                                                       Unchecked
    #> 2                                                       Unchecked
    #> 3                                                       Unchecked
    #> 4                                                       Unchecked
    #> 5                                                       Unchecked
    #> 6                                                       Unchecked
    #>   Vulnerable.Population..choice.Vulnerable.populations.unspecified.
    #> 1                                                         Unchecked
    #> 2                                                         Unchecked
    #> 3                                                         Unchecked
    #> 4                                                         Unchecked
    #> 5                                                         Unchecked
    #> 6                                                         Unchecked
    #>   Vulnerable.Population..choice.Other.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                              Checked
    #> 6                            Unchecked
    #>   Vulnerable.Population..choice.Unspecified.
    #> 1                                    Checked
    #> 2                                    Checked
    #> 3                                    Checked
    #> 4                                    Checked
    #> 5                                  Unchecked
    #> 6                                    Checked
    #>   Vulnerable.Population..choice.Not.applicable.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   If..Other.Vulnerable.Population..Please.Specific.
    #> 1                                                  
    #> 2                                                  
    #> 3                                                  
    #> 4                                                  
    #> 5                          HIV infected individuals
    #> 6                                                  
    #>   Occupational.Groups..choice.Farmers.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Occupational.Groups..choice.Emergency.Responders.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Occupational.Groups..choice.Military.Personnel.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Occupational.Groups..choice.Social.Workers.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Occupational.Groups..choice.Caregivers.
    #> 1                               Unchecked
    #> 2                               Unchecked
    #> 3                               Unchecked
    #> 4                               Unchecked
    #> 5                               Unchecked
    #> 6                               Unchecked
    #>   Occupational.Groups..choice.Health.Personnel.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Occupational.Groups..choice.Hospital.personnel.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Occupational.Groups..choice.Nurses.and.Nursing.Staff.
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Occupational.Groups..choice.Physicians.
    #> 1                               Unchecked
    #> 2                               Unchecked
    #> 3                               Unchecked
    #> 4                               Unchecked
    #> 5                               Unchecked
    #> 6                               Unchecked
    #>   Occupational.Groups..choice.Dentists.and.dental.staff.
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Occupational.Groups..choice.Veterinarians.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Occupational.Groups..choice.Volunteers. Occupational.Groups..choice.Other.
    #> 1                               Unchecked                          Unchecked
    #> 2                               Unchecked                          Unchecked
    #> 3                               Unchecked                          Unchecked
    #> 4                               Unchecked                          Unchecked
    #> 5                               Unchecked                          Unchecked
    #> 6                               Unchecked                          Unchecked
    #>   Occupational.Groups..choice.Unspecified.
    #> 1                                  Checked
    #> 2                                  Checked
    #> 3                                  Checked
    #> 4                                  Checked
    #> 5                                  Checked
    #> 6                                  Checked
    #>   Occupational.Groups..choice.Not.applicable.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   If..Other.OccupationalGroups..Please.Specific.
    #> 1                                               
    #> 2                                               
    #> 3                                               
    #> 4                                               
    #> 5                                               
    #> 6                                               
    #>   Study.Type..choice.Biological.Specimen.Banks.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Study.Type..choice.Case.Reports. Study.Type..choice.Clinical.Conference.
    #> 1                        Unchecked                               Unchecked
    #> 2                        Unchecked                               Unchecked
    #> 3                        Unchecked                               Unchecked
    #> 4                        Unchecked                               Unchecked
    #> 5                        Unchecked                               Unchecked
    #> 6                        Unchecked                               Unchecked
    #>   Study.Type..choice.Clinical.Study. Study.Type..choice.Clinical.Trial.
    #> 1                          Unchecked                          Unchecked
    #> 2                          Unchecked                          Unchecked
    #> 3                          Unchecked                          Unchecked
    #> 4                          Unchecked                          Unchecked
    #> 5                          Unchecked                          Unchecked
    #> 6                          Unchecked                          Unchecked
    #>   Study.Type..choice.Comparative.Study.
    #> 1                             Unchecked
    #> 2                             Unchecked
    #> 3                             Unchecked
    #> 4                             Unchecked
    #> 5                             Unchecked
    #> 6                             Unchecked
    #>   Study.Type..choice.Consensus.Development.Conference.
    #> 1                                            Unchecked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Study.Type..choice.Evaluation.Study. Study.Type..choice.Laboratory.work.
    #> 1                            Unchecked                           Unchecked
    #> 2                            Unchecked                           Unchecked
    #> 3                            Unchecked                           Unchecked
    #> 4                            Unchecked                           Unchecked
    #> 5                            Unchecked                           Unchecked
    #> 6                            Unchecked                           Unchecked
    #>   Study.Type..choice.Meta.Analysis. Study.Type..choice.Observational.Study.
    #> 1                         Unchecked                               Unchecked
    #> 2                         Unchecked                               Unchecked
    #> 3                         Unchecked                               Unchecked
    #> 4                         Unchecked                               Unchecked
    #> 5                         Unchecked                               Unchecked
    #> 6                         Unchecked                               Unchecked
    #>   Study.Type..choice.Policy.report. Study.Type..choice.Review.
    #> 1                         Unchecked                  Unchecked
    #> 2                         Unchecked                  Unchecked
    #> 3                         Unchecked                  Unchecked
    #> 4                         Unchecked                  Unchecked
    #> 5                         Unchecked                  Unchecked
    #> 6                         Unchecked                  Unchecked
    #>   Study.Type..choice.Secondary.Data.Analysis.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Study.Type..choice.Study..design.unspecified.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Study.Type..choice.Systematic.Review. Study.Type..choice.Validation.Study.
    #> 1                             Unchecked                            Unchecked
    #> 2                             Unchecked                            Unchecked
    #> 3                             Unchecked                            Unchecked
    #> 4                             Unchecked                            Unchecked
    #> 5                             Unchecked                            Unchecked
    #> 6                             Unchecked                            Unchecked
    #>   Study.Type..choice.Other. Study.Type..choice.Unspecified.
    #> 1                 Unchecked                         Checked
    #> 2                 Unchecked                         Checked
    #> 3                 Unchecked                         Checked
    #> 4                 Unchecked                         Checked
    #> 5                 Unchecked                         Checked
    #> 6                 Unchecked                         Checked
    #>   Study.Type..choice.Not.applicable. Study.Type..choice.Clinical.
    #> 1                          Unchecked                    Unchecked
    #> 2                          Unchecked                      Checked
    #> 3                          Unchecked                    Unchecked
    #> 4                          Unchecked                    Unchecked
    #> 5                          Unchecked                      Checked
    #> 6                          Unchecked                      Checked
    #>   Study.Type..choice.Non.Clinical. Study.Type..choice.Other..1
    #> 1                          Checked                   Unchecked
    #> 2                        Unchecked                   Unchecked
    #> 3                          Checked                   Unchecked
    #> 4                        Unchecked                   Unchecked
    #> 5                        Unchecked                   Unchecked
    #> 6                        Unchecked                   Unchecked
    #>   Study.Type..choice.Unspecified..1 Study.Type..choice.Not.applicable..1
    #> 1                         Unchecked                            Unchecked
    #> 2                         Unchecked                            Unchecked
    #> 3                         Unchecked                            Unchecked
    #> 4                         Unchecked                            Unchecked
    #> 5                         Unchecked                            Unchecked
    #> 6                         Unchecked                            Unchecked
    #>   Clinical.Trial..choice.Protocol.
    #> 1                        Unchecked
    #> 2                        Unchecked
    #> 3                        Unchecked
    #> 4                        Unchecked
    #> 5                        Unchecked
    #> 6                        Unchecked
    #>   Clinical.Trial..choice.Clinical.Trial..Phase.I.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Clinical.Trial..choice.Clinical.Trial..Phase.II.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Clinical.Trial..choice.Clinical.Trial..Phase.III.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Clinical.Trial..choice.Clinical.Trial..Phase.IV.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Clinical.Trial..choice.Clinical.Trial..Veterinary.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Clinical.Trial..choice.Controlled.Clinical.Trial.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Clinical.Trial..choice.Randomized.Controlled.Trial.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Clinical.Trial..choice.Randomized.Controlled.Trial..Veterinary.
    #> 1                                                       Unchecked
    #> 2                                                       Unchecked
    #> 3                                                       Unchecked
    #> 4                                                       Unchecked
    #> 5                                                       Unchecked
    #> 6                                                       Unchecked
    #>   Clinical.Trial..choice.Unspecified. Clinical.Trial..choice.Not.applicable.
    #> 1                           Unchecked                              Unchecked
    #> 2                           Unchecked                                Checked
    #> 3                           Unchecked                              Unchecked
    #> 4                           Unchecked                              Unchecked
    #> 5                           Unchecked                                Checked
    #> 6                             Checked                              Unchecked
    #>   Report.or.Literature.Based.Research If..Other.Study.Type..Please.Specific.
    #> 1                                  No                                     NA
    #> 2                                                                         NA
    #> 3                                  No                                     NA
    #> 4                                                                         NA
    #> 5                                                                         NA
    #> 6                                                                         NA
    #>   Pathogen..choice.Arenaviridae. Pathogen..choice.Bunyaviridae.
    #> 1                      Unchecked                      Unchecked
    #> 2                      Unchecked                        Checked
    #> 3                        Checked                      Unchecked
    #> 4                      Unchecked                      Unchecked
    #> 5                        Checked                      Unchecked
    #> 6                      Unchecked                        Checked
    #>   Pathogen..choice.Coronavirus. Pathogen..choice.Filoviridae.
    #> 1                     Unchecked                       Checked
    #> 2                     Unchecked                     Unchecked
    #> 3                       Checked                     Unchecked
    #> 4                     Unchecked                       Checked
    #> 5                     Unchecked                     Unchecked
    #> 6                       Checked                     Unchecked
    #>   Pathogen..choice.Flaviviridae. Pathogen..choice.Henipavirus.
    #> 1                      Unchecked                       Checked
    #> 2                      Unchecked                       Checked
    #> 3                        Checked                     Unchecked
    #> 4                        Checked                     Unchecked
    #> 5                      Unchecked                     Unchecked
    #> 6                        Checked                     Unchecked
    #>   Pathogen..choice.Influenza.A. Pathogen..choice.Novel.Pathogen.
    #> 1                     Unchecked                        Unchecked
    #> 2                     Unchecked                        Unchecked
    #> 3                     Unchecked                        Unchecked
    #> 4                     Unchecked                        Unchecked
    #> 5                     Unchecked                        Unchecked
    #> 6                     Unchecked                        Unchecked
    #>   Pathogen..choice.Unspecified. Coronavirus..choice.SARS.CoV.
    #> 1                     Unchecked                     Unchecked
    #> 2                     Unchecked                     Unchecked
    #> 3                     Unchecked                     Unchecked
    #> 4                     Unchecked                     Unchecked
    #> 5                     Unchecked                     Unchecked
    #> 6                     Unchecked                     Unchecked
    #>   Coronavirus..choice.SARSr.CoV. Coronavirus..choice.SARS.CoV.2.
    #> 1                      Unchecked                       Unchecked
    #> 2                      Unchecked                       Unchecked
    #> 3                      Unchecked                       Unchecked
    #> 4                      Unchecked                       Unchecked
    #> 5                      Unchecked                       Unchecked
    #> 6                      Unchecked                       Unchecked
    #>   Coronavirus..choice.SARS.CoV.1. Coronavirus..choice.MERS.CoV.
    #> 1                       Unchecked                     Unchecked
    #> 2                       Unchecked                     Unchecked
    #> 3                       Unchecked                     Unchecked
    #> 4                       Unchecked                     Unchecked
    #> 5                       Unchecked                     Unchecked
    #> 6                       Unchecked                     Unchecked
    #>   Coronavirus..choice.Other. Coronavirus..choice.Unspecified.
    #> 1                  Unchecked                        Unchecked
    #> 2                  Unchecked                        Unchecked
    #> 3                  Unchecked                          Checked
    #> 4                  Unchecked                        Unchecked
    #> 5                  Unchecked                        Unchecked
    #> 6                  Unchecked                          Checked
    #>   Coronavirus..choice.Not.applicable.                           Bunyaviridae
    #> 1                           Unchecked                                       
    #> 2                           Unchecked                                  Other
    #> 3                           Unchecked                                       
    #> 4                           Unchecked                                       
    #> 5                           Unchecked                                       
    #> 6                           Unchecked Crimean-Congo haemorrhagic fever virus
    #>   Filoviridae   Arenaviridae Henipavirus Flaviviridae Influenza.A
    #> 1 Ebola Virus                Unspecified                         
    #> 2                            Nipah virus                         
    #> 3                Unspecified               Zika virus            
    #> 4 Ebola Virus                             Unspecified            
    #> 5             Not applicable                                     
    #> 6                                         Unspecified            
    #>   Disease..choice.COVID.19. Disease..choice.Crimean.Congo.haemorrhagic.fever.
    #> 1                 Unchecked                                           Checked
    #> 2                 Unchecked                                         Unchecked
    #> 3                   Checked                                           Checked
    #> 4                 Unchecked                                         Unchecked
    #> 5                 Unchecked                                         Unchecked
    #> 6                   Checked                                           Checked
    #>   Disease..choice.Ebola.virus.disease. Disease..choice.Marburg.virus.disease.
    #> 1                              Checked                              Unchecked
    #> 2                              Checked                              Unchecked
    #> 3                              Checked                              Unchecked
    #> 4                            Unchecked                                Checked
    #> 5                            Unchecked                                Checked
    #> 6                              Checked                                Checked
    #>   Disease..choice.Lassa.fever.
    #> 1                      Checked
    #> 2                      Checked
    #> 3                    Unchecked
    #> 4                    Unchecked
    #> 5                      Checked
    #> 6                      Checked
    #>   Disease..choice.Middle.East.Respiratory.Syndrome.Coronavirus..MERS.CoV..
    #> 1                                                                  Checked
    #> 2                                                                Unchecked
    #> 3                                                                  Checked
    #> 4                                                                Unchecked
    #> 5                                                                Unchecked
    #> 6                                                                  Checked
    #>   Disease..choice.Severe.Acute.Respiratory.Syndrome..SARS..
    #> 1                                                   Checked
    #> 2                                                 Unchecked
    #> 3                                                   Checked
    #> 4                                                   Checked
    #> 5                                                 Unchecked
    #> 6                                                   Checked
    #>   Disease..choice.Nipah.and.henipaviral.disease.
    #> 1                                      Unchecked
    #> 2                                        Checked
    #> 3                                        Checked
    #> 4                                        Checked
    #> 5                                        Checked
    #> 6                                        Checked
    #>   Disease..choice.Rift.Valley.Fever. Disease..choice.Zika.
    #> 1                          Unchecked               Checked
    #> 2                            Checked             Unchecked
    #> 3                          Unchecked               Checked
    #> 4                            Checked               Checked
    #> 5                            Checked             Unchecked
    #> 6                            Checked             Unchecked
    #>   Disease..choice.Congenital.Zika.virus.disease. Disease..choice.Mpox.
    #> 1                                      Unchecked             Unchecked
    #> 2                                        Checked               Checked
    #> 3                                        Checked             Unchecked
    #> 4                                      Unchecked             Unchecked
    #> 5                                        Checked             Unchecked
    #> 6                                        Checked             Unchecked
    #>   Disease..choice.Plague. Disease..choice.Influenza. Disease..choice.Disease.X.
    #> 1               Unchecked                    Checked                  Unchecked
    #> 2               Unchecked                  Unchecked                  Unchecked
    #> 3               Unchecked                    Checked                  Unchecked
    #> 4                 Checked                    Checked                    Checked
    #> 5               Unchecked                    Checked                  Unchecked
    #> 6                 Checked                  Unchecked                  Unchecked
    #>   Disease..choice.Other. Disease..choice.Not.applicable.
    #> 1              Unchecked                       Unchecked
    #> 2              Unchecked                       Unchecked
    #> 3              Unchecked                       Unchecked
    #> 4              Unchecked                       Unchecked
    #> 5              Unchecked                       Unchecked
    #> 6              Unchecked                       Unchecked
    #>   If..Other.Disease..Please.Specific. MESH_Terms  Complete.
    #> 1                                                  Complete
    #> 2                                                  Complete
    #> 3                                                  Complete
    #> 4                                                Incomplete
    #> 5                                                  Complete
    #> 6                                                  Complete
    #>   Funder.Name..choice.360biolabs.
    #> 1                       Unchecked
    #> 2                       Unchecked
    #> 3                       Unchecked
    #> 4                       Unchecked
    #> 5                       Unchecked
    #> 6                       Unchecked
    #>   Funder.Name..choice.Abdul.Latif.Jameel.Poverty.Action.Lab.
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Funder.Name..choice.Academy.of.Finland. Funder.Name..choice.ACLS.
    #> 1                               Unchecked                 Unchecked
    #> 2                               Unchecked                 Unchecked
    #> 3                               Unchecked                 Unchecked
    #> 4                               Unchecked                 Unchecked
    #> 5                               Unchecked                 Unchecked
    #> 6                               Unchecked                 Unchecked
    #>   Funder.Name..choice.AFD.
    #> 1                Unchecked
    #> 2                Unchecked
    #> 3                Unchecked
    #> 4                Unchecked
    #> 5                Unchecked
    #> 6                Unchecked
    #>   Funder.Name..choice.African.Academy.of.Sciences..AAS...
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Name..choice.Agence.Universitaire.de.la.Francophonie..AUF..
    #> 1                                                          Unchecked
    #> 2                                                          Unchecked
    #> 3                                                          Unchecked
    #> 4                                                          Unchecked
    #> 5                                                          Unchecked
    #> 6                                                          Unchecked
    #>   Funder.Name..choice.Agency.for.Healthcare.Research.and.Quality.
    #> 1                                                       Unchecked
    #> 2                                                       Unchecked
    #> 3                                                       Unchecked
    #> 4                                                       Unchecked
    #> 5                                                       Unchecked
    #> 6                                                       Unchecked
    #>   Funder.Name..choice.Al.Jalila.Foundation.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Alberta.Innovates.
    #> 1                              Unchecked
    #> 2                              Unchecked
    #> 3                              Unchecked
    #> 4                              Unchecked
    #> 5                              Unchecked
    #> 6                              Unchecked
    #>   Funder.Name..choice.Alfred.P..Sloan.Foundation.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Name..choice.American.Diabetes.Association.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.American.Heart.Association.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Name..choice.American.Lung.Association.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.American.Pharmacists.Association.Foundation.
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Funder.Name..choice.American.Society.of.Clinical.Oncology.
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Funder.Name..choice.American.Thoracic.Society.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.American.University.of.Beirut. Funder.Name..choice.ANID.
    #> 1                                          Unchecked                 Unchecked
    #> 2                                          Unchecked                 Unchecked
    #> 3                                          Unchecked                 Unchecked
    #> 4                                          Unchecked                 Unchecked
    #> 5                                          Unchecked                 Unchecked
    #> 6                                          Unchecked                 Unchecked
    #>   Funder.Name..choice.Animal.Free.Research.UK. Funder.Name..choice.ANR.
    #> 1                                    Unchecked                Unchecked
    #> 2                                    Unchecked                Unchecked
    #> 3                                    Unchecked                Unchecked
    #> 4                                    Unchecked                Unchecked
    #> 5                                    Unchecked                Unchecked
    #> 6                                    Unchecked                Unchecked
    #>   Funder.Name..choice.Agence.nationale.de.recherche.sur.le.sida.et.les.hépatites.virale..National.Agency.for.AIDS.Research...ANRS..
    #> 1                                                                                                                         Unchecked
    #> 2                                                                                                                         Unchecked
    #> 3                                                                                                                         Unchecked
    #> 4                                                                                                                         Unchecked
    #> 5                                                                                                                         Unchecked
    #> 6                                                                                                                         Unchecked
    #>   Funder.Name..choice.APPRISE. Funder.Name..choice.ARAMIS.
    #> 1                    Unchecked                   Unchecked
    #> 2                    Unchecked                   Unchecked
    #> 3                    Unchecked                   Unchecked
    #> 4                    Unchecked                   Unchecked
    #> 5                    Unchecked                   Unchecked
    #> 6                    Unchecked                   Unchecked
    #>   Funder.Name..choice.Auckland.Medical.Research.Foundation..AMRF..
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Funder.Name..choice.Australian.Government..Australian.Research.Council.
    #> 1                                                               Unchecked
    #> 2                                                               Unchecked
    #> 3                                                               Unchecked
    #> 4                                                               Unchecked
    #> 5                                                               Unchecked
    #> 6                                                               Unchecked
    #>   Funder.Name..choice.Australian.National.University.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Austrian.Research.Promotion.Agency..FFG..
    #> 1                                                     Unchecked
    #> 2                                                     Unchecked
    #> 3                                                     Unchecked
    #> 4                                                     Unchecked
    #> 5                                                     Unchecked
    #> 6                                                     Unchecked
    #>   Funder.Name..choice.Autism.Science.Foundation. Funder.Name..choice.AXA.
    #> 1                                      Unchecked                Unchecked
    #> 2                                      Unchecked                Unchecked
    #> 3                                      Unchecked                Unchecked
    #> 4                                      Unchecked                Unchecked
    #> 5                                      Unchecked                Unchecked
    #> 6                                      Unchecked                Unchecked
    #>   Funder.Name..choice.Azim.Premji.University.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.BBVA.Foundation..Spain..
    #> 1                                    Unchecked
    #> 2                                    Unchecked
    #> 3                                    Unchecked
    #> 4                                    Unchecked
    #> 5                                    Unchecked
    #> 6                                    Unchecked
    #>   Funder.Name..choice.BC.Ministry.of.Health.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Funder.Name..choice.Bill...Melinda.Gates.Foundation.
    #> 1                                            Unchecked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Funder.Name..choice.Biotechnology.and.Biological.Sciences.Research.Council.
    #> 1                                                                   Unchecked
    #> 2                                                                   Unchecked
    #> 3                                                                   Unchecked
    #> 4                                                                   Unchecked
    #> 5                                                                   Unchecked
    #> 6                                                                   Unchecked
    #>   Funder.Name..choice.BIRAC.
    #> 1                  Unchecked
    #> 2                  Unchecked
    #> 3                  Unchecked
    #> 4                  Unchecked
    #> 5                  Unchecked
    #> 6                  Unchecked
    #>   Funder.Name..choice.Bundesministerium.für.Bildung.und.Forschung..German.Federal.Ministry.of.Education.and.Research...BMBF..
    #> 1                                                                                                                   Unchecked
    #> 2                                                                                                                   Unchecked
    #> 3                                                                                                                   Unchecked
    #> 4                                                                                                                   Unchecked
    #> 5                                                                                                                   Unchecked
    #> 6                                                                                                                   Unchecked
    #>   Funder.Name..choice.Boettcher.Foundation.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Botnar.Research.Centre.for.Child.Health.
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Name..choice.Botnar.Research.Centre.for.Child.Health..BRCCH..
    #> 1                                                            Unchecked
    #> 2                                                            Unchecked
    #> 3                                                            Unchecked
    #> 4                                                            Unchecked
    #> 5                                                            Unchecked
    #> 6                                                            Unchecked
    #>   Funder.Name..choice.BPI.France.
    #> 1                       Unchecked
    #> 2                       Unchecked
    #> 3                       Unchecked
    #> 4                       Unchecked
    #> 5                       Unchecked
    #> 6                       Unchecked
    #>   Funder.Name..choice.Brady.Education.Foundation.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Name..choice.Brain.Research.New.Zealand. Funder.Name..choice.BRICS.
    #> 1                                       Unchecked                  Unchecked
    #> 2                                       Unchecked                  Unchecked
    #> 3                                       Unchecked                  Unchecked
    #> 4                                       Unchecked                  Unchecked
    #> 5                                       Unchecked                  Unchecked
    #> 6                                       Unchecked                  Unchecked
    #>   Funder.Name..choice.British.Academy.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Name..choice.British.Heart.Foundation.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Name..choice.British.Society.for.Antimicrobial.Chemotherapy..BSAC..
    #> 1                                                                  Unchecked
    #> 2                                                                  Unchecked
    #> 3                                                                  Unchecked
    #> 4                                                                  Unchecked
    #> 5                                                                  Unchecked
    #> 6                                                                  Unchecked
    #>   Funder.Name..choice.Brown.University.
    #> 1                             Unchecked
    #> 2                             Unchecked
    #> 3                             Unchecked
    #> 4                             Unchecked
    #> 5                             Unchecked
    #> 6                             Unchecked
    #>   Funder.Name..choice.Bulgaria.National.Science.Fund..BNSF..
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Funder.Name..choice.Bundesamt.für.Gesundheit..BAG..
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Burnet.Institute. Funder.Name..choice.C3.ai.DTI.
    #> 1                             Unchecked                      Unchecked
    #> 2                             Unchecked                      Unchecked
    #> 3                             Unchecked                      Unchecked
    #> 4                             Unchecked                      Unchecked
    #> 5                             Unchecked                      Unchecked
    #> 6                             Unchecked                      Unchecked
    #>   Funder.Name..choice.CABHI. Funder.Name..choice.CaixaImpulse.
    #> 1                  Unchecked                         Unchecked
    #> 2                  Unchecked                         Unchecked
    #> 3                  Unchecked                         Unchecked
    #> 4                  Unchecked                         Unchecked
    #> 5                  Unchecked                         Unchecked
    #> 6                  Unchecked                         Unchecked
    #>   Funder.Name..choice.Callaghan.Innovation.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Cambridge.Africa.
    #> 1                             Unchecked
    #> 2                             Unchecked
    #> 3                             Unchecked
    #> 4                             Unchecked
    #> 5                             Unchecked
    #> 6                             Unchecked
    #>   Funder.Name..choice.Canadian.Frailty.Network.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Name..choice.Canadian.Institute.of.Health.Research..CIHR..
    #> 1                                                         Unchecked
    #> 2                                                         Unchecked
    #> 3                                                         Unchecked
    #> 4                                                         Unchecked
    #> 5                                                         Unchecked
    #> 6                                                         Unchecked
    #>   Funder.Name..choice.Canadian.Statistical.Sciences.Institute..CANSSI..
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.CAPNETZ. Funder.Name..choice.Carlsberg.Foundation.
    #> 1                    Unchecked                                 Unchecked
    #> 2                    Unchecked                                 Unchecked
    #> 3                    Unchecked                                 Unchecked
    #> 4                    Unchecked                                 Unchecked
    #> 5                    Unchecked                                 Unchecked
    #> 6                    Unchecked                                 Unchecked
    #>   Funder.Name..choice.CDC.
    #> 1                Unchecked
    #> 2                Unchecked
    #> 3                Unchecked
    #> 4                Unchecked
    #> 5                Unchecked
    #> 6                Unchecked
    #>   Funder.Name..choice.Centre.de.recherche.de.lInstitut.universitaire.en.santé.mentale.de.Montréal..CR.IUSMM..
    #> 1                                                                                                   Unchecked
    #> 2                                                                                                   Unchecked
    #> 3                                                                                                   Unchecked
    #> 4                                                                                                   Unchecked
    #> 5                                                                                                   Unchecked
    #> 6                                                                                                   Unchecked
    #>   Funder.Name..choice.Centro.Regulador.de.Urgencias.y.Emergencias..CRUE.Santander..
    #> 1                                                                         Unchecked
    #> 2                                                                         Unchecked
    #> 3                                                                         Unchecked
    #> 4                                                                         Unchecked
    #> 5                                                                         Unchecked
    #> 6                                                                         Unchecked
    #>   Funder.Name..choice.Chan.Zuckerberg.Initiative.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Name..choice.CHEST.Foundation. Funder.Name..choice.CHU.de.Limoges.
    #> 1                             Unchecked                           Unchecked
    #> 2                             Unchecked                           Unchecked
    #> 3                             Unchecked                           Unchecked
    #> 4                             Unchecked                           Unchecked
    #> 5                             Unchecked                           Unchecked
    #> 6                             Unchecked                           Unchecked
    #>   Funder.Name..choice.CHU.Dijon.Bourgogne. Funder.Name..choice.CIHR.
    #> 1                                Unchecked                 Unchecked
    #> 2                                Unchecked                 Unchecked
    #> 3                                Unchecked                 Unchecked
    #> 4                                Unchecked                 Unchecked
    #> 5                                Unchecked                 Unchecked
    #> 6                                Unchecked                 Unchecked
    #>   Funder.Name..choice.CIRAD. Funder.Name..choice.CNRS.Lebanon.
    #> 1                  Unchecked                         Unchecked
    #> 2                  Unchecked                         Unchecked
    #> 3                  Unchecked                         Unchecked
    #> 4                  Unchecked                         Unchecked
    #> 5                  Unchecked                         Unchecked
    #> 6                  Unchecked                         Unchecked
    #>   Funder.Name..choice.CNRST.
    #> 1                  Unchecked
    #> 2                  Unchecked
    #> 3                  Unchecked
    #> 4                  Unchecked
    #> 5                  Unchecked
    #> 6                  Unchecked
    #>   Funder.Name..choice.Coalition.for.Epidemic.Preparedness.Innovations..CEPI..
    #> 1                                                                   Unchecked
    #> 2                                                                   Unchecked
    #> 3                                                                   Unchecked
    #> 4                                                                   Unchecked
    #> 5                                                                   Unchecked
    #> 6                                                                   Unchecked
    #>   Funder.Name..choice.Commonwealth.Fund. Funder.Name..choice.CONACYT.Mexico.
    #> 1                              Unchecked                           Unchecked
    #> 2                              Unchecked                           Unchecked
    #> 3                              Unchecked                           Unchecked
    #> 4                              Unchecked                           Unchecked
    #> 5                              Unchecked                           Unchecked
    #> 6                              Unchecked                           Unchecked
    #>   Funder.Name..choice.Congressionally.Directed.Medical.Research.Programs..CDMRP..
    #> 1                                                                       Unchecked
    #> 2                                                                       Unchecked
    #> 3                                                                       Unchecked
    #> 4                                                                       Unchecked
    #> 5                                                                       Unchecked
    #> 6                                                                       Unchecked
    #>   Funder.Name..choice.Consejo.Nacional.de.Ciencia.y.Tecnología..CONACYT..
    #> 1                                                               Unchecked
    #> 2                                                               Unchecked
    #> 3                                                               Unchecked
    #> 4                                                               Unchecked
    #> 5                                                               Unchecked
    #> 6                                                               Unchecked
    #>   Funder.Name..choice.Consejo.Nacional.de.Ciencia..Tecnología.e.Innovación.Tecnológica..CONCYTEC..
    #> 1                                                                                        Unchecked
    #> 2                                                                                        Unchecked
    #> 3                                                                                        Unchecked
    #> 4                                                                                        Unchecked
    #> 5                                                                                        Unchecked
    #> 6                                                                                        Unchecked
    #>   Funder.Name..choice.Consulate.General.of.France..CGF..in.Hong.Kong.
    #> 1                                                           Unchecked
    #> 2                                                           Unchecked
    #> 3                                                           Unchecked
    #> 4                                                           Unchecked
    #> 5                                                           Unchecked
    #> 6                                                           Unchecked
    #>   Funder.Name..choice.Corporación.de.Fomento.de.la.Producción..CORFO..
    #> 1                                                            Unchecked
    #> 2                                                            Unchecked
    #> 3                                                            Unchecked
    #> 4                                                            Unchecked
    #> 5                                                            Unchecked
    #> 6                                                            Unchecked
    #>   Funder.Name..choice.COVID.19.Immunity.Task.Force..CITF..
    #> 1                                                Unchecked
    #> 2                                                Unchecked
    #> 3                                                Unchecked
    #> 4                                                Unchecked
    #> 5                                                Unchecked
    #> 6                                                Unchecked
    #>   Funder.Name..choice.COVID.19.Therapeutics.Accelerator.Wellcome.Trust.
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.CSO.Scotland.
    #> 1                         Unchecked
    #> 2                         Unchecked
    #> 3                         Unchecked
    #> 4                         Unchecked
    #> 5                         Unchecked
    #> 6                         Unchecked
    #>   Funder.Name..choice.Danish.Independent.Research.Foundation.
    #> 1                                                   Unchecked
    #> 2                                                   Unchecked
    #> 3                                                   Unchecked
    #> 4                                                   Unchecked
    #> 5                                                   Unchecked
    #> 6                                                   Unchecked
    #>   Funder.Name..choice.DDR.D..Israel..
    #> 1                           Unchecked
    #> 2                           Unchecked
    #> 3                           Unchecked
    #> 4                           Unchecked
    #> 5                           Unchecked
    #> 6                           Unchecked
    #>   Funder.Name..choice.Decanato.de.Pesquisa.e.Inovação...Universidade.de.Brasilia..DPI..
    #> 1                                                                             Unchecked
    #> 2                                                                             Unchecked
    #> 3                                                                             Unchecked
    #> 4                                                                             Unchecked
    #> 5                                                                             Unchecked
    #> 6                                                                             Unchecked
    #>   Funder.Name..choice.Department.for.Environment..Food.and.Rural.Affairs..DEFRA..
    #> 1                                                                       Unchecked
    #> 2                                                                       Unchecked
    #> 3                                                                       Unchecked
    #> 4                                                                       Unchecked
    #> 5                                                                       Unchecked
    #> 6                                                                       Unchecked
    #>   Funder.Name..choice.Departamento.de.Investigación.postgrado.e.interaccion.social..Bolivia..
    #> 1                                                                                   Unchecked
    #> 2                                                                                   Unchecked
    #> 3                                                                                   Unchecked
    #> 4                                                                                   Unchecked
    #> 5                                                                                   Unchecked
    #> 6                                                                                   Unchecked
    #>   Funder.Name..choice.Department.of.Biotechnology..DBT..India.
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Name..choice.Department.of.Science...Technology..DST..India.
    #> 1                                                           Unchecked
    #> 2                                                           Unchecked
    #> 3                                                           Unchecked
    #> 4                                                           Unchecked
    #> 5                                                           Unchecked
    #> 6                                                           Unchecked
    #>   Funder.Name..choice.Department.of.Science.and.Innovation...South.Africa.
    #> 1                                                                Unchecked
    #> 2                                                                Unchecked
    #> 3                                                                Unchecked
    #> 4                                                                Unchecked
    #> 5                                                                Unchecked
    #> 6                                                                Unchecked
    #>   Funder.Name..choice.Department.of.Science.and.Technology...India.
    #> 1                                                         Unchecked
    #> 2                                                         Unchecked
    #> 3                                                         Unchecked
    #> 4                                                         Unchecked
    #> 5                                                         Unchecked
    #> 6                                                         Unchecked
    #>   Funder.Name..choice.DFG.
    #> 1                Unchecked
    #> 2                Unchecked
    #> 3                Unchecked
    #> 4                Unchecked
    #> 5                Unchecked
    #> 6                Unchecked
    #>   Funder.Name..choice.Department.of.Health.and.Social.Care...National.Institute.for.Health.and.Care.Research..DHSC.NIHR..
    #> 1                                                                                                               Unchecked
    #> 2                                                                                                               Unchecked
    #> 3                                                                                                               Unchecked
    #> 4                                                                                                               Unchecked
    #> 5                                                                                                               Unchecked
    #> 6                                                                                                               Unchecked
    #>   Funder.Name..choice.Diabetes.UK. Funder.Name..choice.DIM.ELICIT.
    #> 1                        Unchecked                       Unchecked
    #> 2                        Unchecked                       Unchecked
    #> 3                        Unchecked                       Unchecked
    #> 4                        Unchecked                       Unchecked
    #> 5                        Unchecked                       Unchecked
    #> 6                        Unchecked                       Unchecked
    #>   Funder.Name..choice.Directorate.General.for.Research.and.Innovation..DG.RTD..
    #> 1                                                                     Unchecked
    #> 2                                                                     Unchecked
    #> 3                                                                     Unchecked
    #> 4                                                                     Unchecked
    #> 5                                                                     Unchecked
    #> 6                                                                     Unchecked
    #>   Funder.Name..choice.Doherty.Institute. Funder.Name..choice.DRDO..India..
    #> 1                              Unchecked                         Unchecked
    #> 2                              Unchecked                         Unchecked
    #> 3                              Unchecked                         Unchecked
    #> 4                              Unchecked                         Unchecked
    #> 5                              Unchecked                         Unchecked
    #> 6                              Unchecked                         Unchecked
    #>   Funder.Name..choice.Duke.University.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Name..choice.Dutch.Research.Council. Funder.Name..choice.e.Asia.JRP.
    #> 1                                   Unchecked                       Unchecked
    #> 2                                   Unchecked                       Unchecked
    #> 3                                   Unchecked                       Unchecked
    #> 4                                   Unchecked                       Unchecked
    #> 5                                   Unchecked                       Unchecked
    #> 6                                   Unchecked                       Unchecked
    #>   Funder.Name..choice.European.Commission. Funder.Name..choice.EC..Horizon..
    #> 1                                Unchecked                         Unchecked
    #> 2                                Unchecked                         Unchecked
    #> 3                                Unchecked                         Unchecked
    #> 4                                Unchecked                         Unchecked
    #> 5                                Unchecked                         Unchecked
    #> 6                                Unchecked                         Unchecked
    #>   Funder.Name..choice.EC..IMI..
    #> 1                     Unchecked
    #> 2                     Unchecked
    #> 3                     Unchecked
    #> 4                     Unchecked
    #> 5                     Unchecked
    #> 6                     Unchecked
    #>   Funder.Name..choice.EC..Marie.Skłodowska.Curie.Actions..
    #> 1                                                Unchecked
    #> 2                                                Unchecked
    #> 3                                                Unchecked
    #> 4                                                Unchecked
    #> 5                                                Unchecked
    #> 6                                                Unchecked
    #>   Funder.Name..choice.Economic.and.Social.Research.Council.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.European...Developing.Countries.Clinical.Trials.Partnership..EDCTP..
    #> 1                                                                                Unchecked
    #> 2                                                                                Unchecked
    #> 3                                                                                Unchecked
    #> 4                                                                                Unchecked
    #> 5                                                                                Unchecked
    #> 6                                                                                Unchecked
    #>   Funder.Name..choice.Elizabeth.Blackwell.Institute.for.Health.Research.
    #> 1                                                              Unchecked
    #> 2                                                              Unchecked
    #> 3                                                              Unchecked
    #> 4                                                              Unchecked
    #> 5                                                              Unchecked
    #> 6                                                              Unchecked
    #>   Funder.Name..choice.Emergency.Medicine.Foundation.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.Emergent.Ventures.Fast.Grants.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.Emory.Vaccine.Center.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Engineering.and.Physical.Sciences.Research.Council.
    #> 1                                                               Unchecked
    #> 2                                                               Unchecked
    #> 3                                                               Unchecked
    #> 4                                                               Unchecked
    #> 5                                                               Unchecked
    #> 6                                                               Unchecked
    #>   Funder.Name..choice.Enterprise.Ireland. Funder.Name..choice.ERC.
    #> 1                               Unchecked                Unchecked
    #> 2                               Unchecked                Unchecked
    #> 3                               Unchecked                Unchecked
    #> 4                               Unchecked                Unchecked
    #> 5                               Unchecked                Unchecked
    #> 6                               Unchecked                Unchecked
    #>   Funder.Name..choice.Estonian.Research.Council.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.Etablissement.Français.du.Sang.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Eunice.Kennedy.Shriver.National.Institute.of.Child.Health.and.Human.Development.
    #> 1                                                                                            Unchecked
    #> 2                                                                                            Unchecked
    #> 3                                                                                            Unchecked
    #> 4                                                                                            Unchecked
    #> 5                                                                                            Unchecked
    #> 6                                                                                            Unchecked
    #>   Funder.Name..choice.European...Developing.Countries.Clinical.Trials.Partnership.
    #> 1                                                                        Unchecked
    #> 2                                                                        Unchecked
    #> 3                                                                        Unchecked
    #> 4                                                                        Unchecked
    #> 5                                                                        Unchecked
    #> 6                                                                        Unchecked
    #>   Funder.Name..choice.European.Institute.of.Innovation...Technology.EC..EIT..
    #> 1                                                                   Unchecked
    #> 2                                                                   Unchecked
    #> 3                                                                   Unchecked
    #> 4                                                                   Unchecked
    #> 5                                                                   Unchecked
    #> 6                                                                   Unchecked
    #>   Funder.Name..choice.European.Open.Science.Cloud..EOSC..
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Name..choice.European.Society.of.Intensive.Care.Medicine.
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Funder.Name..choice.Expertise.France. Funder.Name..choice.FACEPE.Brazil.
    #> 1                             Unchecked                          Unchecked
    #> 2                             Unchecked                          Unchecked
    #> 3                             Unchecked                          Unchecked
    #> 4                             Unchecked                          Unchecked
    #> 5                             Unchecked                          Unchecked
    #> 6                             Unchecked                          Unchecked
    #>   Funder.Name..choice.FAPEAL. Funder.Name..choice.FAPEAM.Brazil.
    #> 1                   Unchecked                          Unchecked
    #> 2                   Unchecked                          Unchecked
    #> 3                   Unchecked                          Unchecked
    #> 4                   Unchecked                          Unchecked
    #> 5                   Unchecked                          Unchecked
    #> 6                   Unchecked                          Unchecked
    #>   Funder.Name..choice.FAPEAP.Brazil. Funder.Name..choice.FAPEG.Brazil.
    #> 1                          Unchecked                         Unchecked
    #> 2                          Unchecked                         Unchecked
    #> 3                          Unchecked                         Unchecked
    #> 4                          Unchecked                         Unchecked
    #> 5                          Unchecked                         Unchecked
    #> 6                          Unchecked                         Unchecked
    #>   Funder.Name..choice.FAPEMIG.Brazil. Funder.Name..choice.FAPEPI.Brazil.
    #> 1                           Unchecked                          Unchecked
    #> 2                           Unchecked                          Unchecked
    #> 3                           Unchecked                          Unchecked
    #> 4                           Unchecked                          Unchecked
    #> 5                           Unchecked                          Unchecked
    #> 6                           Unchecked                          Unchecked
    #>   Funder.Name..choice.FAPERJ. Funder.Name..choice.FAPES.
    #> 1                   Unchecked                  Unchecked
    #> 2                   Unchecked                  Unchecked
    #> 3                   Unchecked                  Unchecked
    #> 4                   Unchecked                  Unchecked
    #> 5                   Unchecked                  Unchecked
    #> 6                   Unchecked                  Unchecked
    #>   Funder.Name..choice.FAPES.Brazil. Funder.Name..choice.FAPESC.
    #> 1                         Unchecked                   Unchecked
    #> 2                         Unchecked                   Unchecked
    #> 3                         Unchecked                   Unchecked
    #> 4                         Unchecked                   Unchecked
    #> 5                         Unchecked                   Unchecked
    #> 6                         Unchecked                   Unchecked
    #>   Funder.Name..choice.FAPESC.Brazil.
    #> 1                          Unchecked
    #> 2                          Unchecked
    #> 3                          Unchecked
    #> 4                          Unchecked
    #> 5                          Unchecked
    #> 6                          Unchecked
    #>   Funder.Name..choice.Fundação.de.Amparo.à.Pesquisa.do.Estado.de.São.Paulo..São.Paulo.Research.Foundation...FAPESP..
    #> 1                                                                                                          Unchecked
    #> 2                                                                                                          Unchecked
    #> 3                                                                                                          Unchecked
    #> 4                                                                                                          Unchecked
    #> 5                                                                                                          Unchecked
    #> 6                                                                                                          Unchecked
    #>   Funder.Name..choice.FAPESQ.Brazil. Funder.Name..choice.FCT.Portugal.
    #> 1                          Unchecked                         Unchecked
    #> 2                          Unchecked                         Unchecked
    #> 3                          Unchecked                         Unchecked
    #> 4                          Unchecked                         Unchecked
    #> 5                          Unchecked                         Unchecked
    #> 6                          Unchecked                         Unchecked
    #>   Funder.Name..choice.Federal.Office.of.Public.Health..FOPH..
    #> 1                                                   Unchecked
    #> 2                                                   Unchecked
    #> 3                                                   Unchecked
    #> 4                                                   Unchecked
    #> 5                                                   Unchecked
    #> 6                                                   Unchecked
    #>   Funder.Name..choice.Finnish.Institute.for.Health.and.Welfare.
    #> 1                                                     Unchecked
    #> 2                                                     Unchecked
    #> 3                                                     Unchecked
    #> 4                                                     Unchecked
    #> 5                                                     Unchecked
    #> 6                                                     Unchecked
    #>   Funder.Name..choice.FNRS.Belgium.
    #> 1                         Unchecked
    #> 2                         Unchecked
    #> 3                         Unchecked
    #> 4                         Unchecked
    #> 5                         Unchecked
    #> 6                         Unchecked
    #>   Funder.Name..choice.Fondation.pour.la.Recherche.Médicale.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.Fonds.de.recherche.du.Québec..FRQ..
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Name..choice.FORE.
    #> 1                 Unchecked
    #> 2                 Unchecked
    #> 3                 Unchecked
    #> 4                 Unchecked
    #> 5                 Unchecked
    #> 6                 Unchecked
    #>   Funder.Name..choice.Foreign..Commonwealth...Development.Office..FCDO..
    #> 1                                                                Checked
    #> 2                                                                Checked
    #> 3                                                                Checked
    #> 4                                                                Checked
    #> 5                                                                Checked
    #> 6                                                                Checked
    #>   Funder.Name..choice.FORMAS.
    #> 1                   Unchecked
    #> 2                   Unchecked
    #> 3                   Unchecked
    #> 4                   Unchecked
    #> 5                   Unchecked
    #> 6                   Unchecked
    #>   Funder.Name..choice.Foundation.for.Food...Agriculture.Research..FFAR..
    #> 1                                                              Unchecked
    #> 2                                                              Unchecked
    #> 3                                                              Unchecked
    #> 4                                                              Unchecked
    #> 5                                                              Unchecked
    #> 6                                                              Unchecked
    #>   Funder.Name..choice.Fraunhofer.Gesellschaft.
    #> 1                                    Unchecked
    #> 2                                    Unchecked
    #> 3                                    Unchecked
    #> 4                                    Unchecked
    #> 5                                    Unchecked
    #> 6                                    Unchecked
    #>   Funder.Name..choice.Fundação.Araucária.
    #> 1                               Unchecked
    #> 2                               Unchecked
    #> 3                               Unchecked
    #> 4                               Unchecked
    #> 5                               Unchecked
    #> 6                               Unchecked
    #>   Funder.Name..choice.Fundação.Cearense.de.Apoio.ao.Desenvolvimento.Científico.e.Tecnológico..FUNCAP..
    #> 1                                                                                            Unchecked
    #> 2                                                                                            Unchecked
    #> 3                                                                                            Unchecked
    #> 4                                                                                            Unchecked
    #> 5                                                                                            Unchecked
    #> 6                                                                                            Unchecked
    #>   Funder.Name..choice.Fundação.de.Amparo.à.Pesquisa.do.Estado.da.Bahia..FAPESB..
    #> 1                                                                      Unchecked
    #> 2                                                                      Unchecked
    #> 3                                                                      Unchecked
    #> 4                                                                      Unchecked
    #> 5                                                                      Unchecked
    #> 6                                                                      Unchecked
    #>   Funder.Name..choice.Fundação.de.Amparo.à.Pesquisa.do.Estado.do.Rio.de.Janeiro..FAPERJ..
    #> 1                                                                               Unchecked
    #> 2                                                                               Unchecked
    #> 3                                                                               Unchecked
    #> 4                                                                               Unchecked
    #> 5                                                                               Unchecked
    #> 6                                                                               Unchecked
    #>   Funder.Name..choice.Fundação.de.Amparo.à.Pesquisa.do.Estado.do.Rio.Grande.do.Sul..FAPERGS..
    #> 1                                                                                   Unchecked
    #> 2                                                                                   Unchecked
    #> 3                                                                                   Unchecked
    #> 4                                                                                   Unchecked
    #> 5                                                                                   Unchecked
    #> 6                                                                                   Unchecked
    #>   Funder.Name..choice.Fundação.de.Amparo.à.Pesquisa.e.ao.Desenvolvimento.Científico.e.Tecnológico.do.Maranhão..FAPEMA..
    #> 1                                                                                                             Unchecked
    #> 2                                                                                                             Unchecked
    #> 3                                                                                                             Unchecked
    #> 4                                                                                                             Unchecked
    #> 5                                                                                                             Unchecked
    #> 6                                                                                                             Unchecked
    #>   Funder.Name..choice.Fundação.de.Apoio.à.Pesquisa.do.Distrito.Federal..FAPDF..
    #> 1                                                                     Unchecked
    #> 2                                                                     Unchecked
    #> 3                                                                     Unchecked
    #> 4                                                                     Unchecked
    #> 5                                                                     Unchecked
    #> 6                                                                     Unchecked
    #>   Funder.Name..choice.Fundação.de.Apoio.ao.Desenvolvimento.do.Ensino..Ciência.e.Tecnologia.do.Estado.de.Mato.Grosso.do.Sul..FUNDECT..
    #> 1                                                                                                                           Unchecked
    #> 2                                                                                                                           Unchecked
    #> 3                                                                                                                           Unchecked
    #> 4                                                                                                                           Unchecked
    #> 5                                                                                                                           Unchecked
    #> 6                                                                                                                           Unchecked
    #>   Funder.Name..choice.Fundacion.Mutua.Madrilena..Spain..
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.FWF. Funder.Name..choice.FWO.Belgium.
    #> 1                Unchecked                        Unchecked
    #> 2                Unchecked                        Unchecked
    #> 3                Unchecked                        Unchecked
    #> 4                Unchecked                        Unchecked
    #> 5                Unchecked                        Unchecked
    #> 6                Unchecked                        Unchecked
    #>   Funder.Name..choice.G2LM. Funder.Name..choice.LIC.
    #> 1                 Unchecked                Unchecked
    #> 2                 Unchecked                Unchecked
    #> 3                 Unchecked                Unchecked
    #> 4                 Unchecked                Unchecked
    #> 5                 Unchecked                Unchecked
    #> 6                 Unchecked                Unchecked
    #>   Funder.Name..choice.Gabon.government. Funder.Name..choice.Genome.BC.
    #> 1                             Unchecked                      Unchecked
    #> 2                             Unchecked                      Unchecked
    #> 3                             Unchecked                      Unchecked
    #> 4                             Unchecked                      Unchecked
    #> 5                             Unchecked                      Unchecked
    #> 6                             Unchecked                      Unchecked
    #>   Funder.Name..choice.Genome.Canada. Funder.Name..choice.Génome.Québec.
    #> 1                          Unchecked                          Unchecked
    #> 2                          Unchecked                          Unchecked
    #> 3                          Unchecked                          Unchecked
    #> 4                          Unchecked                          Unchecked
    #> 5                          Unchecked                          Unchecked
    #> 6                          Unchecked                          Unchecked
    #>   Funder.Name..choice.German.Research.Foundation..DFG..
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Funder.Name..choice.Global.Alliance.for.Vaccines.and.Immunization..GAVI..
    #> 1                                                                 Unchecked
    #> 2                                                                 Unchecked
    #> 3                                                                 Unchecked
    #> 4                                                                 Unchecked
    #> 5                                                                 Unchecked
    #> 6                                                                 Unchecked
    #>   Funder.Name..choice.Goethe.University.
    #> 1                              Unchecked
    #> 2                              Unchecked
    #> 3                              Unchecked
    #> 4                              Unchecked
    #> 5                              Unchecked
    #> 6                              Unchecked
    #>   Funder.Name..choice.Government.of.Nepal.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.Government.of.Ontario..Canada..
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Greenwall.Foundation. Funder.Name..choice.Gund.Institute.
    #> 1                                 Unchecked                           Unchecked
    #> 2                                 Unchecked                           Unchecked
    #> 3                                 Unchecked                           Unchecked
    #> 4                                 Unchecked                           Unchecked
    #> 5                                 Unchecked                           Unchecked
    #> 6                                 Unchecked                           Unchecked
    #>   Funder.Name..choice.Harrington.Discovery.Institute.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Health.Canada.
    #> 1                          Unchecked
    #> 2                          Unchecked
    #> 3                          Unchecked
    #> 4                          Unchecked
    #> 5                          Unchecked
    #> 6                          Unchecked
    #>   Funder.Name..choice.Health.Research.Council.of.New.Zealand.
    #> 1                                                   Unchecked
    #> 2                                                   Unchecked
    #> 3                                                   Unchecked
    #> 4                                                   Unchecked
    #> 5                                                   Unchecked
    #> 6                                                   Unchecked
    #>   Funder.Name..choice.Helmholtz.Zentrum.für.Infektionsforschung..Kanton.Luzern..Kantonsarztamt.Kanton.Bern.
    #> 1                                                                                                 Unchecked
    #> 2                                                                                                 Unchecked
    #> 3                                                                                                 Unchecked
    #> 4                                                                                                 Unchecked
    #> 5                                                                                                 Unchecked
    #> 6                                                                                                 Unchecked
    #>   Funder.Name..choice.Helmsley.Charitable.Trust.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.Henry.Luce.Foundation.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Funder.Name..choice.Higher.Education.Commission.Pakistan.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.HRB.Ireland. Funder.Name..choice.HRZZ.Croatia.
    #> 1                        Unchecked                         Unchecked
    #> 2                        Unchecked                         Unchecked
    #> 3                        Unchecked                         Unchecked
    #> 4                        Unchecked                         Unchecked
    #> 5                        Unchecked                         Unchecked
    #> 6                        Unchecked                         Unchecked
    #>   Funder.Name..choice.IDA.Ireland.
    #> 1                        Unchecked
    #> 2                        Unchecked
    #> 3                        Unchecked
    #> 4                        Unchecked
    #> 5                        Unchecked
    #> 6                        Unchecked
    #>   Funder.Name..choice.International.Development.Research.Centre..IDRC..
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.IHU.Marseille.
    #> 1                          Unchecked
    #> 2                          Unchecked
    #> 3                          Unchecked
    #> 4                          Unchecked
    #> 5                          Unchecked
    #> 6                          Unchecked
    #>   Funder.Name..choice.Independent.Research.Fund.Denmark.
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.Indian.Council.of.Medical.Research..ICMR..
    #> 1                                                      Unchecked
    #> 2                                                      Unchecked
    #> 3                                                      Unchecked
    #> 4                                                      Unchecked
    #> 5                                                      Unchecked
    #> 6                                                      Unchecked
    #>   Funder.Name..choice.Indian.Council.of.Social.Science.Research.
    #> 1                                                      Unchecked
    #> 2                                                      Unchecked
    #> 3                                                      Unchecked
    #> 4                                                      Unchecked
    #> 5                                                      Unchecked
    #> 6                                                      Unchecked
    #>   Funder.Name..choice.Indo.US.Science.and.Technology.Forum.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.Innosuisse. Funder.Name..choice.Innovate.Peru.
    #> 1                       Unchecked                          Unchecked
    #> 2                       Unchecked                          Unchecked
    #> 3                       Unchecked                          Unchecked
    #> 4                       Unchecked                          Unchecked
    #> 5                       Unchecked                          Unchecked
    #> 6                       Unchecked                          Unchecked
    #>   Funder.Name..choice.Innovate.UK.
    #> 1                        Unchecked
    #> 2                        Unchecked
    #> 3                        Unchecked
    #> 4                        Unchecked
    #> 5                        Unchecked
    #> 6                        Unchecked
    #>   Funder.Name..choice.Innovations.for.Poverty.Action.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Innovationsfonden.Denmark. Funder.Name..choice.Inserm.
    #> 1                                      Unchecked                   Unchecked
    #> 2                                      Unchecked                   Unchecked
    #> 3                                      Unchecked                   Unchecked
    #> 4                                      Unchecked                   Unchecked
    #> 5                                      Unchecked                   Unchecked
    #> 6                                      Unchecked                   Unchecked
    #>   Funder.Name..choice.INSERM.
    #> 1                   Unchecked
    #> 2                   Unchecked
    #> 3                   Unchecked
    #> 4                   Unchecked
    #> 5                   Unchecked
    #> 6                   Unchecked
    #>   Funder.Name..choice.Institut.de.recherche.Robert.Sauvé.en.santé.et.en.sécurité.du.travail..IRSST..
    #> 1                                                                                          Unchecked
    #> 2                                                                                          Unchecked
    #> 3                                                                                          Unchecked
    #> 4                                                                                          Unchecked
    #> 5                                                                                          Unchecked
    #> 6                                                                                          Unchecked
    #>   Funder.Name..choice.Institut.Pasteur.International.Network..IPIN..
    #> 1                                                          Unchecked
    #> 2                                                          Unchecked
    #> 3                                                          Unchecked
    #> 4                                                          Unchecked
    #> 5                                                          Unchecked
    #> 6                                                          Unchecked
    #>   Funder.Name..choice.Institute.for.Health.Management.
    #> 1                                            Unchecked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Funder.Name..choice.Instituto.Evandro.Chagas..IEC..
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Instituto.Hondureño.de.Ciencia..Tecnología.e.Innovación..IHCIETI..
    #> 1                                                                              Unchecked
    #> 2                                                                              Unchecked
    #> 3                                                                              Unchecked
    #> 4                                                                              Unchecked
    #> 5                                                                              Unchecked
    #> 6                                                                              Unchecked
    #>   Funder.Name..choice.Instituto.Nacional.de.Salud.Peru.
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Funder.Name..choice.International.Centre.for.Genetic.Engineering.and.Biotechnology..ICGEB..
    #> 1                                                                                   Unchecked
    #> 2                                                                                   Unchecked
    #> 3                                                                                   Unchecked
    #> 4                                                                                   Unchecked
    #> 5                                                                                   Unchecked
    #> 6                                                                                   Unchecked
    #>   Funder.Name..choice.International.Growth.Centre.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Name..choice.International.Hepato.Pancreato.Biliary.Association..IHPBA...USA..
    #> 1                                                                             Unchecked
    #> 2                                                                             Unchecked
    #> 3                                                                             Unchecked
    #> 4                                                                             Unchecked
    #> 5                                                                             Unchecked
    #> 6                                                                             Unchecked
    #>   Funder.Name..choice.International.Science.Council. Funder.Name..choice.IRD.
    #> 1                                          Unchecked                Unchecked
    #> 2                                          Unchecked                Unchecked
    #> 3                                          Unchecked                Unchecked
    #> 4                                          Unchecked                Unchecked
    #> 5                                          Unchecked                Unchecked
    #> 6                                          Unchecked                Unchecked
    #>   Funder.Name..choice.Irish.Research.Council.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.National.Institute.of.Health.Carlos.III..El.Instituto.de.Salud.Carlos.III...ISCIII..
    #> 1                                                                                                Unchecked
    #> 2                                                                                                Unchecked
    #> 3                                                                                                Unchecked
    #> 4                                                                                                Unchecked
    #> 5                                                                                                Unchecked
    #> 6                                                                                                Unchecked
    #>   Funder.Name..choice.Israel.Innovation.Authority. Funder.Name..choice.IVADO.
    #> 1                                        Unchecked                  Unchecked
    #> 2                                        Unchecked                  Unchecked
    #> 3                                        Unchecked                  Unchecked
    #> 4                                        Unchecked                  Unchecked
    #> 5                                        Unchecked                  Unchecked
    #> 6                                        Unchecked                  Unchecked
    #>   Funder.Name..choice.IZA...Institute.of.Labor.Economics.
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Name..choice.Japan.Society.for.the.Promotion.of.Science.
    #> 1                                                       Unchecked
    #> 2                                                       Unchecked
    #> 3                                                       Unchecked
    #> 4                                                       Unchecked
    #> 5                                                       Unchecked
    #> 6                                                       Unchecked
    #>   Funder.Name..choice.Japan.Agency.for.Medical.Research.and.Development..AMED..
    #> 1                                                                     Unchecked
    #> 2                                                                     Unchecked
    #> 3                                                                     Unchecked
    #> 4                                                                     Unchecked
    #> 5                                                                     Unchecked
    #> 6                                                                     Unchecked
    #>   Funder.Name..choice.John.E..Fogarty.International.Center.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.Johns.Hopkins.University.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Name..choice.Junta.de.Andalucia.
    #> 1                               Unchecked
    #> 2                               Unchecked
    #> 3                               Unchecked
    #> 4                               Unchecked
    #> 5                               Unchecked
    #> 6                               Unchecked
    #>   Funder.Name..choice.Junta.de.Castilla.y.Leon...Consejeria.de.Sanidad.
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.KAKENHI. Funder.Name..choice.Leibniz.Association.
    #> 1                    Unchecked                                Unchecked
    #> 2                    Unchecked                                Unchecked
    #> 3                    Unchecked                                Unchecked
    #> 4                    Unchecked                                Unchecked
    #> 5                    Unchecked                                Unchecked
    #> 6                    Unchecked                                Unchecked
    #>   Funder.Name..choice.LifeArc.
    #> 1                    Unchecked
    #> 2                    Unchecked
    #> 3                    Unchecked
    #> 4                    Unchecked
    #> 5                    Unchecked
    #> 6                    Unchecked
    #>   Funder.Name..choice.Liverpool.School.of.Tropical.Medicine.
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Funder.Name..choice.Lundbeck.Foundation.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.Luxembourg.National.Research.Fund.
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.Making.The.Shift.Inc.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Malta.Council.for.Science.and.Technology.
    #> 1                                                     Unchecked
    #> 2                                                     Unchecked
    #> 3                                                     Unchecked
    #> 4                                                     Unchecked
    #> 5                                                     Unchecked
    #> 6                                                     Unchecked
    #>   Funder.Name..choice.MBIE.New.Zealand.
    #> 1                             Unchecked
    #> 2                             Unchecked
    #> 3                             Unchecked
    #> 4                             Unchecked
    #> 5                             Unchecked
    #> 6                             Unchecked
    #>   Funder.Name..choice.Medical.Research.Future.Fund..MRFF..
    #> 1                                                Unchecked
    #> 2                                                Unchecked
    #> 3                                                Unchecked
    #> 4                                                Unchecked
    #> 5                                                Unchecked
    #> 6                                                Unchecked
    #>   Funder.Name..choice.Medical.University.of.Vienna.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Funder.Name..choice.Michael.and.Susan.Dell.Foundation.
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.Michael.Smith.Foundation.for.Health.Research.
    #> 1                                                         Unchecked
    #> 2                                                         Unchecked
    #> 3                                                         Unchecked
    #> 4                                                         Unchecked
    #> 5                                                         Unchecked
    #> 6                                                         Unchecked
    #>   Funder.Name..choice.MINCTCI...Chile.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Name..choice.Ministerio.de.Ciencia..Tecnología.e.Innovación..Ministry.of.Science..Technology.and.Innovation...MINCYT..
    #> 1                                                                                                                     Unchecked
    #> 2                                                                                                                     Unchecked
    #> 3                                                                                                                     Unchecked
    #> 4                                                                                                                     Unchecked
    #> 5                                                                                                                     Unchecked
    #> 6                                                                                                                     Unchecked
    #>   Funder.Name..choice.Ministre.des.Solidarités.et.de.la.Santé..France..
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.Ministry.for.Innovation.and.Technology..Hungary..
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.Ministry.of.Education..University.and.Research.Italy.
    #> 1                                                                 Unchecked
    #> 2                                                                 Unchecked
    #> 3                                                                 Unchecked
    #> 4                                                                 Unchecked
    #> 5                                                                 Unchecked
    #> 6                                                                 Unchecked
    #>   Funder.Name..choice.Ministry.of.Health...Italy.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Name..choice.MinScience...Colombia. Funder.Name..choice.Mitacs.
    #> 1                                  Unchecked                   Unchecked
    #> 2                                  Unchecked                   Unchecked
    #> 3                                  Unchecked                   Unchecked
    #> 4                                  Unchecked                   Unchecked
    #> 5                                  Unchecked                   Unchecked
    #> 6                                  Unchecked                   Unchecked
    #>   Funder.Name..choice.MOH.
    #> 1                Unchecked
    #> 2                Unchecked
    #> 3                Unchecked
    #> 4                Unchecked
    #> 5                Unchecked
    #> 6                Unchecked
    #>   Funder.Name..choice.Montreal.Economic.Institute..MEI..
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.MRFF. Funder.Name..choice.MRIC.Mauritius.
    #> 1                 Unchecked                           Unchecked
    #> 2                 Unchecked                           Unchecked
    #> 3                 Unchecked                           Unchecked
    #> 4                 Unchecked                           Unchecked
    #> 5                 Unchecked                           Unchecked
    #> 6                 Unchecked                           Unchecked
    #>   Funder.Name..choice.NASA.
    #> 1                 Unchecked
    #> 2                 Unchecked
    #> 3                 Unchecked
    #> 4                 Unchecked
    #> 5                 Unchecked
    #> 6                 Unchecked
    #>   Funder.Name..choice.National.Centre.for.Student.Equity.in.Higher.Education..NCSEHE..
    #> 1                                                                            Unchecked
    #> 2                                                                            Unchecked
    #> 3                                                                            Unchecked
    #> 4                                                                            Unchecked
    #> 5                                                                            Unchecked
    #> 6                                                                            Unchecked
    #>   Funder.Name..choice.National.Council.for.Science.and.Technology..NCST..Rwanda.
    #> 1                                                                      Unchecked
    #> 2                                                                      Unchecked
    #> 3                                                                      Unchecked
    #> 4                                                                      Unchecked
    #> 5                                                                      Unchecked
    #> 6                                                                      Unchecked
    #>   Funder.Name..choice.National.Health.and.Medical.Research.Council..NHMRC..
    #> 1                                                                 Unchecked
    #> 2                                                                 Unchecked
    #> 3                                                                 Unchecked
    #> 4                                                                 Unchecked
    #> 5                                                                 Unchecked
    #> 6                                                                 Unchecked
    #>   Funder.Name..choice.National.Institute.for.Health.Research.
    #> 1                                                   Unchecked
    #> 2                                                   Unchecked
    #> 3                                                   Unchecked
    #> 4                                                   Unchecked
    #> 5                                                   Unchecked
    #> 6                                                   Unchecked
    #>   Funder.Name..choice.National.Institute.of.Allergy.and.Infectious.Diseases.
    #> 1                                                                  Unchecked
    #> 2                                                                  Unchecked
    #> 3                                                                  Unchecked
    #> 4                                                                  Unchecked
    #> 5                                                                  Unchecked
    #> 6                                                                  Unchecked
    #>   Funder.Name..choice.National.Institute.of.Dental.and.Craniofacial.Research.
    #> 1                                                                   Unchecked
    #> 2                                                                   Unchecked
    #> 3                                                                   Unchecked
    #> 4                                                                   Unchecked
    #> 5                                                                   Unchecked
    #> 6                                                                   Unchecked
    #>   Funder.Name..choice.National.Institute.of.Neurological.Disorders.and.Stroke.
    #> 1                                                                    Unchecked
    #> 2                                                                    Unchecked
    #> 3                                                                    Unchecked
    #> 4                                                                    Unchecked
    #> 5                                                                    Unchecked
    #> 6                                                                    Unchecked
    #>   Funder.Name..choice.National.Institutes.of.Health.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.National.Medical.Research.Council.Singapore.
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Funder.Name..choice.National.Natural.Science.Foundation.of.China..NSFC..
    #> 1                                                                Unchecked
    #> 2                                                                Unchecked
    #> 3                                                                Unchecked
    #> 4                                                                Unchecked
    #> 5                                                                Unchecked
    #> 6                                                                Unchecked
    #>   Funder.Name..choice.National.Research.Foundation..NRF..
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Name..choice.National.Research.Foundation.of.Korea..NRF..
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Funder.Name..choice.National.Research.Fund..NRF..Kenya.
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Name..choice.National.Research..Development.and.Innovation.Office..NRDI..
    #> 1                                                                        Unchecked
    #> 2                                                                        Unchecked
    #> 3                                                                        Unchecked
    #> 4                                                                        Unchecked
    #> 5                                                                        Unchecked
    #> 6                                                                        Unchecked
    #>   Funder.Name..choice.National.Science.Center.Poland.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Natural.Environment.Research.Council.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.Natural.Sciences.and.Engineering.Research.Council.of.Canada..NSERC..
    #> 1                                                                                Unchecked
    #> 2                                                                                Unchecked
    #> 3                                                                                Unchecked
    #> 4                                                                                Unchecked
    #> 5                                                                                Unchecked
    #> 6                                                                                Unchecked
    #>   Funder.Name..choice.Nazarbayev.University. Funder.Name..choice.NBHRF.
    #> 1                                  Unchecked                  Unchecked
    #> 2                                  Unchecked                  Unchecked
    #> 3                                  Unchecked                  Unchecked
    #> 4                                  Unchecked                  Unchecked
    #> 5                                  Unchecked                  Unchecked
    #> 6                                  Unchecked                  Unchecked
    #>   Funder.Name..choice.New.South.Wales.Government..Health..
    #> 1                                                Unchecked
    #> 2                                                Unchecked
    #> 3                                                Unchecked
    #> 4                                                Unchecked
    #> 5                                                Unchecked
    #> 6                                                Unchecked
    #>   Funder.Name..choice.Newton.Fund.
    #> 1                        Unchecked
    #> 2                        Unchecked
    #> 3                        Unchecked
    #> 4                        Unchecked
    #> 5                        Unchecked
    #> 6                        Unchecked
    #>   Funder.Name..choice.Netherlands.Organisation.for.Health.Research.and.Development..ZonMW..
    #> 1                                                                                 Unchecked
    #> 2                                                                                 Unchecked
    #> 3                                                                                 Unchecked
    #> 4                                                                                 Unchecked
    #> 5                                                                                 Unchecked
    #> 6                                                                                 Unchecked
    #>   Funder.Name..choice.NHMRC.Centre.of.Research.Excellence.in.Emerging.Infectious.Diseases..CREID..
    #> 1                                                                                        Unchecked
    #> 2                                                                                        Unchecked
    #> 3                                                                                        Unchecked
    #> 4                                                                                        Unchecked
    #> 5                                                                                        Unchecked
    #> 6                                                                                        Unchecked
    #>   Funder.Name..choice.NIH. Funder.Name..choice.NORCE.
    #> 1                Unchecked                  Unchecked
    #> 2                Unchecked                  Unchecked
    #> 3                Unchecked                  Unchecked
    #> 4                Unchecked                  Unchecked
    #> 5                Unchecked                  Unchecked
    #> 6                Unchecked                  Unchecked
    #>   Funder.Name..choice.NordForsk.
    #> 1                      Unchecked
    #> 2                      Unchecked
    #> 3                      Unchecked
    #> 4                      Unchecked
    #> 5                      Unchecked
    #> 6                      Unchecked
    #>   Funder.Name..choice.Nordic.Trial.Alliance..NTA..
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Name..choice.North.Carolina.Biotechnology.Center.
    #> 1                                                Unchecked
    #> 2                                                Unchecked
    #> 3                                                Unchecked
    #> 4                                                Unchecked
    #> 5                                                Unchecked
    #> 6                                                Unchecked
    #>   Funder.Name..choice.Northern.Periphery.and.Arctic.Programme.
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Name..choice.Novavax. Funder.Name..choice.Novo.Nordisk.Foundation.
    #> 1                    Unchecked                                    Unchecked
    #> 2                    Unchecked                                    Unchecked
    #> 3                    Unchecked                                    Unchecked
    #> 4                    Unchecked                                    Unchecked
    #> 5                    Unchecked                                    Unchecked
    #> 6                    Unchecked                                    Unchecked
    #>   Funder.Name..choice.NSERC. Funder.Name..choice.NSERC.Canada.
    #> 1                  Unchecked                         Unchecked
    #> 2                  Unchecked                         Unchecked
    #> 3                  Unchecked                         Unchecked
    #> 4                  Unchecked                         Unchecked
    #> 5                  Unchecked                         Unchecked
    #> 6                  Unchecked                         Unchecked
    #>   Funder.Name..choice.NSF. Funder.Name..choice.NSF.Bulgaria.
    #> 1                Unchecked                         Unchecked
    #> 2                Unchecked                         Unchecked
    #> 3                Unchecked                         Unchecked
    #> 4                Unchecked                         Unchecked
    #> 5                Unchecked                         Unchecked
    #> 6                Unchecked                         Unchecked
    #>   Funder.Name..choice.Nuffield.Foundation. Funder.Name..choice.NWO.Netherlands.
    #> 1                                Unchecked                            Unchecked
    #> 2                                Unchecked                            Unchecked
    #> 3                                Unchecked                            Unchecked
    #> 4                                Unchecked                            Unchecked
    #> 5                                Unchecked                            Unchecked
    #> 6                                Unchecked                            Unchecked
    #>   Funder.Name..choice.NYU.Grossman.school.of.Medicine.
    #> 1                                            Unchecked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Funder.Name..choice.OSAV. Funder.Name..choice.Other.Funders..Canada..
    #> 1                 Unchecked                                   Unchecked
    #> 2                 Unchecked                                   Unchecked
    #> 3                 Unchecked                                   Unchecked
    #> 4                 Unchecked                                   Unchecked
    #> 5                 Unchecked                                   Unchecked
    #> 6                 Unchecked                                   Unchecked
    #>   Funder.Name..choice.Other.funders..Canada..
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Other.funders..France..
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Other.Funders..France..
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Other.Funders..Israel..
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Other.Funders..Sweden..
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Other.Funders..USA..
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.Oxford.University.Clinical.Research.Unit..OUCRU..
    #> 1                                                             Unchecked
    #> 2                                                             Unchecked
    #> 3                                                             Unchecked
    #> 4                                                             Unchecked
    #> 5                                                             Unchecked
    #> 6                                                             Unchecked
    #>   Funder.Name..choice.Partnership.for.Advanced.Computng.in.Europe..PRACE..
    #> 1                                                                Unchecked
    #> 2                                                                Unchecked
    #> 3                                                                Unchecked
    #> 4                                                                Unchecked
    #> 5                                                                Unchecked
    #> 6                                                                Unchecked
    #>   Funder.Name..choice.Partnership.for.Economic.Policy..PEP..
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Funder.Name..choice.Patient.Centered.Outcomes.Research.Institute.
    #> 1                                                         Unchecked
    #> 2                                                         Unchecked
    #> 3                                                         Unchecked
    #> 4                                                         Unchecked
    #> 5                                                         Unchecked
    #> 6                                                         Unchecked
    #>   Funder.Name..choice.Patient.Centered.Outcomes.Research.Institute..PCORI..
    #> 1                                                                 Unchecked
    #> 2                                                                 Unchecked
    #> 3                                                                 Unchecked
    #> 4                                                                 Unchecked
    #> 5                                                                 Unchecked
    #> 6                                                                 Unchecked
    #>   Funder.Name..choice.Paul.Ramsay.Foundation..via.APPRISE..
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.Paul.Ramsey.Foundation.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Paul.Scherrer.Institut..PSI.. Funder.Name..choice.PEDL.
    #> 1                                         Unchecked                 Unchecked
    #> 2                                         Unchecked                 Unchecked
    #> 3                                         Unchecked                 Unchecked
    #> 4                                         Unchecked                 Unchecked
    #> 5                                         Unchecked                 Unchecked
    #> 6                                         Unchecked                 Unchecked
    #>   Funder.Name..choice.Peter.Wall.Institute.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Peterson.Foundation.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.Philippine.Council.for.Health.Research.and.Development..PCHRD..
    #> 1                                                                           Unchecked
    #> 2                                                                           Unchecked
    #> 3                                                                           Unchecked
    #> 4                                                                           Unchecked
    #> 5                                                                           Unchecked
    #> 6                                                                           Unchecked
    #>   Funder.Name..choice.PSI.Foundation.
    #> 1                           Unchecked
    #> 2                           Unchecked
    #> 3                           Unchecked
    #> 4                           Unchecked
    #> 5                           Unchecked
    #> 6                           Unchecked
    #>   Funder.Name..choice.Qatar.National.Research.Fund.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Funder.Name..choice.RBWH.Foundation. Funder.Name..choice.RCN.Norway.
    #> 1                            Unchecked                       Unchecked
    #> 2                            Unchecked                       Unchecked
    #> 3                            Unchecked                       Unchecked
    #> 4                            Unchecked                       Unchecked
    #> 5                            Unchecked                       Unchecked
    #> 6                            Unchecked                       Unchecked
    #>   Funder.Name..choice.REACTing.
    #> 1                     Unchecked
    #> 2                     Unchecked
    #> 3                     Unchecked
    #> 4                     Unchecked
    #> 5                     Unchecked
    #> 6                     Unchecked
    #>   Funder.Name..choice.Research.Corporation.for.Science.Advancement.
    #> 1                                                         Unchecked
    #> 2                                                         Unchecked
    #> 3                                                         Unchecked
    #> 4                                                         Unchecked
    #> 5                                                         Unchecked
    #> 6                                                         Unchecked
    #>   Funder.Name..choice.Research.Council.of.Norway..RCN..
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Funder.Name..choice.Research.Grants.Council..RGC..of.Hong.Kong.
    #> 1                                                       Unchecked
    #> 2                                                       Unchecked
    #> 3                                                       Unchecked
    #> 4                                                       Unchecked
    #> 5                                                       Unchecked
    #> 6                                                       Unchecked
    #>   Funder.Name..choice.Research.Manitoba.
    #> 1                              Unchecked
    #> 2                              Unchecked
    #> 3                              Unchecked
    #> 4                              Unchecked
    #> 5                              Unchecked
    #> 6                              Unchecked
    #>   Funder.Name..choice.Research.Nova.Scotia.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.Rheumatology.Research.Foundation.
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Funder.Name..choice.RIKEN.
    #> 1                  Unchecked
    #> 2                  Unchecked
    #> 3                  Unchecked
    #> 4                  Unchecked
    #> 5                  Unchecked
    #> 6                  Unchecked
    #>   Funder.Name..choice.Robert.Wood.Johnson.Foundation.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.Roche.Holding.AG..Roche..
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Name..choice.Royal.Academy.of.Engineering..RAENG..
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.Royal.Society.of.Tropical.Medicine.and.Hygiene..RSTMH..
    #> 1                                                                   Unchecked
    #> 2                                                                   Unchecked
    #> 3                                                                   Unchecked
    #> 4                                                                   Unchecked
    #> 5                                                                   Unchecked
    #> 6                                                                   Unchecked
    #>   Funder.Name..choice.Russell.Sage.Foundation.
    #> 1                                    Unchecked
    #> 2                                    Unchecked
    #> 3                                    Unchecked
    #> 4                                    Unchecked
    #> 5                                    Unchecked
    #> 6                                    Unchecked
    #>   Funder.Name..choice.Russian.Science.Foundation.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Name..choice.Ryerson.University.
    #> 1                               Unchecked
    #> 2                               Unchecked
    #> 3                               Unchecked
    #> 4                               Unchecked
    #> 5                               Unchecked
    #> 6                               Unchecked
    #>   Funder.Name..choice.São.Paulo.Research.Foundation.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.Saskatchewan.Health.Research.Foundation.
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Name..choice.Science.Foundation.Ireland..SFI..Ireland.
    #> 1                                                     Unchecked
    #> 2                                                     Unchecked
    #> 3                                                     Unchecked
    #> 4                                                     Unchecked
    #> 5                                                     Unchecked
    #> 6                                                     Unchecked
    #>   Funder.Name..choice.Secretaría.Nacional.de.Ciencia..Tecnología.e.Innovación..SENACYT..
    #> 1                                                                              Unchecked
    #> 2                                                                              Unchecked
    #> 3                                                                              Unchecked
    #> 4                                                                              Unchecked
    #> 5                                                                              Unchecked
    #> 6                                                                              Unchecked
    #>   Funder.Name..choice.SERB.India. Funder.Name..choice.SFI.Ireland.
    #> 1                       Unchecked                        Unchecked
    #> 2                       Unchecked                        Unchecked
    #> 3                       Unchecked                        Unchecked
    #> 4                       Unchecked                        Unchecked
    #> 5                       Unchecked                        Unchecked
    #> 6                       Unchecked                        Unchecked
    #>   Funder.Name..choice.Shastri.Indo.Canadian.Institute.
    #> 1                                            Unchecked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Funder.Name..choice.Sigma.Theta.Tau.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Name..choice.Smart.Computing.for.Innovation..SOSCIP..
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Name..choice.SNF. Funder.Name..choice.Snow.Medical.via.CREID.
    #> 1                Unchecked                                   Unchecked
    #> 2                Unchecked                                   Unchecked
    #> 3                Unchecked                                   Unchecked
    #> 4                Unchecked                                   Unchecked
    #> 5                Unchecked                                   Unchecked
    #> 6                Unchecked                                   Unchecked
    #>   Funder.Name..choice.SNSF.
    #> 1                 Unchecked
    #> 2                 Unchecked
    #> 3                 Unchecked
    #> 4                 Unchecked
    #> 5                 Unchecked
    #> 6                 Unchecked
    #>   Funder.Name..choice.Social.Sciences.Research.Council..SSRC..
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Name..choice.Sociedad.Espanola.De.Cardiologia.
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Funder.Name..choice.Solidarity.Fund.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Name..choice.South.Africa.Department.of.Science.and.Innovation.
    #> 1                                                              Unchecked
    #> 2                                                              Unchecked
    #> 3                                                              Unchecked
    #> 4                                                              Unchecked
    #> 5                                                              Unchecked
    #> 6                                                              Unchecked
    #>   Funder.Name..choice.South.African.Medical.Research.Council..SAMRC..
    #> 1                                                           Unchecked
    #> 2                                                           Unchecked
    #> 3                                                           Unchecked
    #> 4                                                           Unchecked
    #> 5                                                           Unchecked
    #> 6                                                           Unchecked
    #>   Funder.Name..choice.Southeast.Asia.Engineering.Education.Development.Network.
    #> 1                                                                     Unchecked
    #> 2                                                                     Unchecked
    #> 3                                                                     Unchecked
    #> 4                                                                     Unchecked
    #> 5                                                                     Unchecked
    #> 6                                                                     Unchecked
    #>   Funder.Name..choice.Spanish.Society.of.Pneumology.and.Thoracic.Surgery..SEPAR..
    #> 1                                                                       Unchecked
    #> 2                                                                       Unchecked
    #> 3                                                                       Unchecked
    #> 4                                                                       Unchecked
    #> 5                                                                       Unchecked
    #> 6                                                                       Unchecked
    #>   Funder.Name..choice.Spencer.Foundation. Funder.Name..choice.SSHRC.
    #> 1                               Unchecked                  Unchecked
    #> 2                               Unchecked                  Unchecked
    #> 3                               Unchecked                  Unchecked
    #> 4                               Unchecked                  Unchecked
    #> 5                               Unchecked                  Unchecked
    #> 6                               Unchecked                  Unchecked
    #>   Funder.Name..choice.State.Secretariat.for.Education..Research..and.Innovation.SERI..Staatssekretariat.für.Bildung..Forschung.und.Innovation..
    #> 1                                                                                                                                     Unchecked
    #> 2                                                                                                                                     Unchecked
    #> 3                                                                                                                                     Unchecked
    #> 4                                                                                                                                     Unchecked
    #> 5                                                                                                                                     Unchecked
    #> 6                                                                                                                                     Unchecked
    #>   Funder.Name..choice.SVRI. Funder.Name..choice.Swedish.Research.Council.
    #> 1                 Unchecked                                     Unchecked
    #> 2                 Unchecked                                     Unchecked
    #> 3                 Unchecked                                     Unchecked
    #> 4                 Unchecked                                     Unchecked
    #> 5                 Unchecked                                     Unchecked
    #> 6                 Unchecked                                     Unchecked
    #>   Funder.Name..choice.Swiss.National.Science.Foundation..SNSF..
    #> 1                                                     Unchecked
    #> 2                                                     Unchecked
    #> 3                                                     Unchecked
    #> 4                                                     Unchecked
    #> 5                                                     Unchecked
    #> 6                                                     Unchecked
    #>   Funder.Name..choice.Swiss.Office.of.Energy..SFOE..
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.Technology.Innovation.Agency.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Funder.Name..choice.Telethon.Foundation.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.The.Forum.for.Ethical.Review.Committees.in.the.Asian.and.Western.Pacific.Region..FERCAP..
    #> 1                                                                                                     Unchecked
    #> 2                                                                                                     Unchecked
    #> 3                                                                                                     Unchecked
    #> 4                                                                                                     Unchecked
    #> 5                                                                                                     Unchecked
    #> 6                                                                                                     Unchecked
    #>   Funder.Name..choice.The.Health.Foundation.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Funder.Name..choice.The.Leona.M..and.Harry.B..Helmsley.Charitable.Trust.
    #> 1                                                                Unchecked
    #> 2                                                                Unchecked
    #> 3                                                                Unchecked
    #> 4                                                                Unchecked
    #> 5                                                                Unchecked
    #> 6                                                                Unchecked
    #>   Funder.Name..choice.The.Ottawa.Hospital.Foundation.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Name..choice.The.Structural.Genomics.Consortium..SGC..
    #> 1                                                     Unchecked
    #> 2                                                     Unchecked
    #> 3                                                     Unchecked
    #> 4                                                     Unchecked
    #> 5                                                     Unchecked
    #> 6                                                     Unchecked
    #>   Funder.Name..choice.The.Swedish.Foundation.for.International.Cooperation.in.Research.and.Higher.Education..STINT..
    #> 1                                                                                                          Unchecked
    #> 2                                                                                                          Unchecked
    #> 3                                                                                                          Unchecked
    #> 4                                                                                                          Unchecked
    #> 5                                                                                                          Unchecked
    #> 6                                                                                                          Unchecked
    #>   Funder.Name..choice.The.University.of.Iowa.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.Therapeutic.Innovation.Australia.
    #> 1                                             Unchecked
    #> 2                                             Unchecked
    #> 3                                             Unchecked
    #> 4                                             Unchecked
    #> 5                                             Unchecked
    #> 6                                             Unchecked
    #>   Funder.Name..choice.Trond.Mohn.Foundation. Funder.Name..choice.TUBITAK.
    #> 1                                  Unchecked                    Unchecked
    #> 2                                  Unchecked                    Unchecked
    #> 3                                  Unchecked                    Unchecked
    #> 4                                  Unchecked                    Unchecked
    #> 5                                  Unchecked                    Unchecked
    #> 6                                  Unchecked                    Unchecked
    #>   Funder.Name..choice.TV3.Foundation.
    #> 1                           Unchecked
    #> 2                           Unchecked
    #> 3                           Unchecked
    #> 4                           Unchecked
    #> 5                           Unchecked
    #> 6                           Unchecked
    #>   Funder.Name..choice.UCB.Community.Health.Fund.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.UFM.Denmark. Funder.Name..choice.UFRJ..Brazil..
    #> 1                        Unchecked                          Unchecked
    #> 2                        Unchecked                          Unchecked
    #> 3                        Unchecked                          Unchecked
    #> 4                        Unchecked                          Unchecked
    #> 5                        Unchecked                          Unchecked
    #> 6                        Unchecked                          Unchecked
    #>   Funder.Name..choice.UK.Research.and.Innovation..UKRI..
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.UNICEF. Funder.Name..choice.UNITAID.
    #> 1                   Unchecked                    Unchecked
    #> 2                   Unchecked                    Unchecked
    #> 3                   Unchecked                    Unchecked
    #> 4                   Unchecked                    Unchecked
    #> 5                   Unchecked                    Unchecked
    #> 6                   Unchecked                    Unchecked
    #>   Funder.Name..choice.United.States.Agency.for.International.Development..USAID...Pact.
    #> 1                                                                             Unchecked
    #> 2                                                                             Unchecked
    #> 3                                                                             Unchecked
    #> 4                                                                             Unchecked
    #> 5                                                                             Unchecked
    #> 6                                                                             Unchecked
    #>   Funder.Name..choice.Universidad.de.los.Llanos.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.University.College.London.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.University.of.Auckland.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.University.of.Basel.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.University.of.Birmingham.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Name..choice.University.of.British.Columbia..UBC..
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Name..choice.University.of.Calgary.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Funder.Name..choice.University.of.Calgary..Alberta.Health.Services.
    #> 1                                                           Unchecked
    #> 2                                                           Unchecked
    #> 3                                                           Unchecked
    #> 4                                                           Unchecked
    #> 5                                                           Unchecked
    #> 6                                                           Unchecked
    #>   Funder.Name..choice.University.of.California.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Name..choice.University.of.Colorado.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.University.of.Edinburgh.
    #> 1                                    Unchecked
    #> 2                                    Unchecked
    #> 3                                    Unchecked
    #> 4                                    Unchecked
    #> 5                                    Unchecked
    #> 6                                    Unchecked
    #>   Funder.Name..choice.University.of.Indiana.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Funder.Name..choice.University.of.Maryland.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.University.of.Michigan.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Name..choice.University.of.Minnesota.
    #> 1                                    Unchecked
    #> 2                                    Unchecked
    #> 3                                    Unchecked
    #> 4                                    Unchecked
    #> 5                                    Unchecked
    #> 6                                    Unchecked
    #>   Funder.Name..choice.University.of.Modena.and.Reggio.Emilia.
    #> 1                                                   Unchecked
    #> 2                                                   Unchecked
    #> 3                                                   Unchecked
    #> 4                                                   Unchecked
    #> 5                                                   Unchecked
    #> 6                                                   Unchecked
    #>   Funder.Name..choice.University.of.New.Hampshire.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Name..choice.University.of.New.South.Wales.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Name..choice.University.of.Oxford.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Name..choice.University.of.Pittsburgh.Clinical.and.Translational.Science.Institute..CTSI..
    #> 1                                                                                         Unchecked
    #> 2                                                                                         Unchecked
    #> 3                                                                                         Unchecked
    #> 4                                                                                         Unchecked
    #> 5                                                                                         Unchecked
    #> 6                                                                                         Unchecked
    #>   Funder.Name..choice.University.of.São.Paulo.
    #> 1                                    Unchecked
    #> 2                                    Unchecked
    #> 3                                    Unchecked
    #> 4                                    Unchecked
    #> 5                                    Unchecked
    #> 6                                    Unchecked
    #>   Funder.Name..choice.USDA.National.Institute.of.Food.and.Agriculture..USDA...NIFA..
    #> 1                                                                          Unchecked
    #> 2                                                                          Unchecked
    #> 3                                                                          Unchecked
    #> 4                                                                          Unchecked
    #> 5                                                                          Unchecked
    #> 6                                                                          Unchecked
    #>   Funder.Name..choice.Vancouver.Coastal.Health.Research.Institute.
    #> 1                                                        Unchecked
    #> 2                                                        Unchecked
    #> 3                                                        Unchecked
    #> 4                                                        Unchecked
    #> 5                                                        Unchecked
    #> 6                                                        Unchecked
    #>   Funder.Name..choice.Víctor.Grífols.i.Lucas.Foundation.
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Name..choice.Victoria.State.Government..Australia..
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Funder.Name..choice.Vingroup. Funder.Name..choice.Vinnova.
    #> 1                     Unchecked                    Unchecked
    #> 2                     Unchecked                    Unchecked
    #> 3                     Unchecked                    Unchecked
    #> 4                     Unchecked                    Unchecked
    #> 5                     Unchecked                    Unchecked
    #> 6                     Unchecked                    Unchecked
    #>   Funder.Name..choice.Visegrad. Funder.Name..choice.Vital.Strategies.
    #> 1                     Unchecked                             Unchecked
    #> 2                     Unchecked                             Unchecked
    #> 3                     Unchecked                             Unchecked
    #> 4                     Unchecked                             Unchecked
    #> 5                     Unchecked                             Unchecked
    #> 6                     Unchecked                             Unchecked
    #>   Funder.Name..choice.Volkswagen.Stiftung.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Name..choice.WE.SPARK.HEALTH.Institute.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Name..choice.Wellcome.Centre.for.Infectious.Diseases.Research.in.Africa..CIDRI.Africa..
    #> 1                                                                                      Unchecked
    #> 2                                                                                      Unchecked
    #> 3                                                                                      Unchecked
    #> 4                                                                                      Unchecked
    #> 5                                                                                      Unchecked
    #> 6                                                                                      Unchecked
    #>   Funder.Name..choice.Wellcome.Trust. Funder.Name..choice.Western.University.
    #> 1                             Checked                               Unchecked
    #> 2                             Checked                               Unchecked
    #> 3                             Checked                               Unchecked
    #> 4                             Checked                               Unchecked
    #> 5                             Checked                               Unchecked
    #> 6                             Checked                               Unchecked
    #>   Funder.Name..choice.WHO. Funder.Name..choice.William.T..Grant.Foundation.
    #> 1                Unchecked                                        Unchecked
    #> 2                Unchecked                                        Unchecked
    #> 3                Unchecked                                        Unchecked
    #> 4                Unchecked                                        Unchecked
    #> 5                Unchecked                                        Unchecked
    #> 6                Unchecked                                        Unchecked
    #>   Funder.Name..choice.World.Heart.Federation..WHF..
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Funder.Name..choice.WWTF.Austria. Funder.Name..choice.Yale.University.
    #> 1                         Unchecked                            Unchecked
    #> 2                         Unchecked                            Unchecked
    #> 3                         Unchecked                            Unchecked
    #> 4                         Unchecked                            Unchecked
    #> 5                         Unchecked                            Unchecked
    #> 6                         Unchecked                            Unchecked
    #>   Funder.Name..choice.York.University.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Name..choice.Zurich.University.of.Applied.Sciences..FHNW..Leading.House.for.South.Asia.and.Iran.
    #> 1                                                                                               Unchecked
    #> 2                                                                                               Unchecked
    #> 3                                                                                               Unchecked
    #> 4                                                                                               Unchecked
    #> 5                                                                                               Unchecked
    #> 6                                                                                               Unchecked
    #>   Funder.Country..choice.Afghanistan. Funder.Country..choice.Åland.Islands.
    #> 1                           Unchecked                             Unchecked
    #> 2                           Unchecked                             Unchecked
    #> 3                           Unchecked                             Unchecked
    #> 4                           Unchecked                             Unchecked
    #> 5                           Unchecked                             Unchecked
    #> 6                           Unchecked                             Unchecked
    #>   Funder.Country..choice.Albania. Funder.Country..choice.Algeria.
    #> 1                       Unchecked                       Unchecked
    #> 2                       Unchecked                       Unchecked
    #> 3                       Unchecked                       Unchecked
    #> 4                       Unchecked                       Unchecked
    #> 5                       Unchecked                       Unchecked
    #> 6                       Unchecked                       Unchecked
    #>   Funder.Country..choice.American.Samoa. Funder.Country..choice.Andorra.
    #> 1                              Unchecked                       Unchecked
    #> 2                              Unchecked                       Unchecked
    #> 3                              Unchecked                       Unchecked
    #> 4                              Unchecked                       Unchecked
    #> 5                              Unchecked                       Unchecked
    #> 6                              Unchecked                       Unchecked
    #>   Funder.Country..choice.Angola. Funder.Country..choice.Anguilla.
    #> 1                      Unchecked                        Unchecked
    #> 2                      Unchecked                        Unchecked
    #> 3                      Unchecked                        Unchecked
    #> 4                      Unchecked                        Unchecked
    #> 5                      Unchecked                        Unchecked
    #> 6                      Unchecked                        Unchecked
    #>   Funder.Country..choice.Antarctica.
    #> 1                          Unchecked
    #> 2                          Unchecked
    #> 3                          Unchecked
    #> 4                          Unchecked
    #> 5                          Unchecked
    #> 6                          Unchecked
    #>   Funder.Country..choice.Antigua.and.Barbuda. Funder.Country..choice.Argentina.
    #> 1                                   Unchecked                         Unchecked
    #> 2                                   Unchecked                         Unchecked
    #> 3                                   Unchecked                         Unchecked
    #> 4                                   Unchecked                         Unchecked
    #> 5                                   Unchecked                         Unchecked
    #> 6                                   Unchecked                         Unchecked
    #>   Funder.Country..choice.Armenia. Funder.Country..choice.Aruba.
    #> 1                       Unchecked                     Unchecked
    #> 2                       Unchecked                     Unchecked
    #> 3                       Unchecked                     Unchecked
    #> 4                       Unchecked                     Unchecked
    #> 5                       Unchecked                     Unchecked
    #> 6                       Unchecked                     Unchecked
    #>   Funder.Country..choice.Australia. Funder.Country..choice.Austria.
    #> 1                         Unchecked                       Unchecked
    #> 2                         Unchecked                       Unchecked
    #> 3                         Unchecked                       Unchecked
    #> 4                         Unchecked                       Unchecked
    #> 5                         Unchecked                       Unchecked
    #> 6                         Unchecked                       Unchecked
    #>   Funder.Country..choice.Azerbaijan. Funder.Country..choice.Bahamas.
    #> 1                          Unchecked                       Unchecked
    #> 2                          Unchecked                       Unchecked
    #> 3                          Unchecked                       Unchecked
    #> 4                          Unchecked                       Unchecked
    #> 5                          Unchecked                       Unchecked
    #> 6                          Unchecked                       Unchecked
    #>   Funder.Country..choice.Bahrain. Funder.Country..choice.Bangladesh.
    #> 1                       Unchecked                          Unchecked
    #> 2                       Unchecked                          Unchecked
    #> 3                       Unchecked                          Unchecked
    #> 4                       Unchecked                          Unchecked
    #> 5                       Unchecked                          Unchecked
    #> 6                       Unchecked                          Unchecked
    #>   Funder.Country..choice.Barbados. Funder.Country..choice.Belarus.
    #> 1                        Unchecked                       Unchecked
    #> 2                        Unchecked                       Unchecked
    #> 3                        Unchecked                       Unchecked
    #> 4                        Unchecked                       Unchecked
    #> 5                        Unchecked                       Unchecked
    #> 6                        Unchecked                       Unchecked
    #>   Funder.Country..choice.Belgium. Funder.Country..choice.Belize.
    #> 1                       Unchecked                      Unchecked
    #> 2                       Unchecked                      Unchecked
    #> 3                       Unchecked                      Unchecked
    #> 4                       Unchecked                      Unchecked
    #> 5                       Unchecked                      Unchecked
    #> 6                       Unchecked                      Unchecked
    #>   Funder.Country..choice.Benin. Funder.Country..choice.Bermuda.
    #> 1                     Unchecked                       Unchecked
    #> 2                     Unchecked                       Unchecked
    #> 3                     Unchecked                       Unchecked
    #> 4                     Unchecked                       Unchecked
    #> 5                     Unchecked                       Unchecked
    #> 6                     Unchecked                       Unchecked
    #>   Funder.Country..choice.Bhutan. Funder.Country..choice.Bolivia.
    #> 1                      Unchecked                       Unchecked
    #> 2                      Unchecked                       Unchecked
    #> 3                      Unchecked                       Unchecked
    #> 4                      Unchecked                       Unchecked
    #> 5                      Unchecked                       Unchecked
    #> 6                      Unchecked                       Unchecked
    #>   Funder.Country..choice.Bonaire.
    #> 1                       Unchecked
    #> 2                       Unchecked
    #> 3                       Unchecked
    #> 4                       Unchecked
    #> 5                       Unchecked
    #> 6                       Unchecked
    #>   Funder.Country..choice.Bosnia.and.Herzegovina.
    #> 1                                      Unchecked
    #> 2                                      Unchecked
    #> 3                                      Unchecked
    #> 4                                      Unchecked
    #> 5                                      Unchecked
    #> 6                                      Unchecked
    #>   Funder.Country..choice.Botswana. Funder.Country..choice.Bouvet.Island.
    #> 1                        Unchecked                             Unchecked
    #> 2                        Unchecked                             Unchecked
    #> 3                        Unchecked                             Unchecked
    #> 4                        Unchecked                             Unchecked
    #> 5                        Unchecked                             Unchecked
    #> 6                        Unchecked                             Unchecked
    #>   Funder.Country..choice.Brazil.
    #> 1                      Unchecked
    #> 2                      Unchecked
    #> 3                      Unchecked
    #> 4                      Unchecked
    #> 5                      Unchecked
    #> 6                      Unchecked
    #>   Funder.Country..choice.British.Indian.Ocean.Territory.
    #> 1                                              Unchecked
    #> 2                                              Unchecked
    #> 3                                              Unchecked
    #> 4                                              Unchecked
    #> 5                                              Unchecked
    #> 6                                              Unchecked
    #>   Funder.Country..choice.Brunei.Darussalam. Funder.Country..choice.Bulgaria.
    #> 1                                 Unchecked                        Unchecked
    #> 2                                 Unchecked                        Unchecked
    #> 3                                 Unchecked                        Unchecked
    #> 4                                 Unchecked                        Unchecked
    #> 5                                 Unchecked                        Unchecked
    #> 6                                 Unchecked                        Unchecked
    #>   Funder.Country..choice.Burkina.Faso. Funder.Country..choice.Burundi.
    #> 1                            Unchecked                       Unchecked
    #> 2                            Unchecked                       Unchecked
    #> 3                            Unchecked                       Unchecked
    #> 4                            Unchecked                       Unchecked
    #> 5                            Unchecked                       Unchecked
    #> 6                            Unchecked                       Unchecked
    #>   Funder.Country..choice.Cabo.Verde. Funder.Country..choice.Cambodia.
    #> 1                          Unchecked                        Unchecked
    #> 2                          Unchecked                        Unchecked
    #> 3                          Unchecked                        Unchecked
    #> 4                          Unchecked                        Unchecked
    #> 5                          Unchecked                        Unchecked
    #> 6                          Unchecked                        Unchecked
    #>   Funder.Country..choice.Cameroon. Funder.Country..choice.Canada.
    #> 1                        Unchecked                      Unchecked
    #> 2                        Unchecked                      Unchecked
    #> 3                        Unchecked                      Unchecked
    #> 4                        Unchecked                      Unchecked
    #> 5                        Unchecked                      Unchecked
    #> 6                        Unchecked                      Unchecked
    #>   Funder.Country..choice.Cayman.Islands.
    #> 1                              Unchecked
    #> 2                              Unchecked
    #> 3                              Unchecked
    #> 4                              Unchecked
    #> 5                              Unchecked
    #> 6                              Unchecked
    #>   Funder.Country..choice.Central.African.Republic. Funder.Country..choice.Chad.
    #> 1                                        Unchecked                    Unchecked
    #> 2                                        Unchecked                    Unchecked
    #> 3                                        Unchecked                    Unchecked
    #> 4                                        Unchecked                    Unchecked
    #> 5                                        Unchecked                    Unchecked
    #> 6                                        Unchecked                    Unchecked
    #>   Funder.Country..choice.Chile. Funder.Country..choice.China.
    #> 1                     Unchecked                     Unchecked
    #> 2                     Unchecked                     Unchecked
    #> 3                     Unchecked                     Unchecked
    #> 4                     Unchecked                     Unchecked
    #> 5                     Unchecked                     Unchecked
    #> 6                     Unchecked                     Unchecked
    #>   Funder.Country..choice.Christmas.Island.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Country..choice.Cocos..Keeling..Islands.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Funder.Country..choice.Colombia. Funder.Country..choice.Comoros.
    #> 1                        Unchecked                       Unchecked
    #> 2                        Unchecked                       Unchecked
    #> 3                        Unchecked                       Unchecked
    #> 4                        Unchecked                       Unchecked
    #> 5                        Unchecked                       Unchecked
    #> 6                        Unchecked                       Unchecked
    #>   Funder.Country..choice.Congo. Funder.Country..choice.Congo..DRC..
    #> 1                     Unchecked                           Unchecked
    #> 2                     Unchecked                           Unchecked
    #> 3                     Unchecked                           Unchecked
    #> 4                     Unchecked                           Unchecked
    #> 5                     Unchecked                           Unchecked
    #> 6                     Unchecked                           Unchecked
    #>   Funder.Country..choice.Cook.Islands. Funder.Country..choice.Costa.Rica.
    #> 1                            Unchecked                          Unchecked
    #> 2                            Unchecked                          Unchecked
    #> 3                            Unchecked                          Unchecked
    #> 4                            Unchecked                          Unchecked
    #> 5                            Unchecked                          Unchecked
    #> 6                            Unchecked                          Unchecked
    #>   Funder.Country..choice.Cote.dIvoire. Funder.Country..choice.Croatia.
    #> 1                            Unchecked                       Unchecked
    #> 2                            Unchecked                       Unchecked
    #> 3                            Unchecked                       Unchecked
    #> 4                            Unchecked                       Unchecked
    #> 5                            Unchecked                       Unchecked
    #> 6                            Unchecked                       Unchecked
    #>   Funder.Country..choice.Cuba. Funder.Country..choice.Curaçao.
    #> 1                    Unchecked                       Unchecked
    #> 2                    Unchecked                       Unchecked
    #> 3                    Unchecked                       Unchecked
    #> 4                    Unchecked                       Unchecked
    #> 5                    Unchecked                       Unchecked
    #> 6                    Unchecked                       Unchecked
    #>   Funder.Country..choice.Cyprus. Funder.Country..choice.Czech.Republic.
    #> 1                      Unchecked                              Unchecked
    #> 2                      Unchecked                              Unchecked
    #> 3                      Unchecked                              Unchecked
    #> 4                      Unchecked                              Unchecked
    #> 5                      Unchecked                              Unchecked
    #> 6                      Unchecked                              Unchecked
    #>   Funder.Country..choice.Denmark. Funder.Country..choice.Djibouti.
    #> 1                       Unchecked                        Unchecked
    #> 2                       Unchecked                        Unchecked
    #> 3                       Unchecked                        Unchecked
    #> 4                       Unchecked                        Unchecked
    #> 5                       Unchecked                        Unchecked
    #> 6                       Unchecked                        Unchecked
    #>   Funder.Country..choice.Dominica. Funder.Country..choice.Dominican.Republic.
    #> 1                        Unchecked                                  Unchecked
    #> 2                        Unchecked                                  Unchecked
    #> 3                        Unchecked                                  Unchecked
    #> 4                        Unchecked                                  Unchecked
    #> 5                        Unchecked                                  Unchecked
    #> 6                        Unchecked                                  Unchecked
    #>   Funder.Country..choice.Ecuador. Funder.Country..choice.Egypt.
    #> 1                       Unchecked                     Unchecked
    #> 2                       Unchecked                     Unchecked
    #> 3                       Unchecked                     Unchecked
    #> 4                       Unchecked                     Unchecked
    #> 5                       Unchecked                     Unchecked
    #> 6                       Unchecked                     Unchecked
    #>   Funder.Country..choice.El.Salvador. Funder.Country..choice.Equatorial.Guinea.
    #> 1                           Unchecked                                 Unchecked
    #> 2                           Unchecked                                 Unchecked
    #> 3                           Unchecked                                 Unchecked
    #> 4                           Unchecked                                 Unchecked
    #> 5                           Unchecked                                 Unchecked
    #> 6                           Unchecked                                 Unchecked
    #>   Funder.Country..choice.Eritrea. Funder.Country..choice.Estonia.
    #> 1                       Unchecked                       Unchecked
    #> 2                       Unchecked                       Unchecked
    #> 3                       Unchecked                       Unchecked
    #> 4                       Unchecked                       Unchecked
    #> 5                       Unchecked                       Unchecked
    #> 6                       Unchecked                       Unchecked
    #>   Funder.Country..choice.Eswatini. Funder.Country..choice.Ethiopia.
    #> 1                        Unchecked                        Unchecked
    #> 2                        Unchecked                        Unchecked
    #> 3                        Unchecked                        Unchecked
    #> 4                        Unchecked                        Unchecked
    #> 5                        Unchecked                        Unchecked
    #> 6                        Unchecked                        Unchecked
    #>   Funder.Country..choice.Falkland.Islands.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Country..choice.Faroe.Islands. Funder.Country..choice.Fiji.
    #> 1                             Unchecked                    Unchecked
    #> 2                             Unchecked                    Unchecked
    #> 3                             Unchecked                    Unchecked
    #> 4                             Unchecked                    Unchecked
    #> 5                             Unchecked                    Unchecked
    #> 6                             Unchecked                    Unchecked
    #>   Funder.Country..choice.Finland. Funder.Country..choice.France.
    #> 1                       Unchecked                      Unchecked
    #> 2                       Unchecked                      Unchecked
    #> 3                       Unchecked                      Unchecked
    #> 4                       Unchecked                      Unchecked
    #> 5                       Unchecked                      Unchecked
    #> 6                       Unchecked                      Unchecked
    #>   Funder.Country..choice.French.Guiana.
    #> 1                             Unchecked
    #> 2                             Unchecked
    #> 3                             Unchecked
    #> 4                             Unchecked
    #> 5                             Unchecked
    #> 6                             Unchecked
    #>   Funder.Country..choice.French.Polynesia.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                Unchecked
    #>   Funder.Country..choice.French.Southern.Territories.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Country..choice.Gabon. Funder.Country..choice.Gambia.
    #> 1                     Unchecked                      Unchecked
    #> 2                     Unchecked                      Unchecked
    #> 3                     Unchecked                      Unchecked
    #> 4                     Unchecked                      Unchecked
    #> 5                     Unchecked                      Unchecked
    #> 6                     Unchecked                      Unchecked
    #>   Funder.Country..choice.Georgia. Funder.Country..choice.Germany.
    #> 1                       Unchecked                       Unchecked
    #> 2                       Unchecked                       Unchecked
    #> 3                       Unchecked                       Unchecked
    #> 4                       Unchecked                       Unchecked
    #> 5                       Unchecked                       Unchecked
    #> 6                       Unchecked                       Unchecked
    #>   Funder.Country..choice.Ghana. Funder.Country..choice.Gibraltar.
    #> 1                     Unchecked                         Unchecked
    #> 2                     Unchecked                         Unchecked
    #> 3                     Unchecked                         Unchecked
    #> 4                     Unchecked                         Unchecked
    #> 5                     Unchecked                         Unchecked
    #> 6                     Unchecked                         Unchecked
    #>   Funder.Country..choice.Greece. Funder.Country..choice.Greenland.
    #> 1                      Unchecked                         Unchecked
    #> 2                      Unchecked                         Unchecked
    #> 3                      Unchecked                         Unchecked
    #> 4                      Unchecked                         Unchecked
    #> 5                      Unchecked                         Unchecked
    #> 6                      Unchecked                         Unchecked
    #>   Funder.Country..choice.Grenada. Funder.Country..choice.Guadeloupe.
    #> 1                       Unchecked                          Unchecked
    #> 2                       Unchecked                          Unchecked
    #> 3                       Unchecked                          Unchecked
    #> 4                       Unchecked                          Unchecked
    #> 5                       Unchecked                          Unchecked
    #> 6                       Unchecked                          Unchecked
    #>   Funder.Country..choice.Guam. Funder.Country..choice.Guatemala.
    #> 1                    Unchecked                         Unchecked
    #> 2                    Unchecked                         Unchecked
    #> 3                    Unchecked                         Unchecked
    #> 4                    Unchecked                         Unchecked
    #> 5                    Unchecked                         Unchecked
    #> 6                    Unchecked                         Unchecked
    #>   Funder.Country..choice.Guernsey. Funder.Country..choice.Guinea.
    #> 1                        Unchecked                      Unchecked
    #> 2                        Unchecked                      Unchecked
    #> 3                        Unchecked                      Unchecked
    #> 4                        Unchecked                      Unchecked
    #> 5                        Unchecked                      Unchecked
    #> 6                        Unchecked                      Unchecked
    #>   Funder.Country..choice.Guinea.Bissau. Funder.Country..choice.Guyana.
    #> 1                             Unchecked                      Unchecked
    #> 2                             Unchecked                      Unchecked
    #> 3                             Unchecked                      Unchecked
    #> 4                             Unchecked                      Unchecked
    #> 5                             Unchecked                      Unchecked
    #> 6                             Unchecked                      Unchecked
    #>   Funder.Country..choice.Haiti.
    #> 1                     Unchecked
    #> 2                     Unchecked
    #> 3                     Unchecked
    #> 4                     Unchecked
    #> 5                     Unchecked
    #> 6                     Unchecked
    #>   Funder.Country..choice.Heard.Island.and.McDonald.Islands.
    #> 1                                                 Unchecked
    #> 2                                                 Unchecked
    #> 3                                                 Unchecked
    #> 4                                                 Unchecked
    #> 5                                                 Unchecked
    #> 6                                                 Unchecked
    #>   Funder.Country..choice.Holy.See. Funder.Country..choice.Honduras.
    #> 1                        Unchecked                        Unchecked
    #> 2                        Unchecked                        Unchecked
    #> 3                        Unchecked                        Unchecked
    #> 4                        Unchecked                        Unchecked
    #> 5                        Unchecked                        Unchecked
    #> 6                        Unchecked                        Unchecked
    #>   Funder.Country..choice.Hong.Kong. Funder.Country..choice.Hungary.
    #> 1                         Unchecked                       Unchecked
    #> 2                         Unchecked                       Unchecked
    #> 3                         Unchecked                       Unchecked
    #> 4                         Unchecked                       Unchecked
    #> 5                         Unchecked                       Unchecked
    #> 6                         Unchecked                       Unchecked
    #>   Funder.Country..choice.Iceland. Funder.Country..choice.India.
    #> 1                       Unchecked                     Unchecked
    #> 2                       Unchecked                     Unchecked
    #> 3                       Unchecked                     Unchecked
    #> 4                       Unchecked                     Unchecked
    #> 5                       Unchecked                     Unchecked
    #> 6                       Unchecked                     Unchecked
    #>   Funder.Country..choice.Indonesia. Funder.Country..choice.Iran.
    #> 1                         Unchecked                    Unchecked
    #> 2                         Unchecked                    Unchecked
    #> 3                         Unchecked                    Unchecked
    #> 4                         Unchecked                    Unchecked
    #> 5                         Unchecked                    Unchecked
    #> 6                         Unchecked                    Unchecked
    #>   Funder.Country..choice.Iraq. Funder.Country..choice.Ireland.
    #> 1                    Unchecked                       Unchecked
    #> 2                    Unchecked                       Unchecked
    #> 3                    Unchecked                       Unchecked
    #> 4                    Unchecked                       Unchecked
    #> 5                    Unchecked                       Unchecked
    #> 6                    Unchecked                       Unchecked
    #>   Funder.Country..choice.Isle.of.Man. Funder.Country..choice.Israel.
    #> 1                           Unchecked                      Unchecked
    #> 2                           Unchecked                      Unchecked
    #> 3                           Unchecked                      Unchecked
    #> 4                           Unchecked                      Unchecked
    #> 5                           Unchecked                      Unchecked
    #> 6                           Unchecked                      Unchecked
    #>   Funder.Country..choice.Italy. Funder.Country..choice.Jamaica.
    #> 1                     Unchecked                       Unchecked
    #> 2                     Unchecked                       Unchecked
    #> 3                     Unchecked                       Unchecked
    #> 4                     Unchecked                       Unchecked
    #> 5                     Unchecked                       Unchecked
    #> 6                     Unchecked                       Unchecked
    #>   Funder.Country..choice.Japan. Funder.Country..choice.Jersey.
    #> 1                     Unchecked                      Unchecked
    #> 2                     Unchecked                      Unchecked
    #> 3                     Unchecked                      Unchecked
    #> 4                     Unchecked                      Unchecked
    #> 5                     Unchecked                      Unchecked
    #> 6                     Unchecked                      Unchecked
    #>   Funder.Country..choice.Jordan. Funder.Country..choice.Kazakhstan.
    #> 1                      Unchecked                          Unchecked
    #> 2                      Unchecked                          Unchecked
    #> 3                      Unchecked                          Unchecked
    #> 4                      Unchecked                          Unchecked
    #> 5                      Unchecked                          Unchecked
    #> 6                      Unchecked                          Unchecked
    #>   Funder.Country..choice.Kenya. Funder.Country..choice.Kiribati.
    #> 1                     Unchecked                        Unchecked
    #> 2                     Unchecked                        Unchecked
    #> 3                     Unchecked                        Unchecked
    #> 4                     Unchecked                        Unchecked
    #> 5                     Unchecked                        Unchecked
    #> 6                     Unchecked                        Unchecked
    #>   Funder.Country..choice.Kuwait. Funder.Country..choice.Kyrgyzstan.
    #> 1                      Unchecked                          Unchecked
    #> 2                      Unchecked                          Unchecked
    #> 3                      Unchecked                          Unchecked
    #> 4                      Unchecked                          Unchecked
    #> 5                      Unchecked                          Unchecked
    #> 6                      Unchecked                          Unchecked
    #>   Funder.Country..choice.Lao.Peoples.Democratic.Republic.
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Funder.Country..choice.Latvia. Funder.Country..choice.Lebanon.
    #> 1                      Unchecked                       Unchecked
    #> 2                      Unchecked                       Unchecked
    #> 3                      Unchecked                       Unchecked
    #> 4                      Unchecked                       Unchecked
    #> 5                      Unchecked                       Unchecked
    #> 6                      Unchecked                       Unchecked
    #>   Funder.Country..choice.Lesotho. Funder.Country..choice.Liberia.
    #> 1                       Unchecked                       Unchecked
    #> 2                       Unchecked                       Unchecked
    #> 3                       Unchecked                       Unchecked
    #> 4                       Unchecked                       Unchecked
    #> 5                       Unchecked                       Unchecked
    #> 6                       Unchecked                       Unchecked
    #>   Funder.Country..choice.Libya. Funder.Country..choice.Liechtenstein.
    #> 1                     Unchecked                             Unchecked
    #> 2                     Unchecked                             Unchecked
    #> 3                     Unchecked                             Unchecked
    #> 4                     Unchecked                             Unchecked
    #> 5                     Unchecked                             Unchecked
    #> 6                     Unchecked                             Unchecked
    #>   Funder.Country..choice.Lithuania. Funder.Country..choice.Luxembourg.
    #> 1                         Unchecked                          Unchecked
    #> 2                         Unchecked                          Unchecked
    #> 3                         Unchecked                          Unchecked
    #> 4                         Unchecked                          Unchecked
    #> 5                         Unchecked                          Unchecked
    #> 6                         Unchecked                          Unchecked
    #>   Funder.Country..choice.Macao. Funder.Country..choice.Madagascar.
    #> 1                     Unchecked                          Unchecked
    #> 2                     Unchecked                          Unchecked
    #> 3                     Unchecked                          Unchecked
    #> 4                     Unchecked                          Unchecked
    #> 5                     Unchecked                          Unchecked
    #> 6                     Unchecked                          Unchecked
    #>   Funder.Country..choice.Malawi. Funder.Country..choice.Malaysia.
    #> 1                      Unchecked                        Unchecked
    #> 2                      Unchecked                        Unchecked
    #> 3                      Unchecked                        Unchecked
    #> 4                      Unchecked                        Unchecked
    #> 5                      Unchecked                        Unchecked
    #> 6                      Unchecked                        Unchecked
    #>   Funder.Country..choice.Maldives. Funder.Country..choice.Mali.
    #> 1                        Unchecked                    Unchecked
    #> 2                        Unchecked                    Unchecked
    #> 3                        Unchecked                    Unchecked
    #> 4                        Unchecked                    Unchecked
    #> 5                        Unchecked                    Unchecked
    #> 6                        Unchecked                    Unchecked
    #>   Funder.Country..choice.Malta. Funder.Country..choice.Marshall.Islands.
    #> 1                     Unchecked                                Unchecked
    #> 2                     Unchecked                                Unchecked
    #> 3                     Unchecked                                Unchecked
    #> 4                     Unchecked                                Unchecked
    #> 5                     Unchecked                                Unchecked
    #> 6                     Unchecked                                Unchecked
    #>   Funder.Country..choice.Martinique. Funder.Country..choice.Mauritania.
    #> 1                          Unchecked                          Unchecked
    #> 2                          Unchecked                          Unchecked
    #> 3                          Unchecked                          Unchecked
    #> 4                          Unchecked                          Unchecked
    #> 5                          Unchecked                          Unchecked
    #> 6                          Unchecked                          Unchecked
    #>   Funder.Country..choice.Mauritius. Funder.Country..choice.Mayotte.
    #> 1                         Unchecked                       Unchecked
    #> 2                         Unchecked                       Unchecked
    #> 3                         Unchecked                       Unchecked
    #> 4                         Unchecked                       Unchecked
    #> 5                         Unchecked                       Unchecked
    #> 6                         Unchecked                       Unchecked
    #>   Funder.Country..choice.Mexico. Funder.Country..choice.Micronesia.
    #> 1                      Unchecked                          Unchecked
    #> 2                      Unchecked                          Unchecked
    #> 3                      Unchecked                          Unchecked
    #> 4                      Unchecked                          Unchecked
    #> 5                      Unchecked                          Unchecked
    #> 6                      Unchecked                          Unchecked
    #>   Funder.Country..choice.Moldova. Funder.Country..choice.Monaco.
    #> 1                       Unchecked                      Unchecked
    #> 2                       Unchecked                      Unchecked
    #> 3                       Unchecked                      Unchecked
    #> 4                       Unchecked                      Unchecked
    #> 5                       Unchecked                      Unchecked
    #> 6                       Unchecked                      Unchecked
    #>   Funder.Country..choice.Mongolia. Funder.Country..choice.Montenegro.
    #> 1                        Unchecked                          Unchecked
    #> 2                        Unchecked                          Unchecked
    #> 3                        Unchecked                          Unchecked
    #> 4                        Unchecked                          Unchecked
    #> 5                        Unchecked                          Unchecked
    #> 6                        Unchecked                          Unchecked
    #>   Funder.Country..choice.Montserrat. Funder.Country..choice.Morocco.
    #> 1                          Unchecked                       Unchecked
    #> 2                          Unchecked                       Unchecked
    #> 3                          Unchecked                       Unchecked
    #> 4                          Unchecked                       Unchecked
    #> 5                          Unchecked                       Unchecked
    #> 6                          Unchecked                       Unchecked
    #>   Funder.Country..choice.Mozambique. Funder.Country..choice.Myanmar.
    #> 1                          Unchecked                       Unchecked
    #> 2                          Unchecked                       Unchecked
    #> 3                          Unchecked                       Unchecked
    #> 4                          Unchecked                       Unchecked
    #> 5                          Unchecked                       Unchecked
    #> 6                          Unchecked                       Unchecked
    #>   Funder.Country..choice.Namibia. Funder.Country..choice.Nauru.
    #> 1                       Unchecked                     Unchecked
    #> 2                       Unchecked                     Unchecked
    #> 3                       Unchecked                     Unchecked
    #> 4                       Unchecked                     Unchecked
    #> 5                       Unchecked                     Unchecked
    #> 6                       Unchecked                     Unchecked
    #>   Funder.Country..choice.Nepal. Funder.Country..choice.Netherlands.
    #> 1                     Unchecked                           Unchecked
    #> 2                     Unchecked                           Unchecked
    #> 3                     Unchecked                           Unchecked
    #> 4                     Unchecked                           Unchecked
    #> 5                     Unchecked                           Unchecked
    #> 6                     Unchecked                           Unchecked
    #>   Funder.Country..choice.New.Caledonia. Funder.Country..choice.New.Zealand.
    #> 1                             Unchecked                           Unchecked
    #> 2                             Unchecked                           Unchecked
    #> 3                             Unchecked                           Unchecked
    #> 4                             Unchecked                           Unchecked
    #> 5                             Unchecked                           Unchecked
    #> 6                             Unchecked                           Unchecked
    #>   Funder.Country..choice.Nicaragua. Funder.Country..choice.Niger.
    #> 1                         Unchecked                     Unchecked
    #> 2                         Unchecked                     Unchecked
    #> 3                         Unchecked                     Unchecked
    #> 4                         Unchecked                     Unchecked
    #> 5                         Unchecked                     Unchecked
    #> 6                         Unchecked                     Unchecked
    #>   Funder.Country..choice.Nigeria. Funder.Country..choice.Niue.
    #> 1                       Unchecked                    Unchecked
    #> 2                       Unchecked                    Unchecked
    #> 3                       Unchecked                    Unchecked
    #> 4                       Unchecked                    Unchecked
    #> 5                       Unchecked                    Unchecked
    #> 6                       Unchecked                    Unchecked
    #>   Funder.Country..choice.Norfolk.Island. Funder.Country..choice.North.Korea.
    #> 1                              Unchecked                           Unchecked
    #> 2                              Unchecked                           Unchecked
    #> 3                              Unchecked                           Unchecked
    #> 4                              Unchecked                           Unchecked
    #> 5                              Unchecked                           Unchecked
    #> 6                              Unchecked                           Unchecked
    #>   Funder.Country..choice.Northern.Mariana.Islands.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Country..choice.Norway. Funder.Country..choice.Oman.
    #> 1                      Unchecked                    Unchecked
    #> 2                      Unchecked                    Unchecked
    #> 3                      Unchecked                    Unchecked
    #> 4                      Unchecked                    Unchecked
    #> 5                      Unchecked                    Unchecked
    #> 6                      Unchecked                    Unchecked
    #>   Funder.Country..choice.Pakistan. Funder.Country..choice.Palau.
    #> 1                        Unchecked                     Unchecked
    #> 2                        Unchecked                     Unchecked
    #> 3                        Unchecked                     Unchecked
    #> 4                        Unchecked                     Unchecked
    #> 5                        Unchecked                     Unchecked
    #> 6                        Unchecked                     Unchecked
    #>   Funder.Country..choice.Palestine. Funder.Country..choice.Panama.
    #> 1                         Unchecked                      Unchecked
    #> 2                         Unchecked                      Unchecked
    #> 3                         Unchecked                      Unchecked
    #> 4                         Unchecked                      Unchecked
    #> 5                         Unchecked                      Unchecked
    #> 6                         Unchecked                      Unchecked
    #>   Funder.Country..choice.Papua.New.Guinea. Funder.Country..choice.Paraguay.
    #> 1                                Unchecked                        Unchecked
    #> 2                                Unchecked                        Unchecked
    #> 3                                Unchecked                        Unchecked
    #> 4                                Unchecked                        Unchecked
    #> 5                                Unchecked                        Unchecked
    #> 6                                Unchecked                        Unchecked
    #>   Funder.Country..choice.Peru. Funder.Country..choice.Philippines.
    #> 1                    Unchecked                           Unchecked
    #> 2                    Unchecked                           Unchecked
    #> 3                    Unchecked                           Unchecked
    #> 4                    Unchecked                           Unchecked
    #> 5                    Unchecked                           Unchecked
    #> 6                    Unchecked                           Unchecked
    #>   Funder.Country..choice.Pitcairn. Funder.Country..choice.Poland.
    #> 1                        Unchecked                      Unchecked
    #> 2                        Unchecked                      Unchecked
    #> 3                        Unchecked                      Unchecked
    #> 4                        Unchecked                      Unchecked
    #> 5                        Unchecked                      Unchecked
    #> 6                        Unchecked                      Unchecked
    #>   Funder.Country..choice.Portugal. Funder.Country..choice.Puerto.Rico.
    #> 1                        Unchecked                           Unchecked
    #> 2                        Unchecked                           Unchecked
    #> 3                        Unchecked                           Unchecked
    #> 4                        Unchecked                           Unchecked
    #> 5                        Unchecked                           Unchecked
    #> 6                        Unchecked                           Unchecked
    #>   Funder.Country..choice.Qatar.
    #> 1                     Unchecked
    #> 2                     Unchecked
    #> 3                     Unchecked
    #> 4                     Unchecked
    #> 5                     Unchecked
    #> 6                     Unchecked
    #>   Funder.Country..choice.Republic.of.North.Macedonia.
    #> 1                                           Unchecked
    #> 2                                           Unchecked
    #> 3                                           Unchecked
    #> 4                                           Unchecked
    #> 5                                           Unchecked
    #> 6                                           Unchecked
    #>   Funder.Country..choice.Réunion. Funder.Country..choice.Romania.
    #> 1                       Unchecked                       Unchecked
    #> 2                       Unchecked                       Unchecked
    #> 3                       Unchecked                       Unchecked
    #> 4                       Unchecked                       Unchecked
    #> 5                       Unchecked                       Unchecked
    #> 6                       Unchecked                       Unchecked
    #>   Funder.Country..choice.Russia. Funder.Country..choice.Rwanda.
    #> 1                      Unchecked                      Unchecked
    #> 2                      Unchecked                      Unchecked
    #> 3                      Unchecked                      Unchecked
    #> 4                      Unchecked                      Unchecked
    #> 5                      Unchecked                      Unchecked
    #> 6                      Unchecked                      Unchecked
    #>   Funder.Country..choice.Saint.Barthelemy. Funder.Country..choice.Saint.Helena.
    #> 1                                Unchecked                            Unchecked
    #> 2                                Unchecked                            Unchecked
    #> 3                                Unchecked                            Unchecked
    #> 4                                Unchecked                            Unchecked
    #> 5                                Unchecked                            Unchecked
    #> 6                                Unchecked                            Unchecked
    #>   Funder.Country..choice.Saint.Kitts.and.Nevis.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Country..choice.Saint.Lucia.
    #> 1                           Unchecked
    #> 2                           Unchecked
    #> 3                           Unchecked
    #> 4                           Unchecked
    #> 5                           Unchecked
    #> 6                           Unchecked
    #>   Funder.Country..choice.Saint.Martin..French.part..
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Funder.Country..choice.Saint.Pierre.and.Miquelon.
    #> 1                                         Unchecked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Funder.Country..choice.Saint.Vincent.and.the.Grenadines.
    #> 1                                                Unchecked
    #> 2                                                Unchecked
    #> 3                                                Unchecked
    #> 4                                                Unchecked
    #> 5                                                Unchecked
    #> 6                                                Unchecked
    #>   Funder.Country..choice.Samoa. Funder.Country..choice.San.Marino.
    #> 1                     Unchecked                          Unchecked
    #> 2                     Unchecked                          Unchecked
    #> 3                     Unchecked                          Unchecked
    #> 4                     Unchecked                          Unchecked
    #> 5                     Unchecked                          Unchecked
    #> 6                     Unchecked                          Unchecked
    #>   Funder.Country..choice.Sao.Tome.and.Principe.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Funder.Country..choice.Saudi.Arabia. Funder.Country..choice.Senegal.
    #> 1                            Unchecked                       Unchecked
    #> 2                            Unchecked                       Unchecked
    #> 3                            Unchecked                       Unchecked
    #> 4                            Unchecked                       Unchecked
    #> 5                            Unchecked                       Unchecked
    #> 6                            Unchecked                       Unchecked
    #>   Funder.Country..choice.Serbia. Funder.Country..choice.Seychelles.
    #> 1                      Unchecked                          Unchecked
    #> 2                      Unchecked                          Unchecked
    #> 3                      Unchecked                          Unchecked
    #> 4                      Unchecked                          Unchecked
    #> 5                      Unchecked                          Unchecked
    #> 6                      Unchecked                          Unchecked
    #>   Funder.Country..choice.Sierra.Leone. Funder.Country..choice.Singapore.
    #> 1                            Unchecked                         Unchecked
    #> 2                            Unchecked                         Unchecked
    #> 3                            Unchecked                         Unchecked
    #> 4                            Unchecked                         Unchecked
    #> 5                            Unchecked                         Unchecked
    #> 6                            Unchecked                         Unchecked
    #>   Funder.Country..choice.Sint.Maarten. Funder.Country..choice.Slovakia.
    #> 1                            Unchecked                        Unchecked
    #> 2                            Unchecked                        Unchecked
    #> 3                            Unchecked                        Unchecked
    #> 4                            Unchecked                        Unchecked
    #> 5                            Unchecked                        Unchecked
    #> 6                            Unchecked                        Unchecked
    #>   Funder.Country..choice.Slovenia. Funder.Country..choice.Solomon.Islands.
    #> 1                        Unchecked                               Unchecked
    #> 2                        Unchecked                               Unchecked
    #> 3                        Unchecked                               Unchecked
    #> 4                        Unchecked                               Unchecked
    #> 5                        Unchecked                               Unchecked
    #> 6                        Unchecked                               Unchecked
    #>   Funder.Country..choice.Somalia. Funder.Country..choice.South.Africa.
    #> 1                       Unchecked                            Unchecked
    #> 2                       Unchecked                            Unchecked
    #> 3                       Unchecked                            Unchecked
    #> 4                       Unchecked                            Unchecked
    #> 5                       Unchecked                            Unchecked
    #> 6                       Unchecked                            Unchecked
    #>   Funder.Country..choice.South.Georgia.and.the.South.Sandwich.Islands.
    #> 1                                                            Unchecked
    #> 2                                                            Unchecked
    #> 3                                                            Unchecked
    #> 4                                                            Unchecked
    #> 5                                                            Unchecked
    #> 6                                                            Unchecked
    #>   Funder.Country..choice.South.Korea. Funder.Country..choice.South.Sudan.
    #> 1                           Unchecked                           Unchecked
    #> 2                           Unchecked                           Unchecked
    #> 3                           Unchecked                           Unchecked
    #> 4                           Unchecked                           Unchecked
    #> 5                           Unchecked                           Unchecked
    #> 6                           Unchecked                           Unchecked
    #>   Funder.Country..choice.Spain. Funder.Country..choice.Sri.Lanka.
    #> 1                     Unchecked                         Unchecked
    #> 2                     Unchecked                         Unchecked
    #> 3                     Unchecked                         Unchecked
    #> 4                     Unchecked                         Unchecked
    #> 5                     Unchecked                         Unchecked
    #> 6                     Unchecked                         Unchecked
    #>   Funder.Country..choice.Sudan. Funder.Country..choice.Suriname.
    #> 1                     Unchecked                        Unchecked
    #> 2                     Unchecked                        Unchecked
    #> 3                     Unchecked                        Unchecked
    #> 4                     Unchecked                        Unchecked
    #> 5                     Unchecked                        Unchecked
    #> 6                     Unchecked                        Unchecked
    #>   Funder.Country..choice.Svalbard.and.Jan.Mayen. Funder.Country..choice.Sweden.
    #> 1                                      Unchecked                      Unchecked
    #> 2                                      Unchecked                      Unchecked
    #> 3                                      Unchecked                      Unchecked
    #> 4                                      Unchecked                      Unchecked
    #> 5                                      Unchecked                      Unchecked
    #> 6                                      Unchecked                      Unchecked
    #>   Funder.Country..choice.Switzerland.
    #> 1                           Unchecked
    #> 2                           Unchecked
    #> 3                           Unchecked
    #> 4                           Unchecked
    #> 5                           Unchecked
    #> 6                           Unchecked
    #>   Funder.Country..choice.Syrian.Arab.Republic. Funder.Country..choice.Taiwan.
    #> 1                                    Unchecked                      Unchecked
    #> 2                                    Unchecked                      Unchecked
    #> 3                                    Unchecked                      Unchecked
    #> 4                                    Unchecked                      Unchecked
    #> 5                                    Unchecked                      Unchecked
    #> 6                                    Unchecked                      Unchecked
    #>   Funder.Country..choice.Tajikistan. Funder.Country..choice.Tanzania.
    #> 1                          Unchecked                        Unchecked
    #> 2                          Unchecked                        Unchecked
    #> 3                          Unchecked                        Unchecked
    #> 4                          Unchecked                        Unchecked
    #> 5                          Unchecked                        Unchecked
    #> 6                          Unchecked                        Unchecked
    #>   Funder.Country..choice.Thailand. Funder.Country..choice.Timor.Leste.
    #> 1                        Unchecked                           Unchecked
    #> 2                        Unchecked                           Unchecked
    #> 3                        Unchecked                           Unchecked
    #> 4                        Unchecked                           Unchecked
    #> 5                        Unchecked                           Unchecked
    #> 6                        Unchecked                           Unchecked
    #>   Funder.Country..choice.Togo. Funder.Country..choice.Tokelau.
    #> 1                    Unchecked                       Unchecked
    #> 2                    Unchecked                       Unchecked
    #> 3                    Unchecked                       Unchecked
    #> 4                    Unchecked                       Unchecked
    #> 5                    Unchecked                       Unchecked
    #> 6                    Unchecked                       Unchecked
    #>   Funder.Country..choice.Tonga. Funder.Country..choice.Trinidad.and.Tobago.
    #> 1                     Unchecked                                   Unchecked
    #> 2                     Unchecked                                   Unchecked
    #> 3                     Unchecked                                   Unchecked
    #> 4                     Unchecked                                   Unchecked
    #> 5                     Unchecked                                   Unchecked
    #> 6                     Unchecked                                   Unchecked
    #>   Funder.Country..choice.Tunisia. Funder.Country..choice.Turkey.
    #> 1                       Unchecked                      Unchecked
    #> 2                       Unchecked                      Unchecked
    #> 3                       Unchecked                      Unchecked
    #> 4                       Unchecked                      Unchecked
    #> 5                       Unchecked                      Unchecked
    #> 6                       Unchecked                      Unchecked
    #>   Funder.Country..choice.Turkmenistan.
    #> 1                            Unchecked
    #> 2                            Unchecked
    #> 3                            Unchecked
    #> 4                            Unchecked
    #> 5                            Unchecked
    #> 6                            Unchecked
    #>   Funder.Country..choice.Turks.and.Caicos.Islands.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Country..choice.Tuvalu. Funder.Country..choice.Uganda.
    #> 1                      Unchecked                      Unchecked
    #> 2                      Unchecked                      Unchecked
    #> 3                      Unchecked                      Unchecked
    #> 4                      Unchecked                      Unchecked
    #> 5                      Unchecked                      Unchecked
    #> 6                      Unchecked                      Unchecked
    #>   Funder.Country..choice.Ukraine. Funder.Country..choice.United.Arab.Emirates.
    #> 1                       Unchecked                                    Unchecked
    #> 2                       Unchecked                                    Unchecked
    #> 3                       Unchecked                                    Unchecked
    #> 4                       Unchecked                                    Unchecked
    #> 5                       Unchecked                                    Unchecked
    #> 6                       Unchecked                                    Unchecked
    #>   Funder.Country..choice.United.Kingdom.
    #> 1                                Checked
    #> 2                                Checked
    #> 3                                Checked
    #> 4                                Checked
    #> 5                                Checked
    #> 6                                Checked
    #>   Funder.Country..choice.United.States.Minor.Outlying.Islands.
    #> 1                                                    Unchecked
    #> 2                                                    Unchecked
    #> 3                                                    Unchecked
    #> 4                                                    Unchecked
    #> 5                                                    Unchecked
    #> 6                                                    Unchecked
    #>   Funder.Country..choice.United.States.of.America.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Country..choice.Uruguay. Funder.Country..choice.Uzbekistan.
    #> 1                       Unchecked                          Unchecked
    #> 2                       Unchecked                          Unchecked
    #> 3                       Unchecked                          Unchecked
    #> 4                       Unchecked                          Unchecked
    #> 5                       Unchecked                          Unchecked
    #> 6                       Unchecked                          Unchecked
    #>   Funder.Country..choice.Vanuatu. Funder.Country..choice.Venezuela.
    #> 1                       Unchecked                         Unchecked
    #> 2                       Unchecked                         Unchecked
    #> 3                       Unchecked                         Unchecked
    #> 4                       Unchecked                         Unchecked
    #> 5                       Unchecked                         Unchecked
    #> 6                       Unchecked                         Unchecked
    #>   Funder.Country..choice.Viet.Nam.
    #> 1                        Unchecked
    #> 2                        Unchecked
    #> 3                        Unchecked
    #> 4                        Unchecked
    #> 5                        Unchecked
    #> 6                        Unchecked
    #>   Funder.Country..choice.Virgin.Islands..British..
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>   Funder.Country..choice.Virgin.Islands..US..
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                   Unchecked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                   Unchecked
    #>   Funder.Country..choice.Wallis.and.Futuna.
    #> 1                                 Unchecked
    #> 2                                 Unchecked
    #> 3                                 Unchecked
    #> 4                                 Unchecked
    #> 5                                 Unchecked
    #> 6                                 Unchecked
    #>   Funder.Country..choice.Western.Sahara. Funder.Country..choice.Yemen.
    #> 1                              Unchecked                     Unchecked
    #> 2                              Unchecked                     Unchecked
    #> 3                              Unchecked                     Unchecked
    #> 4                              Unchecked                     Unchecked
    #> 5                              Unchecked                     Unchecked
    #> 6                              Unchecked                     Unchecked
    #>   Funder.Country..choice.Zambia. Funder.Country..choice.Zimbabwe.
    #> 1                      Unchecked                        Unchecked
    #> 2                      Unchecked                        Unchecked
    #> 3                      Unchecked                        Unchecked
    #> 4                      Unchecked                        Unchecked
    #> 5                      Unchecked                        Unchecked
    #> 6                      Unchecked                        Unchecked
    #>   Funder.Country..choice.International. Funder.Country..choice.Europe.
    #> 1                             Unchecked                      Unchecked
    #> 2                             Unchecked                      Unchecked
    #> 3                             Unchecked                      Unchecked
    #> 4                             Unchecked                      Unchecked
    #> 5                             Unchecked                      Unchecked
    #> 6                             Unchecked                      Unchecked
    #>   Funder.Country..choice.South.East.Asia.
    #> 1                               Unchecked
    #> 2                               Unchecked
    #> 3                               Unchecked
    #> 4                               Unchecked
    #> 5                               Unchecked
    #> 6                               Unchecked
    #>   Funder.Country..choice.Western.Pacific. Funder.Region..choice.Africa.
    #> 1                               Unchecked                     Unchecked
    #> 2                               Unchecked                     Unchecked
    #> 3                               Unchecked                     Unchecked
    #> 4                               Unchecked                     Unchecked
    #> 5                               Unchecked                     Unchecked
    #> 6                               Unchecked                     Unchecked
    #>   Funder.Region..choice.Americas. Funder.Region..choice.Eastern.Mediterranean.
    #> 1                       Unchecked                                    Unchecked
    #> 2                       Unchecked                                    Unchecked
    #> 3                       Unchecked                                    Unchecked
    #> 4                       Unchecked                                    Unchecked
    #> 5                       Unchecked                                    Unchecked
    #> 6                       Unchecked                                    Unchecked
    #>   Funder.Region..choice.Europe. Funder.Region..choice.International.
    #> 1                       Checked                            Unchecked
    #> 2                       Checked                            Unchecked
    #> 3                       Checked                            Unchecked
    #> 4                       Checked                            Unchecked
    #> 5                       Checked                            Unchecked
    #> 6                       Checked                            Unchecked
    #>   Funder.Region..choice.South.East.Asia. Funder.Region..choice.Western.Pacific.
    #> 1                              Unchecked                              Unchecked
    #> 2                              Unchecked                              Unchecked
    #> 3                              Unchecked                              Unchecked
    #> 4                              Unchecked                              Unchecked
    #> 5                              Unchecked                              Unchecked
    #> 6                              Unchecked                              Unchecked
    #>   Funder.Region..choice.Unspecified. Complete..1        ROR.ID
    #> 1                          Unchecked  Incomplete   grid.4280.e
    #> 2                          Unchecked  Incomplete              
    #> 3                          Unchecked  Incomplete   grid.7372.1
    #> 4                          Unchecked  Incomplete grid.487281.0
    #> 5                          Unchecked  Incomplete grid.416657.7
    #> 6                          Unchecked  Incomplete   grid.4991.5
    #>                                                                         Institution.Name
    #> 1                                                       National University of Singapore
    #> 2                                                MRC/UVRI and LSHTM Uganda Research Unit
    #> 3                                                                  University of Warwick
    #> 4                          Kumasi Center for Collaborative Research in Tropical Medicine
    #> 5 National Institute for Communicable Diseases of the National Health Laboratory Service
    #> 6                                                                   University of Oxford
    #>   Institution.Country institution.Country.ISO
    #> 1           Singapore                     702
    #> 2              Uganda                     800
    #> 3      United Kingdom                     826
    #> 4               Ghana                     288
    #> 5        South Africa                     710
    #> 6      United Kingdom                     826
    #>   Research_Institution_Region..choice.Africa.
    #> 1                                   Unchecked
    #> 2                                     Checked
    #> 3                                   Unchecked
    #> 4                                     Checked
    #> 5                                     Checked
    #> 6                                   Unchecked
    #>   Research_Institution_Region..choice.Americas.
    #> 1                                     Unchecked
    #> 2                                     Unchecked
    #> 3                                     Unchecked
    #> 4                                     Unchecked
    #> 5                                     Unchecked
    #> 6                                     Unchecked
    #>   Research_Institution_Region..choice.Eastern.Mediterranean.
    #> 1                                                  Unchecked
    #> 2                                                  Unchecked
    #> 3                                                  Unchecked
    #> 4                                                  Unchecked
    #> 5                                                  Unchecked
    #> 6                                                  Unchecked
    #>   Research_Institution_Region..choice.Europe.
    #> 1                                   Unchecked
    #> 2                                   Unchecked
    #> 3                                     Checked
    #> 4                                   Unchecked
    #> 5                                   Unchecked
    #> 6                                     Checked
    #>   Research_Institution_Region..choice.International.
    #> 1                                          Unchecked
    #> 2                                          Unchecked
    #> 3                                          Unchecked
    #> 4                                          Unchecked
    #> 5                                          Unchecked
    #> 6                                          Unchecked
    #>   Research_Institution_Region..choice.South.East.Asia.
    #> 1                                            Unchecked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Research_Institution_Region..choice.Western.Pacific.
    #> 1                                              Checked
    #> 2                                            Unchecked
    #> 3                                            Unchecked
    #> 4                                            Unchecked
    #> 5                                            Unchecked
    #> 6                                            Unchecked
    #>   Research_Institution_Region..choice.Unspecified.
    #> 1                                        Unchecked
    #> 2                                        Unchecked
    #> 3                                        Unchecked
    #> 4                                        Unchecked
    #> 5                                        Unchecked
    #> 6                                        Unchecked
    #>        Research.Location.Country Research.Location.Country.ISO
    #> 1 Singapore, Hong Kong, Thailand                 702, 344, 764
    #> 2                                                             
    #> 3                  Uganda, Kenya                      800, 404
    #> 4                                                             
    #> 5                   South Africa                           710
    #> 6                 United Kingdom                           826
    #>   Research.Location.Region..choice.Africa.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                  Checked
    #> 4                                Unchecked
    #> 5                                  Checked
    #> 6                                Unchecked
    #>   Research.Location.Region..choice.Americas.
    #> 1                                  Unchecked
    #> 2                                  Unchecked
    #> 3                                  Unchecked
    #> 4                                  Unchecked
    #> 5                                  Unchecked
    #> 6                                  Unchecked
    #>   Research.Location.Region..choice.Eastern.Mediterranean.
    #> 1                                               Unchecked
    #> 2                                               Unchecked
    #> 3                                               Unchecked
    #> 4                                               Unchecked
    #> 5                                               Unchecked
    #> 6                                               Unchecked
    #>   Research.Location.Region..choice.Europe.
    #> 1                                Unchecked
    #> 2                                Unchecked
    #> 3                                Unchecked
    #> 4                                Unchecked
    #> 5                                Unchecked
    #> 6                                  Checked
    #>   Research.Location.Region..choice.International.
    #> 1                                       Unchecked
    #> 2                                       Unchecked
    #> 3                                       Unchecked
    #> 4                                       Unchecked
    #> 5                                       Unchecked
    #> 6                                       Unchecked
    #>   Research.Location.Region..choice.South.East.Asia.
    #> 1                                           Checked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Research.Location.Region..choice.Western.Pacific.
    #> 1                                           Checked
    #> 2                                         Unchecked
    #> 3                                         Unchecked
    #> 4                                         Unchecked
    #> 5                                         Unchecked
    #> 6                                         Unchecked
    #>   Research.Location.Region..choice.Unspecified. Complete..2
    #> 1                                     Unchecked  Incomplete
    #> 2                                       Checked  Incomplete
    #> 3                                     Unchecked  Incomplete
    #> 4                                       Checked  Incomplete
    #> 5                                     Unchecked  Incomplete
    #> 6                                     Unchecked  Incomplete
    #>   Tags..choice.Data.Management.and.Data.Sharing. Tags..choice.Digital.Health.
    #> 1                                      Unchecked                    Unchecked
    #> 2                                        Checked                    Unchecked
    #> 3                                      Unchecked                    Unchecked
    #> 4                                      Unchecked                    Unchecked
    #> 5                                      Unchecked                    Unchecked
    #> 6                                      Unchecked                    Unchecked
    #>   Tags..choice.Innovation. Tags..choice.Gender.
    #> 1                Unchecked            Unchecked
    #> 2                Unchecked            Unchecked
    #> 3                Unchecked            Unchecked
    #> 4                Unchecked            Unchecked
    #> 5                Unchecked            Unchecked
    #> 6                Unchecked            Unchecked
    #>   Main.Research.Category.Priority.Area.Number..NEW.
    #> 1                                                 3
    #> 2                                          1, 3, 12
    #> 3                                                 3
    #> 4                                                 4
    #> 5                                       1, 3, 4, 10
    #> 6                                                 1
    #>   Main.Research.Sub.Priority.Number.s...NEW.
    #> 1                                     3a, 3b
    #> 2                        1a, 1b, 1c, 3a, 12c
    #> 3                                         3a
    #> 4                                         4c
    #> 5                        1d, 3a, 3b, 4b, 10a
    #> 6                                         1d
    #>   SECONDARY.Research.Category.Priority.Area.Number..NEW.
    #> 1                                                       
    #> 2                                                       
    #> 3                                                       
    #> 4                                                      5
    #> 5                                                       
    #> 6                                                       
    #>   SECONDARY.Research.Sub.Priority.Number.s...NEW. Complete..3
    #> 1                                                    Complete
    #> 2                                                    Complete
    #> 3                                                    Complete
    #> 4                                              5a  Incomplete
    #> 5                                                    Complete
    #> 6                                                    Complete

This reads the *labelled* tracker dataset by default. If the raw dataset
is required, then issue the following command:

``` r
pact_read_data_tracker(tracker_type = "raw")
```

which outputs the following:

    #>   pactid grant_number
    #> 1 SDS001      unknown
    #> 2 C00153      unknown
    #> 3 C00154      unknown
    #> 4 C00155      unknown
    #> 5 C00156      unknown
    #> 6 C00157      unknown
    #>                                                                                                                             grant_title_original
    #> 1                                                                                                                                   Dummy record
    #> 2                                      Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand
    #> 3                                                                                                       African COVID-19 Preparedness (AFRICO19)
    #> 4                                                                                       COVID-19 Intervention Modelling for East Africa  (CIMEA)
    #> 5                            The African coaLition for Epidemic Research, Response and Training, Clinical Characterization Protocol (ALERRT CCP)
    #> 6 Characterization of SARS-CoV-2 transmission dynamics, clinical features and disease impact in South Africa, a setting with high HIV prevalence
    #>                                                                                                                                  grant_title_eng
    #> 1                                                                                                                                   Dummy record
    #> 2                                      Serological studies to quantify SARS-CoV-2 population infection risk in Singapore, Hong Kong and Thailand
    #> 3                                                                                                       African COVID-19 Preparedness (AFRICO19)
    #> 4                                                                                       COVID-19 Intervention Modelling for East Africa  (CIMEA)
    #> 5                            The African coaLition for Epidemic Research, Response and Training, Clinical Characterization Protocol (ALERRT CCP)
    #> 6 Characterization of SARS-CoV-2 transmission dynamics, clinical features and disease impact in South Africa, a setting with high HIV prevalence
    #>   award_amount_converted
    #> 1                1234567
    #> 2                1043108
    #> 3                2462448
    #> 4                1699974
    #> 5                1742202
    #> 6                2484600
    #>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            abstract
    #> 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       A dummy record to simulate a version update
    #> 2                                                                                                                                                                                                                                                                                              We propose a prospective serological study to investigate the incidence of SARS-CoV-2 infection in the general population in three Asian settings: Singapore, Hong Kong and Thailand. The study will aim to measure the age-specific seroprevalence and incidence of SARS-CoV-2 infection at 3 time points, each 6 months apart. Age-specific incidence estimates will be applied to the census population to obtain numbers of infections in the population at each time point. These estimates will be compared with external data on COVID-19 hospitalisations and deaths in each setting, to calculate age-specific infection-hospitalisation and infection-fatality ratios. SARS-CoV-2 antibody kinetics will be defined by studying changes in antibody titres over time. Risk factors for infection will be studied by comparing SARS-CoV-2 seroconverters and non-seroconverters with respect to epidemiological exposures. This study will provide crucial information regarding population exposure and SARS-CoV-2 transmission dynamics, and will provide a complete picture of the relationship between clinically apparent and asymptomatic infections.
    #> 3 Our project, AFRICO19, will enhance capacity to understand SARS-CoV-2/hCoV-19 infection in three regions of Africa and globally. Building on existing infrastructures and collaborations we will create a network to share knowledge on next generation sequencing (NGS), including Oxford Nanopore Technology (MinION), coronavirus biology and COVID-19 disease control. Our consortium links three African sites combined with genomics and informatics support from the University of Glasgow to achieve the following key goals: 1. Support East and West African capacities for rapid diagnosis and sequencing of SARS-CoV-2 to help with contact tracing and quarantine measures. Novel diagnostic tools optimized for this virus will be deployed. An African COVID-19 case definition will be refined using machine learning for identification of SARS-CoV-2 infections. 2. Surveillance of SARS-CoV-2 will be performed in one cohort at each African site. This will use established cohorts to ensure that sampling begins quickly. A sampling plan optimized to detect initial moderate and severe cases followed by household contact tracing will be employed to obtain both mild to severe COVID-19 cases. 3. Provide improved understanding of SARS-CoV-2 biology/evolution using machine learning and novel bioinformatics analyses. Our results will be shared via a real-time analysis platform using the newly developed CoV-GLUE resource.
    #> 4     COVID-19 is a global threat to health, with many countries reporting extended outbreaks. To date 9 countries in Africa have recorded infection and it seems imminent that East Africa will have introductions and onward transmission. The SARS-CoV-2 virus (the aetiological agent of COVID-19) spreads rapidly (R0~2, serial interval about 1 week), and hence control will be difficult.  National plans for dealing with this public health emergency will benefit from predictions of the expected rate, distribution and extent of spread in countries throughout the region, and on the likely impact and feasibility of isolation and contact tracing interventions. We will support the emergency preparations through bespoke modelling, incorporating known demographic population structure, age-related contact patterns and existing mobile phone population movement data. In Uganda and Kenya we will collect epidemiological, genomic and behavioural data through health facility surveillance, household follow-up and contact studies to quantify uncertainties of SARS-CoV-2  virus epidemiology and contact patterns in well and unwell individuals. Results from the study will be rapidly communicated to the relevant authorities, and modelling code and analysis, and data including sequences, placed in the public domain in near real-time. This project could have lasting impact on the role of research in policy decisions.
    #> 5                                                                                                  As part of the response to the emergence of COVID-19, the World Health Organization Africa Regional Office is organizing various Infection Prevention and Control (IPC) and critical care training activities targeted at Low and Middle-Income countries (LMICs) in Africa. While the initiatives taken by WHO/AFRO are critical, training for research into the disease also needs to be targeted at the same LMICs, because being an Emerging Infectious Disease, we need to ??????learn-as-we-go?????\x9d. Clinical research on COVID-19 will have to be closely integrated with the IPC, clinical care, and epidemiological training activities, including use of the WHO First Few X (FFX) Cases and contact investigation protocol for COVID-19. ALERRT proposes to work closely with the WHO/AFRO and Africa CDC and existing networks and structures across Africa and globally to provide the forementioned clinical research training and support. ALERRT is a member of the Global Federation - ISARIC, which has developed a Clinical Characterization protocol for COVID-19. This protocol been endorsed by the WHO and is currently being used in China and across the UK and Europe.Being already established and conducting activities in sub-Sahara Africa, the ALERRT network has the capacity to effectively implement the proposed project.
    #> 6    Factors prevalent in Africa such as malnutrition, HIV, tuberculosis and limited access to healthcare, among others, may impact both transmission dynamics and disease progression associated with SARS-CoV-2 infection as well as the burden on the healthcare system and society.We aim to characterize key transmissibility and clinical features of and the antibody response to SARS-CoV-2 as well as to enhance surveillance for COVID-19, identify groups at increased risk of severe illness, estimate the disease burden of medically- and non-medically attended mild, severe-non-fatal and fatal illness and forecast the impact of the outbreak on the healthcare system and the society in South Africa. Particular emphasis will be given to HIV-infected individuals. The aims will be achieved through the implementation of shedding and household transmission studies, collection of sequential serum samples, enhanced facility-based (hospitals and clinics) surveillance among patients with mild and severe respiratory illness in well-established population-based surveillance sites where incidence can be calculated, and healthcare utilization and serological surveys in selected communities. In addition, digital surveillance (based on Google searches) will be used to complement virological surveillance and nowcasting and short-term forecasting (up to 4 weeks) will be implemented over the duration of the epidemic.
    #>   laysummary oda_funding_used grant_type grant_start_year study_subject___1
    #> 1        N/A              -77        -77             2020                 0
    #> 2                         -77        -77             2020                 0
    #> 3                         -77          1             2020                 0
    #> 4                         -77        -77             2020                 0
    #> 5                         -77        -77             2020                 0
    #> 6                         -77        -77             2020                 0
    #>   study_subject___2 study_subject___3 study_subject___4 study_subject___5
    #> 1                 0                 1                 0                 0
    #> 2                 0                 1                 0                 0
    #> 3                 0                 1                 0                 1
    #> 4                 0                 1                 0                 0
    #> 5                 0                 1                 0                 0
    #> 6                 0                 1                 0                 0
    #>   study_subject___6 study_subject____88 study_subject____99
    #> 1                 0                   0                   0
    #> 2                 0                   0                   0
    #> 3                 0                   0                   0
    #> 4                 0                   0                   0
    #> 5                 0                   0                   0
    #> 6                 0                   0                   0
    #>   study_subject____9999 study_subject_other ethnicity___1 ethnicity___2
    #> 1                     0                                 0             0
    #> 2                     0                                 0             0
    #> 3                     0                                 0             0
    #> 4                     0                                 0             0
    #> 5                     0                                 0             0
    #> 6                     0                                 0             0
    #>   ethnicity___3 ethnicity___4 ethnicity____88 ethnicity____99 ethnicity____9999
    #> 1             0             0               0               1                 0
    #> 2             0             0               0               1                 0
    #> 3             0             0               0               1                 0
    #> 4             0             0               0               1                 0
    #> 5             0             0               0               1                 0
    #> 6             0             0               0               1                 0
    #>   ethnicity_other age_groups___1 age_groups___2 age_groups___5 age_groups___6
    #> 1                              0              0              0              0
    #> 2                              0              0              0              0
    #> 3                              0              0              0              0
    #> 4                              0              0              0              0
    #> 5                              0              0              0              0
    #> 6                              0              0              0              0
    #>   age_groups___7 age_groups___3 age_groups____88 age_groups____99
    #> 1              0              0                0                1
    #> 2              0              0                0                1
    #> 3              0              0                0                1
    #> 4              0              0                0                1
    #> 5              0              0                0                1
    #> 6              0              0                0                1
    #>   age_groups____9999 agegroups_other rurality___1 rurality___2 rurality___3
    #> 1                  0                            0            0            0
    #> 2                  0                            0            0            0
    #> 3                  0                            0            0            0
    #> 4                  0                            0            0            0
    #> 5                  0                            0            0            0
    #> 6                  0                            0            0            0
    #>   rurality____88 rurality____99 rurality____9999 rurality_other
    #> 1              0              1                0               
    #> 2              0              1                0               
    #> 3              0              1                0               
    #> 4              0              1                0               
    #> 5              0              0                0               
    #> 6              0              1                0               
    #>   vulnerable_population___1 vulnerable_population___2 vulnerable_population___3
    #> 1                         0                         0                         0
    #> 2                         0                         0                         0
    #> 3                         0                         0                         0
    #> 4                         0                         0                         0
    #> 5                         0                         0                         0
    #> 6                         0                         0                         0
    #>   vulnerable_population___4 vulnerable_population___5 vulnerable_population___6
    #> 1                         0                         0                         0
    #> 2                         0                         0                         0
    #> 3                         0                         0                         0
    #> 4                         0                         0                         0
    #> 5                         0                         0                         0
    #> 6                         0                         0                         0
    #>   vulnerable_population___7 vulnerable_population___8 vulnerable_population___9
    #> 1                         0                         0                         0
    #> 2                         0                         0                         0
    #> 3                         0                         0                         0
    #> 4                         0                         0                         0
    #> 5                         0                         0                         0
    #> 6                         0                         0                         0
    #>   vulnerable_population___10 vulnerable_population___13
    #> 1                          0                          0
    #> 2                          0                          0
    #> 3                          0                          0
    #> 4                          0                          0
    #> 5                          0                          0
    #> 6                          0                          0
    #>   vulnerable_population___11 vulnerable_population___12
    #> 1                          0                          0
    #> 2                          0                          0
    #> 3                          0                          0
    #> 4                          0                          0
    #> 5                          0                          0
    #> 6                          0                          0
    #>   vulnerable_population____88 vulnerable_population____99
    #> 1                           0                           1
    #> 2                           0                           1
    #> 3                           0                           1
    #> 4                           0                           1
    #> 5                           0                           1
    #> 6                           1                           0
    #>   vulnerable_population____9999 vulnerable_population_other
    #> 1                             0                            
    #> 2                             0                            
    #> 3                             0                            
    #> 4                             0                            
    #> 5                             0                            
    #> 6                             0    HIV infected individuals
    #>   occupational_groups___1 occupational_groups___2 occupational_groups___3
    #> 1                       0                       0                       0
    #> 2                       0                       0                       0
    #> 3                       0                       0                       0
    #> 4                       0                       0                       0
    #> 5                       0                       0                       0
    #> 6                       0                       0                       0
    #>   occupational_groups___4 occupational_groups___5 occupational_groups___6
    #> 1                       0                       0                       0
    #> 2                       0                       0                       0
    #> 3                       0                       0                       0
    #> 4                       0                       0                       0
    #> 5                       0                       0                       0
    #> 6                       0                       0                       0
    #>   occupational_groups___7 occupational_groups___8 occupational_groups___9
    #> 1                       0                       0                       0
    #> 2                       0                       0                       0
    #> 3                       0                       0                       0
    #> 4                       0                       0                       0
    #> 5                       0                       0                       0
    #> 6                       0                       0                       0
    #>   occupational_groups___10 occupational_groups___11 occupational_groups___12
    #> 1                        0                        0                        0
    #> 2                        0                        0                        0
    #> 3                        0                        0                        0
    #> 4                        0                        0                        0
    #> 5                        0                        0                        0
    #> 6                        0                        0                        0
    #>   occupational_groups____88 occupational_groups____99
    #> 1                         0                         1
    #> 2                         0                         1
    #> 3                         0                         1
    #> 4                         0                         1
    #> 5                         0                         1
    #> 6                         0                         1
    #>   occupational_groups____9999 occupationalgroups_other study_type___1
    #> 1                           0                                       0
    #> 2                           0                                       0
    #> 3                           0                                       0
    #> 4                           0                                       0
    #> 5                           0                                       0
    #> 6                           0                                       0
    #>   study_type___2 study_type___3 study_type___4 study_type___5 study_type___6
    #> 1              0              0              0              0              0
    #> 2              0              0              0              0              0
    #> 3              0              0              0              0              0
    #> 4              0              0              0              0              0
    #> 5              0              0              0              0              0
    #> 6              0              0              0              0              0
    #>   study_type___7 study_type___8 study_type___9 study_type___10 study_type___11
    #> 1              0              0              0               0               0
    #> 2              0              0              0               0               0
    #> 3              0              0              0               0               0
    #> 4              0              0              0               0               0
    #> 5              0              0              0               0               0
    #> 6              0              0              0               0               0
    #>   study_type___12 study_type___13 study_type___14 study_type___15
    #> 1               0               0               0               0
    #> 2               0               0               0               0
    #> 3               0               0               0               0
    #> 4               0               0               0               0
    #> 5               0               0               0               0
    #> 6               0               0               0               0
    #>   study_type___16 study_type___17 study_type____88 study_type____99
    #> 1               0               0                0                1
    #> 2               0               0                0                1
    #> 3               0               0                0                1
    #> 4               0               0                0                1
    #> 5               0               0                0                1
    #> 6               0               0                0                1
    #>   study_type____9999 study_type_main___5 study_type_main___6
    #> 1                  0                   0                   1
    #> 2                  0                   0                   1
    #> 3                  0                   1                   0
    #> 4                  0                   0                   1
    #> 5                  0                   0                   0
    #> 6                  0                   1                   0
    #>   study_type_main____88 study_type_main____99 study_type_main____9999
    #> 1                     0                     0                       0
    #> 2                     0                     0                       0
    #> 3                     0                     0                       0
    #> 4                     0                     0                       0
    #> 5                     0                     0                       0
    #> 6                     0                     0                       0
    #>   clinical_trial___1 clinical_trial___2 clinical_trial___3 clinical_trial___4
    #> 1                  0                  0                  0                  0
    #> 2                  0                  0                  0                  0
    #> 3                  0                  0                  0                  0
    #> 4                  0                  0                  0                  0
    #> 5                  0                  0                  0                  0
    #> 6                  0                  0                  0                  0
    #>   clinical_trial___5 clinical_trial___6 clinical_trial___7 clinical_trial___8
    #> 1                  0                  0                  0                  0
    #> 2                  0                  0                  0                  0
    #> 3                  0                  0                  0                  0
    #> 4                  0                  0                  0                  0
    #> 5                  0                  0                  0                  0
    #> 6                  0                  0                  0                  0
    #>   clinical_trial___9 clinical_trial____99 clinical_trial____9999
    #> 1                  0                    0                      0
    #> 2                  0                    0                      0
    #> 3                  0                    0                      1
    #> 4                  0                    0                      0
    #> 5                  0                    0                      0
    #> 6                  0                    0                      1
    #>   report_or_literature_based_research study_type_other pathogen___243624009
    #> 1                                   0               NA                    0
    #> 2                                   0               NA                    0
    #> 3                                  NA               NA                    0
    #> 4                                   0               NA                    1
    #> 5                                  NA               NA                    0
    #> 6                                  NA               NA                    1
    #>   pathogen___243615000 pathogen___243607003 pathogen___407325004
    #> 1                    0                    0                    1
    #> 2                    0                    0                    1
    #> 3                    1                    0                    0
    #> 4                    0                    1                    0
    #> 5                    0                    0                    1
    #> 6                    0                    0                    0
    #>   pathogen___243602009 pathogen___407486001 pathogen___407479009
    #> 1                    0                    1                    0
    #> 2                    0                    1                    0
    #> 3                    0                    1                    0
    #> 4                    1                    0                    0
    #> 5                    1                    0                    0
    #> 6                    0                    0                    0
    #>   pathogen___np001 pathogen____99 coronavirus___1263733001
    #> 1                0              0                        0
    #> 2                0              0                        0
    #> 3                0              0                        0
    #> 4                0              0                        0
    #> 5                0              0                        0
    #> 6                0              0                        0
    #>   coronavirus___1263732006 coronavirus___840533007 coronavirus___12637330001
    #> 1                        0                       0                         0
    #> 2                        0                       0                         0
    #> 3                        0                       0                         0
    #> 4                        0                       0                         0
    #> 5                        0                       0                         0
    #> 6                        0                       0                         0
    #>   coronavirus___697932005 coronavirus____88 coronavirus____99
    #> 1                       0                 0                 0
    #> 2                       0                 0                 0
    #> 3                       0                 0                 0
    #> 4                       0                 0                 1
    #> 5                       0                 0                 0
    #> 6                       0                 0                 0
    #>   coronavirus____9999 bunyaviridae filoviridae arenaviridae henipavirus
    #> 1                   0           NA   424206003           NA         -99
    #> 2                   0           NA   424206003           NA         -99
    #> 3                   0          -88          NA           NA           1
    #> 4                   0           NA          NA          -99          NA
    #> 5                   0           NA   424206003           NA          NA
    #> 6                   0           NA          NA        -9999          NA
    #>   flaviviridae influenza_a disease___840539006 disease___43489008
    #> 1           NA          NA                   0                  1
    #> 2           NA          NA                   0                  1
    #> 3           NA          NA                   0                  0
    #> 4            1          NA                   1                  1
    #> 5          -99          NA                   0                  0
    #> 6           NA          NA                   0                  0
    #>   disease___37109004 disease___77503002 disease___19065005
    #> 1                  1                  0                  1
    #> 2                  1                  0                  1
    #> 3                  1                  0                  1
    #> 4                  1                  0                  0
    #> 5                  0                  1                  0
    #> 6                  0                  1                  1
    #>   disease___651000146102 disease___398447004 disease___406597005
    #> 1                      1                   1                   0
    #> 2                      1                   1                   0
    #> 3                      0                   0                   1
    #> 4                      1                   1                   1
    #> 5                      0                   1                   1
    #> 6                      0                   0                   1
    #>   disease___402917003 disease___3928002 disease___762725007 disease___359814004
    #> 1                   0                 1                   0                   0
    #> 2                   0                 1                   0                   0
    #> 3                   1                 0                   1                   1
    #> 4                   0                 1                   1                   0
    #> 5                   1                 1                   0                   0
    #> 6                   1                 0                   1                   0
    #>   disease___58750007 disease___6142004 disease___dx001 disease____88
    #> 1                  0                 1               0             0
    #> 2                  0                 1               0             0
    #> 3                  0                 0               0             0
    #> 4                  0                 1               0             0
    #> 5                  1                 1               1             0
    #> 6                  0                 1               0             0
    #>   disease____9999 disease_other mesh_terms grant_complete funder_name___395
    #> 1               0                                       2                 0
    #> 2               0                                       2                 0
    #> 3               0                                       2                 0
    #> 4               0                                       2                 0
    #> 5               0                                       0                 0
    #> 6               0                                       2                 0
    #>   funder_name___290 funder_name___46 funder_name___216 funder_name___152
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___139 funder_name___174 funder_name___102 funder_name___231
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___95 funder_name___339 funder_name___262 funder_name___209
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___250 funder_name___229 funder_name___220 funder_name___223
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___242 funder_name___158 funder_name___107 funder_name___29
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___21 funder_name___8 funder_name___143 funder_name___259
    #> 1                0               0                 0                 0
    #> 2                0               0                 0                 0
    #> 3                0               0                 0                 0
    #> 4                0               0                 0                 0
    #> 5                0               0                 0                 0
    #> 6                0               0                 0                 0
    #>   funder_name___337 funder_name___265 funder_name___110 funder_name___230
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___99 funder_name___203 funder_name___133 funder_name___380
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___356 funder_name___396 funder_name___272 funder_name___15
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___252 funder_name___111 funder_name___347 funder_name___84
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___291 funder_name___312 funder_name___160 funder_name___35
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___188 funder_name___100 funder_name___293 funder_name___361
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___349 funder_name___243 funder_name___166 funder_name___384
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___115 funder_name___313 funder_name___155 funder_name___281
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___397 funder_name___246 funder_name___198 funder_name___68
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___377 funder_name___388 funder_name___106 funder_name___74
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___236 funder_name___298 funder_name___297 funder_name___3
    #> 1                 0                 0                 0               0
    #> 2                 0                 0                 0               0
    #> 3                 0                 0                 0               0
    #> 4                 0                 0                 0               0
    #> 5                 0                 0                 0               0
    #> 6                 0                 0                 0               0
    #>   funder_name___168 funder_name___49 funder_name___193 funder_name___16
    #> 1                 0                0                 0                0
    #> 2                 0                0                 0                0
    #> 3                 0                0                 0                0
    #> 4                 0                0                 0                0
    #> 5                 0                0                 0                0
    #> 6                 0                0                 0                0
    #>   funder_name___210 funder_name___44 funder_name___228 funder_name___136
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___131 funder_name___391 funder_name___141 funder_name___277
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___28 funder_name___18 funder_name___53 funder_name___394
    #> 1                0                0                0                 0
    #> 2                0                0                0                 0
    #> 3                0                0                0                 0
    #> 4                0                0                0                 0
    #> 5                0                0                0                 0
    #> 6                0                0                0                 0
    #>   funder_name___134 funder_name___92 funder_name___128 funder_name___249
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___248 funder_name___266 funder_name___199 funder_name___27
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___34 funder_name___187 funder_name___85 funder_name___341
    #> 1                0                 0                0                 0
    #> 2                0                 0                0                 0
    #> 3                0                 0                0                 0
    #> 4                0                 0                0                 0
    #> 5                0                 0                0                 0
    #> 6                0                 0                0                 0
    #>   funder_name___256 funder_name___365 funder_name___191 funder_name___398
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___148 funder_name___1 funder_name___56 funder_name___57
    #> 1                 0               0                0                0
    #> 2                 0               0                0                0
    #> 3                 0               0                0                0
    #> 4                 0               0                0                0
    #> 5                 0               0                0                0
    #> 6                 0               0                0                0
    #>   funder_name___184 funder_name___399 funder_name___24 funder_name___330
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___253 funder_name___14 funder_name___362 funder_name___400
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___393 funder_name___336 funder_name___80 funder_name___296
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___401 funder_name___402 funder_name___70 funder_name___71
    #> 1                 0                 0                0                0
    #> 2                 0                 0                0                0
    #> 3                 0                 0                0                0
    #> 4                 0                 0                0                0
    #> 5                 0                 0                0                0
    #> 6                 0                 0                0                0
    #>   funder_name___369 funder_name___355 funder_name___176 funder_name___270
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___118 funder_name___173 funder_name___179 funder_name___180
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___119 funder_name___308 funder_name___286 funder_name___120
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___287 funder_name___122 funder_name___78 funder_name___177
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___82 funder_name___76 funder_name___273 funder_name___50
    #> 1                0                0                 0                0
    #> 2                0                0                 0                0
    #> 3                0                0                 0                0
    #> 4                0                0                 0                0
    #> 5                0                0                 0                0
    #> 6                0                0                 0                0
    #>   funder_name___31 funder_name___279 funder_name___226 funder_name___25
    #> 1                0                 0                 0                1
    #> 2                0                 0                 0                1
    #> 3                0                 0                 0                1
    #> 4                0                 0                 0                1
    #> 5                0                 0                 0                1
    #> 6                0                 0                 0                1
    #>   funder_name___87 funder_name___235 funder_name___218 funder_name___181
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___175 funder_name___121 funder_name___51 funder_name___117
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___116 funder_name___127 funder_name___178 funder_name___129
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___47 funder_name___48 funder_name___207 funder_name___lic
    #> 1                0                0                 0                 0
    #> 2                0                0                 0                 0
    #> 3                0                0                 0                 0
    #> 4                0                0                 0                 0
    #> 5                0                0                 0                 0
    #> 6                0                0                 0                 0
    #>   funder_name___381 funder_name___225 funder_name___354 funder_name___390
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___340 funder_name___346 funder_name___214 funder_name___275
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___65 funder_name___224 funder_name___104 funder_name___284
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___359 funder_name___17 funder_name___348 funder_name___302
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___205 funder_name___274 funder_name___36 funder_name___67
    #> 1                 0                 0                0                0
    #> 2                 0                 0                0                0
    #> 3                 0                 0                0                0
    #> 4                 0                 0                0                0
    #> 5                 0                 0                0                0
    #> 6                 0                 0                0                0
    #>   funder_name___358 funder_name___5 funder_name___169 funder_name___147
    #> 1                 0               0                 0                 0
    #> 2                 0               0                 0                 0
    #> 3                 0               0                 0                 0
    #> 4                 0               0                 0                 0
    #> 5                 0               0                 0                 0
    #> 6                 0               0                 0                 0
    #>   funder_name___162 funder_name___112 funder_name___375 funder_name___75
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___114 funder_name___403 funder_name___94 funder_name___54
    #> 1                 0                 0                0                0
    #> 2                 0                 0                0                0
    #> 3                 0                 0                0                0
    #> 4                 0                 0                0                0
    #> 5                 0                 0                0                0
    #> 6                 0                 0                0                0
    #>   funder_name___295 funder_name___353 funder_name___109 funder_name___13
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___329 funder_name___260 funder_name___132 funder_name___261
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___204 funder_name___126 funder_name___364 funder_name___222
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___172 funder_name___357 funder_name___12 funder_name___91
    #> 1                 0                 0                0                0
    #> 2                 0                 0                0                0
    #> 3                 0                 0                0                0
    #> 4                 0                 0                0                0
    #> 5                 0                 0                0                0
    #> 6                 0                 0                0                0
    #>   funder_name___278 funder_name___183 funder_name___342 funder_name___7
    #> 1                 0                 0                 0               0
    #> 2                 0                 0                 0               0
    #> 3                 0                 0                 0               0
    #> 4                 0                 0                 0               0
    #> 5                 0                 0                 0               0
    #> 6                 0                 0                 0               0
    #>   funder_name___404 funder_name___206 funder_name___101 funder_name___130
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___241 funder_name___219 funder_name___263 funder_name___376
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___55 funder_name___124 funder_name___325 funder_name___151
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___311 funder_name___23 funder_name___264 funder_name___386
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___96 funder_name___157 funder_name___40 funder_name___125
    #> 1                0                 0                0                 0
    #> 2                0                 0                0                 0
    #> 3                0                 0                0                 0
    #> 4                0                 0                0                 0
    #> 5                0                 0                0                 0
    #> 6                0                 0                0                 0
    #>   funder_name___332 funder_name___328 funder_name___163 funder_name___79
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___331 funder_name___382 funder_name___389 funder_name___309
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___154 funder_name___146 funder_name___232 funder_name___334
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___405 funder_name___406 funder_name___407 funder_name___408
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___409 funder_name___410 funder_name___32 funder_name___89
    #> 1                 0                 0                0                0
    #> 2                 0                 0                0                0
    #> 3                 0                 0                0                0
    #> 4                 0                 0                0                0
    #> 5                 0                 0                0                0
    #> 6                 0                 0                0                0
    #>   funder_name___213 funder_name___90 funder_name___153 funder_name___255
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___59 funder_name___411 funder_name___149 funder_name___315
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___383 funder_name___93 funder_name___267 funder_name___137
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___39 funder_name___20 funder_name___217 funder_name___81
    #> 1                0                0                 0                0
    #> 2                0                0                 0                0
    #> 3                0                0                 0                0
    #> 4                0                0                 0                0
    #> 5                0                0                 0                0
    #> 6                0                0                 0                0
    #>   funder_name___69 funder_name___192 funder_name___323 funder_name___378
    #> 1                0                 0                 0                 0
    #> 2                0                 0                 0                 0
    #> 3                0                 0                 0                 0
    #> 4                0                 0                 0                 0
    #> 5                0                 0                 0                 0
    #> 6                0                 0                 0                 0
    #>   funder_name___41 funder_name___301 funder_name___6 funder_name___19
    #> 1                0                 0               0                0
    #> 2                0                 0               0                0
    #> 3                0                 0               0                0
    #> 4                0                 0               0                0
    #> 5                0                 0               0                0
    #> 6                0                 0               0                0
    #>   funder_name___159 funder_name___186 funder_name___73 funder_name___372
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___77 funder_name___62 funder_name___299 funder_name___30
    #> 1                0                0                 0                0
    #> 2                0                0                 0                0
    #> 3                0                0                 0                0
    #> 4                0                0                 0                0
    #> 5                0                0                 0                0
    #> 6                0                0                 0                0
    #>   funder_name___303 funder_name___294 funder_name___319 funder_name___282
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___244 funder_name___189 funder_name___165 funder_name___103
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___280 funder_name___72 funder_name___161 funder_name___283
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___197 funder_name___98 funder_name___289 funder_name___258
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___285 funder_name___113 funder_name___257 funder_name___307
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___2 funder_name___292 funder_name___43 funder_name___333
    #> 1               0                 0                0                 0
    #> 2               0                 0                0                 0
    #> 3               0                 0                0                 0
    #> 4               0                 0                0                 0
    #> 5               0                 0                0                 0
    #> 6               0                 0                0                 0
    #>   funder_name___9 funder_name___64 funder_name___234 funder_name___190
    #> 1               0                0                 0                 0
    #> 2               0                0                 0                 0
    #> 3               0                0                 0                 0
    #> 4               0                0                 0                 0
    #> 5               0                0                 0                 0
    #> 6               0                0                 0                 0
    #>   funder_name___42 funder_name___63 funder_name___61 funder_name___142
    #> 1                0                0                0                 0
    #> 2                0                0                0                 0
    #> 3                0                0                0                 0
    #> 4                0                0                0                 0
    #> 5                0                0                0                 0
    #> 6                0                0                0                 0
    #>   funder_name___185 funder_name___318 funder_name___317 funder_name___412
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___97 funder_name___37 funder_name___135 funder_name___60
    #> 1                0                0                 0                0
    #> 2                0                0                 0                0
    #> 3                0                0                 0                0
    #> 4                0                0                 0                0
    #> 5                0                0                 0                0
    #> 6                0                0                 0                0
    #>   funder_name___314 funder_name___245 funder_name___227 funder_name___324
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___33 funder_name___38 funder_name___150 funder_name___182
    #> 1                0                0                 0                 0
    #> 2                0                0                 0                 0
    #> 3                0                0                 0                 0
    #> 4                0                0                 0                 0
    #> 5                0                0                 0                 0
    #> 6                0                0                 0                 0
    #>   funder_name___194 funder_name___268 funder_name___387 funder_name___269
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___145 funder_name___140 funder_name___201 funder_name___4
    #> 1                 0                 0                 0               0
    #> 2                 0                 0                 0               0
    #> 3                 0                 0                 0               0
    #> 4                 0                 0                 0               0
    #> 5                 0                 0                 0               0
    #> 6                 0                 0                 0               0
    #>   funder_name___350 funder_name___196 funder_name___26 funder_name___343
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___144 funder_name___385 funder_name___195 funder_name___370
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___338 funder_name___379 funder_name___233 funder_name___88
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___164 funder_name___366 funder_name___239 funder_name___360
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___221 funder_name___271 funder_name___202 funder_name___52
    #> 1                 0                 0                 0                0
    #> 2                 0                 0                 0                0
    #> 3                 0                 0                 0                0
    #> 4                 0                 0                 0                0
    #> 5                 0                 0                 0                0
    #> 6                 0                 0                 0                0
    #>   funder_name___304 funder_name___11 funder_name___170 funder_name___22
    #> 1                 0                0                 0                0
    #> 2                 0                0                 0                0
    #> 3                 0                0                 0                0
    #> 4                 0                0                 0                0
    #> 5                 0                0                 0                0
    #> 6                 0                0                 0                0
    #>   funder_name___344 funder_name___138 funder_name___240 funder_name___310
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___345 funder_name___363 funder_name___300 funder_name___321
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___322 funder_name___327 funder_name___251 funder_name___367
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___371 funder_name___238 funder_name___254 funder_name___108
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___373 funder_name___247 funder_name___237 funder_name___374
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___288 funder_name___305 funder_name___276 funder_name___105
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___200 funder_name___86 funder_name___212 funder_name___123
    #> 1                 0                0                 0                 0
    #> 2                 0                0                 0                 0
    #> 3                 0                0                 0                 0
    #> 4                 0                0                 0                 0
    #> 5                 0                0                 0                 0
    #> 6                 0                0                 0                 0
    #>   funder_name___215 funder_name___351 funder_name___45 funder_name___326
    #> 1                 0                 0                0                 0
    #> 2                 0                 0                0                 0
    #> 3                 0                 0                0                 0
    #> 4                 0                 0                0                 0
    #> 5                 0                 0                0                 0
    #> 6                 0                 0                0                 0
    #>   funder_name___66 funder_name___10 funder_name___320 funder_name___171
    #> 1                0                1                 0                 0
    #> 2                0                1                 0                 0
    #> 3                0                1                 0                 0
    #> 4                0                1                 0                 0
    #> 5                0                1                 0                 0
    #> 6                0                1                 0                 0
    #>   funder_name___211 funder_name___368 funder_name___156 funder_name___208
    #> 1                 0                 0                 0                 0
    #> 2                 0                 0                 0                 0
    #> 3                 0                 0                 0                 0
    #> 4                 0                 0                 0                 0
    #> 5                 0                 0                 0                 0
    #> 6                 0                 0                 0                 0
    #>   funder_name___316 funder_name___392 funder_country___4 funder_country___248
    #> 1                 0                 0                  0                    0
    #> 2                 0                 0                  0                    0
    #> 3                 0                 0                  0                    0
    #> 4                 0                 0                  0                    0
    #> 5                 0                 0                  0                    0
    #> 6                 0                 0                  0                    0
    #>   funder_country___8 funder_country___12 funder_country___16
    #> 1                  0                   0                   0
    #> 2                  0                   0                   0
    #> 3                  0                   0                   0
    #> 4                  0                   0                   0
    #> 5                  0                   0                   0
    #> 6                  0                   0                   0
    #>   funder_country___20 funder_country___24 funder_country___660
    #> 1                   0                   0                    0
    #> 2                   0                   0                    0
    #> 3                   0                   0                    0
    #> 4                   0                   0                    0
    #> 5                   0                   0                    0
    #> 6                   0                   0                    0
    #>   funder_country___10 funder_country___28 funder_country___32
    #> 1                   0                   0                   0
    #> 2                   0                   0                   0
    #> 3                   0                   0                   0
    #> 4                   0                   0                   0
    #> 5                   0                   0                   0
    #> 6                   0                   0                   0
    #>   funder_country___51 funder_country___533 funder_country___36
    #> 1                   0                    0                   0
    #> 2                   0                    0                   0
    #> 3                   0                    0                   0
    #> 4                   0                    0                   0
    #> 5                   0                    0                   0
    #> 6                   0                    0                   0
    #>   funder_country___40 funder_country___31 funder_country___44
    #> 1                   0                   0                   0
    #> 2                   0                   0                   0
    #> 3                   0                   0                   0
    #> 4                   0                   0                   0
    #> 5                   0                   0                   0
    #> 6                   0                   0                   0
    #>   funder_country___48 funder_country___50 funder_country___52
    #> 1                   0                   0                   0
    #> 2                   0                   0                   0
    #> 3                   0                   0                   0
    #> 4                   0                   0                   0
    #> 5                   0                   0                   0
    #> 6                   0                   0                   0
    #>   funder_country___112 funder_country___56 funder_country___84
    #> 1                    0                   0                   0
    #> 2                    0                   0                   0
    #> 3                    0                   0                   0
    #> 4                    0                   0                   0
    #> 5                    0                   0                   0
    #> 6                    0                   0                   0
    #>   funder_country___204 funder_country___60 funder_country___64
    #> 1                    0                   0                   0
    #> 2                    0                   0                   0
    #> 3                    0                   0                   0
    #> 4                    0                   0                   0
    #> 5                    0                   0                   0
    #> 6                    0                   0                   0
    #>   funder_country___68 funder_country___535 funder_country___70
    #> 1                   0                    0                   0
    #> 2                   0                    0                   0
    #> 3                   0                    0                   0
    #> 4                   0                    0                   0
    #> 5                   0                    0                   0
    #> 6                   0                    0                   0
    #>   funder_country___72 funder_country___74 funder_country___76
    #> 1                   0                   0                   0
    #> 2                   0                   0                   0
    #> 3                   0                   0                   0
    #> 4                   0                   0                   0
    #> 5                   0                   0                   0
    #> 6                   0                   0                   0
    #>   funder_country___86 funder_country___96 funder_country___100
    #> 1                   0                   0                    0
    #> 2                   0                   0                    0
    #> 3                   0                   0                    0
    #> 4                   0                   0                    0
    #> 5                   0                   0                    0
    #> 6                   0                   0                    0
    #>   funder_country___854 funder_country___108 funder_country___132
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___116 funder_country___120 funder_country___124
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___136 funder_country___140 funder_country___148
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___152 funder_country___156 funder_country___162
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___166 funder_country___170 funder_country___174
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___178 funder_country___180 funder_country___184
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___188 funder_country___384 funder_country___191
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___192 funder_country___531 funder_country___196
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___203 funder_country___208 funder_country___262
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___212 funder_country___214 funder_country___218
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___818 funder_country___222 funder_country___226
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___232 funder_country___233 funder_country___748
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___231 funder_country___238 funder_country___234
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___242 funder_country___246 funder_country___250
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___254 funder_country___258 funder_country___260
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___266 funder_country___270 funder_country___268
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___276 funder_country___288 funder_country___292
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___300 funder_country___304 funder_country___308
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___312 funder_country___316 funder_country___320
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___831 funder_country___324 funder_country___624
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___328 funder_country___332 funder_country___334
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___336 funder_country___340 funder_country___344
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___348 funder_country___352 funder_country___356
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___360 funder_country___364 funder_country___368
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___372 funder_country___833 funder_country___376
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___380 funder_country___388 funder_country___392
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___832 funder_country___400 funder_country___398
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___404 funder_country___296 funder_country___414
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___417 funder_country___418 funder_country___428
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___422 funder_country___426 funder_country___430
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___434 funder_country___438 funder_country___440
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___442 funder_country___446 funder_country___450
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___454 funder_country___458 funder_country___462
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___466 funder_country___470 funder_country___584
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___474 funder_country___478 funder_country___480
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___175 funder_country___484 funder_country___583
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___498 funder_country___492 funder_country___496
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___499 funder_country___500 funder_country___504
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___508 funder_country___104 funder_country___516
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___520 funder_country___524 funder_country___528
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___540 funder_country___554 funder_country___558
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___562 funder_country___566 funder_country___570
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___574 funder_country___408 funder_country___580
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___578 funder_country___512 funder_country___586
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___585 funder_country___275 funder_country___591
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___598 funder_country___600 funder_country___604
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___608 funder_country___612 funder_country___616
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___620 funder_country___630 funder_country___634
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___807 funder_country___638 funder_country___642
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___643 funder_country___646 funder_country___652
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___654 funder_country___659 funder_country___662
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___663 funder_country___666 funder_country___670
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___882 funder_country___674 funder_country___678
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___682 funder_country___686 funder_country___688
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___690 funder_country___694 funder_country___702
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___534 funder_country___703 funder_country___705
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___90 funder_country___706 funder_country___710
    #> 1                   0                    0                    0
    #> 2                   0                    0                    0
    #> 3                   0                    0                    0
    #> 4                   0                    0                    0
    #> 5                   0                    0                    0
    #> 6                   0                    0                    0
    #>   funder_country___239 funder_country___410 funder_country___728
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___724 funder_country___144 funder_country___729
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___740 funder_country___744 funder_country___752
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___756 funder_country___760 funder_country___158
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___762 funder_country___834 funder_country___764
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___626 funder_country___768 funder_country___772
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___776 funder_country___780 funder_country___788
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___792 funder_country___795 funder_country___796
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___798 funder_country___800 funder_country___804
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___784 funder_country___826 funder_country___581
    #> 1                    0                    1                    0
    #> 2                    0                    1                    0
    #> 3                    0                    1                    0
    #> 4                    0                    1                    0
    #> 5                    0                    1                    0
    #> 6                    0                    1                    0
    #>   funder_country___840 funder_country___858 funder_country___860
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___548 funder_country___862 funder_country___704
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___92 funder_country___850 funder_country___876
    #> 1                   0                    0                    0
    #> 2                   0                    0                    0
    #> 3                   0                    0                    0
    #> 4                   0                    0                    0
    #> 5                   0                    0                    0
    #> 6                   0                    0                    0
    #>   funder_country___732 funder_country___887 funder_country___894
    #> 1                    0                    0                    0
    #> 2                    0                    0                    0
    #> 3                    0                    0                    0
    #> 4                    0                    0                    0
    #> 5                    0                    0                    0
    #> 6                    0                    0                    0
    #>   funder_country___716 funder_country___9999 funder_country___99999
    #> 1                    0                     0                      0
    #> 2                    0                     0                      0
    #> 3                    0                     0                      0
    #> 4                    0                     0                      0
    #> 5                    0                     0                      0
    #> 6                    0                     0                      0
    #>   funder_country___999999 funder_country___9999999 funder_region___1
    #> 1                       0                        0                 0
    #> 2                       0                        0                 0
    #> 3                       0                        0                 0
    #> 4                       0                        0                 0
    #> 5                       0                        0                 0
    #> 6                       0                        0                 0
    #>   funder_region___2 funder_region___5 funder_region___99999
    #> 1                 0                 0                     1
    #> 2                 0                 0                     1
    #> 3                 0                 0                     1
    #> 4                 0                 0                     1
    #> 5                 0                 0                     1
    #> 6                 0                 0                     1
    #>   funder_region___9999 funder_region___999999 funder_region___9999999
    #> 1                    0                      0                       0
    #> 2                    0                      0                       0
    #> 3                    0                      0                       0
    #> 4                    0                      0                       0
    #> 5                    0                      0                       0
    #> 6                    0                      0                       0
    #>   funder_region____99 funder_complete         rorid
    #> 1                   0               0   grid.4280.e
    #> 2                   0               0   grid.4280.e
    #> 3                   0               0              
    #> 4                   0               0   grid.7372.1
    #> 5                   0               0 grid.487281.0
    #> 6                   0               0 grid.416657.7
    #>                                                                research_institition_name
    #> 1                                                       National University of Singapore
    #> 2                                                       National University of Singapore
    #> 3                                                MRC/UVRI and LSHTM Uganda Research Unit
    #> 4                                                                  University of Warwick
    #> 5                          Kumasi Center for Collaborative Research in Tropical Medicine
    #> 6 National Institute for Communicable Diseases of the National Health Laboratory Service
    #>   research_institution_country research_institution_country_iso
    #> 1                    Singapore                              702
    #> 2                    Singapore                              702
    #> 3                       Uganda                              800
    #> 4               United Kingdom                              826
    #> 5                        Ghana                              288
    #> 6                 South Africa                              710
    #>   research_institution_region___1 research_institution_region___2
    #> 1                               0                               0
    #> 2                               0                               0
    #> 3                               1                               0
    #> 4                               0                               0
    #> 5                               1                               0
    #> 6                               1                               0
    #>   research_institution_region___5 research_institution_region___99999
    #> 1                               0                                   0
    #> 2                               0                                   0
    #> 3                               0                                   0
    #> 4                               0                                   1
    #> 5                               0                                   0
    #> 6                               0                                   0
    #>   research_institution_region___9999 research_institution_region___999999
    #> 1                                  0                                    0
    #> 2                                  0                                    0
    #> 3                                  0                                    0
    #> 4                                  0                                    0
    #> 5                                  0                                    0
    #> 6                                  0                                    0
    #>   research_institution_region___9999999 research_institution_region____99
    #> 1                                     1                                 0
    #> 2                                     1                                 0
    #> 3                                     0                                 0
    #> 4                                     0                                 0
    #> 5                                     0                                 0
    #> 6                                     0                                 0
    #>        research_location_country research_location_country_iso
    #> 1 Singapore, Hong Kong, Thailand                 702, 344, 764
    #> 2 Singapore, Hong Kong, Thailand                 702, 344, 764
    #> 3                                                             
    #> 4                  Uganda, Kenya                      800, 404
    #> 5                                                             
    #> 6                   South Africa                           710
    #>   research_location_region___1 research_location_region___2
    #> 1                            0                            0
    #> 2                            0                            0
    #> 3                            0                            0
    #> 4                            1                            0
    #> 5                            0                            0
    #> 6                            1                            0
    #>   research_location_region___5 research_location_region___99999
    #> 1                            0                                0
    #> 2                            0                                0
    #> 3                            0                                0
    #> 4                            0                                0
    #> 5                            0                                0
    #> 6                            0                                0
    #>   research_location_region___9999 research_location_region___999999
    #> 1                               0                                 1
    #> 2                               0                                 1
    #> 3                               0                                 0
    #> 4                               0                                 0
    #> 5                               0                                 0
    #> 6                               0                                 0
    #>   research_location_region___9999999 research_location_region____99
    #> 1                                  1                              0
    #> 2                                  1                              0
    #> 3                                  0                              1
    #> 4                                  0                              0
    #> 5                                  0                              1
    #> 6                                  0                              0
    #>   researchinstitution_complete tags___1 tags___2 tags___3 tags___4
    #> 1                            0        0        0        0        0
    #> 2                            0        0        0        0        0
    #> 3                            0        1        0        0        0
    #> 4                            0        0        0        0        0
    #> 5                            0        0        0        0        0
    #> 6                            0        0        0        0        0
    #>   main_research_priority_area_number_new main_research_sub_priority_number_new
    #> 1                                      3                                3a, 3b
    #> 2                                      3                                3a, 3b
    #> 3                               1, 3, 12                   1a, 1b, 1c, 3a, 12c
    #> 4                                      3                                    3a
    #> 5                                      4                                    4c
    #> 6                            1, 3, 4, 10                   1d, 3a, 3b, 4b, 10a
    #>   secondary_research_priority_area_number_new
    #> 1                                            
    #> 2                                            
    #> 3                                            
    #> 4                                            
    #> 5                                           5
    #> 6                                            
    #>   secondary_research_sub_priority_number_new researchcategory_complete
    #> 1                                                                    2
    #> 2                                                                    2
    #> 3                                                                    2
    #> 4                                                                    2
    #> 5                                         5a                         0
    #> 6                                                                    2

## Citation

To cite the `pactr` package, please use the suggested citation provided
by a call to the `citation()` function as follows:

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
pact_cite(id = 24763548)
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
