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
#' This helper function builds an enum type using the provided arguments. It is mainly useful
#' to load the elements of an enum from a data base or config file (e. g. CSV file) and create an enum type.
#'
#' @param allowed.values    Vector with all allowed values
#' @param value.names       Vector of character containing the names that correspond to the allowed values
#'                          Duplicated names will be made unique.
#'                          Invalid characters are replaced by characters that are allowed in names in R
#'
#' @return                  A list that represents an enumeration via named elements
#' @export
#'
#' @examples                
#' COLOR.ENUM <- create.enum(c(1L, 2L, 3L), c("BLUE", "RED", "BLACK"))
#' # Returns an enumeration type that also could have been constructed manually like this:
#' COLOR.ENUM <- list(BLUE = 1L, RED = 2L, BLACK = 3L)
create.enum <- function(allowed.values,
                        value.names  = make.names(allowed.values, unique = TRUE),
                        descriptions = value.names) {
  
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
  
  # if (length(inputList) < 1)
  #   stop ("Enums may not be empty." )
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
  
  
  
  new.enum <- as.list(allowed.values)
  names(new.enum) <- value.names
  
  
  
  attr(new.enum, "descriptions") <- descriptions
  
  
  return(new.enum)
}
