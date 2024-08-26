#'
#' Initiate a new Pandemic PACT Figshare client session
#'
#' @returns A local client to the Figshare service.
#'
#' @examples
#' pact_client_set()
#'
#' @rdname pact_client
#' @export
#'

pact_client_set <- function() {
  deposits::depositsClient$new(service = "figshare")
}
