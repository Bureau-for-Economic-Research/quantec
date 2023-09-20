#' Check API response for errors
#'
#' @param response A response object.
#'
#' @return NULL. Raises an error if response has an error code.
check_response_error <- function(response) {
  if (http_error(response)) {
    status <- status_code(response)
    error <- glue("API request failed [{status}]")

    message <- content(response)$message
    if (!is.null(message)) {
      error <- glue("{error}: {message}")
    }

    stop(error, call. = FALSE)
  }
}
#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
GET <- function(url = NULL, config = list(), retry = 5, query_list, ...) {
  headers = list()
  response <- httr::RETRY(
    "GET",
    url,
    config,
    ...,
    query = query_list,
    do.call(add_headers, headers),
    handle = NULL,
    times = retry,
    terminate_on = c(400, 404, 429, 500)
  )

  # Check for "400 UNAUTHORISED".
  # Check for "429 LIMIT EXCEEDED".
  if (response$status_code %in% c(400, 429)) {
    out <- response %>%
      content(as = "text", encoding = "UTF-8") %>%
      fromJSON() %>%
      toJSON(pretty = TRUE)

    stop(out, call. = FALSE)
  }

  response
}
