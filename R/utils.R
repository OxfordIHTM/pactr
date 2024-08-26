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
