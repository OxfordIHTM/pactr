#'
#' Process Pandemic PACT data
#'
#' @param df A data.frame of the Pandemic PACT dataset from the Figshare
#'   repository
#'
#' @returns A tibble
#'
#' @examples
#' \dontrun{
#'   pact_data <- pact_read_data_tracker(pact_client_set())
#'   pact_process_data_tracker(df = pact_data)
#' }
#'
#' @rdname pact_process
#' @export
#'

pact_process_data_tracker <- function(df) {
  core_vars <- df |>
    dplyr::select(.data$PactID:.data$Grant.Start.Year)

  study_subject <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Study.Subject"),
      names_to = "Study.Subject", names_prefix = "Study.Subject..choice."
    ) |>
    dplyr::mutate(
      Study.Subject = stringr::str_replace_all(
        string = .data$Study.Subject, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x) ifelse(x == "Other", .data$If..Study.Subject..Please.Specific., x))()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Study.Subject = list(.data$Study.Subject)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Study.Subject))

  tidy_data <- dplyr::left_join(core_vars, study_subject, by = "PactID") |>
    tibble::tibble()

  ethnicity <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Ethnicity"),
      names_to = "Ethnicity", names_prefix = "Ethnicity..choice."
    ) |>
    dplyr::mutate(
      Ethnicity = stringr::str_replace_all(
        string = .data$Ethnicity, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(
              x == "Other", .data$If..Other.Ethnicity..Please.Specific., x
            )
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Ethnicity = list(.data$Ethnicity)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Ethnicity))

  tidy_data <- dplyr::left_join(tidy_data, ethnicity, by = "PactID")

  age_groups <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Age.Groups"),
      names_to = "Age.Groups", names_prefix = "Age.Groups..choice."
    ) |>
    dplyr::mutate(
      Age.Groups = stringr::str_replace_all(
        string = .data$Age.Groups, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(
              x == "Other", .data$If..Other.AgeGroups..Please.Specific., x
            )
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Age.Groups = list(.data$Age.Groups)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Age.Groups))

  tidy_data <- dplyr::left_join(tidy_data, age_groups, by = "PactID")

  rurality <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Rurality"),
      names_to = "Rurality", names_prefix = "Rurality..choice."
    ) |>
    dplyr::mutate(
      Rurality = stringr::str_replace_all(
        string = .data$Rurality, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(x == "Other", .data$If..Other.Rurality..Please.Specific., x)
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Rurality = list(.data$Rurality)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Rurality))

  tidy_data <- dplyr::left_join(tidy_data, rurality, by = "PactID")

  vulnerable <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Vulnerable.Population"),
      names_to = "Vulnerable.Population",
      names_prefix = "Vulnerable.Population..choice."
    ) |>
    dplyr::mutate(
      Vulnerable.Population = stringr::str_replace_all(
        string = .data$Vulnerable.Population, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(
              x == "Other",
              .data$If..Other.Vulnerable.Population..Please.Specific.,
              x
            )
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Vulnerable.Population = list(.data$Vulnerable.Population)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Vulnerable.Population))

  tidy_data <- dplyr::left_join(tidy_data, vulnerable, by = "PactID")

  occupation <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Occupational.Groups"),
      names_to = "Occupational.Groups",
      names_prefix = "Occupational.Groups..choice."
    ) |>
    dplyr::mutate(
      Occupational.Groups = stringr::str_replace_all(
        string = .data$Occupational.Groups, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(
              x == "Other",
              .data$If..Other.OccupationalGroups..Please.Specific.,
              x
            )
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Occupational.Groups = list(.data$Occupational.Groups)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Occupational.Groups))

  tidy_data <- dplyr::left_join(tidy_data, occupation, by = "PactID")

  study_type <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Study.Type"),
      names_to = "Study.Type",
      names_prefix = "Study.Type..choice."
    ) |>
    dplyr::mutate(
      Study.Type = stringr::str_replace_all(
        string = .data$Study.Type, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(
              x == "Other",
              .data$If..Other.Study.Type..Please.Specific.,
              x)
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Study.Type = list(.data$Study.Type)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Study.Type))

  tidy_data <- dplyr::left_join(tidy_data, study_type, by = "PactID")

  clinical_trial <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Clinical.Trial"),
      names_to = "Clinical.Trial",
      names_prefix = "Clinical.Trial..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Clinical.Trial = list(.data$Clinical.Trial)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Clinical.Trial))

  tidy_data <- dplyr::left_join(tidy_data, clinical_trial, by = "PactID") |>
    dplyr::mutate(report = df$Report.or.Literature.Based.Research)

  pathogen <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Pathogen"),
      names_to = "Pathogen",
      names_prefix = "Pathogen..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::select(c(.data$PactID, .data$Pathogen)) |>
    dplyr::left_join(
      df |>
        tidyr::pivot_longer(
          cols = dplyr::starts_with("Coronavirus"),
          names_to = "Coronavirus",
          names_prefix = "Coronavirus..choice."
        ) |>
        dplyr::filter(.data$value == "Checked") |>
        dplyr::select(c(.data$PactID, .data$Coronavirus)),
      by = "PactID",
      relationship = "many-to-many"
    ) |>
    dplyr::left_join(
      df |>
        dplyr::select(
          c(.data$PactID, .data$Bunyaviridae:.data$Influenza.A)
        ),
      by = "PactID"
    ) |>
    dplyr::mutate(
      dplyr::across(
        .cols = .data$Pathogen:.data$Influenza.A,
        .fns = function(x) stringr::str_remove_all(
          string = x, pattern = "\\.$"
        ) |>
          (\(x) ifelse(x == "Not.applicable|Not applicable", NA_character_, x))()
      ),
      Coronavirus = stringr::str_replace_all(
        string = .data$Coronavirus, pattern = "\\.", replacement = "-"
      ),
      Pathogen = stringr::str_replace(
        string = .data$Pathogen, pattern = "\\.", replacement = " "
      ),
      Pathogen.Specific = dplyr::case_when(
        .data$Pathogen == "Coronavirus" ~ paste0(.data$Pathogen, " - ", .data$Coronavirus),
        .data$Pathogen == "Bunyaviridae" ~ paste0(.data$Pathogen, " - ", .data$Bunyaviridae),
        .data$Pathogen == "Filoviridae" ~ paste0(.data$Pathogen, " - ", .data$Filoviridae),
        .data$Pathogen == "Arenaviridae" ~ paste0(.data$Pathogen, " - ", .data$Arenaviridae),
        .data$Pathogen == "Henipavirus" ~ paste0(.data$Pathogen, " - ", .data$Henipavirus),
        .data$Pathogen == "Flaviviridae" ~ paste0(.data$Pathogen, " - ", .data$Flaviviridae),
        .data$Pathogen == "Influenza A" ~ paste0(.data$Pathogen, " - ", .data$Influenza.A),
        .default = .data$Pathogen
      )
    ) |>
    dplyr::select(c(.data$PactID, .data$Pathogen, .data$Pathogen.Specific)) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(
      dplyr::across(
        .cols = .data$Pathogen:.data$Pathogen.Specific,
        .fns = ~list(.x)
      )
    ) |>
    dplyr::distinct() |>
    dplyr::ungroup()

  tidy_data <- dplyr::left_join(tidy_data, pathogen, by = "PactID")

  disease <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Disease"),
      names_to = "Disease",
      names_prefix = "Disease..choice."
    ) |>
    dplyr::mutate(
      Disease = stringr::str_replace_all(
        string = .data$Disease, pattern = "\\.", replacement = " "
      ) |>
        stringr::str_trim() |>
        (\(x)
          {
            ifelse(x == "Other", .data$If..Other.Disease..Please.Specific., x)
          }
        )()
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Disease = list(.data$Disease)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Disease))

  tidy_data <- dplyr::left_join(tidy_data, disease, by = "PactID") |>
    dplyr::mutate(
      mesh_terms = df$MESH_Terms,
      complete_section1 = df$Complete.
    )

  funder <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Funder.Name"),
      names_to = "Funder.Name",
      names_prefix = "Funder.Name..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::mutate(
      Funder.Name = stringr::str_replace(
        string = .data$Funder.Name, pattern = "\\.\\.\\.", replacement = " "
      ) |>
        stringr::str_replace(pattern = "\\.\\.", replacement = " (") |>
        stringr::str_replace(pattern = "\\.\\.", replacement = ")") |>
        stringr::str_replace_all(pattern = "\\.", replacement = " ")
    ) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Funder.Name = list(.data$Funder.Name)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Funder.Name))

  tidy_data <- dplyr::left_join(tidy_data, funder, by = "PactID")

  funder_country <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Funder.Country"),
      names_to = "Funder.Country",
      names_prefix = "Funder.Country..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::mutate(
      Funder.Country = stringr::str_remove(
        string = .data$Funder.Country, pattern = "\\.$"
      ) |>
        stringr::str_replace_all(pattern = "\\.", replacement = " ")
    ) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Funder.Country = list(.data$Funder.Country)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Funder.Country))

  tidy_data <- dplyr::left_join(tidy_data, funder_country, by = "PactID")

  funder_region <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Funder.Region"),
      names_to = "Funder.Region",
      names_prefix = "Funder.Region..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::mutate(
      Funder.Region = stringr::str_remove(
        string = .data$Funder.Region, pattern = "\\.$"
      ) |>
        stringr::str_replace_all(pattern = "\\.", replacement = " ")
    ) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Funder.Region = list(.data$Funder.Region)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Funder.Region))

  tidy_data <- dplyr::left_join(tidy_data, funder_region, by = "PactID") |>
    dplyr::mutate(
      complete_section2 = df$Complete..1,
      ror_id = df$ROR.ID,
      institution_name = df$Institution.Name,
      institution_country = df$Institution.Country,
      institution_country_code = df$institution.Country.ISO
    )

  institution_region <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Research_Institution_Region"),
      names_to = "Research_Institution_Region",
      names_prefix = "Research_Institution_Region..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::mutate(
      Research_Institution_Region = stringr::str_remove(
        string = .data$Research_Institution_Region, pattern = "\\.$"
      ) |>
        stringr::str_replace(pattern = "\\.", replacement = " ")
    ) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(
      Research_Institution_Region = list(.data$Research_Institution_Region)
    ) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Research_Institution_Region))

  tidy_data <- dplyr::left_join(tidy_data, institution_region, by = "PactID")

  research_region <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Research.Location.Region"),
      names_to = "Research.Location.Region",
      names_prefix = "Research.Location.Region..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::mutate(
      Research.Location.Region = stringr::str_remove(
        string = .data$Research.Location.Region, pattern = "\\.$"
      ) |>
        stringr::str_replace_all(pattern = "\\.", replacement = " ")
    ) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(
      Research.Location.Region = list(.data$Research.Location.Region)
    ) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Research.Location.Region))

  tidy_data <- dplyr::left_join(tidy_data, research_region, by = "PactID") |>
    dplyr::mutate(complete_section3 = df$Complete..2)

  tags <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with("Tags"),
      names_to = "Tags",
      names_prefix = "Tags..choice."
    ) |>
    dplyr::filter(.data$value == "Checked") |>
    dplyr::mutate(
      Tags = stringr::str_remove(string = .data$Tags, pattern = "\\.$") |>
        stringr::str_replace_all(pattern = "\\.", replacement = " ")
    ) |>
    dplyr::group_by(.data$PactID) |>
    dplyr::mutate(Tags = list(.data$Tags)) |>
    dplyr::distinct() |>
    dplyr::ungroup() |>
    dplyr::select(c(.data$PactID, .data$Tags))

  tidy_data <- dplyr::left_join(tidy_data, tags, by = "PactID") |>
    dplyr::mutate(complete_section4 = df$Complete..3)

  tidy_data
}
