% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pact_process_website.R
\name{pact_process_website}
\alias{pact_process_website}
\title{Process Pandemic PACT dataset retrieved from the website}
\usage{
pact_process_website(pact_data, col_list = TRUE, fix = TRUE)
}
\arguments{
\item{pact_data}{A data.frame for the Pandemic PACT dataset read from the
Pandemic PACT website. This is usually obtained via a call to
\code{pact_read_website()}.}

\item{col_list}{Logical. Should variable/fields with multiple values be
made into column lists? Default to TRUE.}

\item{fix}{Logical. Should fixes be applied to the dataset based on known
issues? Default to TRUE.}
}
\value{
A tibble of the dataset from the website structured based on
\code{col_list} and `fix`` specifications.
}
\description{
Process Pandemic PACT dataset retrieved from the website
}
\examples{
\dontrun{
  pact_data <- pact_read_website()
  pact_process_website(pact_data)
}

}
