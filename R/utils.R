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
