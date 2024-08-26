#'
#' Initiate a new Pandemic PACT Figshare client session
#'
#' @returns description
#'

pact_client_set <- function() {
  deposits::depositsClient$new(service = "figshare")
}
