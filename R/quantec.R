#' quantec.R
#' @import logger
#' @import dplyr
#' @import lubridate
#' @import jsonlite
#' @importFrom httr RETRY add_headers http_type http_error content status_code
#' @importFrom snakecase to_sentence_case to_snake_case
#' @importFrom glue glue
#' @importFrom readr read_csv
#' @importFrom scales comma
#'

PKG_VERSION <- utils::packageDescription('quantec')$Version
