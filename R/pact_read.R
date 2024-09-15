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

  ## Read dataset from website ----
  df <- read.csv(file = .url) |> tibble::tibble()

  ## Fix one-to-one issues ----
  df$ResearchInstitutionRegion <- get_who_regions(df$ResearchInstitutionCountry)
  df$ResearchLocationRegion <- get_who_regions(df$ResearchLocationCountry)

  ## Create list columns ----
  list_cols_df <- df |>
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::contains(nested_vars),
        .fns = ~stringr::str_split(
          string = .x, pattern = ", | \\| "
        )
      )
    )

  ## Structure data ----
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



