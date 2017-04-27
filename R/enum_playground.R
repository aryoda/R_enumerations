# Inspired by:
# https://stackoverflow.com/questions/33838392/enum-like-arguments-in-r




#' Make enums with assigned values or use the name as the value if no value is specified
#'
#' Defines the enum by constructing a list like list(a = "a", b = "b", ...)
#'
#' @param inputList 
#'
#' @return
#' @export
#'
#' @examples
create.enum <- function(inputList) {
  # TODO check values
  # if (length(inputList) < 1)
  #   stop ("Enums may not be empty." )
  # inputList.upper <- toupper(as.character(inputList))
  # uniqueEnums <- unique(inputList.upper)
  # if ( ! identical( inputList.upper, uniqueEnums ))
  #   stop ("Enums must be unique (ignoring case)." )
  # validNames <- make.names(inputList.upper)   # Make syntactically valid names out of character vectors.
  # if ( ! identical( inputList.upper, validNames ))
  #   stop( "Enums must be valid R identifiers." )
  
  
  myEnum <- as.list(inputList)
  enumNames <- names(myEnum)
  if (is.null(enumNames)) {
    names(myEnum) <- myEnum
  } else if ("" %in% enumNames) {
    stop("The inputList has some but not all names assigned. They must be all assigned or none assigned")
  }
  return(myEnum)
}






#' Match the passed enum value against the list of allowed enum values
#' 
#' Based on the R code of the base function "match.arg"...
#'
#' @param arg 
#' @param choices 
#'
#' @return
#' @export
#'
#' @examples
match.enum.arg <- function(arg, choices) {
  
  # Get the formal arguments of "arg" if no choices were passed in
  if (missing(choices)) {
    formal.args <- formals(sys.function(sys.parent()))
    # print(paste("formal.args = ", formal.args))
    # print(sys.calls())
    choices <- eval(formal.args[[as.character(substitute(arg))]])
    # print(paste("choices:", choices))
    # print(paste("arg:", arg))
  }
  
  if(identical(arg, choices))
    arg <- choices[[1]]    # choose the first value of the first list item
  
  # allowed.values <- sapply(choices, function(item) {item[1]})   # extract the integer values of the enum items
  
  if(!is.element(arg, choices))
    stop(paste("'arg' must be one of the values in the 'choices' list:", paste(choices, collapse = ", ")))
  
  return(arg)
}


