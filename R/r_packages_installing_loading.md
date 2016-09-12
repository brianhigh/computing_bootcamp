# R Packages: Installing and Loading
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## Learning Objectives

You will learn:

* What packages are
* What a "library" is
* How to view your libraries
* How to install a package
* How to upgrade a package
* How to upgrade all of your packages
* How to load a package into memory
* How to unload a package
* How to uninstall a package

## Packages

* Collections of code (functions), data (for examples), and documentation
* Bundled together to make for easier management
* Designed to be managed with a common set of utilities
* Almost 10,000 packages on [CRAN](https://cran.r-project.org/web/packages/)
* Most packages are written by statisticians (for better or worse)
* Most popular packages are very well documented
* In other language, a "package" is called a "module", "class", or "library"

## R Package Libraries

In R, a "library" is a collection of packages. You use the `library()`
function to load a package from a library on disk into working memory (RAM).

A library is stored as a folder structure on your disk (or the network, etc.).

Site libraries are for packages that all users of your system can access, while
only you can access your personal libraries.

You can install packages to your personal library, but you may not be able to
install packages to site libraries, depending on the permissions settings 
("rights") on your system.

## Viewing your Libraries

If you type the command `library()` at the prompt and press *Enter*, you will
see a list of all of your libraries and their installed packages.

They will be organized by which parent folder the packages reside in. There 
are one or more "site" libraries and one or more "personal" libraries.

To see the parent folders designated as libraries for your session, use the 
`.libPaths()` command.

## Installing Packages

You can install packages with `install.packages()` usually*. Your R session will
keep track of you favorite package "repository" for you, or you can specify it.
If you don't, R will prompt you to pick from a list. When installing packages, 
R will try to install to a site library, but will fall back to a personal
library if it can't write to the site library.


```r
install.packages("foo")
install.packages(c("foo", "bar"))
install.packages(c("foo", "bar"), repos = "http://cran.r-project.org")
```

Note that the package name(s) must be quoted. If more that one is supplied, then
you must supply a "vector" of package names. If your package names are stored 
as a variable, then you may supply that variable name instead. The varable name 
is not quoted.


```r
my.packages <- c('fi', 'fi', 'fo', 'fum')
install.packages(my.packages)
```

`*` For packages from the Bioconductor project (for bio-informatics), there is 
[another method](https://www.bioconductor.org/install/) to install packages. 

## Upgrading Packages

You can upgrade (update) the package *foo* by running this command:


```r
update.packages("foo")
```

You can upgrade all of your packages with:


```r
update.packages()
```

To update without any prompting and for all suggested dependencies, try:


```r
update.packages(ask = FALSE, dependencies = c('Suggests'))
```

## Load a package into memory

Before you can use a package, you need to load it into memory (RAM). I.e.:


```r
library(foo)
```

Unlike, `install.packages` and `update.packages`:

* only one package name is allowed
* the package name is not quoted
    - unless you use `character.only=TRUE` (rare: a lot of extra typing!)
    - example: `library("foo", character.only=TRUE)`

There is a similar command called `require()` that is meant to be used inside
of functions. Most of the time, you will use `library()` instead.

You can unload a package with `detach`, as in `detach(foo)`.

The see the list of currently loaded packages, type `(.packages())` and include
all of those parenthesis.

## Uninstall a package

To uninstall (remove) package *foo*, you simply run:


```r
remove.packages("foo")
```

You can also supply an additional argument for the library path to remove from.

Otherwise, packages will be removed from the first library listed with `.libPaths()`.

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
