# Basic test of enumerations



# Initialize ------------------------------------------------------------------------------------------------------

# The variable must be defined in the global environment since testthat does not find the object
# when the test is run via "devtools::test".
# 
ColorEnum <<- list(BLUE = 1L, RED = 2L, BLACK = 3L)

# Expects an color enum value as input and returns the color value
color.code <- function(color = ColorEnum) { 
  i <- match.enum.arg(color) # , ColorEnum)
  # i <- match.arg(color)
  i <- color
  return(i)
}




# Tests -----------------------------------------------------------------------------------------------------------

test_that("Enum item returns the enum value", {

  expect_equal(color.code(ColorEnum$BLUE),   1L)
  expect_equal(color.code(ColorEnum$RED),    2L)
  expect_equal(color.code(ColorEnum$BLACK),  3L)
  
})

test_that("Invalid enum values throw an error", {
 
  expect_error(color.code(0), "'arg' must be one of the values in the 'choices' list: 1, 2, 3", fixed = TRUE)
   
})



# make a defined list of names and don't care about the values you can use like this:
colors <- create.enum(c("red", "green", "blue"))


# specify values
hexColors <- create.enum(c(red="#FF0000", green="#00FF00", blue="#0000FF"))

# It is easy to access the enum names because of code completion:
hexColors$green
# [1] "#00FF00"

# To check if a variable is a value in your enum you can check like this:
param <- hexColors$green
param %in% hexColors

intColors <- create.enum(c(red=1, green=2, blue=3))
intColors
intColors$red



EnumTest = function(enum = c("BLUE", "RED", "BLACK")) {
  enumArg <-
    switch(
      match.arg(enum), "BLUE" = 0L, "RED" = 1L, "BLACK" = 2L
    )
  switch(enumArg,
         # do something
  )
}

