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
* How to create categorical variables in R
* How to convert data objects to other types

## Accessing Data

If you just enter a value at the R command prompt, R will print out the value:


```r
1
```

```
## [1] 1
```

Or you can use the `print()` function instead (to be explicit about it):


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

* *__number sign__*: shorthand for &#8470; (*numero*, No.)
* *__pound sign__*: shorthand for &#8468; (*libra pondo*, lb.)
* *__hash__*: from "cross hatch"; popular with programmers (and also in the UK)
* *__hashtag__*: as used on social media sites like Twitter for keyword searching
* *__octothorpe__*: originated at Bell Labs for use with telephone keypads

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

## Basic Data Structures

R has four basic data structures:

* Vector (Atomic vector)
* Matrix
* Array
* List (Composite vector)

However, the most commonly used data structure is the "Data frame", based on 
the "List". 

## Summary of Basic Data Structures

Dimension|Homogeneous|Heterogeneous
---------|-----------|-------------
1d|Atomic vector|List
2d|Matrix|Data frame
nd|Array|

_Source_: [Advanced R: Data Structures](http://adv-r.had.co.nz/Data-structures.html), 
&copy; Hadley Wickham. 

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

## Underlying Data Structure

Several functions may be used to expose the underlying data structure.


```r
str(mat)         # int ...    (a 2x2 structure of the integers 1 through 4)
```

```
##  int [1:2, 1:2] 1 3 2 4
```

```r
typeof(mat)      # "integer"  (the data type of the primitive elements)
```

```
## [1] "integer"
```

```r
class(mat)       # "matrix"   (the higher order data structure)
```

```
## [1] "matrix"
```

```r
attributes(mat)  # $dim ...   (the metadata for the object, related to its class)
```

```
## $dim
## [1] 2 2
```

## Array

An Array is a multi-dimensional structure of values, all of the same data type.


```r
arr.data <- seq(5, 120, 5)    # A vector of length 24
arr.dim <- c(3, 4, 2)         # The product of the these three values is 24
arr3d <- array(data = arr.data, dim = arr.dim)
arr3d
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
typeof(arr3d)      # "double"
```

```
## [1] "double"
```

```r
str(arr3d)         # num ...
```

```
##  num [1:3, 1:4, 1:2] 5 10 15 20 25 30 35 40 45 50 ...
```

```r
class(arr3d)       # "array"
```

```
## [1] "array"
```

```r
attributes(arr3d)  # $dim ...
```

```
## $dim
## [1] 3 4 2
```

## List

A list is a vector of data objects which may be heterogenous (non-atomic).


```r
lst3d <- list(x=1:3, y=letters[1:4], z=LETTERS[1:2])
lst3d
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
is.atomic(lst3d)
```

```
## [1] FALSE
```

This list was built from three vectors, which were labeled "x", "y", and "z". 

## List


```r
typeof(lst3d)    # list (does not show primitive data type since it may vary)
```

```
## [1] "list"
```

```r
class(lst3d)     # list (same as result of typeof function)
```

```
## [1] "list"
```

The "class" of the list is shown in the first line of `str()` output. 


```r
str(lst3d)
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
arr3d.named <- array(data = arr.data, dim = arr.dim, dimnames = lst3d)
arr3d.named
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

## Data frame

A Data frame is a multi-dimensional structure of values, allowing multiple data
types. It is implemented as a list. A data frame is used like a database table 
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

## Data frame


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

## Data frame

By default, "character" values are converted to "factors" (categorical 
variables). We can change this behavior with `stringsAsFactors = FALSE`.


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

## Data frame


```r
typeof(df)       # list
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

```r
attributes(df)
```

```
## $names
## [1] "number" "letter"
## 
## $row.names
## [1] 1 2 3 4
## 
## $class
## [1] "data.frame"
```

## Data frame

We can see that our list, `lst3d`, has a different class than our data frame, `df`.


```r
class(lst3d)     # list
```

```
## [1] "list"
```

```r
class(df)        # data.frame
```

```
## [1] "data.frame"
```

Although a data frame is implemented as a list, it has additional properties 
which make it very useful for data analysis. Those properties are associated
with the data frame's "class". As before, `typeof()` shows the lower order 
data type and `class()` shows the higher order data type.

## Factors

We stumbled upon the topic of "factors" (categorical variables) when we created 
a data frame from a character vector. Let's create one and explore it's properties.


```r
gender <- factor(c('m', 'm', 'f', 'm', 'f', 'f'))
gender
```

```
## [1] m m f m f f
## Levels: f m
```

```r
class(gender)
```

```
## [1] "factor"
```

This looks like a character vector with the additional attribute of "Levels", 
where the levels are the unique values from the vector. But how is this implemented?

## Factors


```r
typeof(gender)
```

```
## [1] "integer"
```

```r
str(gender)
```

```
##  Factor w/ 2 levels "f","m": 2 2 1 2 1 1
```

```r
attributes(gender)
```

```
## $levels
## [1] "f" "m"
## 
## $class
## [1] "factor"
```

As we can see, a factor in R is an object of class "factor" composed of an 
integer vector and a `$class` attribute and a `$levels` attribute containing a 
character vector.

## Factors

Factors can also represent ordinal variables, but you need to be careful when 
using ordered factors to make sure the order is correct.


```r
risk <- c('medium', 'high', 'low', 'low', 'medium', 'low', 'high')
factor(risk, ordered = TRUE)                # Factors in alpha-numeric order
```

```
## [1] medium high   low    low    medium low    high  
## Levels: high < low < medium
```

```r
severity <- c('low', 'medium', 'high')      # Factors by increasing severity
risk <- factor(risk, ordered = TRUE, levels = severity)
risk
```

```
## [1] medium high   low    low    medium low    high  
## Levels: low < medium < high
```

```r
# Create a data frame using this risk factor variable
risky <- data.frame(id = LETTERS[1:7], risk, stringsAsFactors = FALSE)
```

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

## Data Structure Conversion

We can create a matrix from two dimensions of a 3D array using the `matrix()`
constructor we have used previously. However, it may not behave as you expect.


```r
arr2d.named <- arr3d.named[,,1]   # Subset before converting (just two dimensions)
attributes(arr2d.named)           # A 3x4 array with dimension names
```

```
## $dim
## [1] 3 4
## 
## $dimnames
## $dimnames$x
## [1] "1" "2" "3"
## 
## $dimnames$y
## [1] "a" "b" "c" "d"
```

```r
m1 <- matrix(arr2d.named)         # Flattened. Same as:  matrix(as.vector(arr_2d))
attributes(m1)                    # A 12x1 matrix without dimension names -- surprise!
```

```
## $dim
## [1] 12  1
```

## Data Structure Conversion

We can also use "as" functions to convert higher order data structures.

Let's use the `as.matrix()` converter to create the matrix from the array.


```r
m2 <- as.matrix(arr2d.named)      # Not flattened. Dimensions and names are retained.
attributes(m2)
```

```
## $dim
## [1] 3 4
## 
## $dimnames
## $dimnames$x
## [1] "1" "2" "3"
## 
## $dimnames$y
## [1] "a" "b" "c" "d"
```

Note the difference between the `matrix()` constructor and the `as.matrix()`
converter. The dimension and name attributes have been retained when using
the converter function. Which approach you choose will depend on whether or not
you prefer to flatten or retain the structure and attributes of the original 
object. It will also depend on the types of objects you are using. (Try 
this with a data frame.)
