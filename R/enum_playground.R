# ***************************************************************************
# Copyright (C) 2016 Juergen Altfeld (R@altfeld-im.de)
# ---------------------------------------------------------------------------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ***************************************************************************
#

# This code can be found at:
# https://github.com/aryoda/R_enumerations

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
create.enum.simple <- function(inputList) {
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




#' Create an enumeration
#'
#' @param allowed.values 
#' @param value.names 
#'
#' @return
#' @export
#'
#' @examples
create.enum <- function(allowed.values,
                        value.names = make.names(allowed.values, unique = TRUE)) {

  if (length(allowed.values) < 1)
    stop ("Enums may not be empty. 'allowed.values' must contain at least one element." )
  
  if (length(allowed.values) != length(value.names))
    stop(paste0("'allowed.values' [", length(allowed.values), "] and 'value.names' [", length(value.names), "] must be the same length"))

  unique.values <- unique(allowed.values)
  
  if (length(allowed.values) != length(unique.values))
    stop("'allowed.values' must contain unique elements, but duplicates were found.")
  
  
  
  new.enum <- as.list(allowed.values)
  names(new.enum) <- value.names
  
  
  
  return(new.enum)
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


