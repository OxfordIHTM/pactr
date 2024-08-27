#'
#' Cite an output/asset available from the Pandemic PACT Figshare repository
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#' @param id A unique integer value identifying a specific file in the
#'   repository.
#'
#' @returns A string for recommended bibliographic citation for specific
#'   Pandemic PACT output/asset in DateCite bibliographic style.
#'
#' @examples
#' \dontrun{
#'   pact_client <- pact_client_set()
#'   pact_cite(pact_client, id = 24763548)
#' }
#'
#' @rdname pact_cite
#' @export
#'

pact_cite <- function(pact_client,
                      id) {
  info <- pact_client$deposit_retrieve(deposit_id = id) |>
    (\(x) x$hostdata)()

  path <- file.path(tempdir(), "CITATION")

  writeLines(
    text = paste0(
      'bibentry(
        bibtype  = "Misc",
        header   = "To cite ', info$title, ' in publications use:",
        title    = "',
        info$title, '. ', info$defined_type_name, ' version ', info$version, '",
        author   = ',
        process_author_names(info$authors$full_name), ',
        year     = "',
        strptime(info$published_date, format = "%Y") |> format(format = "%Y"), '",
        doi      = "', info$doi, '"
      )'
    ),
    con = path
  )

  readCitationFile(path)
}
