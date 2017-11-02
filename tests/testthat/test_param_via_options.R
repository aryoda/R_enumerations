# library(testthat)

testthat::context("test_param_via_options.R")


# Initialize ------------------------------------------------------------------------------------------------------

# The variable must be defined in the global environment since testthat does not find the object
# when the test is run via "devtools::test".
# 
ColorEnum <<- list(BLUE = 1L, RED = 2L, BLACK = 3L)

options(test.enum.name = NULL)  # remove existing option

# Takes an color enum value as input and returns the color value
color.code <- function(color = getOption("test.enum.name", ColorEnum)) { 
  
  i <- match.enum.arg(color, ColorEnum)
  
  return(i)
}



# unit tests ------------------------------------------------------------------------------------------------------

test_that("empty option works", {
 
  expect_equal(color.code(ColorEnum$BLUE), 1L) 
  
  expect_equal(color.code(), ColorEnum$BLUE, info = "first enum element must be the default value")
  
  expect_error(color.code(0), "'arg' must be one of the values in the 'choices' list: BLUE = 1, RED = 2, BLACK = 3", fixed = TRUE)

})



test_that("defined option works", {
  
  options(test.enum.name = ColorEnum$BLACK)  # remove existing option
  
  expect_equal(color.code(ColorEnum$BLUE), 1L) 
  
  expect_equal(color.code(), ColorEnum$BLACK, info = "first enum element must be the default value")
  
  expect_error(color.code(0), "'arg' must be one of the values in the 'choices' list: BLUE = 1, RED = 2, BLACK = 3", fixed = TRUE)

})



# Clean-up --------------------------------------------------------------------------------------------------------

options(test.enum.name = NULL)  # remove existing option

