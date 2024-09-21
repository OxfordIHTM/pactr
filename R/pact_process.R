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
#'   name/s  in `pact_data` to use as grouping variable/s. When specified as 
#'   NULL (default), no grouping is applied to come up with value of `outcome`
#'   based on the `topic` of interest.
#' @param outcome The type of outcome. Either *"frequency"* or *"money"*.
#'   Default is *"frequency"*.
#' @param na_values A character value or vector of values for strings to be
#'   considered as NA for `topic` and `group`. If NULL (default), `topic` and
#'   `group` are kept as is.
#' @param split_grants Logical. Should grants be divided into those with
#'   specified or unspecified amount of funding. Default to TRUE.
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
#'   pact_process_topic_group(df, topic = "Disease")
#' }
#' 
#' @rdname pact_process
#' @export
#' 

pact_process_topic_group <- function(pact_data_list_cols, 
                                     topic, group = NULL, 
                                     outcome = c("frequency", "money"),
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
  
  ## Get outcome value ----
  outcome <- match.arg(outcome)

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

  ## Frequencies or monies ----
  if (outcome == "frequency") {
    tidy_df <- parse(
      text = paste0(
        "tidy_df |> dplyr::count(",
        paste(c(group, topic), collapse = ", "), ")"
      )
    ) |>
      eval()
  } else {
    tidy_df <- parse(
      text = paste0(
        "tidy_df |> dplyr::group_by(",
        paste(c(group, topic), collapse = ", "), 
        ") |> dplyr::summarise(",
        "total_grant_amount = sum(GrantAmountConverted, na.rm = TRUE))"
      )
    ) |>
      eval()
  }

  ## Return tidy_df ----
  tidy_df
}

#'
#' @rdname pact_process
#' @export
#' 

pact_process_disease <- function(pact_data_list_cols,
                                 group = NULL,
                                 outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)

  pact_process_topic_group(
    pact_data_list_cols = pact_data_list_cols, 
    topic = "Disease", group = group, outcome = outcome
  )
}

#'
#' @rdname pact_process
#' @export
#' 

pact_process_category <- function(pact_data_list_cols,
                                  topic = c("ResearchCat", "ResearchSubcat"),
                                  split_grants = TRUE,
                                  outcome = c("frequency", "money")) {
  ## Get topic ----
  topic <- match.arg(topic)

  ## Get outcome ----
  outcome <- match.arg(outcome)

  ## Process data based on split_grants ----
  if (outcome == "frequency") {
    if (split_grants) {
      pact_data_list_cols <- pact_data_list_cols |>
        dplyr::mutate(
          grant_known_amount = ifelse(
            is.na(.data$GrantAmountConverted), "Unspecified", "Specified"
          ) |>
            factor(levels = c("Specified", "Unspecified"))
        )
      
      ## Create group ----
      group <- ifelse(
        topic == "ResearchCat", "ResearchCat", 
        c("ResearchCat", "ResearchSubcat")
      )

      ## Set topic ----
      topic <- "grant_known_amount"
    } else {
      if (topic == "ResearchCat") group <- NULL
      if (topic == "ResearchSubcat") group <- "ResearchCat"
    }
  } else {
    if (topic == "ResearchCat") group <- NULL
    if (topic == "ResearchSubcat") group <- "ResearchCat"
  }

  ## Process table ----
  pact_process_topic_group(
    pact_data_list_cols = pact_data_list_cols, 
    topic = topic, 
    group = group, outcome = outcome
  )
}
