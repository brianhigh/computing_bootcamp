# R Language Basics
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## Learning objectives

You will learn:

* How to access, assign and display data in R
* How to call functions
* How to use vectorized operations
* How to store, load, and remove data
* How to make comments in R code
* What is unusual about R
* The overall structure of the R language

## Accessing Data

If you just enter a value at the R command prompt, R will print out the value 
to your screen:


```r
68.1
```

```
## [1] 68.1
```

Or you can call the `print()` function instead (to be explicit about it):


```r
print('A')
```

```
## [1] "A"
```

## Variable assignment with `<-`

You can store data in memory by *assigning* values to variables (using `<-`).


```r
number <- 68.1
number
```

```
## [1] 68.1
```

This value will be stored in your computer's memory for the duration of the 
current session, or until it is modified or deleted by you, your code, or your
environment (execution context).

The `<-` (arrow) symbol is used as the primary assignment operator in R.

You can also use the `=` symbol for the assignment operator, but it is not 
as commonly used in R, except for argument assignment in function calls.

## Argument assignment with `=`

In this function call, we use the `=` symbol to tell R that the expected 
argument (parameter) `x` should take the value of our `number` variable.


```r
print(x = number)
```

```
## [1] 68.1
```

This assignment takes place within the function call and is not available 
outside of the function or after the function call is made.

Since the `x` argument is the first argument expected by the function, we do
not have to explicity assign our value to this argument, if we supply our
value as the first (or only) argument.


```r
print(number)
```

```
## [1] 68.1
```

## Assignment operators

Just remember: 

* use `<-` for variable assignment 


```r
number <- 68.1
```

* use `=` for argument assignment within function calls


```r
print(x = number)
```

## Vectors

In R, a vector is a group of values or variables. You can create a 
vector from a collection of data values using the `c()` (combine) function.


```r
id <- c('A', 'B', 'C', 'D')
height <- c(68.1, 69.4, 71.2, 68.9)
weight <- c(159.2, 162.3, 203.5, 181.3)
```

Here, we created three vectors, which we may describe as follows:

* `id` is a character vector containing alphabetic indentifiers
* `height` is a numeric vector containing heights in inches
* `weight` is a numeric vector containing weights in pounds

More technically speaking, a vector is an ordered collection of one or more 
individual values of the same data type. 

In other computer languages this data structure would be called an array or a 
list, but R uses those terms for other, more complex data structures.

## Data types and classes

We can view the (underlying) data type of an object by using the `typeof()` function.


```r
typeof(id)
```

```
## [1] "character"
```

We can find the (higher order) category of an object with `class()`.


```r
class(id)
```

```
## [1] "character"
```

Both the type and class of a character vector is "character".


```r
is.vector(id)
```

```
## [1] TRUE
```

We can see that our vector is indeed a vector even if the class is not.

## Data types and classes


```r
typeof(weight)
```

```
## [1] "double"
```

```r
class(height)
```

```
## [1] "numeric"
```

The type of a numeric vector may be "double" or "integer". The class is "numeric".

The term "double" used above refers to data storage as a [double-precision 
floating point](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) 
format (64 bit) number.

We will explore the various R data objects and their properties in depth in a 
later module.

## Data frames

You can store a two dimensional matrix of data (a "table") as a data frame. This
is the most common way to work with data in R. A data frame is often constructed
from one or more vectors.


```r
df <- data.frame(id, height, weight)
df
```

```
##   id height weight
## 1  A   68.1  159.2
## 2  B   69.4  162.3
## 3  C   71.2  203.5
## 4  D   68.9  181.3
```

The rows represent observations or cases and the columns represent variables.

We can see that our data frame, `df`, is a data frame by using the `class()` 
function.


```r
class(df)
```

```
## [1] "data.frame"
```

## Viewing data

You can see your data frame in a grid format by using the `View()` function.


```r
View(df)
```

This will open the data frame in a new window or tab and display it like a 
spreadsheet. 

![](images/df.png)

However, unlike a spreadsheet, you will not be able to manipulate
your data in this display.

## Performing calculations

R is basically a calculator. You can use many built-in operators and functions.


```r
2*2
```

```
## [1] 4
```

```r
2/2
```

```
## [1] 1
```

```r
2^2
```

```
## [1] 4
```

```r
sqrt(2)
```

```
## [1] 1.414214
```

## Code Comments in R

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

In this tutorial, we will usually refer to it as a "hash" or "pound".

## Vectorized operations

R allows you to perform calculations on all items in a vector or all rows of a 
data frame at the same time. 

Operations that allow this are called *vectorized* operations. They are often 
much faster than the alternatives. 

Let's [calculate](https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html) the adult Body Mass Index (BMI), using our two vectors as input.


```r
# Calculate adult BMI from vectors: weight (in pounds) and height (in inches)
bmi <- (weight / height ^ 2) * 703
bmi
```

```
## [1] 24.13260 23.68945 28.22018 26.84817
```

This creates a new vector of results and prints the vector to the screen.

You will want to make sure your input vectors have the same number of values 
(elements). If they do not match, you may see strange results.

## Vectorized operations versus loops

Alternatively, we could have used a loop to iterate through the input data. This
approach would calculate a single adult BMI for each loop iteration. 

We can implement this approach with a `for()` loop.


```r
# Initialize vector before use in body of loop
bmi <- NULL

# Calculate adult BMI using loop from values: weight (in pounds) and height (in inches)
for (i in 1:length(weight)) bmi[i] <- (weight[i] / height[i] ^ 2) * 703
bmi
```

```
## [1] 24.13260 23.68945 28.22018 26.84817
```

Not only does this take more code it is also less efficient, since many more
operations (function calls) have to be performed.

## Vectorized operations versus loops

For comparison, let's create two data vectors with 100,000 values in each, by
randomly sampling from the normal distribution.


```r
set.seed(5)      # Start the random number generator reproducibly.
wt100k <- rnorm(n = 100000, mean = 175, sd = 30)
ht100k <- rnorm(n = 100000, mean = 65, sd = 3)
```

Then, time the two adult BMI calculation methods.


```r
system.time(bmi <- (wt100k / ht100k ^ 2) * 703)
```

```
##    user  system elapsed 
##   0.001   0.000   0.002
```

```r
system.time(for (i in 1:length(wt100k)) bmi[i] <- (wt100k[i] / ht100k[i] ^ 2) * 703)
```

```
##    user  system elapsed 
##   0.213   0.012   0.224
```

Clearly, the loop approach takes longer to run than the vectorized approach.

## Vectorized operations with data frames

We can also perform this operation on columns of a data frame to produce a new
column.


```r
# Add a new column for adult BMI calculated from the weight and height columns
df$bmi <- (df$weight / df$height ^ 2) * 703
df
```

```
##   id height weight      bmi
## 1  A   68.1  159.2 24.13260
## 2  B   69.4  162.3 23.68945
## 3  C   71.2  203.5 28.22018
## 4  D   68.9  181.3 26.84817
```

We performed the same BMI calculation as before, but this time on the columns 
of a data frame, adding a new column for the BMI.

## Storing and loading data

While we have seen how to create data objects using the assignment operator, 
`<-`, these objects only reside is our computer's volatile memory. Much of the
time, this is all we need to do in order to perform calculations on our data.

Sometimes we want to store our data on our disk drive or our network for long-term
storage or for sharing with collaborators. We can do this by saving the data as
a file using the `save()` function.


```r
save(df, file="df.rda")
```

You can read a data file and load it's contents in memory with `load()`.


```r
load("df.rda")
df
```

```
##   id height weight      bmi
## 1  A   68.1  159.2 24.13260
## 2  B   69.4  162.3 23.68945
## 3  C   71.2  203.5 28.22018
## 4  D   68.9  181.3 26.84817
```

## Removing data

You can remove a data object from your working (volatile) memory with `rm()`.


```r
rm(df)
```

You can remove a file with `unlink()`.


```r
unlink("df.rda")
```

## What is unusual about R

Compared to other popular computer languages, R has some quirks.

**_Assignment_**

* R's assignment operator is `<-` not `=` (though `=` will usually work anyway)
* But most R users still seem to prefer `<-`
* Except within a function call, where you would use `=`

**_The Period:_**

* The `.` is often used to separate words in a variable name
* Many other languages use the `.` to refer to the properties of a variable

**_Vectors:_**

* A set of values of the same type is called a "vector" (not an "array", etc.)
* Many common functions and operators work directly on vectors ("vectorized")

**_Usage:_**

* R is often used for interactive data analysis at a command prompt

## The R Language (Some Jargon)

R is a language of **_objects_**. Everything in R is an object. Even functions,
operators, and and variable names are objects. R is an *object oriented language*.

What does this mean?

* You compose R commands as **_expressions_** of R objects.
* Some of those objects are **_functions_** which perform **_operations_**.
* Functions operate on other objects, such as **_data objects_**.
* Feeding objects to a function is called **_calling_** a function.
* You feed the objects to functions as **_arguments_**.
* Based on the arguments you provide, the function will perform operations.
* The operations will **_return_** results which returned as objects.
* You can then use these returned objects for further operations.

So, in R you write expressions composed of function calls which perform 
operations on objects. Even the mathematical **_operators_** are actually functions.

## What's an object?

An object is:

* an instance of a "class"
* data (attributes)
* functions (methods)

Analogy:

* "my car" is in instance of class "car" or even the class "Toyota Echo"
* it's size, weight, color, etc. are attributes it's attributes
* my car can go can start, go forward, backward, stop, etc. (it's functions)

Example:

* the data frame "df" is an instance of the class "data.frame"
* attributes are row names, column names, dimensions, and data values
* methods are summary, subset, rownames, print, plot, etc.

## What's an object?

Example:


```r
A <- data.frame(runif(10))
class(A)
```

```
## [1] "data.frame"
```

```r
attributes(A)
```

```
## $names
## [1] "runif.10."
## 
## $row.names
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $class
## [1] "data.frame"
```

```r
methods(class=class(A))
```

```
##  [1] aggregate     anyDuplicated as.data.frame as.list       as.matrix    
##  [6] by            cbind         coerce        [<-           [            
## [11] [[<-          [[            $<-           $             dim          
## [16] dimnames<-    dimnames      droplevels    duplicated    edit         
## [21] format        formula       head          initialize    is.na        
## [26] Math          merge         na.exclude    na.omit       Ops          
## [31] plot          print         prompt        rbind         row.names<-  
## [36] row.names     rowsum        show          slotsFromS3   split<-      
## [41] split         stack         str           subset        summary      
## [46] Summary       tail          t             transform     unique       
## [51] unstack       within       
## see '?methods' for accessing help and source code
```

##


<pre style="color: indigo; background: linear-gradient(to right, gold, rgba(255,0,0,0)); padding-top: 50px; padding-bottom: 50px;">
                                                                                        
                                                  ,,                                    
  .g8""8q.                                 mm     db                           ,M"""b.  
.dP'    `YM.                               MM                                  89'  `Mg 
dM'      `MM `7MM  `7MM  .gP"Ya  ,pP"Ybd mmMMmm `7MM  ,pW"Wq.`7MMpMMMb.  ,pP"Ybd    ,M9 
MM        MM   MM    MM ,M'   Yb 8I   `"   MM     MM 6W'   `Wb MM    MM  8I   `" mMMY'  
MM.      ,MP   MM    MM 8M"""""" `YMMMa.   MM     MM 8M     M8 MM    MM  `YMMMa. MM     
`Mb.    ,dP'   MM    MM YM.    , L.   I8   MM     MM YA.   ,A9 MM    MM  L.   I8 ,,     
  `"bmmd"'     `Mbod"YML.`Mbmmd' M9mmmP'   `Mbmo.JMML.`Ybmd9'.JMML  JMML.M9mmmP' db     
      MMb                                                                               
       `bood'
</pre>
<!-- http://patorjk.com/software/taag/#p=display&f=Georgia11&t=Questions%3F%0A -->
