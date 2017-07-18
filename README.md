# Enumerations in R

## Overview

A package that adds a dynamic enumeration data type to the R programming language

An enumeration is a data type that consisting of a set of named values.



## Background

For a good definition and background information about *enumeration types* see wikipedia:

https://en.wikipedia.org/wiki/Enumerated_type



## Advantages of enumerations

Enumerated types

1. make the code **more self-documenting** by using self-explanatory names instead of "magic" values
2. reduce the risk of passing wrong actual parameter values to functions via **validation against
   the list of allowed values**
   (if the formal parameter is an enumerated type)
3. **make coding easier** if the IDE supports code completion (e. g. RStudio)
   by presenting the list of allowed names
   


## Installation

To install the package using the source code at github you can use the package *devtools*:

```R
# install.packages("devtools")
library(devtools)
install_github("aryoda/R_enumerations")
```


## Usage

TODO



## Import into your own packages

If you want to use this package in your own packages you have to declare the dependencies in the
`DESCRIPTION` file and add a remote dependency to the github location:

```
Imports: ...,
         enumerations

Remotes: aryoda/R_enumerations
```

For details see: https://stackoverflow.com/questions/30493388/create-an-r-package-that-depends-on-another-r-package-located-on-github
