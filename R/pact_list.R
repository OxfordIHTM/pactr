#'
#' List all available outputs/assets from Pandemic PACT's Figshare repository
#'
#' @returns A data.frame of available outputs/assets from Pandemic PACT's
#'   Figshare repository.
#'
#' @examples
#' pact_list()
#'
#' @rdname pact_list
#' @export
#'
pact_list <- function() {
  pact_client <- deposits::depositsClient$new(service = "figshare")

  pact_client$deposits_search(group = 53043)
}

#'
#' @rdname pact_list
#' @export
#'

pact_list_data <- function() {
  pact_client <- deposits::depositsClient$new(service = "figshare")

  pact_client$deposits_search(group = 53043) |>
    subset(defined_type == 3)
}
