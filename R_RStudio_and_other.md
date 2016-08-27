# R, RStudio and other tools
Brian High  
![CC BY-SA 4.0](cc_by-sa_4.png)  



## R Language Basics

## Accessing Data

If you just enter a value, R will print it out:


```r
1
```

```
## [1] 1
```

Or you can use the `print()` function instead:


```r
print('a')
```

```
## [1] "a"
```

You can store data in memory by assigning values to variables.


```r
a <- 1
a
```

```
## [1] 1
```

## Comments

The `#` is used for comments. Everthing after the `#` will be ignored by R.


```r
a    # This is a bad name for a variable.
```

```
## [1] 1
```

The `#` symbol often is called:

* number sign
* pound sign
* hash (Popular with programmers.)
* hashtag (Technically, this refers to a number sign and the text following it.)
* octothorpe (This term originated at Bell Labs, possibly as a "joke".)

## Data Types and Classes

You can show the type of a value with `typeof()` or `class()`.


```r
typeof(1)      # double  (the more basic "primative" type)
```

```
## [1] "double"
```

```r
class(1)       # numeric (the more general "higher order" type)
```

```
## [1] "numeric"
```

```r
typeof('a')    # character
```

```
## [1] "character"
```

```r
class('a')     # character
```

```
## [1] "character"
```

## Data Types and Classes

The most basic data types are `numeric` (`double` and `integer`), `complex`, 
and `character`. You can view the type of a value with the `typeof()` function:


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
typeof(1 + 2i)  # "complex" -- a number with real and imaginary components
```

```
## [1] "complex"
```

## Data Types and Classes

Characters are entered with quotes around them (single or double quotes).


```r
typeof('a')     # "character" -- a non-numeric "string" of text characters
```

```
## [1] "character"
```

If you omit the quotes of an alphanumeric string, R will assume you are 
referring to a variable name.


```r
a <- 1
typeof(a)
```

```
## [1] "double"
```

## Testing for Numeric Values

You can test if a value is numeric using the `is.numeric()` function:


```r
is.numeric(1)
```

```
## [1] TRUE
```

```r
is.numeric(1L)
```

```
## [1] TRUE
```

```r
is.numeric(1 + 2i)
```

```
## [1] FALSE
```

## Testing for Character Values

As before, we quote literal character strings but not variable names.


```r
is.character('a')
```

```
## [1] TRUE
```

```r
a <- 1
is.character(a)
```

```
## [1] FALSE
```

## Data Structures

R has four basic data structures:

* Vector
* Matrix
* Array
* List
* Dataframe

## Vector

The default data structure is a Vector. A vector is a one-dimensional group 
(collection) of one or more values (data elements), all of the same primative data 
type.


```r
a <- 1
```

The `c()` function "concatenates" a collection of values into a vector.


```r
a <- c(1, 2)
a
```

```
## [1] 1 2
```

```r
is.vector(a)
```

```
## [1] TRUE
```

## Vector

We can save ourselves some typing when working with sequences of integers. 
These are all ways to create equivalent vectors of the digits one through four:


```r
c(1L, 2L, 3L, 4L)
```

```
## [1] 1 2 3 4
```

```r
1:4
```

```
## [1] 1 2 3 4
```

```r
seq(1:4)
```

```
## [1] 1 2 3 4
```

## Vector

R will try to "coerce" the values of a vector to a common data type, if necessary.


```r
c('a', 1)                # Coerced to "character"
```

```
## [1] "a" "1"
```

```r
c(1L, 1.1)               # Coerced to "double"
```

```
## [1] 1.0 1.1
```

```r
c(1L, 1.1, 1+1i)         # Coerced to "complex"
```

```
## [1] 1.0+0i 1.1+0i 1.0+1i
```

```r
c('a', 1L, 1.1, 1+1i)    # Coerced to "character"
```

```
## [1] "a"    "1"    "1.1"  "1+1i"
```

## Matrix

A Matrix is a two-dimensional structure of values, all of the same data type. It can
be constructed from a Vector, as supplied by the "data" argument for the `matrix()`
function.


```r
m <- matrix(data = 1:4, nrow = 2)
m
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
```

You can also arrange the values by row instead of by column.


```r
m <- matrix(data = 1:4, nrow = 2, byrow = TRUE)
m
```

```
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
```

## Underlying structure and "class"

The `str()` function may be used to show the underlying data structure.


```r
str(m)
```

```
##  int [1:2, 1:2] 1 3 2 4
```

This shows that we have a 2x2 structure of the integers 1 through 4.

We can also display the class with the `class()` function:


```r
class(m)
```

```
## [1] "matrix"
```

So, the 2x2 structure is stored as a `matrix`.

## Array

An Array is a multi-dimensional structure of values, all of the same data type.


```r
a <- array(data = 1:8, dim = c(2, 2, 2))
a
```

```
## , , 1
## 
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
## 
## , , 2
## 
##      [,1] [,2]
## [1,]    5    7
## [2,]    6    8
```

## Array


```r
typeof(a)
```

```
## [1] "integer"
```

```r
str(a)
```

```
##  int [1:2, 1:2, 1:2] 1 2 3 4 5 6 7 8
```

```r
class(a)
```

```
## [1] "array"
```

## List

A List is a multi-dimensional structure of values, allowing for different data
types in each of it's dimensions.


```r
x <- list(a = 1:3, b = c('i', 'j', 'k'))
x
```

```
## $a
## [1] 1 2 3
## 
## $b
## [1] "i" "j" "k"
```

## List


```r
typeof(x)
```

```
## [1] "list"
```

```r
str(x)
```

```
## List of 2
##  $ a: int [1:3] 1 2 3
##  $ b: chr [1:3] "i" "j" "k"
```

The "class" of the list is shown in the first line of `str()` output. 


```r
class(x)
```

```
## [1] "list"
```

## Dataframe

A Dataframe is a multi-dimensional structure of values, allowing multiple data
types. It is implemented as a list.


```r
y <- data.frame(a = 1:3, b = c('i', 'j', 'k'))
y
```

```
##   a b
## 1 1 i
## 2 2 j
## 3 3 k
```

## Dataframe


```r
typeof(y)
```

```
## [1] "list"
```

```r
str(y)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ a: int  1 2 3
##  $ b: Factor w/ 3 levels "i","j","k": 1 2 3
```

## Dataframe

By default, "character" values are converted to "factors". We can change this
behavior with `stringsAsFactors = FALSE`.


```r
y <- data.frame(a = 1:3, b = c('i', 'j', 'k'), stringsAsFactors = FALSE)
y
```

```
##   a b
## 1 1 i
## 2 2 j
## 3 3 k
```

And we can hide the row numbers using `print()` with `row.names = FALSE`.


```r
print(y, row.names = FALSE)
```

```
##  a b
##  1 i
##  2 j
##  3 k
```

## Dataframe


```r
typeof(y)
```

```
## [1] "list"
```

```r
str(y)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ a: int  1 2 3
##  $ b: chr  "i" "j" "k"
```

## Dataframe

We can see that our list, `x`, has a different class than our dataframe, `y`.


```r
class(x)    # list
```

```
## [1] "list"
```

```r
class(y)    # data.frame
```

```
## [1] "data.frame"
```

Although a dataframe is implemented as a list, it has additional properties 
which make it very useful for data analysis. Those properties are associated
with the dataframe's "class". As before, `typeof()` shows the lower order 
data type and `class()` shows the higher order data type.
