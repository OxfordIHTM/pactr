#'
#' Read datasets from the Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is set through a call to `pact_client_set()`.
#' @param tracker_type Either "labelled" or "raw". Default is "labelled".
#'
#' @returns A data.frame of the requested dataset.
#'
#' @examples
#' pact_read_data_dictionary()
#'
#' @rdname pact_read
#' @export
#'

pact_read_data_tracker <- function(pact_client = pact_client_set(),
                                   tracker_type = c("labelled", "raw")) {
  ## Set to chosen tracker type ----
  tracker_type <- match.arg(tracker_type)

  ## Update client with specific output/asset ----
  if (tracker_type == "labelled") {
    deposit_id <- 24763548
  } else {
    deposit_id <- 24786258
  }

  ## Retrieve output/asset from Figshare and store in locat client ----
  pact_client_update <- pact_client$deposit_retrieve(deposit_id = deposit_id)
  data_url <- pact_client_update$hostdata$files$download_url

  ## Read dataset ----
  read.csv(file = data_url)
}

#'
#' @rdname pact_read
#' @export
#'

pact_read_data_dictionary <- function(pact_client = pact_client_set()) {
  ## Retrieve output/asset from Figshare and store in locat client ----
  pact_client_update <- pact_client$deposit_retrieve(deposit_id = 24773787)
  data_url <- pact_client_update$hostdata$files$download_url

  ## Read data dictionary ----
  read.csv(file = data_url)
}
