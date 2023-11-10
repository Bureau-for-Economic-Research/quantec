#' Get Quantec Data
#'
#' @description Get timeseries by specifying comma seperated code(s).
#' @param time_series_code time series code to return, `NMS-EC_BUS,NMS-GA_BUS`
#' @param freq frequency to return `M`, `Q` or `A`
#' @param start_year year to start
#' @param end_year year to end
#' @param log_file log file to output to if in parallel
#'
#' @return tibble
#' @export
#'

quantec_get_data <- function(time_series_code, 
                             freq =  c("M", "Q", "A")[1], 
                             start_year = "",
                             end_year = "",
                             log_file){
  
  
  if(!missing(log_file))
    log_appender(appender_file(log_file, max_lines = 1e6))

  apikey <- Sys.getenv("QUANTEC_API")
  
  url <- glue("https://www.easydata.co.za/api/v3/download/")

  query_list <- all_param <- list(
    timeSeriesCodes = time_series_code,
    respFormat = "csv",
    freqs = freq,
    auth_token = apikey,
    startYear = start_year,
    endYear = end_year,
    isTidy = TRUE
  )
  
  all_param['auth_token'] <- NULL
  all_param <- toJSON(all_param)
  
  log_debug(skip_formatter(glue("[{time_series_code}] -- Querying with parameters: [{all_param}]")))

  response <- GET(url, query_list = query_list)

  check_response_error(response)

  out <- content(response) %>% read_csv(show_col_types = FALSE)
  log_debug(glue("[{time_series_code}] -- Found {comma(nrow(out))} rows"))
  
  return(out)
}
