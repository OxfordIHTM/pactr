#'
#' List all available outputs/assets from Pandemic PACT's Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#'
#' @returns A data.frame of available outputs/assets from Pandemic PACT's
#'   Figshare repository.
#'
#' @examples
#' \dontrun{
#'   pact_list(pact_client = pact_client_set())
#' }
#'
#' @rdname pact_list
#' @export
#'
pact_list <- function(pact_client) {
  pact_client$deposits_search(group = 53043)
}

#'
#' @rdname pact_list
#' @export
#'

pact_list_data <- function(pact_client) {
  pact_client$deposits_search(group = 53043) |>
    dplyr::filter(.data$defined_type == 3)
}
