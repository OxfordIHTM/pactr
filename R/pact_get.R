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
#'   identifier or information.
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

pact_get_group_id <- function(pact_client, id) {
  pact_figshare_list(pact_client = pact_client) |>
    (\(x) x[x$id == id, ]$group_id)()
}

#'
#' @rdname pact_get
#' @export
#'

pact_get_filename <- function(pact_client, id) {
  pact_figshare_list(pact_client = pact_client) |>
    (\(x) x[x$id == id, ]$name)()
}


#'
#' @rdname pact_get
#' @export
#' 

pact_get_url <- function(pact_client, id) {
  pact_figshare_list(pact_client = pact_client) |>
    (\(x) x[x$id == id, ]$download_url)()
}

