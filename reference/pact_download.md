# Download outputs/assets from Pandemic PACT Figshare repository

Download outputs/assets from Pandemic PACT Figshare repository

## Usage

``` r
pact_download_figshare(pact_client, id, path, overwrite = FALSE, quiet = TRUE)

pact_download_website(path, overwrite = FALSE, quiet = TRUE)
```

## Arguments

- pact_client:

  An interface client to the Pandemic PACT Figshare repository. This is
  usually set/created through a call to
  [`pact_client_set()`](https://oxford-ihtm.io/pactr/reference/pact_client.md).

- id:

  A unique integer value identifying a specific file in the repository.

- path:

  The local directory where file is to be downloaded.

- overwrite:

  Logical. Should existing files be overwritten? If TRUE, existing files
  will be overwritten. Default is FALSE.

- quiet:

  Logical. If TRUE (default), download progress is not displayed.

## Value

The full path of the downloaded file.

## Examples

``` r
if (FALSE) { # \dontrun{
  ## From Figshare
  pact_client <- pact_client_set()
  pact_download_figshare(pact_client, id = 25827649, path = tempdir())

  ## From website
  pact_download_website(path = tempdir())
} # }

```
