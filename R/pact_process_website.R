#'
#' Process Pandemic PACT dataset retrieved from the website
#' 
#' @param pact_data A data.frame for the Pandemic PACT dataset read from the
#'   Pandemic PACT website. This is usually obtained via a call to 
#'   `pact_read_website()`.
#' @param col_list Logical. Should variable/fields with multiple values be
#'   made into column lists? Default to TRUE.
#' @param fix Logical. Should fixes be applied to the dataset based on known
#'   issues? Default to TRUE.
#'
#' @returns A tibble of the dataset from the website structured based on 
#'   `col_list` and `fix`` specifications.
#'
#' @examples
#' \dontrun{
#'   pact_data <- pact_read_website()
#'   pact_process_website(pact_data)
#' }
#'
#' @rdname pact_process_website
#' @export
#' 

pact_process_website <- function(pact_data,
                                 col_list = TRUE, 
                                 fix = TRUE) {
  if (fix) {
    ## Fix blank value for Disease (grant ID P22196)
    pact_data <- pact_data |>
      dplyr::mutate(
        Disease = ifelse(
          .data$GrantID == "P22196", "Zika virus disease", .data$Disease
        ),
        PubMedGrantId = ifelse(
          .data$PubMedGrantId == "", NA_character_, .data$PubMedGrantId
        ),
        Abstract = ifelse(.data$Abstract == "", NA_character_, .data$Abstract),
        PublicationYearOfAward = ifelse(
          .data$PublicationYearOfAward == -99, NA_integer_, 
          .data$PublicationYearOfAward
        ),
        GrantEndYear = ifelse(
          .data$GrantEndYear == -99, NA_integer_, .data$GrantEndYear
        ),   
        ResearchInstitutionName = ifelse(
          .data$ResearchInstitutionName == "N/A", NA_character_, 
          .data$ResearchInstitutionName
        ),
        ClinicalTrial = ifelse(
          .data$ClinicalTrial == "", NA_character_, .data$ClinicalTrial
        ),
        Pathogen = ifelse(.data$Pathogen == "", NA_character_, .data$Pathogen),
        InfluenzaA = ifelse(
          .data$InfluenzaA == "", NA_character_, .data$InfluenzaA
        ),
        InfluenzaH1 = ifelse(
          .data$InfluenzaH1 == "", NA_character_, .data$InfluenzaH1
        ),
        InfluenzaH2 = ifelse(
          .data$InfluenzaH2 == "", NA_character_, .data$InfluenzaH2
        ),
        InfluenzaH3 = ifelse(
          .data$InfluenzaH3 == "", NA_character_, .data$InfluenzaH3
        ),
        InfluenzaH5 = ifelse(
          .data$InfluenzaH5 == "", NA_character_, .data$InfluenzaH5
        ),
        InfluenzaH6 = ifelse(
          .data$InfluenzaH6 == "", NA_character_, .data$InfluenzaH6
        ),
        InfluenzaH7 = ifelse(
          .data$InfluenzaH7 == "", NA_character_, .data$InfluenzaH7
        ),
        InfluenzaH10 = ifelse(
          .data$InfluenzaH10 == "", NA_character_, .data$InfluenzaH10
        ),
        Disease = ifelse(
          .data$Disease == "", NA_character_, .data$Disease
        ),
        FundingOrgName = ifelse(
          .data$FundingOrgName == "", NA_character_, .data$FundingOrgName
        ),
        Tags = ifelse(.data$Tags == "", NA_character_, .data$Tags)
      )
  
    ## Fix one-to-one issues for country and region variables ----
    pact_data <- within(pact_data, {
      FunderRegion <- get_who_regions(FunderCountry)
      ResearchInstitutionRegion <- get_who_regions(ResearchInstitutionCountry)
      ResearchLocationRegion <- get_who_regions(ResearchLocationCountry)
    })

    ## Fix GrantStartYear ----
    pact_data <- pact_data |>
      dplyr::mutate(
        GrantStartYear = ifelse(
          .data$GrantStartYear < 2020 | is.na(.data$GrantStartYear), 
          .data$PublicationYearOfAward, .data$GrantStartYear
        )
      )

    ## Fix one-to-one issues with research category and subcategory ----
    pact_data <- get_research_category(pact_data)

    ## Fix one-to-one issues for Mpox subpriority and Mpox priority ----
    pact_data <- get_mpox_priority(pact_data)
  }
  
  ## Standardise NA specification (nested) ----
  # pact_data <- pact_data |>
  #   dplyr::mutate(
  #     PubMedGrantId = ifelse(
  #       .data$PubMedGrantId == "", NA_character_, .data$PubMedGrantId
  #     ),
  #     Abstract = ifelse(.data$Abstract == "", NA_character_, .data$Abstract),
  #     PublicationYearOfAward = ifelse(
  #       .data$PublicationYearOfAward == -99, NA_integer_, 
  #       .data$PublicationYearOfAward
  #     ),
  #     GrantEndYear = ifelse(
  #       .data$GrantEndYear == -99, NA_integer_, .data$GrantEndYear
  #     ),   
  #     ResearchInstitutionName = ifelse(
  #       .data$ResearchInstitutionName == "N/A", 
  #       NA_character_, 
  #       .data$ResearchInstitutionName
  #     ),
  #     StudySubject = ifelse(
  #       .data$StudySubject == "Not applicable", NA_character_, 
  #       .data$StudySubject
  #     ),
  #     Ethnicity = ifelse(
  #       .data$Ethnicity == "Not applicable", NA_character_, .data$Ethnicity
  #     ),
  #     AgeGroups = ifelse(
  #       .data$AgeGroups == "Not Applicable", NA_character_, .data$AgeGroups
  #     ),
  #     Rurality = ifelse(
  #       .data$Rurality == "Not applicable", NA_character_, .data$Rurality
  #     ),
  #     VulnerablePopulations = ifelse(
  #       .data$VulnerablePopulations == "Not applicable", NA_character_,
  #       .data$VulnerablePopulations
  #     ),
  #     OccupationalGroups = ifelse(
  #       .data$OccupationalGroups == "Not applicable", NA_character_,
  #       .data$OccupationalGroups
  #     ),
  #     StudyType = ifelse(
  #       .data$StudyType == "Not applicable", NA_character_, .data$StudyType
  #     ),
  #     ClinicalTrial = dplyr::case_when(
  #       .data$ClinicalTrial == "" ~ NA_character_,
  #       .data$ClinicalTrial == "Not applicable" ~ NA_character_,
  #       .default = .data$ClinicalTrial
  #     ),
  #     Pathogen = ifelse(.data$Pathogen == "", NA_character_, .data$Pathogen),
  #     InfluenzaA = ifelse(
  #       .data$InfluenzaA == "", NA_character_, .data$InfluenzaA
  #     ),
  #     InfluenzaH1 = ifelse(
  #       .data$InfluenzaH1 == "", NA_character_, .data$InfluenzaH1
  #     ),
  #     InfluenzaH2 = ifelse(
  #     .data$InfluenzaH2 == "", NA_character_, .data$InfluenzaH2
  #     ),
  #     InfluenzaH3 = ifelse(
  #       .data$InfluenzaH3 == "", NA_character_, .data$InfluenzaH3
  #     ),
  #     InfluenzaH5 = ifelse(
  #       .data$InfluenzaH5 == "", NA_character_, .data$InfluenzaH5
  #     ),
  #     InfluenzaH6 = ifelse(
  #       .data$InfluenzaH6 == "", NA_character_, .data$InfluenzaH6
  #     ),
  #     InfluenzaH7 = ifelse(
  #       .data$InfluenzaH7 == "", NA_character_, .data$InfluenzaH7
  #     ),
  #     InfluenzaH10 = ifelse(
  #       .data$InfluenzaH10 == "", NA_character_, .data$InfluenzaH10
  #     ),
  #     Disease = dplyr::case_when(
  #       .data$Disease == "" ~ NA_character_,
  #       .data$Disease == "Not applicable" ~ NA_character_,
  #       .default = .data$Disease
  #     ),
  #     FundingOrgName = ifelse(
  #       .data$FundingOrgName == "", NA_character_, .data$FundingOrgName
  #     ),
  #     Tags = ifelse(.data$Tags == "", NA_character_, .data$Tags)
  #   )        
  
  ## Create list columns ----
  list_cols_df <- pact_data |>
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::contains(nested_vars),
        .fns = ~stringr::str_split(
          string = .x, pattern = " \\| "
        )
      ),
      PubMedGrantId = stringr::str_split(
        string = .data$PubMedGrantId, pattern = ", "
      )
    )
  
  ## Structure data ----
  if (col_list) {
    pact_data <- list_cols_df
  } else {
    pact_data <- pact_data
  }

  ## Return pact_data ----
  pact_data
}
