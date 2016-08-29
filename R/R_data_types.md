# R Data Types
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## R Data Types and Structures

### Learning objectives

You will learn:

* How to access and display data in R
* How to make comments in R code
* The basic "primitive" data types in R
* The basic "higher order" data structures in R
* The basics of R "data objects" and "classes"
* How to inspect the properties of data objects
* How to convert data objects to other types

## Accessing Data

If you just enter a value at the R command prompt, R will print out the value:


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

You can store data in memory by assigning values to variables (using `<-`).


```r
val <- 1234
val
```

```
## [1] 1234
```

## Aside: Code Comments in R

The `#` is used for comments. Everthing after the `#` will be ignored by R.


```r
val <- 1234
val    # This is a bad name for a variable because it is not very descriptive.
```

```
## [1] 1234
```

The `#` symbol has several names:

* **number (numero) sign**: shorthand for &#8470; (No.)
* **pound sign**: shorthand for &#8468; (lb.)
* **hash**: popular with programmers and in the UK and Ireland
* **hashtag**: as used on social media sites like Twitter
* **octothorpe**: originated at Bell Labs, possibly as a joke

Since programmers generally call it a "hash", we will keep with this tradition.

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

You can show the "higher order" type of a data object with `class()`.


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

You can test if a value is numeric using the `is.numeric()` function:


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

## Data Structures

R has four basic data structures:

* Vector (atomic vector)
* Matrix
* Array
* List (non-atomic vector)

However, the most commonly used data structure is the "Dataframe", based on 
the "List". 

## Vector

The default data structure in R is a Vector. A vector is a one-dimensional group 
(collection) of one or more values (data elements), all of the same 
("homogenous") primitive data type (i.e. "atomic").


```r
vec <- 1234   # A vector containing a single value
```

The `c()` function "combines" values into a vector.


```r
vec <- c(12, 34)
vec
```

```
## [1] 12 34
```

```r
is.vector(vec)
```

```
## [1] TRUE
```

## Vector

Vectors in R are called "atomic vectors" because they are a "flat" structure 
composed only of single-valued items.


```r
length(vec)
```

```
## [1] 2
```

```r
is.atomic(vec)
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
seq(1, 4)         # Type ?seq to find out how to make more complex sequences.
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
typeof(mat)   # integer (the data type of the primitive elements)
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
arr_data <- seq(5, 120, 5)    # A vector of length 24
arr_dim <- c(3, 4, 2)         # The product of the these three values is 24
arr <- array(data = arr_data, dim = arr_dim)
arr
```

```
## , , 1
## 
##      [,1] [,2] [,3] [,4]
## [1,]    5   20   35   50
## [2,]   10   25   40   55
## [3,]   15   30   45   60
## 
## , , 2
## 
##      [,1] [,2] [,3] [,4]
## [1,]   65   80   95  110
## [2,]   70   85  100  115
## [3,]   75   90  105  120
```

This array was built from a single data vector, but split into three dimensions.

## Array


```r
typeof(arr)    # integer
```

```
## [1] "double"
```

```r
str(arr)
```

```
##  num [1:3, 1:4, 1:2] 5 10 15 20 25 30 35 40 45 50 ...
```

```r
class(arr)     # array
```

```
## [1] "array"
```

## List

A list is a vector of data objects which may be heterogenous (non-atomic).


```r
lst <- list(x=1:3, y=letters[1:4], z=LETTERS[1:2])
lst
```

```
## $x
## [1] 1 2 3
## 
## $y
## [1] "a" "b" "c" "d"
## 
## $z
## [1] "A" "B"
```

```r
is.atomic(lst)
```

```
## [1] FALSE
```

This list was built from three vectors, which were labeled "x", "y", and "z". 

## List


```r
typeof(lst)    # list (does not show primitive data type since it may vary)
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
## List of 3
##  $ x: int [1:3] 1 2 3
##  $ y: chr [1:4] "a" "b" "c" "d"
##  $ z: chr [1:2] "A" "B"
```

## Naming Array Dimensions with a List

Now that we know about lists, we can see one in action.


```r
named_arr <- array(data = arr_data, dim = arr_dim, dimnames = lst)
named_arr
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

We used our list to define the item names for each dimension of the array.

## Dataframe

A Dataframe is a multi-dimensional structure of values, allowing multiple data
types. It is implemented as a list. A dataframe is used like a database table 
to store and manipulate tabular data in rows ("observations") and columns 
("variables"). You can think of the columns as vectors, since the values in a 
column must be of the same type.



```r
df <- data.frame(number=1:4, letter=letters[1:4])
df
```

```
##   number letter
## 1      1      a
## 2      2      b
## 3      3      c
## 4      4      d
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
## 'data.frame':	4 obs. of  2 variables:
##  $ number: int  1 2 3 4
##  $ letter: Factor w/ 4 levels "a","b","c","d": 1 2 3 4
```

## Dataframe

By default, "character" values are converted to "factors". We can change this
behavior with `stringsAsFactors = FALSE`.


```r
df <- data.frame(number=1:4, letter=letters[1:4], stringsAsFactors = FALSE)
df
```

```
##   number letter
## 1      1      a
## 2      2      b
## 3      3      c
## 4      4      d
```

And we can hide the row numbers using `print()` with `row.names = FALSE`.


```r
print(df, row.names = FALSE)
```

```
##  number letter
##       1      a
##       2      b
##       3      c
##       4      d
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
## 'data.frame':	4 obs. of  2 variables:
##  $ number: int  1 2 3 4
##  $ letter: chr  "a" "b" "c" "d"
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

## Summary of Data Structures

Dimension|Homogeneous|Heterogeneous
---------|-----------|-------------
1d|Atomic vector|List
2d|Matrix|Data frame
nd|Array|

_Source_: [Advanced R: Data Structures](http://adv-r.had.co.nz/Data-structures.html)
