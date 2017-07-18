#' Creates a data.frame with all elements of an enum
#'
#' The data.frame is useful for debugging purposes, filling list and combo boxes in user interfaces to
#' select one value etc.
#'
#' @param enum   An object of class "enumeration" (created with \code{\link{create.enum}})
#'
#' @return       A data.frame with three columns: allowed.values, value.names and descriptions.
#'               The 'descriptions' column is set to the names attribute of the enum if no 'descriptions'
#'               attribute exists.
#' @export
#'
#' @examples
as.data.frame.enumeration <- function(enum) {

  stopifnot(is.enumeration(enum))
  
  descriptions <- attr(enum, "descriptions", exact = TRUE)
  
  if (is.null(descriptions)) descriptions <- names(enum)
  
  result <- data.frame(allowed.values = unlist(enum, use.names = FALSE),
                       value.names = names(enum),
                       descriptions = descriptions,
                       stringsAsFactors = FALSE)
  
  return(result)
}
