# Build Figshare download URL for a collection

Build Figshare download URL for a collection

## Usage

``` r
build_figshare_download_url(collection_id, private_link_id)
```

## Arguments

- collection_id:

  An integer for the collection identifier.

- private_link_id:

  An identifier value for the private link to the collection.

## Value

A download URL for the specified private Figshare collection.

## Examples

``` r
if (FALSE) { # \dontrun{
  build_figshare_download_url(
    collection_id = 25370686, 
    private_link_id = "58527668245cb63f14f5"
  )
} # }
```
