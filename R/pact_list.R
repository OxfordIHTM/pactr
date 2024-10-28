#'
#' List all available outputs/assets from Pandemic PACT's Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param path_to_download Path to downloaded zip file from Pandemic PACT's
#'   Figshare repository
#'
#' @returns A data.frame of available outputs/assets from Pandemic PACT's
#'   Figshare repository.
#'
#' @examples
#' \dontrun{
#'   pact_list(pact_client = pact_client_set())
#' }
#'
#' @rdname pact_list
#' @export
#'
pact_list <- function(pact_client) {
  pact_client$deposits_search(group = 53043)
}

#'
#' @rdname pact_list
#' @export
#'

pact_list_data <- function(pact_client) {
  pact_client$deposits_search(group = 53043) |>
    dplyr::filter(.data$defined_type == 3)
}


#'
#' @rdname pact_list
#' @export
#' 

pact_list_download <- function(path_to_download) {
  if (tools::file_ext(path_to_download) != "zip") {
    stop("`path_to_download` should be a zip file. Try again.")
  }

  utils::unzip(zipfile = path_to_download, list = TRUE) |>
    dplyr::arrange(.data$Name)
}

