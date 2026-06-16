# Read datasets from the Pandemic PACT Figshare repository

Read datasets from the Pandemic PACT Figshare repository

## Usage

``` r
pact_read_figshare(pact_client, tracker_type = c("labelled", "raw"))

pact_read_figshare_dictionary(pact_client)

pact_read_figshare_download(path_to_download, filename)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

- tracker_type:

  Either "labelled" or "raw". Default is "labelled".

- path_to_download:

  Path to downloaded private Figshare collection zip file.

- filename:

  Filename of Pandemic PACT asset or dataset to read from downloaded
  private Figshare collection zip file.

## Value

A data.frame of the requested dataset.

## Examples

``` r
if (FALSE) { # \dontrun{
  pact_client <- pact_client_set()
  pact_read_figshare_dictionary(pact_client)
} # }
```
