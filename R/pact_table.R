#'
#' Process variable of interest from Pandemic PACT website data by a grouping
#' variable
#' 
#' @param pact_data_list_cols A data.frame for the Pandemic PACT dataset read 
#'   from the Pandemic PACT website that has already been pre-processed to have
#'   list columns for nested variables. This is usually obtained via a call to 
#'   `pact_process_website()` with `col_list = TRUE`.
#' @param topic A character value of the variable name in `pact_data` for the 
#'   topic of interest.
#' @param group A character value or vector of up to two values of the variable 
#'   name/s  in `pact_data_list_cols` to use as grouping variable/s. When 
#'   specified as NULL (default), no grouping is applied to the tabulation
#'   based on the `topic` of interest and `group` specified.
#' @param na_values A character value or vector of values for strings to be
#'   considered as NA for `topic` and `group`. If NULL (default), `topic` and
#'   `group` are kept as is.
#' 
#' @returns A data.frame structured based on specification. If `group` is NULL,
#'   the data.frame presents values for `topic` as first column and then either
#'   frequencies/counts of grants per `topic` value or sum of monetary amount of 
#'   grants per `topic`. if `group` has one value, the data.frame presents 
#'   values for `group` as first column followed by either frequencies/counts 
#'   of grants per `group` or sum of monetary amount of grants per `group` then
#'   followed by the `topics` within each `group` followed by either 
#'   frequencies/counts of grants per `topic` by `group` or sum of monetary 
#'   amount of grants per `topic` by `group`.
#' 
#' @examples
#' \dontrun{
#'   df <- pact_read_website() |> pact_process_website()
#'   pact_table_topic_group(df, topic = "Disease")
#' }
#' 
#' @rdname pact_table
#' @export
#' 

pact_table_topic_group <- function(pact_data_list_cols, 
                                   topic, group = NULL, 
                                   na_values = NULL) {
  ## Check for list columns ----
  if (all(lapply(pact_data_list_cols[ , nested_vars], FUN = class) == "list")) {
    pact_data <- pact_data_list_cols
  } else {
    stop(
      "`pact_data_list_cols` doesn't seem to have the expected list columns. ",
      "Please check that you have used `col_list = TRUE` when using ",
      "`pact_process_website()` and try again."
    )
  }

  ## Check that group is of length 2 or less ----
  if (length(group) > 2) {
    stop(
      "More than 2 grouping variables have been specified. ",
      "Only up to 2 grouping variables are currently supported. ",
      "Please try again."
    )
  }

  ## Check that topic and group are not the same ----
  if (topic %in% group) {
    stop(
      "The `topic` variable cannot be one of the `group` variable. ",
      "Please try again."
    )
  }

  ## Check if topic is a nested variable and unnest if so ----
  if (topic %in% nested_vars) {
    tidy_df <- pact_data |>
      tidyr::unnest(cols = {{ topic }})
  } else {
    tidy_df <- pact_data
  }

  ## Check if group is/are nested variable/s and unnest if so ----
  nested_group_cols <- group[group %in% nested_vars]

  if (all(stringr::str_detect(nested_group_cols, pattern = "Country|Region"))) {
    nested_group_cols <- c(
      nested_group_cols[stringr::str_detect(nested_group_cols, "Country")],
      nested_group_cols[stringr::str_detect(nested_group_cols, "Region")]
    )

    tidy_df <- tidy_df |>
      tidyr::unnest(cols = nested_group_cols)
  } else {
    if (length(nested_group_cols) == 0) {
      tidy_df
    } else {
      unnest_text <- paste0(
        "tidy_df |> ",
        paste0(
          "tidyr::unnest(cols = ",
          nested_group_cols,
          ")" 
        ) |>
          paste(collapse = " |> ")
      )
  
      tidy_df <- parse(text = unnest_text) |> eval()
    }
  }

  ## Handle NA values ----
  if (!is.null(na_values)) {
    tidy_df <- tidy_df |>
      dplyr::mutate(
        dplyr::across(
          .cols = dplyr::contains(c(group, topic)),
          .fns = ~ifelse(.x %in% na_values, NA_character_, .x)
        )
      )
  }

  ## Create variable for grant_amount_type ----
  tidy_df <- tidy_df |>
    dplyr::mutate(
      grant_amount_type = ifelse(
        is.na(.data$GrantAmountConverted), "Unspecfiied", "Specified"
      )
    )

  ## Frequencies ----
  frequency_df <- parse(
    text = paste0(
      "tidy_df |> dplyr::count(",
      paste(c(group, topic), collapse = ", "), 
      ", name = 'n_grants')"
    )
  ) |>
    eval()

  ## Frequencies by grant_amount_type ----
  specified_df <- parse(
    text = paste0(
      "tidy_df |> dplyr::count(",
      paste(c(group, topic, "grant_amount_type"), collapse = ", "), 
      ", name = 'n_grants_specified')"
    )
  ) |>
    eval() |>
    dplyr::filter(.data$grant_amount_type == "Specified") |>
    dplyr::select(c(group, topic, "n_grants_specified"))

  ## Total amount of grants ----
  amount_df <- parse(
    text = paste0(
      "tidy_df |> dplyr::group_by(",
      paste(c(group, topic), collapse = ", "), 
      ") |> dplyr::summarise(",
      "grant_amount_total = sum(GrantAmountConverted, na.rm = TRUE))"
    )
  ) |>
    eval()

  ## Concatenate frequency and amount ----
  tidy_df <- dplyr::full_join(
    frequency_df, specified_df, by = c(group, topic)
  ) |>
    dplyr::full_join(amount_df, by = c(group, topic))
  
  ## Return tidy_df ----
  tidy_df
}

#'
#' @rdname pact_table
#' @export
#' 

pact_table_disease <- function(pact_data_list_cols, group = NULL) {
  ## Process table
  pact_table_topic_group(
    pact_data_list_cols = pact_data_list_cols, 
    topic = "Disease", group = group
  )
}

#'
#' @rdname pact_table
#' @export
#' 

pact_table_category <- function(pact_data_list_cols,
                                topic = c("ResearchCat", "ResearchSubcat")) {
  ## Get topic ----
  topic <- match.arg(topic)

  ## Determine group based on topic ----
  if (topic == "ResearchCat") group <- NULL
  if (topic == "ResearchSubcat") group <- "ResearchCat"

  ## Process table ----
  pact_table_topic_group(
    pact_data_list_cols = pact_data_list_cols, topic = topic, group = group
  )
}
