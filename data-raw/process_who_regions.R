# Processs WHO regions ---------------------------------------------------------

## Create rvest session with WHO countries page ----
#session <- rvest::session("https://www.who.int/countries")
session <- rvest::session("https://data.who.int/countries")

## Read in list of URLs for countries ----
who_country_urls <- rvest::read_html(session) |>
  rvest::html_elements(".alphabetical-list li a") |>
  rvest::html_attr(name = "href")

## Extract country information ----
who_country_info <- lapply(
  X = who_country_urls,
  FUN = function(x) {
    session <- rvest::session(x)
    rvest::read_html(session) |>
      rvest::html_table() |>
      (\(x) x[2:3])() |>
      dplyr::bind_rows() |>
      dplyr::filter(
        X1 %in% c("WHO region", "WHO short name", "Formal name", "UN region", "ISO alpha 3 code")
      ) |>
        tidyr::pivot_wider(names_from = X1, values_from = X2)
  }
) |>
  dplyr::bind_rows() |> 
  dplyr::rename_with(
    .fn = ~c("country_iso3c", "who_short_name", "formal_name", "who_region", "un_region")
  )

## Store who_country_info as internal data ----
usethis::use_data(who_country_info, overwrite = TRUE, compress = "xz")
