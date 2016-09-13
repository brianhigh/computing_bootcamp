# Modular Programming
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  





## Learning Objectives

You will learn:

* How to modularize your code
* How to write functions in R
* How to create your own R packages
* How to create package documentation
* How to share your own R packages on Github
* How to install packages from Github

## Example: Adult BMI Calculation

![*Source*: CDC [About Adult BMI](https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html)
](images/aboutBMI.png)

## Example: Adult BMI Calculator

![*Source*: CDC [Adult BMI Calculator](https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/english_bmi_calculator/bmi_calculator.html)
](images/adultBMI_calculator.png)

We will be implementing this calculator in R as a `function`.

## User-defined functions

We can store an [BMI calculation for adults](https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html) 
in a `function`, which is an R object which can perform a series of operations upon data.


```r
adultBMI <- function(wt.lb, ht.in) { (wt.lb / ht.in ^ 2) * 703 }
```

Now we can use our function to perform this calculation whenever we need to.


```r
weight <- c(159.2, 162.3, 203.5, 181.3)     # Weight in pounds
height <- c(68.1, 69.4, 71.2, 68.9)         # Height in inches
adultBMI(weight, height)
```

```
## [1] 24.13260 23.68945 28.22018 26.84817
```

By placing commonly-used code in functions, we make our programs more modular,
allowing for code reuse and cleaner, clearer, more maintainable code.

Taking this a step further, we can also create our own *packages* to store and
share functions, documentation, and example data.

This approach is called *modular programming*.

## Creating Packages

It is not difficult to create our own packages and to share them. Here is the 
absolute minimum of steps needed to create a very "bare bones" package.


```r
# Create the package name from the system username to minimize conflicts
pkg.name <- paste(Sys.info()['user'], '.', 'bmi', sep = '')

# Create the "bmi" package folder and the "R" subfolder
dir.create(file.path(pkg.name, 'R'), showWarnings = FALSE, recursive = TRUE)

# Create an R script containing just the function definition
sink(file.path(pkg.name, 'R', 'adultBMI.R'))
cat('adultBMI <- function(wt.lb, ht.in) { (wt.lb / ht.in ^ 2) * 703 }', sep = '\n')
sink()

sink(file.path(pkg.name, 'DESCRIPTION'))    # Create a DESCRIPTION text file
cat(paste('Package:', pkg.name), sep = '\n')
cat('Version: 0.1', sep = '\n', append = TRUE)
sink()

sink(file.path(pkg.name, 'NAMESPACE'))      # Create a NAMESPACE text file
cat('export(adultBMI)', sep = '\n')
sink()

library(devtools)
build(pkg.name, quiet = TRUE)               # Build the package (as a tarball)
```

## Creating Packages

We can install the *bmi* package we just built and verify that it installed.


```r
install(pkg.name)                     # Install the package
unlink(pkg.name, recursive = TRUE)    # Remove the temporary build folder
packageDescription(pkg.name)          # View package description to confirm
```

If we see a listing of the package description, then the package has been 
installed okay. Now we can load the package and use the function it contains.


```r
library(pkg.name, character.only = TRUE)
adultBMI(150, 65)                     # Expected result:  24.95858
```

If we get the expected result then the package works okay.

Now we can unload the package and uninstall it.


```r
detach(pos=grep(pkg.name, search()), unload = TRUE)
remove.packages(pkg.name)             # Remove package when done with example
```

## Creating Packages

Next, we will expand on our BMI example by adding documentation (help files) to 
provide a more complete picture of this process.

## Creating Packages with Documentation

We will be using some additional packages to make the task of generating 
the package files and documentation easier.

First, install the packages if you don't already have them.


```r
install.packages(c("devtools", "roxygen2", "knitr"))
```

Then load the packages.


```r
library("devtools")
library("roxygen2")
library("knitr")
```

## Create the Package Directory

We will construct our package name from our user name as before.


```r
# Create the package name from the system username to minimize conflicts
pkg.name <- paste(Sys.info()['user'], '.', 'bmi', sep = '')
```

Then we remove the temporary build folder, if it exists from our previous work.


```r
# Remove the build folder if it exists
unlink(pkg.name, recursive = TRUE)    # Remove the temporary build folder
```

Then we use the `create()` function to create the package directory and
file templates.


```r
# Create the package directory and file templates
create(pkg.name)
```

## Create Custom DESCRIPTION File

While the `create()` has already created a DESCRIPTION file, we will replace it
with our own custom version. This could be done manually with a text editor.


```r
description <- 
"Title: BMI Calculator
Description: Calculates the Body Mass Index (BMI).
Author: Your Name Here <your.name@example.com>
Maintainer: Your Name Here <your.name@example.com>
Depends: R (>= 3.3.1)
License: MIT
Encoding: UTF-8
LazyData: true
"

sink(file.path(pkg.name, 'DESCRIPTION'))
cat(paste('Package:', pkg.name), sep = '\n')
cat('Version: 0.2', sep = '\n', append = TRUE)    # Update the version number!
cat(paste('Date:', format(Sys.time(), "%Y-%m-%d")), sep = '\n', append = TRUE)
cat(description)
sink()
```

## Create R Function Files

With the *roxygen2* package, we can embed documention in our R script using
the `#'` notation.

Again, we could do this manually, but have scripted it here for reproducibility.


```r
my.function <- 
"#' Adult BMI Calculator
#'
#' Calculates the adult BMI given weight in pounds and height in inches.
#' See: https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html.
#' @param wt.lbs Weight in pounds
#' @param ht.in Height in inches
#' @keywords bmi
#' @export
#' @examples
#' adultBMI(150, 65)                  # Expected result:  24.95858 

adultBMI <- function(wt.lb, ht.in) { (wt.lb / ht.in ^ 2) * 703 }
"

sink(file.path(pkg.name, 'R', 'adultBMI.R'))
cat(my.function)
sink()
```

## Generate Documentation

The `document()` function will create the `man/adultBMI.Rd` file, which is used
in the R help system to display the `help()` and `example()` results.


```r
setwd(pkg.name)
document()
setwd('..')
```

## Install Package and Test Help

We install the package using `install()` and load with `library()` as before.


```r
install(pkg.name)
library(pkg.name, character.only = TRUE)
```

Now that we have documentation, we can test them with `help()` and `example()`.


```r
help(adultBMI)
example(adultBMI)
```

## Send the Package to Github

If you have a Github account and have already created a repository (repo) for 
this package, you can send the package to the repo for others to use.

Here are commands to type at the Bash prompt to send a package to
Github.


```bash
cd high.bmi
git init
echo 'high.bmi.Rproj' >> .gitignore
git add .
git commit -m 'First commit'
git remote add origin https://github.com/brianhigh/high.bmi.git
git push -u origin master
cd ..
```

Of course, you would replace `high.bmi` with your own package name and 
`brianhigh` with your own Github account name.

Note: The repository name must match the package name.

## Installing the Package from Github

Now anyone with access to your Github repo can install your package.


```r
library("devtools")
install_github('brianhigh/high.bmi')
library(high.bmi)
```

## Publishing your Package on CRAN

Sites like [CRAN](https://cran.r-project.org/) and [Bioconductor](https://www.bioconductor.org) 
are the "big time". You will need to do additional work to include your package 
in those repositories. 

We don't have time to cover that topic today, so we will point you in the
direction of some helpful resources:

* [Releasing a package](http://r-pkgs.had.co.nz/release.html) by Hadley Wickham
* [Getting your R package on CRAN](http://kbroman.org/pkg_primer/pages/cran.html) by Karl Broman
* [Developing R packages](https://github.com/jtleek/rpackages) by Jeff Leek
* [Bioconductor Package Submission](https://www.bioconductor.org/developers/package-submission/)

## Unload and Remove Package

Now that we are done with the package example, we can remove the build folder
and the package from our system.


```r
detach(pos=grep(pkg.name, search()), unload = TRUE)
remove.packages(pkg.name)             # Remove package when done with example
unlink(pkg.name, recursive = TRUE)    # Remove the temporary build folder
```

## Exercise #1

Modify the `adultBMI` function for calculating the BMI to allow metric weights 
and heights. Modify the *bmi* package to use this new version of the function.


```r
# Function:
adultBMI <- function(weight, height, metric = FALSE) {
    (weight / height ^ 2) * ifelse(metric == FALSE, 703, 1)
}

# Examples:
adultBMI(150, 65)                     # Expected result:  24.95858
```

```
## [1] 24.95858
```

```r
adultBMI(68, 1.65, metric = TRUE)     # Expected result:  24.97704
```

```
## [1] 24.97704
```

Include documentation for the `help()` and `example()` functions.

## Exercise #2

Add another function to the *bmi* package. Include documentation for the 
`help()` and `example()` functions.


```r
# Function: Categorize adult BMI values according to the CDC's levels.
# See: https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html
catAdultBMI <- function(adult.bmi) { 
    cut(x = adult.bmi, 
        breaks = c(0, 18.5, 25, 30, Inf), 
        right = FALSE,
        labels = c('Underweight', 'Normal', 'Overweight', 'Obese'), 
        ordered_result = TRUE)
}

# Example:
catAdultBMI(c(20.8, 17.0, 18.5, 31.9, 25.0, 33.6))
```

```
## [1] Normal      Underweight Normal      Obese       Overweight  Obese      
## Levels: Underweight < Normal < Overweight < Obese
```

What other functions might be useful?

## Exercise #3

Data often include strings, and these strings often contain extra whitespace. 
Leading and trailing whitespace is a common cause of errors, as it is hard to
detect visually.

Create a package called *trimmer* which provides three functions to trim 
whitespace or other characters from the beginning and ending of text strings.


```r
ltrim <- function(x, pattern = '^[[:space:]]+') sub(pattern, '', x)
rtrim <- function(x, pattern = '[[:space:]]+$') sub(pattern, '', x)
trim <- function(x) ltrim(rtrim(x))
```

Include documentation for each function including *Description*, *Usage*, 
*Arguments*, *Value*, *Details*, *See Also*, and *Examples* sections. The 
*See Also* section should refer to the `trimws()` function of the *base* 
package. The *Details* section should briefly explain how the functions in 
this package differs from the `trimws()` function with respect to the types 
of characters which are removed. Karl Broman's [Writing documentation with Roxygen2](http://kbroman.org/pkg_primer/pages/docs.html) may serve as a guide.

Post this package on Github and include `README.md` and `LICENSE` files in the
package repository.

NOTE: The *stringr* and *stringi* packages also contain string trimming
functions.

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
