# Basic test of enumerations

testthat::context("test_basis.R")


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


test_that("create.enum works", {
 
  new.enum1 <- create.enum(1:5, LETTERS[1:5])
  expected.enum1 <- list(A = 1, B = 2, C = 3, D = 4, E = 5)

  expect_equal(new.enum1, expected.enum1)
  
  
  
  values <- c("aaa", "b_b", "c c", "d.d")
  new.enum2 <- create.enum(values, LETTERS[1:4])
  exp.enum2 <- list(A = "aaa", B = "b_b", C = "c c", D = "d.d")

  expect_equal(new.enum2, exp.enum2)
  
  
  
  new.enum3 <- create.enum(values)
  exp.enum3 <- list(aaa = "aaa", b_b = "b_b", c.c = "c c", d.d = "d.d")
  expect_equal(new.enum3, exp.enum3)
  
  
  
  new.enum4 <- create.enum(c("a a", "a.a"))
  exp.enum4 <- list( a.a.1 = "a a", a.a = "a.a")
  expect_equal(new.enum4, exp.enum4)
  
})



test_that("create.enums recognizes wrong parameter values", {

  expect_error(create.enum(integer(0), c("a", "b")), "Enums may not be empty.", fixed = TRUE)
  expect_error(create.enum(c(1,1,2)), "'allowed.values' must contain unique elements", fixed = TRUE)
  expect_error(create.enum(1:3, c("aaa", "bbb")), "'allowed.values' [3] and 'value.names' [2] must be the same length", fixed = TRUE)
  
})




# OPEN TEST CASES -------------------------------------------------------------------------------------------------



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

