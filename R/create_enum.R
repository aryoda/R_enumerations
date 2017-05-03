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
