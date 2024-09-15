#
# Quiet down checks for global variables
#

utils::globalVariables(c("defined_type", "group_id"))

#
# Process author names
#

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
# Detect one-to-one mismatch
#

detect_mismatch <- function(x, y) {
  length_a <- stringr::str_split(string = x, pattern = " \\| ") |>
    lapply(FUN = length) |>
    unlist()

  length_b <- stringr::str_split(string = y, pattern = " \\| ") |>
    lapply(FUN = length) |>
    unlist()
    
  length_a > length_b
}

#
# Get WHO region
#

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
        who_country_info |>
          dplyr::filter(country_iso3c == x) |>
          dplyr::pull(who_region)
      )
    }
  ) |>
    paste(collapse = " | ")
}

#
# Get WHO regions
#

get_who_regions <- function(x) {
  lapply(
    X = x,
    FUN = get_who_region
  ) |>
    unlist()
}