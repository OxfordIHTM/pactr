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
  repeat {
    ## Initiate client ----
    pact_client <- try(
      deposits::depositsClient$new(service = "figshare")
    )

    ## Check if successful ----
    if (is(pact_client, "depositsClient")) break

    ## Wait for next attempt if unsuccessful ----
    Sys.sleep(time = 65)
  }

  ## Return client ----
  pact_client
}
