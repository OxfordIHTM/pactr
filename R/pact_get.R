#'
#' Get outputs/assets identifiers
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param id A unique integer value identifying a specific file in the
#'   repository.
#'
#' @returns An integer or character value or vector of values for requested
#'   identifier.
#'
#' @examples
#' \dontrun{
#'   pact_client <- pact_client_set()
#'   pact_get_group_id(pact_client)
#'   pact_get_filename(pact_client, id = 24763548)
#' }
#'
#' @rdname pact_get
#' @export
#'

pact_get_group_id <- function(pact_client) {
  pact_list(pact_client = pact_client) |>
    dplyr::pull(.data$group_id) |>
    unique() |>
    unlist()
}

#'
#' @rdname pact_get
#' @export
#'

pact_get_filename <- function(pact_client, id) {
  pact_client$deposit_retrieve(deposit_id = id) |>
    (\(x) x$hostdata$files$name)()
}
