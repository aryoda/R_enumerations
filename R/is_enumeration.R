

#' Test if an object is an instance of the class \code{enumeration} (created with \code{\link{create.enum}}
#'
#' @param obj    object to be tested
#'
#' @return       TRUE if \code{obj} is an instance of the class \code{enumeration}
#' @export
#'
#' @examples
#' is.enumeration(1.10)
#' is.enumeration(create.enum(1:10))
is.enumeration <- function(obj) {
  
  return("enumeration" %in% class(obj))
    
}
