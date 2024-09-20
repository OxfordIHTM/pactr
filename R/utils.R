#'
#' Process author names
#'
#' @param authors A character vector of author names
#' 
#' @returns A concatenated string of author names formatted as per person
#'   specification.
#' 
#' @examples
#' \dontrun{
#'   process_author_names(c("John Doe", "Jane Doe"))
#' }
#' 
#' @keywords internal
#' 

process_author_names <- function(authors) {
  paste0(
    "c(", paste(
      paste0("person(\'", authors, "\')"), collapse = ", "
    ), ")"
  ) |>
    parse(text = _)
}

#
# Nested variables in downloadable dataset from website
#

nested_vars <- c(
  "PubMedGrantId", "StudySubject", "Ethnicity", "AgeGroups", "Rurality",
  "VulnerablePopulations", "OccupationalGroups", "StudyType", "ClinicalTrial",
  "Pathogen", "Disease", "FundingOrgName", "FunderCountry", "FunderRegion",
  "ResearchInstitutionRegion", "ResearchLocationRegion", "Tags",
  "MPOXResearchPriority", "MPOXResearchSubPriority", 
  "ResearchInstitutionCountry", "ResearchLocationCountry", "ResearchCat",
  "ResearchSubcat"
)

#
# Topic variables in downloadable dataset from website
#

topic_vars <- c(
  "GrantEndYear", "ResearchInstitutionName", "StudySubject", "Ethnicity",
  "AgeGroups", "Rurality", "VulnerablePopulations", "OccupationalGroups",
  "StudyType", "ClinicalTrial", "Pathogen", "InfluenzaA", "InfluenzaH1",
  "InfluenzaH2", "InfluenzaH3", "InfluenzaH5", "InfluenzaH6", "InfluenzaH7",
  "InfluenzaH10", "Disease", "FundingOrgName", "FunderCountry", "FunderRegion",
  "ResearchInstitutionRegion", "ResearchLocationRegion", "Tags",
  "MPOXResearchPriority", "MPOXResearchSubPriority", 
  "ResearchInstitutionCountry", "ResearchLocationCountry", "ResearchCat",
  "GrantStartYear" 
)

#'
#' Detect one-to-one mismatch in variables
#' 
#' @param x A vector of values from the Pandemic PACT dataset.
#' @param y A vector of values from the Pandemic PACT dataset to match `x`
#'   against. 
#' 
#' @returns A logical vector indicating whether `x` and `y` have matching
#'   values (TRUE) or not (FALSE).
#' 
#' @examples
#' \dontrun{
#'   detect_mismatch(ResearchInstitutionCountry, ResearchInstitutionRegion)
#' } 
#' 
#' @keywords internal
#'

detect_mismatch <- function(x, y) {
  length_a <- stringr::str_split(string = x, pattern = " \\| ") |>
    lapply(FUN = length) |>
    unlist()

  length_b <- stringr::str_split(string = y, pattern = " \\| ") |>
    lapply(FUN = length) |>
    unlist()
    
  length_a > length_b
}

#'
#' Get WHO region
#' 
#' @param x A character value or vector of values of WHO countries to get the 
#'   WHO region/s of.
#' 
#' @returns A character value or vector of values of WHO regions.
#' 
#' @examples
#' \dontrun{
#'   get_who_regions("United Kingdom")
#' }
#' 
#' @rdname get_who_region
#' @keywords internal
#'

get_who_region <- function(x) {
  ccode <- ifelse(
    x == "", NA_character_, stringr::str_split(string = x, pattern = " \\| ")
  ) |>
    lapply(
      FUN = function(x) {
        ifelse(
          x == "International", "INT",
          countrycode::countrycode(
            sourcevar = x, origin = "country.name", destination = "iso3c",
            warn = FALSE
          )
        )
      }
    ) |>
      unlist()

  lapply(
    X = ccode, 
    FUN = function(x) {
      ifelse(
        x == "INT", "International",
        pactr::who_country_info |>
          dplyr::filter(.data$country_iso3c == x) |>
          dplyr::pull(.data$who_region)
      )
    }
  ) |>
    paste(collapse = " | ")
}

#'
#' @rdname get_who_region
#' @keywords internal
#' 

get_who_regions <- function(x) {
  lapply(
    X = x,
    FUN = get_who_region
  ) |>
    unlist()
}

#'
#' Get Pandemic PACT research category
#'
#' @param pact_data A data.frame for the Pandemic PACT dataset read from the
#'   Pandemic PACT website. This is usually obtained via a call to 
#'   `pact_read_website()`. 
#' 
#' @returns A data.frame of same structure as `pact_data` but with `ResearchCat`
#'   and `ResearchSubcat` variables processed/cleaned.
#' 
#' @examples
#' \dontrun{
#'   get_research_category(pact_data)
#' }
#' 
#' @rdname get_research_category
#' @keywords internal
#'

get_research_category <- function(pact_data) {
  ## Create CatSubcat in reference table ----
  category_reference <- pactr::pact_research_category |>
    dplyr::mutate(
      CatSubcat = paste(
        .data$research_category, .data$research_subcategory, sep = " - "
      )
    )

  ## Recode categories and subcategories with "" values ----
  catsubcat <- pact_data |>
    dplyr::mutate(
      ResearchCat = ifelse(
        .data$ResearchCat == "", "No category", .data$ResearchCat
      ),
      ResearchSubcat = ifelse(
        .data$ResearchSubcat == "", "No subcategory", .data$ResearchSubcat
      )
    ) |>
    dplyr::mutate(
      ResearchCat = stringr::str_split(
        string = .data$ResearchCat, pattern = " \\| "
      ),
      ResearchSubcat = stringr::str_split(
        string = .data$ResearchSubcat, pattern = " \\| "
      )
    ) |>
    tidyr::unnest(.data$ResearchSubcat) |>
    tidyr::unnest(.data$ResearchCat) |>
    dplyr::mutate(
      CatSubcat = paste(
        .data$ResearchCat, .data$ResearchSubcat, sep = " - "
      )
    ) |>
    dplyr::filter(
      .data$CatSubcat %in% category_reference$CatSubcat |
        stringr::str_detect(
          string = .data$CatSubcat, pattern = "No category|No subcategory"
        )
    ) |>
    dplyr::group_by(.data$GrantID) |>
    dplyr::summarise(
      CatSubcat = unique(.data$CatSubcat) |> paste(collapse = " | "),
      .groups = "drop"
    )

  pact_data <- within(pact_data, {
    ResearchCat = catsubcat$CatSubcat |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!!seq_len(length(x)) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
    ResearchSubcat = catsubcat$CatSubcat |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!seq_len(length(x)) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
  }) |>
    dplyr::mutate(
      ResearchCat = ifelse(
        .data$ResearchCat == "No category", NA_character_,
        .data$ResearchCat
      ),
      ResearchSubcat = ifelse(
        .data$ResearchSubcat == "No subcategory", NA_character_,
        .data$ResearchSubcat
      )
    )

  ## Return pact_data ----
  pact_data
}  
  

#'
#' Get Pandemic PACT Mpox priority
#'
#' @param pact_data A data.frame for the Pandemic PACT dataset read from the
#'   Pandemic PACT website. This is usually obtained via a call to 
#'   `pact_read_website()`. 
#' 
#' @returns A data.frame of same structure as `pact_data` but with
#'   `MPOXResearchPriority` and `MPOXResearchSubPriority` variables 
#'   processed/cleaned.
#' 
#' @examples
#' \dontrun{
#'   get_mpox_priority(pact_data)
#' }
#' 
#' @rdname get_mpox_priority
#' @keywords internal
#'

get_mpox_priority <- function(pact_data) {
  ## Create priority reference based on details in reference table ----
  priority_reference <- pactr::pact_mpox_priority |>
    dplyr::mutate(
      PriorSubprior = paste(
        .data$mpox_priority, .data$mpox_subpriority, sep = " - "
      )
    )

  ## Recode priorities and subpriorities with "" values ----
  priorsubprior <- pact_data |>
    dplyr::mutate(
      MPOXResearchPriority = ifelse(
        .data$MPOXResearchPriority == "", 
        "No priority", .data$MPOXResearchPriority
      ),
      MPOXResearchSubPriority = ifelse(
        .data$MPOXResearchSubPriority == "", 
        "No subpriority", .data$MPOXResearchSubPriority
      )
    ) |>
    dplyr::mutate(
      MPOXResearchPriority = stringr::str_split(
        string = .data$MPOXResearchPriority, pattern = " \\| "
      ),
      MPOXResearchSubPriority = stringr::str_split(
        string = .data$MPOXResearchSubPriority, pattern = " \\| "
      )
    ) |>
    tidyr::unnest(.data$MPOXResearchSubPriority) |>
    tidyr::unnest(.data$MPOXResearchPriority) |>
    dplyr::mutate(
      PriorSubprior = paste(
        .data$MPOXResearchPriority, .data$MPOXResearchSubPriority, 
        sep = " - "
      )
    ) |>
    dplyr::filter(
      .data$PriorSubprior %in% priority_reference$PriorSubprior |
        stringr::str_detect(
          string = .data$PriorSubprior, pattern = "No priority|No subpriority"
        )
    ) |>
    dplyr::group_by(.data$GrantID) |>
    dplyr::summarise(
      PriorSubprior = unique(.data$PriorSubprior) |> paste(collapse = " | "),
      .groups = "drop"
    )

  pact_data <- within(pact_data, {
    MPOXResearchPriority = priorsubprior$PriorSubprior |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!!seq_len(length(x)) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
    MPOXResearchSubPriority = priorsubprior$PriorSubprior |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!seq_len(length(x)) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
  }) |>
    dplyr::mutate(
      MPOXResearchPriority = ifelse(
        .data$MPOXResearchPriority == "No priority", NA_character_,
        .data$MPOXResearchPriority
      ),
      MPOXResearchSubPriority = ifelse(
        .data$MPOXResearchSubPriority == "No subpriority", NA_character_,
        .data$MPOXResearchSubPriority
      )
    )


  ## Return pact_data ----
  pact_data
}