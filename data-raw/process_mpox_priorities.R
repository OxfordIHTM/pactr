# Create dataset for Pandemic PACT Mpox ontology ----------------

## Get Mpox priorities ----

mpox_priority <- c(
  rep("Pathogen: natural history, transmission and diagnostics", 3),
  rep("Animal and environmental research and research on diseases vectors", 1),
  rep("Epidemiological studies", 5),
  rep("Clinical characterisation and management", 4),
  rep("Infection prevention and control", 1),
  rep("Therapeutics research, development and implementation", 1),
  rep("Vaccines research, development and implementation", 2),
  rep("Policies for public health, disease control &  community resilience", 3),
  rep("Secondary impacts of disease, response & control measures", 1),
  rep("Health Systems Research", 2)
)

mpox_priority_code <- c(
  rep("01", 3),
  rep("02", 1),
  rep("03", 5),
  rep("04", 4),
  rep("05", 1),
  rep("06", 1),
  rep("07", 2),
  rep("08", 3),
  rep("09", 1),
  rep("10", 2)
)

mpox_subpriority <- c(
  "Development of equitable, accessible, safe & effective diagnostics (including POC)",
  "Research for enhanced understanding of the disease",
  "Viral evolution in different contexts & implications",  
  "Investigation of zoonotic transmission & reservoirs",
  "Epidemiology & transmission dynamics of mpox including sexual transmission.",
  "Disease epidemiology & risk factors  & modes of transmission",
  "Transmission dynamics including via various modes",
  "Transmission dynamics including risk & determinants of acquisition",
  "Ongoing assessment & evaluation of surveillance",
  "Promote improved understanding of the disease (including evidence synthesis)",
  "Spectrum & determinants of mpox clinical presentation, pathogenesis & disease course",
  "Treatment approaches in advanced HIV disease or other immunocompromising conditions.",
  "Optimal care protocols for standard patient care and prevention of complications",
  "Evidence synthesis to support evidence-based decision-making",
  "Development of equitable, accessible, safe & effective therapeutics",
  "Development of equitable, accessible, safe and effective vaccines",
  "Immunisation strategies to optimise use of available vaccines",
  "Risk communication & community engagement e.g.  key populations",
  "Behavioural drivers of risk and protection in different contexts",
  "Evaluation of elimination strategy implementation in different contexts.",
  "Prevention of complications & social sequelae",
  "Optimal provision of clinical care for mpox",
  "Support measures & protection of HCWs/caregivers"
)


mpox_subpriority_code <- paste0(
  mpox_priority_code,
  mpox_priority_code |> 
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
  
pact_mpox_priority <- tibble::tibble(
  mpox_priority_code, mpox_priority, 
  mpox_subpriority_code, mpox_subpriority
)

usethis::use_data(pact_mpox_priority, overwrite = TRUE, compress = "xz")
