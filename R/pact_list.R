#'
#' List all available outputs/assets from Pandemic PACT's Figshare repositories.
#'
#' @param pact_client An interface client to the Pandemic PACT Figshare
#'   repository. This is usually set/created through a call to
#'   `pact_client_set()`.
#'
#' @returns A `tibble::tibble()` of available outputs/assets from the
#'   Pandemic PACT Figshare repository.
#'
#' @examples
#' \dontrun{
#'   pact_figshare_list(pact_client = pact_client_set())
#' }
#'
#' @rdname pact_figshare_list
#' @export
#'
pact_figshare_list <- function(pact_client) {
  df <- pact_figshare_list_group(pact_client = pact_client)

  lapply(
    X = df$id,
    FUN = function(x) {
      pact_client$deposit_retrieve(deposit_id = x) |>
        (\(x) x$hostdata$files)() |>
        tibble::as_tibble() |>
        dplyr::mutate(deposit_id = x, .before = 1)
    }
  ) |>
    dplyr::bind_rows() |>
    dplyr::left_join(
      y = df |> 
        dplyr::select(
          dplyr::all_of(c("group_id", "project_id", "id", "title"))
        ),
      by = c("deposit_id" = "id")
    )
}


#' @keywords internal

pact_figshare_list_group <- function(pact_client, page = 1L) {
  ## Recursively retrieve all pages of deposits ----
  df <- pact_client$deposits_search(
    page_size = 10L, group = 53043, page = page
  ) |>
    tibble::as_tibble()

  if (nrow(df) == 0) {
    NULL
  } else {
    dplyr::bind_rows(
      df, pact_figshare_list_group(pact_client, page = page + 1L)
    ) |>
      dplyr::mutate(group_id = as.integer(53043), .before = 1)
  }
}
