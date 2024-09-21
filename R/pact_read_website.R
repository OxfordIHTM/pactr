#'
#' Read datasets from the Pandemic PACT website
#'
#' @param .url The URL for the website dataset.
#'
#' @returns A tibble of the Pandemic PACT dataset from the website.
#'
#' @examples
#' \dontrun{
#'   pact_read_website()
#' }
#'
#' @rdname pact_read_website
#' @export
#' 

pact_read_website <- function(.url = NULL) {
  if (is.null(.url)) {
    .url <- "https://pandemicpact.org/export/pandemic-pact-grants.csv"
  } else {
    .url <- .url 
  }

  ## Read dataset from website ----
  pact_data <- read.csv(file = .url) |> tibble::tibble()

  ## Return pact_data ----
  pact_data
}
