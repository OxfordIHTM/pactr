#'
#' An Interface to the Pandemic PACT Database
#'
#' The Pandemic PACT <https://www.pandemicpact.org/> monitors and analyses
#' global funding and research evidence related to diseases with pandemic
#' potential, as well as broader research preparedness efforts, and is equipped
#' to pivot in response to outbreaks. It collects, curates, codes, and analyses
#' data in alignment with WHO priority diseases and other selected illnesses,
#' including pandemic influenza, mpox, and plague. Pandemic PACT aims to guide
#' policy and decision-making for research funders, policymakers, researchers,
#' multilateral agencies. The database is publicly available for download from
#' its website and from Figshare. This package interfaces with the project's
#' Figshare repository to provide programmatic access to the database along with
#' other data products provided by the project.
#'
#' @docType package
#' @name pactr
#' @keywords internal
#' @importFrom deposits depositsClient
#' @importFrom utils read.csv download.file readCitationFile
#' @importFrom methods is
#' @importFrom tibble tibble
#' @importFrom stringr str_remove str_remove_all str_replace str_replace_all
#'   str_trim str_split
#' @importFrom rlang .data
#' @importFrom dplyr left_join mutate group_by ungroup across select filter
#'   right_join arrange relocate pull
#' @importFrom tidyr pivot_longer unnest
#' @importFrom countrycode countrycode
#'
"_PACKAGE"
