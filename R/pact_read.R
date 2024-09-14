#'
#' Read datasets from the Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param tracker_type Either "labelled" or "raw". Default is "labelled".
#' @param nest Logical. Should variable/fields with multiple values be nested? 
#'   Default to FALSE.
#' @param col_list Logical. Should variable/fields with multiple values be
#'   made into column lists? Only evaluated if `nest = TRUE`.
#'
#' @returns A data.frame of the requested dataset. For
#'   `pact_read_data_website()`, a tibble of the dataset from the website
#'   structured based on `nest` and `col_list` specifications.
#'
#' @examples
#' \dontrun{
#'   pact_client <- pact_client_set()
#'   pact_read_data_dictionary(pact_client)
#' }
#'
#' @rdname pact_read
#' @export
#'

pact_read_data_figshare <- function(pact_client,
                                    tracker_type = c("labelled", "raw")) {
  ## Set to chosen tracker type ----
  tracker_type <- match.arg(tracker_type)

  ## Update client with specific output/asset ----
  if (tracker_type == "labelled") {
    deposit_id <- 24763548
  } else {
    deposit_id <- 24786258
  }

  ## Retrieve output/asset from Figshare and store in locat client ----
  pact_client_update <- pact_client$deposit_retrieve(deposit_id = deposit_id)
  data_url <- pact_client_update$hostdata$files$download_url

  ## Read dataset ----
  read.csv(file = data_url)
}

#'
#' @rdname pact_read
#' @export
#'

pact_read_data_dictionary <- function(pact_client) {
  ## Retrieve output/asset from Figshare and store in locat client ----
  pact_client_update <- pact_client$deposit_retrieve(deposit_id = 24773787)
  data_url <- pact_client_update$hostdata$files$download_url

  ## Read data dictionary ----
  read.csv(file = data_url)
}


#'
#' @rdname pact_read
#' @export
#' 

pact_read_data_website <- function(nest = TRUE,
                                   col_list = TRUE) {
  .url <- "https://pandemicpact.org/export/pandemic-pact-grants.csv"

  df <- read.csv(file = .url) |> tibble::tibble()

  ## Hotfix for non-matching country and region for research institution ----
  df[716, "ResearchInstitutionRegion"]  <- "Africa | Europe | Europe | Europe"
  df[719, "ResearchInstitutionRegion"]  <- "Europe | Africa | Europe"
  df[730, "ResearchInstitutionRegion"]  <- "Africa | Europe | Europe | Europe"
  df[1611, "ResearchInstitutionRegion"] <- "Africa | Western Pacific | Western Pacific | Western Pacific | Western Pacific | Western Pacific | Western Pacific"
  df[1612, "ResearchInstitutionRegion"] <- "Americas | Europe | Europe"
  df[1613, "ResearchInstitutionRegion"] <- "Europe | International | Africa | Africa | Europe | Americas | Africa | International | Europe | South-East Asia | Africa | Western Pacific | Africa | South-East Asia | Americas | Europe | Europe | International | Eastern Mediterranean"
  df[1614, "ResearchInstitutionRegion"] <- "Europe | Europe | Americas | Americas | Americas"
  df[1619, "ResearchInstitutionRegion"] <- "Eastern Mediterranean | South-East Asia | Europe | Europe | Europe | Europe | South-East Asia | South-East Asia"
  df[5352, "ResearchInstitutionRegion"] <- "Africa | Europe | Europe | Europe"

  ## Hotfix for research location ----
  df[2, "ResearchLocationRegion"]    <- "Americas | Western Pacific | Western Pacific | Europe | Europe | Africa | Eastern Mediterranean | Africa | Eastern Mediterranean | Eastern Mediterranean | Africa"
  df[11, "ResearchLocationRegion"]   <- "Americas | Western Pacific | Western Pacific | Western Pacific | South-East Asia | Western Pacific | South-East Asia | Western Pacific | Western Pacific | South-East Asia | Western Pacific"
  df[20, "ResearchLocationRegion"]   <- "Americas | Europe | Americas | Africa | Rwanda"
  df[35, "ResearchLocationRegion"]   <- "Americas | Americas | Western Pacific | Europe | Europe | Western Pacific | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Eastern Mediterranean | Europe | Eatern Mediterranean | Europe | Europe | Europe | Europe"
  df[70, "ResearchLocationRegion"]   <- "Americas | Western Pacific | Western Pacific"
  df[72, "ResearchLocationRegion"]   <- "Americas | Americas | Europe | Africa"
  df[83, "ResearchLocationRegion"]   <- "Western Pacific | Western Pacific | South-East Asia"
  df[102, "ResearchLocationRegion"]  <- "Western Pacific | Western Pacific | Americas"
  df[400, "ResearchLocationRegion"]  <- "Western Pacific | Africa | Africa | Africa | Africa | Africa"
  df[403, "ResearchLocationRegion"]  <- "Americas | Americas | Americas | Europe"
  df[480, "ResearchLocationRegion"]  <- "Europe | Europe | Western Pacific"
  df[484, "ResearchLocationRegion"]  <- "Europe | Americas | Europe"
  df[602, "ResearchLocationRegion"]  <- "Europe | Africa | Africa"
  df[608, "ResearchLocationRegion"]  <- "Africa | Africa | South-East Asia | South-East Asia"
  df[716, "ResearchLocationRegion"]  <- "Africa | Europe | Europe | Europe"
  df[743, "ResearchLocationRegion"]  <- "Europe | Eastern Mediterranean | Eastern Mediterranean"
  df[745, "ResearchLocationRegion"]  <- "Eastern Mediterranean | South-East Asia | Africa | Eastern Mediterranean | Eastern Mediterranean | Africa"
  df[749, "ResearchLocationRegion"]  <- "South-East Asia | Western Pacific | South-East Asia | Europe"
  df[804, "ResearchLocationRegion"]  <- "Europe | Europe | Africa"
  df[805, "ResearchLocationRegion"]  <- "Europe | Europe | Western Pacific"
  df[808, "ResearchLocationRegion"]  <- "Europe | Americas | Europe"
  df[816, "ResearchLocationRegion"]  <- "Europe | Europe | Europe | Europe | Americas"
  df[837, "ResearchLocationRegion"]  <- "Europe | Europe | Americas | Americas"
  df[982, "ResearchLocationRegion"]  <- "Americas | Americas | Africa | Africa | Africa | Americas | Africa | Africa"
  df[1021, "ResearchLocationRegion"] <- "Americas | Africa | Africa"
  df[1032, "ResearchLocationRegion"] <- "Western Pacific | Western Pacific | Europe | Europe | Africa | Africa | Africa | Eastern Mediterranean | Eatern Mediterranean | Africa | Americas"
  df[1104, "ResearchLocationRegion"] <- "Europe | Western Pacific | Eatern Mediterranean | Europe | Americas"
  df[1109, "ResearchLocationRegion"] <- "Europe | Europe | Western Pacific | Americas"
  df[1313, "ResearchLocationRegion"] <- "Western Pacific | Western Pacific | South-East Asia | Western Pacific | Europe"
  df[1321, "ResearchLocationRegion"] <- "Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe | Europe"

  list_cols_df <- df |>
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::contains(nested_vars),
        .fns = ~stringr::str_split(
          string = .x, pattern = ", | \\| "
        )
      )
    )

  if (nest) {
    if (col_list) {
      df <- list_cols_df
    } else {
      df
    }
  } else {
    ## Unnest PubMedGrantId ----
    main_df <- list_cols_df |>
      tidyr::unnest(cols = PubMedGrantId) |>
      tidyr::unnest(cols = StudySubject) |>
      tidyr::unnest(cols = Ethnicity) |>
      tidyr::unnest(cols = AgeGroups) |>
      tidyr::unnest(cols = Rurality) |>
      tidyr::unnest(cols = VulnerablePopulations) |>
      tidyr::unnest(cols = OccupationalGroups) |>
      tidyr::unnest(cols = StudyType) |>
      tidyr::unnest(cols = ClinicalTrial) |>
      tidyr::unnest(cols = Pathogen) |>
      tidyr::unnest(cols = Disease) |>
      tidyr::unnest(cols = Tags) |>
      tidyr::unnest(cols = MPOXResearchPriority) |>
      tidyr::unnest(cols = MPOXResearchSubPriority) |>
      tidyr::unnest(cols = ResearchCat) |>
      tidyr::unnest(cols = ResearchSubcat)

    ## Fix one-to-one issues ----
    

    ## Unnest funder locations ----
    funder_df <- list_cols_df |>
      tidyr::unnest(cols = c(FundingOrgName)) |>
      tidyr::unnest(cols = c(FunderCountry, FunderRegion))

    ## Unnest research institution location ----
    institution_df <- list_cols_df |>
      tidyr::unnest(c(ResearchInstitutionCountry, ResearchInstitutionRegion))

    ## Unnest research location ----
    research_df <- list_cols_df |>
      tidyr::unnest(c(ResearchLocationCountry, ResearchLocationRegion))
  } 
}



