# R Data Types
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



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
val <- 1
val
```

```
## [1] 1
```

## Comments

The `#` is used for comments. Everthing after the `#` will be ignored by R.


```r
val    # This is a bad name for a variable because it is not very descriptive.
```

```
## [1] 1
```

The `#` symbol has several names:

* number sign (Shorthand for No.)
* pound sign (Shorthand for lb.)
* hash (Popular with programmers and in the UK and Ireland.)
* hashtag (As used on social media sites like Twitter.)
* octothorpe (Originated at Bell Labs, possibly as a joke.)

Since programmers generally call it a "hash", we will keep with this tradition.

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
val <- 1
typeof(val)
```

```
## [1] "double"
```

## Data Types and Classes

You can show the "higher order" type of a data object with `class()`.


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

## Testing for Numeric Values

You can test if a value is numeric using the `is.numeric()` function:


```r
is.numeric(1)          # TRUE
```

```
## [1] TRUE
```

```r
is.numeric(1L)         # TRUE
```

```
## [1] TRUE
```

```r
is.numeric(1 + 2i)     # FALSE
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
val <- 1
is.character(val)      # FALSE
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

However, the most commonly used data structure is the "Dataframe", based on 
the "List". 

## Vector

The default data structure is a Vector. A vector is a one-dimensional group 
(collection) of one or more values (data elements), all of the same primative 
data type.


```r
vec <- 1
```

The `c()` function "concatenates" a collection of values into a vector.


```r
vec <- c(1, 2)
vec
```

```
## [1] 1 2
```

```r
is.vector(vec)
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
seq(1, 4)
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

A Matrix is a two-dimensional structure of values, all of the same data type. 
It can be constructed from a Vector, as supplied by the "data" argument for the 
`matrix()` function.


```r
mat <- matrix(data = 1:4, nrow = 2)
mat
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
```

You can also arrange the values by row instead of by column.


```r
mat <- matrix(data = 1:4, nrow = 2, byrow = TRUE)
mat
```

```
##      [,1] [,2]
## [1,]    1    2
## [2,]    3    4
```

## Underlying Structure

The `str()` function may be used to show the underlying data structure.


```r
str(mat)
```

```
##  int [1:2, 1:2] 1 3 2 4
```

This shows that we have a 2x2 structure of the integers 1 through 4.

Let's compare this result with the `typeof()` and `class()` functions:


```r
typeof(mat)   # integer (the data type of the primative elements)
```

```
## [1] "integer"
```

```r
class(mat)    # matrix (the higher order data structure)
```

```
## [1] "matrix"
```

## Array

An Array is a multi-dimensional structure of values, all of the same data type.


```r
arr <- array(data = 1:8, dim = c(2, 2, 2))
arr
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

This array was built from a single vector, but split into three dimensions, each
containing 2 elements.

## Array


```r
typeof(arr)    # integer
```

```
## [1] "integer"
```

```r
str(arr)
```

```
##  int [1:2, 1:2, 1:2] 1 2 3 4 5 6 7 8
```

```r
class(arr)     # array
```

```
## [1] "array"
```

## List

A List is a multi-dimensional structure of values, allowing for different data
types in each of it's dimensions.


```r
lst <- list(a = 1:3, b = c('i', 'j', 'k'))
lst
```

```
## $a
## [1] 1 2 3
## 
## $b
## [1] "i" "j" "k"
```

This list was built from two vectors, which were labeled "a" and "b".

## List


```r
typeof(lst)    # list (does not show primative data type since it may vary)
```

```
## [1] "list"
```

```r
class(lst)     # list (same as result of typeof function)
```

```
## [1] "list"
```

The "class" of the list is shown in the first line of `str()` output. 


```r
str(lst)
```

```
## List of 2
##  $ a: int [1:3] 1 2 3
##  $ b: chr [1:3] "i" "j" "k"
```

## Naming Array Dimensions with a List

Now that we know about lists, we can see one in action.


```r
arr <- array(data = seq(5, 120, 5), dim = c(3, 4, 2), 
             dimnames = list(x=1:3, y=letters[1:4], z=LETTERS[1:2]))
arr
```

```
## , , z = A
## 
##    y
## x    a  b  c  d
##   1  5 20 35 50
##   2 10 25 40 55
##   3 15 30 45 60
## 
## , , z = B
## 
##    y
## x    a  b   c   d
##   1 65 80  95 110
##   2 70 85 100 115
##   3 75 90 105 120
```

## Dataframe

A Dataframe is a multi-dimensional structure of values, allowing multiple data
types. It is implemented as a list. A dataframe is used like a database table 
to store and manipulate tabular data in rows ("observations") and columns 
("variables"). You can think of the columns as vectors, since the values in a 
column must be of the same type.



```r
df <- data.frame(a = 1:3, b = c('i', 'j', 'k'))
df
```

```
##   a b
## 1 1 i
## 2 2 j
## 3 3 k
```

## Dataframe


```r
typeof(df)     # list
```

```
## [1] "list"
```

```r
str(df)
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
df <- data.frame(a = 1:3, b = c('i', 'j', 'k'), stringsAsFactors = FALSE)
df
```

```
##   a b
## 1 1 i
## 2 2 j
## 3 3 k
```

And we can hide the row numbers using `print()` with `row.names = FALSE`.


```r
print(df, row.names = FALSE)
```

```
##  a b
##  1 i
##  2 j
##  3 k
```

## Dataframe


```r
typeof(df)    # list
```

```
## [1] "list"
```

```r
str(df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ a: int  1 2 3
##  $ b: chr  "i" "j" "k"
```

## Dataframe

We can see that our list, `lst`, has a different class than our dataframe, `df`.


```r
class(lst)     # list
```

```
## [1] "list"
```

```r
class(df)      # data.frame
```

```
## [1] "data.frame"
```

Although a dataframe is implemented as a list, it has additional properties 
which make it very useful for data analysis. Those properties are associated
with the dataframe's "class". As before, `typeof()` shows the lower order 
data type and `class()` shows the higher order data type.
