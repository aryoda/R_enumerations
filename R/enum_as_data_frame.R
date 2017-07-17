# TODO   Implement this as S3 function and append a class attribute to the enum?

#' Creates a data.frame with all elements of an enum
#'
#' The data.frame is useful for debugging purposes, filling list and combo boxes in user interfaces to
#' select one value etc.
#'
#' @param enum   The enumeration (list of constants)
#'
#' @return       A data.frame with three columns: allowed.values, value.names and descriptions.
#'               The 'descriptions' column is set to the names attribute of the enum if no 'descriptions'
#'               attribute exists.
#' @export
#'
#' @examples
enum.as.data.frame <- function(enum) {

  descriptions <- attr(enum, "descriptions", exact = TRUE)
  
  if (is.null(descriptions)) descriptions <- names(enum)
  
  result <- data.frame(allowed.values = unlist(enum, use.names = FALSE),
                       value.names = names(enum),
                       descriptions = descriptions,
                       stringsAsFactors = FALSE)
  
  return(result)
}
