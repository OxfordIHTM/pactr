#'
#' Download outputs/assets from Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param id A unique integer value identifying a specific file in the
#'   repository.
#' @param path The local directory where file is to be downloaded.
#' @param overwrite Logical. Should existing files be overwritten? If TRUE,
#'   existing files will be overwritten. Default is FALSE.
#' @param quiet Logical. If TRUE (default), download progress is not displayed.
#'
#' @returns The full path of the downloaded file.
#'
#' @examples
#' \dontrun{
#'   ## From Figshare
#'   pact_client <- pact_client_set()
#'   pact_download_figshare(pact_client, id = 25827649, path = tempdir())
#' 
#'   ## From website
#'   pact_download_website(path = tempdir())
#' }
#' 
#'
#' @rdname pact_download
#' @export
#'

pact_download_figshare <- function(pact_client,
                                   id, path,
                                   overwrite = FALSE, 
                                   quiet = TRUE) {
  ## Retrieve specified file ----
  pact_client$deposit_retrieve(deposit_id = id)

  ## Get download URL and filename of specified file ----
  download_url <- pact_client$hostdata$files$download_url
  filename <- pact_client$hostdata$files$name

  ## Check if download file is already present in path
  file_present <- filename %in% list.files(path)

  ## Download file ----
  if (overwrite) {
    download.file(
      url = download_url, destfile = file.path(path, filename), quiet = quiet
    )
  } else {
    if (!file_present) {
      download.file(
        url = download_url, destfile = file.path(path, filename), quiet = quiet
      )
    }
  }

  ## Return path to downloaded file ----
  file.path(path, filename)
}

#'
#' @rdname pact_download
#' @export
#' 

pact_download_figshare_private <- function(path,
                                           overwrite = FALSE, 
                                           quiet = TRUE) {
  ## Private collection ID ----
  collection_id <- 25370686
  private_link_id <- "58527668245cb63f14f5"
  
  ## Filename ----
  filename <- "pandemic_pact_figshare.zip"
  
  ## Build download URL ----
  download_url <- build_figshare_download_url(
    collection_id = collection_id, private_link_id = private_link_id
  )

  ## Check if download file is already present in path
  file_present <- filename %in% list.files(path)

  withr::with_options(
    new = list(timeout = max(300, getOption("timeout"))),
    code = {
      ## Download file ----
      if (overwrite) {
        download.file(
          url = download_url, destfile = file.path(path, filename), 
          quiet = quiet
        )
      } else {
        if (!file_present) {
          download.file(
            url = download_url, destfile = file.path(path, filename), 
            quiet = quiet
          )
        }
      }
    }
  )

  ## Return path to downloaded file ----
  file.path(path, filename)
}

#'
#' @rdname pact_download
#' @export
#' 

pact_download_website <- function(path, overwrite = FALSE, quiet = TRUE) {
  ## Get filename of specified file ----
  download_url <- "https://pandemicpact.org/export/pandemic-pact-grants.csv"
  filename <- basename(download_url)

  ## Check if download file is already present in path
  file_present <- filename %in% list.files(path)

  ## Download file ----
  if (overwrite) {
    download.file(
      url = download_url, destfile = file.path(path, filename), quiet = quiet
    )
  } else {
    if (!file_present) {
      download.file(
        url = download_url, destfile = file.path(path, filename), quiet = quiet
      )
    }
  }

  ## Return path to downloaded file ----
  file.path(path, filename)
}