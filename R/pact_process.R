#'
#' Process variable of interest from Pandemic PACT website data by a grouping
#' variable
#' 
#' @param df A data.frame of the Pandemic PACT dataset from the Figshare
#'   repository.
#' @param topic A character value of the variable name in `df` for the topic of
#'   interest.
#' @param group A character value or vector of up to two values of the variable 
#'   name/s  in `df` to use as grouping variable/s. When specified as NULL
#'   (default), no grouping is applied to come up with value of `outcome`
#'   based on the `topic` of interest. When specified as NULL (default), no
#'   grouping is applied.
#' @param outcome The type of outcome. Either *"frequency"* or *"money"*.
#'   Default is *"frequency"*.
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
#'   df <- pact_read_website()
#'   pact_process_topic_group(df, topic = "Disease")
#' }
#' 
#' @rdname pact_process
#' @export
#' 

pact_process_topic_group <- function(df, topic, group = NULL, 
                                     outcome = c("frequency", "money")) {
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
    tidy_df <- df |>
      tidyr::unnest(cols = {{ topic }})
  } else {
    tidy_df <- df
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

pact_process_disease <- function(df,
                                 group = NULL,
                                 outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)

  pact_process_topic_group(
    df = df, topic = "Disease", group = group, outcome = outcome
  )
}

#'
#' @rdname pact_process
#' @export
#' 

pact_process_category <- function(df,
                                  group = NULL,
                                  outcome = c("frequency", "money")) {
  ## Get outcome ----
  outcome <- match.arg(outcome)

  pact_process_topic_group(
    df = df, topic = "ResearchSubcat", group = group, outcome = outcome
  )
}