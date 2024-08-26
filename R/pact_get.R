#'
#' Get outputs/assets identifiers
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is set through a call to `pact_client_set()`.
#' @param id A unique integer value identifying a specific file in the
#'   repository.
#'
#' @returns An integer or character value or vector of values for requested
#'   identifier.
#'
#' @examples
#' pact_get_group_id()
#' file_id <- pact_list() |> (\(x) x$id[1])()
#' pact_get_filename(id = file_id)
#'
#' @rdname pact_get
#' @export
#'

pact_get_group_id <- function(pact_client = pact_client_set()) {
  pact_list(pact_client = pact_client) |>
    subset(select = group_id) |>
    unique() |>
    unlist()
}

#'
#' @rdname pact_get
#' @export
#'

pact_get_filename <- function(pact_client = pact_client_set(), id) {
  pact_client$deposit_retrieve(deposit_id = id) |>
    (\(x) x$hostdata$files$name)()
}
