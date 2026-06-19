#'
#' Read Pandemic PACT tracker dataset from the Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param latest Logical. If `TRUE` (default), the latest version of the
#'   Pandemic PACT dataset is read.
#' @param version A character string specifying the version of the Pandemic PACT
#'   dataset to read. This should be in the format "YYYY-MM-DD". If `latest` is
#'   set to `TRUE`, this argument is ignored. If `version` is specified, it must
#'   match one of the available versions in the Pandemic PACT Figshare repository.
#'   If it does not match, a warning will be issued and the latest version will
#'   be read instead. If `version` is not specified and `latest` is set to
#'   `FALSE`, a warning will be issued and the latest version will be read
#'   instead. 
#'
#' @returns A data.frame of the requested dataset.
#'
#' @examples
#' \dontrun{
#'   pact_client <- pact_client_set()
#'   pact_read_figshare_dictionary(pact_client)
#' }
#'
#' @rdname pact_read_figshare
#' @export
#'

pact_data_read_figshare <- function(pact_client,
                                    latest = TRUE,
                                    version = NULL) {
  ## Get list of available Pandemic PACT tracker datasets ----
  fig_list <- pact_figshare_list(pact_client = pact_client) |>
    pact_data_list_figshare()
  
  if (latest) {
    version <- get_latest_version(fig_list = fig_list)
  } else {
    ## Check version ----
    version <- check_version(
      version = version, data_versions = fig_list$pact_data$release_date
    )
  }

  ## Get download URL for specified version ----
  download_url <- fig_list$pact_data |>
    dplyr::filter(.data$release_date == version) |>
    dplyr::pull(.data$download_url)

  ## Read dataset ----
  utils::read.csv(file = download_url)
}



#'
#' @rdname pact_read_figshare
#' @export
#'

pact_read_figshare_dictionary <- function(pact_client) {
  ## Retrieve output/asset from Figshare and store in local client ----
  pact_client_update <- pact_client$deposit_retrieve(deposit_id = 24773787)
  data_url <- pact_client_update$hostdata$files$download_url

  ## Read data dictionary ----
  utils::read.csv(file = data_url)
}



