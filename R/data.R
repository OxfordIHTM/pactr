#'
#' World Health Organization (WHO) Country Information
#' 
#' @format A data.frame with 5 columns and 194 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *country_iso3c* | ISO-3 country code |
#' | *who_short_name* | Country short name given by WHO |
#' | *formal_name* | Country formal name |
#' | *who_region* | WHO region name to which country belongs to |
#' | *un_region* | UN region name to which country belongs to |
#'
#' @examples
#' who_country_info
#'
#' @source Data are drawn from WHO's Data Country list found at 
#'   https://data.who.int/countries/
#'
"who_country_info"

#'
#' Pandemic PACT Research Categories
#' 
#' @format A data.frame with 4 columns and 70 rows:
#' 
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *research_category_code* | Two digit research category code |
#' | *research_category* | Research category name |
#' | *research_subcategory_code* | Four digit research sub-category code |
#' | *research_subcategory* | Research sub-category name |
#' 
#' @examples
#' pact_research_category
#' 
#' @source Pandemic PACT website https://www.pandemicpact.org/
#' 
"pact_research_category"
