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
