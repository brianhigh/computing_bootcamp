# R Data Types
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## Learning Objectives

You will learn:

* The basics of R "data objects" and "classes"
* The basic "primitive" data types in R
* How to inspect the properties of data objects
* How to convert data objects to other types

## Data Objects

Since R is an *object oriented* language, everything in R is an *object*. What 
this means is that all of your data and code structures are stored in your 
computer's memory using the same framework. 

This provides a great deal of consistency in working with R because you can use 
many of the same methods to interact with various components of R.

There are a core set of basic object types and classes built into R. All other
objects are built upon these.

*Data objects* are those structures which you use to store data. Objects can 
also store functions, packages, connections, and other structures intended for 
other uses. 

In this module, we will focus entirely on data objects -- those which are used 
primarily for data storage and manipulation in memory.

Like other objects, data objects have a *type* and a *class*. The type defines
*how* the data are stored, while the class define *what* data are contained 
within an object.

## Data Types and Classes

The most basic data types are `numeric` (`double` and `integer`), `complex`, 
`logical` (boolean), and `character` (string).


```r
typeof(1)       # "double" -- double precision floating point number
```

```
## [1] "double"
```

```r
typeof(1L)      # "integer" -- "L" after one or more digits makes it an integer
```

```
## [1] "integer"
```

```r
typeof(TRUE)    # "logical" -- either TRUE or FALSE
```

```
## [1] "logical"
```

```r
typeof(1 + 2i)  # "complex" -- a number with real and imaginary components
```

```
## [1] "complex"
```

## Data Types and Classes

Characters are entered with quotes around them (single or double quotes).


```r
typeof('abcd')     # "character" -- a non-numeric "string" of text characters
```

```
## [1] "character"
```

If you omit the quotes of an alphanumeric string, R will assume you are 
referring to a variable name.


```r
val <- 1234
typeof(val)
```

```
## [1] "double"
```

## Data Types and Classes

You can show the "higher order" (if any) type of a data object with `class()`.


```r
typeof(1234)      # double  (the more basic "primitive" type)
```

```
## [1] "double"
```

```r
class(1234)       # numeric (the more general "higher order" type)
```

```
## [1] "numeric"
```

```r
typeof('abcd')    # character
```

```
## [1] "character"
```

```r
class('abcd')     # character
```

```
## [1] "character"
```

## Testing for Numeric Values

You can test if the (storage) `mode` of a value is numeric using the 
`is.numeric()` function:


```r
is.numeric(1234)          # TRUE
```

```
## [1] TRUE
```

```r
is.numeric(1234L)         # TRUE
```

```
## [1] TRUE
```

```r
is.numeric(1234 + 5i)     # FALSE
```

```
## [1] FALSE
```

## Testing for Character Values

As before, we quote literal character strings but not variable names.


```r
is.character('val')    # TRUE
```

```
## [1] TRUE
```

```r
val <- 1234
is.character(val)      # FALSE
```

```
## [1] FALSE
```

## Dates and Times

While R could store a dates and times as character strings, it actually has 
special classes for these to allow for date/time arithmetic and formatting.


```r
# Class: "Date"
cat('The date was', format(Sys.Date() - 7, '%Y-%m-%d'), 'a week ago.')
```

```
## The date was 2016-08-28 a week ago.
```

```r
cat('Halloween is on a', weekdays(as.Date('10-31', format='%m-%d')), 'this year.')
```

```
## Halloween is on a Monday this year.
```

```r
# Class: "POSIXct" (date, time, timezone, etc.) and "difftime"
since.midnight <- Sys.time() - as.POSIXct('0', format='%H')
cat('It has been', format(since.midnight), 'since midnight.')
```

```
## It has been 11.12979 hours since midnight.
```

## Basic Single-Value (Scalar) Data Types

Data types consisting of only a single value are also called "scalar" types.

Example    | Type      | Class             | Storage Mode
-----------|-----------|-------------------|-------------
1L         | integer   | integer           | numeric
1          | double    | numeric           | numeric
'1'        | character | character         | character
TRUE       | logical   | logical           | logical
1+1i       | complex   | complex           | complex
Sys.Date() | double    | Date              | numeric 
Sys.time() | double    | POSIXct,  POSIXlt | numeric 

There are other, more esoteric data types, which you can learn about with 
`?typeof`. One of those is `list`, which we will cover next.

## Data Type Conversion

We already saw how types can be automatically "coerced" to other types through 
combination and other operations. R also has several "as" functions to 
explicitly convert types and structures as well.


```r
as.integer('0')
```

```
## [1] 0
```

```r
as.character(0)
```

```
## [1] "0"
```

```r
as.logical(0)
```

```
## [1] FALSE
```
