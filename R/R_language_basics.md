# R Language Basics
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## R Language Basics

### Learning objectives

You will learn:

* How to store, access and display data in R
* How to make comments in R code

## Accessing Data

If you just enter a value at the R command prompt, R will print out the value 
to your screen:


```r
68.1
```

```
## [1] 68.1
```

Or you can use the `print()` function instead (to be explicit about it):


```r
print('Mary')
```

```
## [1] "Mary"
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

This value will be stored in your computer's memory until for the duration of
the current session, or until it is modified or deleted by you or your code.

The `<-` operator is known as the assignment operator.

You can also use the `=` symbol for the assignment operator, but it is not 
as commonly used in R, except for argument assignment in function calls.

## Argument assignment with `=`

In this function call, we use the `=` operator to tell R that the expected 
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
value as the first (or only) argument to the function.


```r
print(number)
```

```
## [1] 68.1
```

Just remember: use `<-` for variable assignment and `=` for argument assignment 
within function calls.

## Vectors

By default, unless you specify otherwise, R will try to store your data in a 
vector. You can create a vector from a collection of data values using the 
`c()` (combine) function.


```r
name <- c('Mary', 'John', 'Fred', 'Sam')
height <- c(68.1, 69.4, 71.2, 68.9)
weight <- c(159.2, 162.3, 203.5, 181.3)
```

This is a collection of one or more individual values of the same data type. We 
can view the data type with the `typeof()` function.


```r
typeof(name)
```

```
## [1] "character"
```

In many other computer languages this data structure would be called an array 
or a list, but R uses those terms for other, mosre complex data structures.

We will explore R data objects in depth in a later module.

## Data frames

You can store a two dimensional matrix of data (a "table") as a data frame. This
is the most common way to work with data in R. A data frame is often constructed
from one or more vectors.


```r
df <- data.frame(name, height, weight)
df
```

```
##   name height weight
## 1 Mary   68.1  159.2
## 2 John   69.4  162.3
## 3 Fred   71.2  203.5
## 4  Sam   68.9  181.3
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

## Vectorized operations

R allows you to perform calculations on all items in a vector or all rows of a 
data frame at the same time. This is very convenient. Operations that allow this
are called *vectorized* operations.


```r
bmi <- (weight / height^2) * 703
bmi
```

```
## [1] 24.13260 23.68945 28.22018 26.84817
```

```r
df$bmi <- (df$weight / df$height^2) * 703
df
```

```
##   name height weight      bmi
## 1 Mary   68.1  159.2 24.13260
## 2 John   69.4  162.3 23.68945
## 3 Fred   71.2  203.5 28.22018
## 4  Sam   68.9  181.3 26.84817
```

First we created a vector by [calculating](https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html) 
the Body Mass Index (BMI) using two other vectors as input. Next, we performed 
the same calculation on the columns of a data frame, adding a new column for the BMI.

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
##   name height weight      bmi
## 1 Mary   68.1  159.2 24.13260
## 2 John   69.4  162.3 23.68945
## 3 Fred   71.2  203.5 28.22018
## 4  Sam   68.9  181.3 26.84817
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

Since programmers generally call it a "hash", we will keep with this tradition.
