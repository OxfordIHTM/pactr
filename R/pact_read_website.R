#'
#' Read datasets from the Pandemic PACT website
#'
#' @param nest Logical. Should variable/fields with multiple values be nested? 
#'   Default to FALSE.
#' @param col_list Logical. Should variable/fields with multiple values be
#'   made into column lists? Only evaluated if `nest = TRUE`.
#'
#' @returns A tibble of the dataset from the website structured based on 
#'   `nest` and `col_list` specifications.
#'
#' @examples
#' \dontrun{
#'   pact_read_website(pact_client)
#' }
#'
#' @rdname pact_read_website
#' @export
#' 

pact_read_website <- function(nest = TRUE,
                              col_list = TRUE) {
  .url <- "https://pandemicpact.org/export/pandemic-pact-grants.csv"

  ## Read dataset from website ----
  df <- read.csv(file = .url) |> tibble::tibble()

  ## Fix one-to-one issues ----
  df$FunderRegion <- get_who_regions(df$FunderCountry)
  df$ResearchInstitutionRegion <- get_who_regions(df$ResearchInstitutionCountry)
  df$ResearchLocationRegion <- get_who_regions(df$ResearchLocationCountry)

  ## Convert N/A to NA ----
  df <- df |>
    dplyr::mutate(
      ResearchInstitutionName = ifelse(
        .data$ResearchInstitutionName == "N/A", 
        NA_character_, 
        .data$ResearchInstitutionName
      )
    )

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
      tidyr::unnest(cols = .data$PubMedGrantId) |>
      tidyr::unnest(cols = .data$StudySubject) |>
      tidyr::unnest(cols = .data$Ethnicity) |>
      tidyr::unnest(cols = .data$AgeGroups) |>
      tidyr::unnest(cols = .data$Rurality) |>
      tidyr::unnest(cols = .data$VulnerablePopulations) |>
      tidyr::unnest(cols = .data$OccupationalGroups) |>
      tidyr::unnest(cols = .data$StudyType) |>
      tidyr::unnest(cols = .data$ClinicalTrial) |>
      tidyr::unnest(cols = .data$Pathogen) |>
      tidyr::unnest(cols = .data$Disease) |>
      tidyr::unnest(cols = .data$Tags) |>
      tidyr::unnest(cols = .data$MPOXResearchPriority) |>
      tidyr::unnest(cols = .data$MPOXResearchSubPriority) |>
      tidyr::unnest(cols = .data$ResearchCat) |>
      tidyr::unnest(cols = .data$ResearchSubcat)

    ## Unnest funder locations ----
    funder_df <- list_cols_df |>
      tidyr::unnest(cols = .data$FundingOrgName) |>
      tidyr::unnest(cols = c(.data$FunderCountry, .data$FunderRegion))

    ## Unnest research institution location ----
    institution_df <- list_cols_df |>
      tidyr::unnest(
        c(.data$ResearchInstitutionCountry, .data$ResearchInstitutionRegion)
      )

    ## Unnest research location ----
    research_df <- list_cols_df |>
      tidyr::unnest(
        c(.data$ResearchLocationCountry, .data$ResearchLocationRegion)
      )
  }
}
