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
