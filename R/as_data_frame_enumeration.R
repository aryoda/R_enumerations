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

#' Creates a data.frame with all elements of an enum
#'
#' The data.frame is useful for debugging purposes, filling list and combo boxes in user interfaces to
#' select one value etc.
#'
#' @inheritParams base::as.data.frame
#' @param x         An object of class "enumeration" (created with \code{\link{create.enum}})
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

  # print(paste("Called from:", sys.calls()))
  
  stopifnot(is.enumeration(x))

  # TODO Parameter "optional" is ignored currently!
    
  descriptions <- attr(x, "descriptions", exact = TRUE)
  
  if (is.null(descriptions)) descriptions <- names(x)
  
  if (is.null(row.names))
    row.names <- 1L:length(x)
  
  # Important: To avoid an endless recursion the class must be removed from x
  #            before creating the data.frame.
  #            "unlist", "unclass" and "as.vector" are possible candidates for that.
  # Sympthoms were: # Error: C stack usage  7969328 is too close to the limit
  # Diagnosed with: Logging the as.data.frame.enumeration calls with sys.calls()
  # Code to reproduce:
  #   library(enumerations)
  #   x <- c(hello = 1, new = 2, world = 3)
  #   class(x) <- append("enumeration", class(x))
  #   result <- data.frame(col1 = x)
  #   # Error: C stack usage  7969328 is too close to the limit
  
  result <- data.frame(allowed.values = as.vector(unlist(x, use.names = FALSE)),
                       value.names = names(x),
                       descriptions = descriptions,
                       row.names = row.names,
                       stringsAsFactors = FALSE)
  
  return(result)
}
