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



#' Match the passed enum value against the list of allowed enum values
#' 
#' Call this function at the beginning of your own function that uses an enum parameter
#' to validate the passed enum value against the list of allowed enum values.
#' 
#' You can pass an enum value name or the value itself.
#' 
#' If no enum value is passed (missing parameter value) the first item of the enum is used as default value.
#' 
#' Based on the R code of the base function \code{\link{match.arg}}.
#' 
#' Inspired by \url{https://stackoverflow.com/questions/33838392/enum-like-arguments-in-r}
#'
#' @param arg     The actual function parameter that shall be validated against the allowed enum values
#' @param choices The list of allowed enum values
#'
#' @return        Returns the passed actual parameter if is a valid enum value.
#'                If no actual parameter was passed it returns the first element of the enum.
#' @export
#'
#' @examples
#' ColorEnum <- list(BLUE = 1L, RED = 2L, BLACK = 3L)
#' 
#' print_color_code = function(enum = ColorEnum) { 
#'   i <- match.enum.arg(enum)
#'   print(i)
#'   invisible(i)
#' }
#' 
#' print_color_code(ColorEnum$RED) # use a value from the enum (with auto completion support)
#' # [1] 2
#' print_color_code()              # takes the first color of the ColorEnum
#' # [1] 1
#' print_color_code(3)             # an integer enum value (dirty, just for demonstration)
#' # [1] 3
#' print_color_code(4)             # an invalid number
#' # Error in match.enum.arg(enum) : 
#' #  'arg' must be one of the values in the 'choices' list: 1, 2, 3
#' 
#' 
#' 
#' PAYMENT_FREQUENCY <- create.enum(c(12, 4, 1), c("MONTHLY", "QUARTERLY", "ANNUALY"))
#' 
#' payment.amount <- function(annual.amount, payment.frequency = PAYMENT_FREQUENCY) {
#'   payments.per.year <- match.enum.arg(payment.frequency)
#'   return(annual.amount / payments.per.year)
#' }
#' 
#' payment.amount(120, PAYMENT_FREQUENCY$MONTHLY)
#' # [1] 10
#' payment.amount(120, PAYMENT_FREQUENCY$QUARTERLY)
#' # [1] 30
#' payment.amount(120, 2)
#' # Error in match.enum.arg(payment.frequency) : 
#' #  'arg' must be one of the values in the 'choices' list: 12, 4, 1 
#' 
#' payment.amount(120)   # uses the first value as default value!
#' [1] 10
#' 
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
  
  # TODO Support other items than the only the first one as default value (e. g. add a new parameter)
  # DISADVANTAGE: The default value cannot be recognized in the function signature but only in the documentation!
  if(identical(arg, choices))
    arg <- choices[[1]]    # choose the first value of the first list item as default value
  
  # allowed.values <- sapply(choices, function(item) {item[1]})   # extract the integer values of the enum items
  
  # TODO Show enum values together with the enum labels!
  if(!is.element(arg, choices))
    stop(paste("'arg' must be one of the values in the 'choices' list:", paste(choices, collapse = ", ")))
  
  return(arg)
}

