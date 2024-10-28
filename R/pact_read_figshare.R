#'
#' Read datasets from the Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param tracker_type Either "labelled" or "raw". Default is "labelled".
#' @param path_to_download Path to downloaded private Figshare collection zip
#'   file.
#' @param filename Filename of Pandemic PACT asset or dataset to read from 
#'   downloaded private Figshare collection zip file.
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

pact_read_figshare <- function(pact_client,
                               tracker_type = c("labelled", "raw")) {
  ## Set to chosen tracker type ----
  tracker_type <- match.arg(tracker_type)

  ## Update client with specific output/asset ----
  if (tracker_type == "labelled") {
    deposit_id <- 24763548
  } else {
    deposit_id <- 24786258
  }

  ## Retrieve output/asset from Figshare and store in local client ----
  pact_client_update <- pact_client$deposit_retrieve(deposit_id = deposit_id)
  data_url <- pact_client_update$hostdata$files$download_url

  ## Read dataset ----
  read.csv(file = data_url)
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
  read.csv(file = data_url)
}

#'
#' @rdname pact_read_figshare
#' @export
#' 

pact_read_figshare_download <- function(path_to_download, filename) {
  ## Create temporary directory to extract file to ----
  temp_dir <- tempdir()

  ## Unzip file from zip download ----
  utils::unzip(zipfile = path_to_download, files = filename, exdir = temp_dir)

  ## Get path to unzipped file ----
  path_to_file <- file.path(temp_dir, filename)

  ## Read file ----
  if (tools::file_ext(filename) == "xlsx") {
    openxlsx2::read_xlsx(file = path_to_file)
  } else {
    read.csv(file = path_to_file)
  }
}

