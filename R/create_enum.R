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



# TODO: Create an enum by just providing the constant names (the values are integers then starting by 1 or any start value)



#' Create an enumeration (an enumeration is a list of constants)
#'
#' This helper function builds an enum type using the provided arguments.
#' 
#' Setting the enum names via the \code{value.names} parameter is mainly useful to load the elements
#' of an enum from a data base or config file (e. g. CSV file) to create an enum type.
#'
#' Since the returned enumeration object is also a \code{\link{list}} you can also use it like a list.
#'
#' @param allowed.values    Vector with all allowed values
#'                          and (optionally) the enum names as names of the vector elements.
#' @param value.names       Vector of character strings containing the names that correspond to the allowed values
#'                          If the names are neither provided in the allowed values nor in the parameter `value.names`
#'                          the enum values are taken as names.
#'                          Duplicated names will be made unique only if the parameter \code{ensure.valid.value.names}
#'                          is set to \code{TRUE}.
#' @param descriptions      Vector with more detailled descriptive information for each enum value
#' @param ensure.valid.value.names TRUE to convert invalid characters into syntacically allowed names
#'                                      and make duplicated names unique (by appending a number).
#'                                 FALSE leaves value names like they are. To use enum names that contain invalid
#'                                       characters you have to quote them, e. g. \code{my.enum$`a special name`}
#'
#' @return                  An object of class "enumeration" that represents an enumeration via a list with named elements
#' @export
#'
#' @examples                
#' # This is the easiest way to create an enumeration if the enum values are not important
#' DRINKS <- create.enum(c("COFFEE", "TEA", "SOFT DRINK"))
#'
#' # This is the most intuitive way of creating an enumeration
#' COLOR.ENUM <- create.enum(c(BLUE = 1L, RED = 2L, BLACK = 3L))
#'
#' COLOR.ENUM <- create.enum(c(1L, 2L, 3L), c("BLUE", "RED", "BLACK"))
#' # returns an enumeration type that internally is constructed similar to this:
#' # COLOR.ENUM <- list(BLUE = 1L, RED = 2L, BLACK = 3L)
#' 
#' 
create.enum <- function(allowed.values,
                        value.names  = if (is.null(names(allowed.values))) allowed.values else names(allowed.values),
                        descriptions = value.names,
                        ensure.valid.value.names = TRUE) {
  
  if (!is.atomic(allowed.values))
    stop(paste("'allowed.values' does not contain an atomic (scalar) vector but is a", mode(allowed.values), "with class =", class(allowed.values)))

  if (!is.atomic(value.names))
    stop(paste("'value.names' does not contain an atomic (scalar) vector but is a", mode(value.names), "with class =", class(value.names)))
  
  if (length(allowed.values) < 1)
    stop("Enums may not be empty. 'allowed.values' must contain at least one element." )
  
  if (length(allowed.values) != length(value.names))
    stop(paste0("'allowed.values' [", length(allowed.values), "] and 'value.names' [", length(value.names), "] must have the same length"))
  
  unique.values <- unique(allowed.values)
  
  if (length(allowed.values) != length(unique.values))
    stop("'allowed.values' must contain unique elements, but duplicates were found.")

  if (length(descriptions) != length(allowed.values))
      stop(paste0("'descriptions' [", length(descriptions), "] and 'allowed.values' [", length(allowed.values), "] must have the same length"))
  
  # TODO More validations like:
  
  # inputList.upper <- toupper(as.character(inputList))
  # uniqueEnums <- unique(inputList.upper)
  # if ( ! identical( inputList.upper, uniqueEnums ))
  #   stop ("Enums must be unique (ignoring case)." )
  # validNames <- make.names(inputList.upper)   # Make syntactically valid names out of character vectors.
  # if ( ! identical( inputList.upper, validNames ))
  #   stop( "Enums must be valid R identifiers." )

  # if (is.null(enumNames)) {
  #   names(myEnum) <- myEnum
  # } else if ("" %in% enumNames) {
  #   stop("The inputList has some but not all names assigned. They must be all assigned or none assigned")
  # }  
  
  
  
  # clean-up the valid names?
  if (ensure.valid.value.names) {
    value.names <- make.names(value.names, unique = TRUE)
  }
  
  
  
  new.enum <- as.list(allowed.values)
  names(new.enum) <- value.names
  
  
  
  attr(new.enum, "descriptions") <- descriptions
  
  
  
  class(new.enum) <- append("enumeration", class(new.enum))
  
  
  
  return(new.enum)
}
