# Basic test of enumerations

# library(testthat)

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
 
  expect_error(color.code(0), "'arg' must be one of the values in the 'choices' list: BLUE = 1, RED = 2, BLACK = 3", fixed = TRUE)
   
})


test_that("create.enum works", {
 
  new.enum1 <- create.enum(1:5, LETTERS[1:5])
  expected.enum1 <- list(A = 1, B = 2, C = 3, D = 4, E = 5)

  expect_equal(new.enum1, expected.enum1, check.attributes = FALSE)
  
  
  
  values <- c("aaa", "b_b", "c c", "d.d")
  new.enum2 <- create.enum(values, LETTERS[1:4])
  exp.enum2 <- list(A = "aaa", B = "b_b", C = "c c", D = "d.d")

  expect_equal(new.enum2, exp.enum2, check.attributes = FALSE)
  
  
  
  new.enum3 <- create.enum(values)
  exp.enum3 <- list(aaa = "aaa", b_b = "b_b", c.c = "c c", d.d = "d.d")
  expect_equal(new.enum3, exp.enum3, check.attributes = FALSE)
  
  
  
  new.enum4 <- create.enum(c("a a", "a.a"))
  exp.enum4 <- list( a.a.1 = "a a", a.a = "a.a")
  expect_equal(new.enum4, exp.enum4, check.attributes = FALSE)
  
  # Attributes must be different
  # expect_unequal: https://stackoverflow.com/questions/12111863/expect-not-equal-in-pkgtestthat
  expect_false(isTRUE(all.equal(new.enum4, exp.enum4, check.attributes = TRUE)))

})



test_that("create.enum recognizes wrong parameter values", {

  expect_error(create.enum(integer(0), c("a", "b")), "Enums may not be empty.", fixed = TRUE)
  expect_error(create.enum(c(1,1,2)), "'allowed.values' must contain unique elements", fixed = TRUE)
  expect_error(create.enum(1:3, c("aaa", "bbb")), "'allowed.values' [3] and 'value.names' [2] must have the same length", fixed = TRUE)
  
})



test_that("create.enum stores descriptions", {
  
  new.enum <- create.enum(1:3, c("hello", "new", "world"), c("greeting", "not old", "everyone"))
  expect_equal(attr(new.enum, "descriptions"), c("greeting", "not old", "everyone"))
})



test_that("enum as.data.frame works", {
  
  new.enum <- create.enum(1:3, c("hello", "new", "world"), c("greeting", "not old", "everyone"))
  expected <- data.frame(allowed.values = 1:3,
                         value.names    = c("hello", "new", "world"),
                         descriptions   = c("greeting", "not old", "everyone"),
                         stringsAsFactors = FALSE)
  
  expect_equal(as.data.frame(new.enum), expected)
  
  
  expect_error(as.data.frame.enumeration(1), "is.enumeration(enum) is not TRUE", fixed = TRUE)
  
})



test_that("invalid enum value names do work as-is", {
  
  new.enum <- create.enum(1:3, c("hi 1", "222", "a$3*2"), ensure.valid.value.names = FALSE)
  
  expect_equal(new.enum$`hi 1`, 1)
  expect_equal(new.enum$`222`, 2)
  expect_equal(new.enum$`a$3*2`, 3)
  
})



test_that("invalid enum value names are cleaned-up", {
  
  new.enum <- create.enum(1:3, c("hi 1", "222", "a$3*2"))  # ensure.valid.value.names = TRUE is default!
  
  expect_equal(new.enum$hi.1, 1)
  expect_equal(new.enum$X222, 2)
  expect_equal(new.enum$a.3.2, 3)
  
})



test_that("is.enumeration works", {
  
  expect_false(is.enumeration(1.10))
  expect_true(is.enumeration(create.enum(1:10)))

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


