#'
#' Download outputs/assets from Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param id A unique integer value identifying a specific file in the
#'   repository.
#' @param .url A URL to the bulk download facility provided by Figshare for the
#'   private Pandemic PACT dataset collection. If provided (not missing), this
#'   will override the default URL for the private dataset collection.
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

  pact_download_url(
    .url = download_url,
    destfile = file.path(path, filename),
    overwrite = overwrite,
    quiet = quiet
  )
}


#'
#' @rdname pact_download
#' @export
#'
 
pact_download_figshare_private <- function(.url, path,
                                           overwrite = FALSE,
                                           quiet = TRUE) {
  download_url <- "https://figshare.com/ndownloader/articles/26937448?private_link=9e712aa1f4255e37b0db"

  if (!missing(.url)) {
    download_url <- .url
  }

  destfile <- file.path(path, "pandemic_pact_figshare.zip")

  ## Nothing there yet -> just download normally ----
  if (!file.exists(destfile)) {
    return(
      pact_download_url(.url = download_url, destfile = destfile, quiet = quiet)
    )
  }

  ## File exists -> download to temp, compare, then decide ----
  tmp <- tempfile(fileext = ".zip")
  on.exit(unlink(tmp), add = TRUE)
  
  pact_download_url(.url = download_url, destfile = tmp, quiet = quiet)

  if (same_file(tmp, destfile)) {
    ## identical content -> keep existing, skip the write
    message(
      "Existing file is identical to the remote file; keeping local copy."
    )
    
    return(destfile)
  }

  if (!overwrite) {
    message(
      "Remote file differs from local file. Set `overwrite = TRUE` to replace."
    )

    return(destfile)
  }

  file.copy(tmp, destfile, overwrite = TRUE)
  destfile
}

#'
#' @rdname pact_download
#' @export
#' 

pact_download_website <- function(path, overwrite = FALSE, quiet = TRUE) {
  ## Get filename of specified file ----
  download_url <- "https://pandemicpact.org/export/grants/pandemic-pact-grants.csv"
  filename <- basename(download_url)

  pact_download_url(
    .url = download_url,
    destfile = file.path(path, filename),
    overwrite = overwrite,
    quiet = quiet
  )
}