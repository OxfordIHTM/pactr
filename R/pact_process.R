#'
#' Process Pandemic PACT data
#'
#' @param df A data.frame of the Pandemic PACT dataset from the Figshare
#'   repository
#' @param category A character value for the variable category to look for
#'   in the fields for `df` for collapsing multiple fields into one.
#' @param other A character value for the name of the variable in `df` for
#'   values for other for fields that have an other option. Default to NULL to
#'   indicate that field `category` has no other option.
#' @param nest Logical. Should variable/fields with multiple values be nested? 
#'   Default to FALSE.
#'
#' @returns A tibble of processed Pandemic PACT dataset.
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
  ## Get core variables ----
  core_vars <- df |>
    dplyr::select(.data$PactID:.data$Grant.Start.Year)

  ## Process study subject variable ----
  study_subject <- pact_process_category(
    df, category = "Study.Subject",
    other = "If..Study.Subject..Please.Specific.", nest = TRUE
  )

  ## Concatenate core and study subject ----
  tidy_data <- dplyr::left_join(core_vars, study_subject, by = "PactID") |>
    tibble::tibble()

  ## Process ethnicity variable ----
  ethnicity <- pact_process_category(
    df = df, category = "Ethnicity", 
    other = "If..Other.Ethnicity..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with ethnicity ----
  tidy_data <- dplyr::left_join(tidy_data, ethnicity, by = "PactID")

  ## Process age groups variable ----
  age_groups <- pact_process_category(
    df = df, category = "Age.Groups",
    other = "If..Other.AgeGroups..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with age_groups ----
  tidy_data <- dplyr::left_join(tidy_data, age_groups, by = "PactID")

  ## Process rurality variable ----
  rurality <- pact_process_category(
    df = df, category = "Rurality", 
    other = "If..Other.Rurality..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with rurality ----
  tidy_data <- dplyr::left_join(tidy_data, rurality, by = "PactID")

  ## Process vulnerable variable ----
  vulnerable <- pact_process_category(
    df = df, category = "Vulnerable.Population",
    other = "If..Other.Vulnerable.Population..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with vulnerable ----
  tidy_data <- dplyr::left_join(tidy_data, vulnerable, by = "PactID")

  ## Process occupation variable ----
  occupation <- pact_process_category(
    df = df, category = "Occupational.Groups",
    other = "If..Other.OccupationalGroups..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with occupation ----
  tidy_data <- dplyr::left_join(tidy_data, occupation, by = "PactID")

  ## Process study type variable ----
  study_type <- pact_process_category(
    df = df, category = "Study.Type",
    other = "If..Other.Study.Type..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with study_type ----
  tidy_data <- dplyr::left_join(tidy_data, study_type, by = "PactID")

  ## Process clinical trial variable ----
  clinical_trial <- pact_process_category(
    df = df, category = "Clinical.Trial", nest = TRUE
  )

  ## Concatenate tidy_data with clinical_trial ----
  tidy_data <- dplyr::left_join(tidy_data, clinical_trial, by = "PactID") |>
    dplyr::mutate(report = df$Report.or.Literature.Based.Research)

  ## Process pathogen variable ----
  pathogen <- pact_process_category_pathogen(df = df)

  ## Concatenate tidy_data with pathogen ----
  tidy_data <- dplyr::left_join(tidy_data, pathogen, by = "PactID")

  ## Process disease variable ----
  disease <- pact_process_category(
    df = df, category = "Disease",
    other = "If..Other.Disease..Please.Specific.", nest = TRUE
  )

  ## Concatenate tidy_data with disease ----
  tidy_data <- dplyr::left_join(tidy_data, disease, by = "PactID") |>
    dplyr::mutate(
      mesh_terms = df$MESH_Terms,
      complete_section1 = df$Complete.
    )

  ## Process funder variable ----
  funder <- pact_process_category_funder(df)

  ## Concatenate tidy_data with funder ----
  tidy_data <- dplyr::left_join(tidy_data, funder, by = "PactID")

  ## Process funder country variable ----
  funder_country <- pact_process_category(
    df, category = "Funder.Country", nest = TRUE
  )

  ## Concatenate tidy_data with funder country ----
  tidy_data <- dplyr::left_join(tidy_data, funder_country, by = "PactID")

  ## Process funder region variable ----
  funder_region <- pact_process_category(
    df, category = "Funder.Region", nest = TRUE
  )

  ## Concatenate tidy_data with funder region ----
  tidy_data <- dplyr::left_join(tidy_data, funder_region, by = "PactID") |>
    dplyr::mutate(
      complete_section2 = df$Complete..1,
      ror_id = df$ROR.ID,
      institution_name = df$Institution.Name,
      institution_country = df$Institution.Country |>
        stringr::str_split(pattern = ","),
      institution_country_code = df$institution.Country.ISO |>
        stringr::str_split(pattern = ",")
    )

  ## Process institution region variable ----
  institution_region <- pact_process_category(
    df, category = "Research_Institution_Region", nest = TRUE
  )

  ## Concatenate tidy_data with institution region ----
  tidy_data <- dplyr::left_join(tidy_data, institution_region, by = "PactID")

  ## Process research location region variable ----
  research_region <- pact_process_category(
    df, category = "Research.Location.Region", nest = TRUE
  )

  ## Concatenate tidy_data with research region ----
  tidy_data <- dplyr::left_join(tidy_data, research_region, by = "PactID") |>
    dplyr::mutate(complete_section3 = df$Complete..2)

  ## Process tags variable ----
  tags <- pact_process_category(df, category = "Tags", nest = TRUE)

  ## Concatenate tidy_data with tags ----
  tidy_data <- dplyr::left_join(tidy_data, tags, by = "PactID") |>
    dplyr::mutate(complete_section4 = df$Complete..3)

  ## Return tidy_data
  tidy_data
}


#'
#' @rdname pact_process
#' @export
#'

pact_process_category <- function(df, category, other = NULL, nest = FALSE) {
  ## Tidy up df ----
  tidy_df <- df |>
    tidyr::pivot_longer(
      cols = dplyr::starts_with(category),
      names_to = category, names_prefix = paste0(category, "..choice.")
    ) |>
    dplyr::filter(.data$value == "Checked")

  ## Should the category value be recoded based on other responses? ----
  if (!is.null(other)) {
    tidy_df <- tidy_df |>
      dplyr::mutate(
        dplyr::across(
          .cols = dplyr::starts_with(category),
          .fns = ~ifelse(
            .x %in% c("Other.", "Other"),
            .data[[other]],
            .x
          )
        )
      )
  }

  ## Tidy the category values ----
  tidy_df <- tidy_df |>
    dplyr::mutate(
      dplyr::across(
        .cols = dplyr::starts_with(category),
        .fns = function(x) stringr::str_replace_all(
          string = .data[[category]], pattern = "\\.", 
          replacement = " "
        ) |>
          stringr::str_replace_all(
            pattern = "\\s{2,}font\\s{2,}em", replacement = ""
          ) |>
          stringr::str_replace_all(
            pattern = "  em  font color blue  ", replacement = " - "
          ) |>
          stringr::str_trim()
      )
    )

  ## Should the tidied output be nested? ----
  if (nest) {
    tidy_df <- tidy_df |>
      dplyr::group_by(.data$PactID) |>
      dplyr::mutate(
        dplyr::across(
          .cols = dplyr::starts_with(category),
          .fns = ~list(.x)
        )
      ) |>
      dplyr::distinct() |>
      dplyr::ungroup()
  }

  ## Select PactID and category variable ----
  tidy_df <- tidy_df |>
    dplyr::select(c(.data$PactID, {{ category }}))

  ## Return tidy_df ----
  tidy_df
}

#'
#' @rdname pact_process
#' @export
#' 

pact_process_category_pathogen <- function(df) {
  df |>
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
}

#'
#' @rdname pact_process
#' @export
#' 

pact_process_category_funder <- function(df) {
  df |>
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
}

#'
#' @rdname pact_process
#' @export
#' 

pact_process_disease <- function(df,
                                 group = FALSE,
                                 group_type = c("funder", "funder_location",
                                                "institution", 
                                                "institution_location",
                                                "research_location",
                                                "year")) {
  ## Get agg_type ----
  group_type <- match.arg(group_type)

  ## Unnest disease ----
  unnest_df <- df |>
    tidyr::unnest(cols = Disease)

  if (group) {
    if (group_type == "funder") {
      tidy_df <- unnest_df |>
        tidyr::unnest(FundingOrgName) |>
        dplyr::count(FundingOrgName, name = "n_grant") |>
        dplyr::right_join(
          unnest_df |>
            tidyr::unnest(FundingOrgName) |>
            dplyr::group_by(FundingOrgName, Disease) |>
            dplyr::count(Disease, name = "n_grant_disease"),
          by = "FundingOrgName"
        ) |>
        dplyr::arrange(dplyr::desc(n_grant), dplyr::desc(n_grant_disease)) |>
        dplyr::relocate(n_grant, .before = n_grant_disease)
    }

    if (group_type == "funder_location") {
      tidy_df <- unnest_df |>
        tidyr::unnest(FunderRegion, FunderCountry) |>
        dplyr::count(FunderRegion, name = "n_grant_region") |>
        dplyr::right_join(
          unnest_df |>
            tidyr::unnest(FunderRegion, FunderCountry) |>
            dplyr::group_by(FunderRegion, FunderCountry) |>
            dplyr::count(FunderCountry, name = "n_grant_country"),
          by = "FunderRegion"
        ) |>
        dplyr::right_join(
          unnest_df |>
            tidyr::unnest(FunderRegion, FunderCountry, Disease) |>
            dplyr::group_by(FunderRegion, FunderCountry, Disease) |>
            dplyr::count(Disease, name = "n_grant_disease")
        ) |>
        dplyr::arrange(
          dplyr::desc(n_grant_region), 
          dplyr::desc(n_grant_country), 
          dplyr::desc(n_grant_disease)
        )
    }
  } else {
    tidy_df <- unnest_df |>
      dplyr::count(Disease) |>
      dplyr::arrange(dplyr::desc(n))
  } 
}