#' Creates a data.frame with all elements of an enum
#'
#' The data.frame is useful for debugging purposes, filling list and combo boxes in user interfaces to
#' select one value etc.
#'
#' @param x         An object of class "enumeration" (created with \code{\link{create.enum}})
#' @param row.names Currently not used (but required for a compatible S3 interface)
#' @param optional  Currently not used (but required for a compatible S3 interface)
#' @param ...       Currently not used (but required for a compatible S3 interface)
#'
#' @return       A data.frame with three columns: allowed.values, value.names and descriptions.
#'               The 'descriptions' column is set to the names attribute of the enum if no 'descriptions'
#'               attribute exists. Character strings are never converted to factors (\code{stringsAsFactors = FALSE}).
#' @export
#'
#' @examples
#' DRINKS <- create.enum(c(COFFEE = 1, TEA = 2, SOFT_DRINK = 3),
#'                       descriptions = c("hot", "hotter", "cold"))
#' as.data.frame(DRINKS)
as.data.frame.enumeration <- function(x, row.names = NULL, optional = FALSE, ...) {

  stopifnot(is.enumeration(x))

  # TODO Parameters "row.names" and "optional" are ignored currently!
    
  descriptions <- attr(x, "descriptions", exact = TRUE)
  
  if (is.null(descriptions)) descriptions <- names(x)
  
  result <- data.frame(allowed.values = unlist(x, use.names = FALSE),
                       value.names = names(x),
                       descriptions = descriptions,
                       stringsAsFactors = FALSE)
  
  return(result)
}
