
# quantec <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![](https://img.shields.io/github/last-commit/Bureau-for-Economic-Research/quantec.svg)](https://github.com/Bureau-for-Economic-Research/quantec/commits/develop)

The [quantec](https://github.com/Bureau-for-Economic-Research/quantec)
library is a *basic* wrapper around the [EasyData data
portal](https://www.easydata.co.za/) API from Quantec maintained by the
[Bureau for Economic Research](https://www.ber.ac.za/home/).

This is the homepage for the {quantec} R package
<https://github.com/Bureau-for-Economic-Research/quantec>.

**NOTE:** The API is currently in *BETA* testing.

💡 Please be a good digital citizen when interacting with an API -
restrict parallel implementation and institute sleeps between calling
data.

## Disclaimer

This package is no way endorsed by
[Quantec](https://www.easydata.co.za/) and was developed at the [Bureau
for Economic Research](https://www.ber.ac.za/home/) in order to
streamline research process.

## About Qauntec

**From the Quantec Website**

Quantec is a consultancy providing economic and financial data, country
intelligence and quantitative analytical software.

Please reach out to [Quantec](https://www.easydata.co.za/) via their
Contact Page <https://www.quantec.co.za/contact/> to receive an API key.

## Installation

Install from GitHub.

``` r
remotes::install_github("Bureau-for-Economic-Research/quantec")
```

## Usage

``` r
library(quantec)
```

Check version.

``` r
packageVersion("quantec")
```

### Set API Key

To access the API you’ll need to first specify an API in your
`.Renviron` key as provided to you by
[Quantec](https://www.easydata.co.za/). (`usethis::edit_r_environ()`)

- `.Renviron`

``` txt
QUANTEC_API=place_your_key_here
```

After setting the API key in `.Renviron`, remember to restart R:
`ctrl + shift + F10`.

- In R

``` r
Sys.setenv(QUANTEC_API="place_your_key_here")
Sys.getenv("QUANTEC_API")
```

# The API interface

The package currently provides an interface to the
[Quantec](https://www.easydata.co.za/) data API. The function
`quantec_get_data` has the following options:

- `time_series_code` time series code to return, `NMS-EC_BUS,NMS-GA_BUS`
- `freq` frequency to return `M`, `Q` or `A`
- `start_year` year to start
- `end_year` year to end
- `respformat` to return `csv` or `json`
- `log_file` log file to output to
- `is_tidy` tidyformat for easy read

``` r
library(quantec)
library(logger)

quantec_get_data(time_series_code = "NMS-EC_BUS", 
                 freq = "A", 
                 start_year = 2000, 
                 end_year = 2022)

# A tibble: 29 × 6                                                                                                                                                                                                    
#    title                                                                    unit                           source code           date       value
#    <chr>                                                                    <chr>                          <chr>  <chr>          <date>     <dbl>
#  1 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1994-12-31    10
#  2 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1995-12-31     7
#  3 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1996-12-31    28
#  4 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1997-12-31    70
#  5 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1998-12-31     7
#  6 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1999-12-31     3
#  7 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2000-12-31     6
#  8 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2001-12-31    25
#  9 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2002-12-31    53
# 10 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2003-12-31    17
# ℹ 19 more rows
# ℹ Use `print(n = ...)` to see more rows
```

If you want to turn on the logging:

``` r
library(quantec)
library(logger)

log_threshold(level = DEBUG)
quantec_get_data(time_series_code = "NMS-EC_BUS", 
                 freq = "A", 
                 start_year = 2000, 
                 end_year = 2022)

# DEBUG [2023-09-20 14:10:46] [NMS-EC_BUS] -- Querying with parameters: # [{"timeSeriesCodes":["NMS-EC_BUS"],"respFormat":["csv"],"freqs":["A"],"startYear":[2000],"endYear":[2022],"isTidy":[true]}]
# DEBUG [2023-09-20 14:10:46] [NMS-EC_BUS] -- Found 29 rows                                                                                                                                                            
# A tibble: 29 × 6
#    title                                                                    unit                           source code           date       value
#    <chr>                                                                    <chr>                          <chr>  <chr>          <date>     <dbl>
#  1 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1994-12-31    10
#  2 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1995-12-31     7
#  3 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1996-12-31    28
#  4 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1997-12-31    70
#  5 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1998-12-31     7
#  6 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 1999-12-31     3
#  7 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2000-12-31     6
#  8 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2001-12-31    25
#  9 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2002-12-31    53
# 10 SACU domestic sales - South Africa - Eastern Cape: Bus sales (> 8,500kg) Number (Sum of Monthly Values) NAAMSA NMS-EC_BUS-SAN 2003-12-31    17
# ℹ 19 more rows
# ℹ Use `print(n = ...)` to see more rows
```
