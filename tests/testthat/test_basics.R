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
 
  values <- c("COFFEE", "TEA", "SOFT DRINK")
  DRINKS <- create.enum(values)
  expect_equal(DRINKS, values, check.attributes = FALSE)
  expect_equal(names(DRINKS), make.names(values), check.attributes = FALSE)
  
  
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

  expect_error(create.enum(1:2, LETTERS[1:3]), info = "different number of values and names")

  expect_error(create.enum(NULL, LETTERS[1:3]), "Enums may not be empty. 'allowed.values' must contain at least one element", fixed = TRUE)

  expect_error(create.enum(list(1, "2", 3), c("A", "B", "C")), "'allowed.values' does not contain an atomic (scalar) vector but is a list", fixed = TRUE)
  
  expect_error(create.enum(mtcars, mtcars$mpg), "'allowed.values' does not contain an atomic (scalar) vector but is a list with class = data.frame", fixed = TRUE)
  
  expect_error(create.enum(1:3, list("A", 2, "B")), "'value.names' does not contain an atomic (scalar) vector but is a list with class = list", fixed = TRUE)

})



test_that("create.enum handles NA", {
  
  e1 <- create.enum(c(a = 1, b = 2, c = NA))
  expect_true(is.na(e1$c), info = "NA value must be allowed")

  e2 <- create.enum(NA)
  expect_equal(length(e2), 1)
  expect_equal(e2$NA., NA)
  expect_true(is.na(e2[[1]]))

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
  
  result <- as.data.frame(new.enum)
  
  expect_equal(result, expected)
  
  
  expect_error(as.data.frame.enumeration(1), "is.enumeration(x) is not TRUE", fixed = TRUE)
  
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



test_that("create.enum works with named vector elements", {
  
  values <- c(BLUE = 1L, RED = 2L, BLACK = 3L)

  expect_equal(create.enum(values), as.list(values), check.attributes = FALSE)
  
})


# OPEN TEST CASES -------------------------------------------------------------------------------------------------


# To check if a variable is a value in your enum you can check like this:
# param <- hexColors$green
# param %in% hexColors


