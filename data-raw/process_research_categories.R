# Create dataset for Pandemic PACT research categories ontology ----------------

## Get research categories ----

research_category <- c(
  rep("Pathogen: natural history, transmission and diagnostics", 6),
  rep("Animal and environmental research and research on diseases vectors", 3),
  rep("Epidemiological studies", 4),
  rep("Clinical characterisation and management", 5),
  rep("Infection prevention and control", 4),
  rep("Therapeutics research, development and implementation", 11),
  rep("Vaccines research, development and implementation", 12),
  rep("Research to inform ethical issues", 6),
  rep("Policies for public health, disease control & community resilience", 5),
  rep("Secondary impacts of disease, response & control measures", 4),
  rep("Health Systems Research", 6),
  rep("Research on Capacity Strengthening", 4)
)

research_category_code <- c(
  rep("01",  6),
  rep("02",  3),
  rep("03",  4),
  rep("04",  5),
  rep("05",  4),
  rep("06", 11),
  rep("07", 12),
  rep("08",  6),
  rep("09",  5),
  rep("10",  4),
  rep("11",  6),
  rep("12",  4)
)

research_subcategory <- c(
  "Diagnostics",
  "Pathogen morphology, shedding & natural history",
  "Pathogen genomics, mutations and adaptations",
  "Immunity",
  "Disease models",
  "Environmental stability of pathogen",
  "Animal source and routes of transmission",
  "Vector biology",
  "Vector control strategies",
  "Disease transmission dynamics",
  "Disease susceptibility",
  "Impact/ effectiveness of control measures",
  "Disease surveillance & mapping",
  "Prognostic factors for disease severity",
  "Disease pathogenesis",
  "Supportive care, processes of care and management",
  "Post acute and long term health consequences",
  "Clinical trials for disease management",
  "Restriction measures to prevent secondary transmission in communities",
  "Barriers, PPE, environmental, animal and vector control measures",
  "IPC in health care settings",
  "IPC at the human-animal interface",
  "Pre-clinical studies",
  "Phase 0 clinical trial",
  "Phase 1 clinical trial",
  "Phase 2 clinical trial",
  "Phase 3 clinical trial",
  "Phase 4 clinical trial",
  "Prophylactic use of treatments",
  "Clinical trial (unspecified trial phase)",
  "Therapeutics logistics and supply chains and distribution strategies",
  "Therapeutic trial design",
  "Adverse events associated with therapeutic administration",
  "Pre-clinical studies",
  "Phase 0 clinical trial",
  "Phase 1 clinical trial",
  "Phase 2 clinical trial",
  "Phase 3 clinical trial",
  "Phase 4 clinical trial",
  "Clinical trial (unspecified trial phase)",
  "Vaccine logistics and supply chains and distribution strategies",
  "Vaccine design and administration",
  "Vaccine trial design and infrastructure",
  "Adverse events associated with immunization",
  "Characterisation of vaccine-induced immunity",  
  "Research to inform ethical issues in Research",
  "Research to inform ethical issues related to Public Health Measures",
  "Research to inform ethical issues in Clinical and Health System Decision-Making",
  "Research to inform ethical issues in the Allocation of Resources",
  "Research to inform ethical issues in Governance",
  "Research to inform ethical issues related to Social Determinants of Health, Trust, and Inequities",
  "Approaches to public health interventions",
  "Community engagement",
  "Communication",
  "Vaccine/Therapeutic/ treatment hesitancy",
  "Policy research and interventions", 
  "Indirect health impacts",
  "Social impacts",
  "Economic impacts",
  "Other secondary impacts",  
  "Health service delivery",
  "Health financing",
  "Medicines, vaccines & other technologies",
  "Health information systems",
  "Health leadership and governance",
  "Health workforce",
  "Individual level capacity strengthening",
  "Institutional level capacity strengthening",
  "Systemic/environmental components of capacity strengthening",
  "Cross-cutting"
)

research_subcategory_code <- paste0(
  research_category_code,
  research_category_code |> 
    table() |> 
    data.frame() |>
    dplyr::pull(Freq) |>
    lapply(
      FUN = function(x) {
        seq_len(x) |>
          stringr::str_pad(width = 2, side = "left", pad = "0")
      }
    ) |>
    unlist()
)
  
pact_research_category <- tibble::tibble(
  research_category_code, research_category, 
  research_subcategory_code, research_subcategory
)

usethis::use_data(pact_research_category, overwrite = TRUE, compress = "xz")
