#'
#' Process author names
#'
#' @param authors A character vector of author names
#' 
#' @returns A concatenated string of author names formatted as per person
#'   specification.
#' 
#' @examples
#' \dontrun{
#'   process_author_names(c("John Doe", "Jane Doe"))
#' }
#' 
#' @keywords internal
#' 

process_author_names <- function(authors) {
  paste0(
    "c(", paste(
      paste0("person(\'", authors, "\')"), collapse = ", "
    ), ")"
  ) |>
    parse(text = _)
}

#
# Nested variables in downloadable dataset from website
#

nested_vars <- c(
  "PubMedGrantId", "StudySubject", "Ethnicity", "AgeGroups", "Rurality",
  "VulnerablePopulations", "OccupationalGroups", "StudyType", "ClinicalTrial",
  "Pathogens", "Diseases", "FundingOrgName", "FunderCountry", "FunderRegion",
  "ResearchInstitutionRegion", "ResearchLocationRegion", "Tags",
  "WHOMpoxResearchPriorities", "WHOMpoxResearchSubPriorities",
  "GlobalMpoxResearchPriorities", "GlobalMpoxResearchSubPriorities",
  "ResearchInstitutionCountry", "ResearchLocationCountry", "ResearchCat",
  "ResearchSubcat"
)

#
# Topic variables in downloadable dataset from website
#

topic_vars <- c(
  "GrantEndYear", "ResearchInstitutionName", "StudySubject", "Ethnicity",
  "AgeGroups", "Rurality", "VulnerablePopulations", "OccupationalGroups",
  "StudyType", "ClinicalTrial", "Pathogens", "Diseases", "FundingOrgName",
  "FunderCountry", "FunderRegion", "ResearchInstitutionRegion",
  "ResearchLocationRegion", "Tags",
  "WHOMpoxResearchPriorities", "WHOMpoxResearchSubPriorities",
  "GlobalMpoxResearchPriorities", "GlobalMpoxResearchSubPriorities",
  "ResearchInstitutionCountry", "ResearchLocationCountry", "ResearchCat",
  "GrantStartYear" 
)

#'
#' Detect one-to-one mismatch in variables
#' 
#' @param x A vector of values from the Pandemic PACT dataset.
#' @param y A vector of values from the Pandemic PACT dataset to match `x`
#'   against. 
#' 
#' @returns A logical vector indicating whether `x` and `y` have matching
#'   values (TRUE) or not (FALSE).
#' 
#' @examples
#' \dontrun{
#'   detect_mismatch(ResearchInstitutionCountry, ResearchInstitutionRegion)
#' } 
#' 
#' @keywords internal
#'

detect_mismatch <- function(x, y) {
  length_a <- stringr::str_split(string = x, pattern = " \\| ") |>
    lapply(FUN = length) |>
    unlist()

  length_b <- stringr::str_split(string = y, pattern = " \\| ") |>
    lapply(FUN = length) |>
    unlist()
    
  length_a > length_b
}

#'
#' Get WHO region
#' 
#' @param x A character value or vector of values of WHO countries to get the 
#'   WHO region/s of.
#' 
#' @returns A character value or vector of values of WHO regions.
#' 
#' @examples
#' \dontrun{
#'   get_who_regions("United Kingdom")
#' }
#' 
#' @rdname get_who_region
#' @keywords internal
#'

get_who_region <- function(x) {
  country_name <- ifelse(
    x == "", NA_character_, stringr::str_split(string = x, pattern = " \\| ")
  ) |>
    unlist()

  country_region <- get_regions(country_name)
}

#'
#' @rdname get_who_region
#' @keywords internal
#' 

get_who_regions <- function(x) {
  lapply(
    X = x,
    FUN = get_who_region
  ) |>
    unlist()
}

#'
#' @rdname get_who_region
#' @keywords internal
#'

get_region <- function(x) {
  if (is.na(x)) {
    NA_character_
  } else {
    region_reference <- add_countries()

    ccode <- countrycode::countrycode(
      sourcevar = x, origin = "country.name", 
      destination = "iso3c", warn = FALSE
    )

    ccode[x == "Saint Martin (French part)"] <- "MAF"
    ccode[x == "International"]              <- "INT"
    ccode[x == "Europe"]                     <- "EUR"

    which(region_reference$country_iso3c == ccode) |>
      (\(x) region_reference$who_region[x])()
  }
}

#'
#' @rdname get_who_region
#' @keywords internal
#'
get_regions <- function(x) {
  if (all(is.na(x))) {
    NA_character_
  } else {
    lapply(X = x, FUN = get_region) |>
      paste(collapse = " | ")
  }
}

#'
#' @rdname get_who_region
#' @keywords internal
#'

add_countries <- function() {
  df <- data.frame(
    country_iso3c = c("PRI", "HKG", "PSE", "MAF", "EUR", "INT"),
    who_short_name = c(
      "Puerto Rico", "Hong Kong", "Palestine", "Saint Martin (French part)",
      "Europe", "International"
    ),
    formal_name = c(
      "Puerto Rico", "Hong Kong", "Palestine", "Saint Martin (French part)",
      "Europe", "International"
    ),
    who_region = c(
      "Americas", "Western Pacific", "Eastern Mediterranean", "Europe", 
      "Europe", "International"
    ),
    un_region = NA_character_    
  )

  rbind(pactr::who_country_info, df) |>
    tibble::tibble()
}

#'
#' Get Pandemic PACT research category
#'
#' @param pact_data A data.frame for the Pandemic PACT dataset read from the
#'   Pandemic PACT website. This is usually obtained via a call to 
#'   `pact_read_website()`. 
#' 
#' @returns A data.frame of same structure as `pact_data` but with `ResearchCat`
#'   and `ResearchSubcat` variables processed/cleaned.
#' 
#' @examples
#' \dontrun{
#'   get_research_category(pact_data)
#' }
#' 
#' @rdname get_research_category
#' @keywords internal
#'

get_research_category <- function(pact_data) {
  ## Create CatSubcat in reference table ----
  category_reference <- pactr::pact_research_category |>
    dplyr::mutate(
      CatSubcat = paste(
        .data$research_category, .data$research_subcategory, sep = " - "
      )
    )

  ## Recode categories and subcategories with "" values ----
  catsubcat <- pact_data |>
    dplyr::mutate(
      ResearchCat = ifelse(
        .data$ResearchCat == "", "No category", .data$ResearchCat
      ),
      ResearchSubcat = ifelse(
        .data$ResearchSubcat == "", "No subcategory", .data$ResearchSubcat
      )
    ) |>
    dplyr::mutate(
      ResearchCat = stringr::str_split(
        string = .data$ResearchCat, pattern = " \\| "
      ),
      ResearchSubcat = stringr::str_split(
        string = .data$ResearchSubcat, pattern = " \\| "
      )
    ) |>
    dplyr::group_by(.data$GrantID) |>
    tidyr::unnest("ResearchSubcat") |>
    tidyr::unnest("ResearchCat") |>
    dplyr::mutate(
      CatSubcat = paste(
        .data$ResearchCat, .data$ResearchSubcat, sep = " - "
      )
    ) |>
    # dplyr::filter(
    #   .data$CatSubcat %in% category_reference$CatSubcat |
    #     stringr::str_detect(
    #       string = .data$CatSubcat, pattern = "No category|No subcategory"
    #     )
    # ) |>
    dplyr::summarise(
      CatSubcat = unique(.data$CatSubcat) |> paste(collapse = " | "),
      .groups = "drop"
    )

  pact_data <- within(pact_data, {
    ResearchCat = catsubcat$CatSubcat |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!!seq_along(x) %% 2] |>
            paste(collapse = " | ") |>
            (\(x) ifelse(x == "NA", NA_character_, x))()
        }
      ) |>
      unlist()
    ResearchSubcat = catsubcat$CatSubcat |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!seq_along(x) %% 2] |>
            paste(collapse = " | ") |>
            (\(x) ifelse(x == "NA", NA_character_, x))()
        }
      ) |>
      unlist()
  }) |>
    dplyr::mutate(
      ResearchCat = ifelse(
        .data$ResearchCat == "No category" | .data$ResearchCat == "NA", 
        NA_character_,
        .data$ResearchCat
      ),
      ResearchSubcat = ifelse(
        .data$ResearchSubcat == "No subcategory" | .data$ResearchSubcat == "NA", 
        NA_character_,
        .data$ResearchSubcat
      )
    )

  ## Return pact_data ----
  pact_data
}  
  

#'
#' Get Pandemic PACT Mpox priority - Global and WHO Research Priority
#'
#' @param pact_data A data.frame for the Pandemic PACT dataset read from the
#'   Pandemic PACT website. This is usually obtained via a call to 
#'   `pact_read_website()`. 
#' 
#' @returns A data.frame of same structure as `pact_data` but with
#'   `WHOMpoxResearchPriorities` and `WHOMpoxResearchSubPriorities` variables or
#'   `GlobalMpoxResearchPriorities` and `GlobalMpoxResearchSubPriorities`
#'   variables processed/cleaned.
#' 
#' @examples
#' \dontrun{
#'   get_mpox_priority_who(pact_data)
#'   get_mpox_priority_global(pact_data)
#' }
#' 
#' @rdname get_mpox_priority
#' @keywords internal
#'

get_mpox_priority_who <- function(pact_data) {
  ## Create priority reference based on details in reference table ----
  priority_reference <- pactr::pact_mpox_priority |>
    dplyr::mutate(
      PriorSubprior = paste(
        .data$mpox_priority, .data$mpox_subpriority, sep = " - "
      )
    )

  ## Recode priorities and subpriorities with "" values ----
  priorsubprior <- pact_data |>
    dplyr::mutate(
      WHOMpoxResearchPriorities = ifelse(
        .data$WHOMpoxResearchPriorities == "", 
        "No priority", .data$WHOMpoxResearchPriorities
      ),
      WHOMpoxResearchSubPriorities = ifelse(
        .data$WHOMpoxResearchSubPriorities == "", 
        "No subpriority", .data$WHOMpoxResearchSubPriorities
      )
    ) |>
    dplyr::mutate(
      WHOMpoxResearchPriorities = stringr::str_split(
        string = .data$WHOMpoxResearchPriorities, pattern = " \\| "
      ),
      WHOMpoxResearchSubPriorities = stringr::str_split(
        string = .data$WHOMpoxResearchSubPriorities, pattern = " \\| "
      )
    ) |>
    tidyr::unnest("WHOMpoxResearchSubPriorities") |>
    tidyr::unnest("WHOMpoxResearchPriorities") |>
    dplyr::mutate(
      PriorSubprior = paste(
        .data$WHOMpoxResearchPriorities, .data$WHOMpoxResearchSubPriorities, 
        sep = " - "
      )
    ) |>
    # dplyr::filter(
    #   .data$PriorSubprior %in% priority_reference$PriorSubprior |
    #     stringr::str_detect(
    #       string = .data$PriorSubprior, pattern = "No priority|No subpriority"
    #     )
    # ) |>
    dplyr::group_by(.data$GrantID) |>
    dplyr::summarise(
      PriorSubprior = unique(.data$PriorSubprior) |> paste(collapse = " | "),
      .groups = "drop"
    )

  pact_data <- within(pact_data, {
    WHOMpoxResearchPriorities = priorsubprior$PriorSubprior |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!!seq_along(x) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
    WHOMpoxResearchSubPriorities = priorsubprior$PriorSubprior |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!seq_along(x) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
  }) |>
    dplyr::mutate(
      WHOMpoxResearchPriorities = ifelse(
        .data$WHOMpoxResearchPriorities == "No priority", NA_character_,
        .data$WHOMpoxResearchPriorities
      ),
      WHOMpoxResearchSubPriorities = ifelse(
        .data$WHOMpoxResearchSubPriorities == "No subpriority", NA_character_,
        .data$WHOMpoxResearchSubPriorities
      )
    )

  ## Return pact_data ----
  pact_data
}

#' 
#' @rdname get_mpox_priority
#' @keywords internal
#'

get_mpox_priority_global <- function(pact_data) {
  ## Create priority reference based on details in reference table ----
  priority_reference <- pactr::pact_mpox_priority |>
    dplyr::mutate(
      PriorSubprior = paste(
        .data$mpox_priority, .data$mpox_subpriority, sep = " - "
      )
    )

  ## Recode priorities and subpriorities with "" values ----
  priorsubprior <- pact_data |>
    dplyr::mutate(
      GlobalMpoxResearchPriorities = ifelse(
        .data$GlobalMpoxResearchPriorities == "", 
        "No priority", .data$GlobalMpoxResearchPriorities
      ),
      GlobalMpoxResearchSubPriorities = ifelse(
        .data$GlobalMpoxResearchSubPriorities == "", 
        "No subpriority", .data$GlobalMpoxResearchSubPriorities
      )
    ) |>
    dplyr::mutate(
      GlobalMpoxResearchPriorities = stringr::str_split(
        string = .data$GlobalMpoxResearchPriorities, pattern = " \\| "
      ),
      GlobalMpoxResearchSubPriorities = stringr::str_split(
        string = .data$GlobalMpoxResearchSubPriorities, pattern = " \\| "
      )
    ) |>
    tidyr::unnest("GlobalMpoxResearchSubPriorities") |>
    tidyr::unnest("GlobalMpoxResearchPriorities") |>
    dplyr::mutate(
      PriorSubprior = paste(
        .data$GlobalMpoxResearchPriorities, .data$GlobalMpoxResearchSubPriorities, 
        sep = " - "
      )
    ) |>
    # dplyr::filter(
    #   .data$PriorSubprior %in% priority_reference$PriorSubprior |
    #     stringr::str_detect(
    #       string = .data$PriorSubprior, pattern = "No priority|No subpriority"
    #     )
    # ) |>
    dplyr::group_by(.data$GrantID) |>
    dplyr::summarise(
      PriorSubprior = unique(.data$PriorSubprior) |> paste(collapse = " | "),
      .groups = "drop"
    )

  pact_data <- within(pact_data, {
    GlobalMpoxResearchPriorities = priorsubprior$PriorSubprior |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!!seq_along(x) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
    GlobalMpoxResearchSubPriorities = priorsubprior$PriorSubprior |>
      stringr::str_split(pattern = " - | \\| ") |>
      lapply(
        FUN = function(x) {
          x[!seq_along(x) %% 2] |>
            paste(collapse = " | ")
        }
      ) |>
      unlist()
  }) |>
    dplyr::mutate(
      GlobalMpoxResearchPriorities = ifelse(
        .data$GlobalMpoxResearchPriorities == "No priority", NA_character_,
        .data$GlobalMpoxResearchPriorities
      ),
      GlobalMpoxResearchSubPriorities = ifelse(
        .data$GlobalMpoxResearchSubPriorities == "No subpriority", NA_character_,
        .data$GlobalMpoxResearchSubPriorities
      )
    )

  ## Return pact_data ----
  pact_data
}



#'
#' Build Figshare download URL for a collection
#' 
#' @param collection_id An integer for the collection identifier.
#' @param private_link_id An identifier value for the private link to the
#'   collection.
#' 
#' @returns A download URL for the specified private Figshare collection.
#' 
#' @examples
#' \dontrun{
#'   build_figshare_download_url(
#'     collection_id = 25370686, 
#'     private_link_id = "58527668245cb63f14f5"
#'   )
#' }
#' 
#' @keywords internal
#' 

build_figshare_download_url <- function(collection_id, private_link_id) {
  file.path(
    "https://figshare.com/ndownloader/articles",
    collection_id
  ) |>
    paste(private_link_id, sep = "?private_link=")
}



#' @keywords internal

pact_download_url <- function(.url, 
                              destfile,
                              overwrite = FALSE,
                              quiet = TRUE,
                              timeout = 300,
                              connecttimeout = 30) {
  ## Skip if file already present and not overwriting ----
  if (file.exists(destfile) && !overwrite) {
    return(destfile)
  }

  ## Build request ----
  req <- httr2::request(.url) |>
    httr2::req_timeout(seconds = timeout) |>
    httr2::req_options(connecttimeout = connecttimeout) |>
    httr2::req_retry(max_tries = 3)

  ## Add a progress bar unless quiet ----
  if (!quiet) {
    req <- httr2::req_progress(req, type = "down")
  }

  ## Stream response body to disk ----
  httr2::req_perform(req, path = destfile)

  destfile
}

#' @keywords internal

same_file <- function(path_a, path_b) {
  if (!file.exists(path_a) || !file.exists(path_b)) return(FALSE)
  ## cheap size pre-check before hashing
  if (file.info(path_a)$size != file.info(path_b)$size) return(FALSE)
  unname(tools::md5sum(path_a) == tools::md5sum(path_b))
}
