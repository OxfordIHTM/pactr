#' @keywords internal 

pact_data_list_figshare <- function(fig_list) {
  ## List all available Pandemic PACT tracker datasets ----
  data_df <- fig_list |>
    dplyr::filter(grepl(pattern = "PandemicPACT-Dataset", x = .data$name)) |>
    dplyr::mutate(
      release_date = as.Date(stringr::str_extract(
        string = .data$name,
        pattern = "[0-9]{4}-[0-9]{2}-[0-9]{2}"
      ))
    ) |>
    dplyr::arrange(desc(.data$release_date))

  data_dict <- fig_list |>
    dplyr::filter(grepl(pattern = "PandemicPACT_DataDictionary", x = .data$name)) |>
    dplyr::mutate(
      release_date = as.Date(stringr::str_extract(
        string = .data$name,
        pattern = "[0-9]{4}-[0-9]{2}-[0-9]{2}"
      ))
    ) |>
    dplyr::arrange(desc(.data$release_date))

  list(
    pact_data = data_df,
    pact_data_dictionary = data_dict
  )
}

#' @keywords internal

get_dictionary_version <- function(data_version, dict_versions) {
  head(dict_versions[data_version >= dict_versions], 1)
}


#' @keywords internal

check_version <- function(version, data_versions) {
  if (is.null(version)) {
    warning(
      "`version` is not specified. Reading the latest version instead."
    )

    version_date <- as.Date(data_versions[1])
  } else {
    ## Check that version is in the right format ----
    version_date <- try(as.Date(version), silent = TRUE)

    if (is(version_date, "try-error")) {
      stop(
        "`version` is not specified correctly. Please try again."
      )
    }

    if (!version_date %in% as.Date(data_versions)) {
      warning(
        "Specified `version` is not a known Pandemic PACT dataset version. ",
        "Reading the latest version instead."
      )
      
      version_date <- as.Date(data_versions[1])
    }
  }

  version_date
}

#' @keywords internal

get_latest_version <- function(fig_list, data_type = c("data", "dictionary")) {
  data_type <- match.arg(data_type)

  switch(
    data_type,
    "data" = fig_list[["pact_data"]]$release_date[1],
    "dictionary" = fig_list[["pact_data_dictionary"]]$release_date[1]
  )
}
