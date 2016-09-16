# Big Data in R
Brian High  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



## Learning Objectives

You will learn:

* The problems presented by Big Data in R
* Solutions to those problems when using R
 
## Big Data in R

When you import a data file, using something like `read.table()`, R will try 
to load the entire file into your computer's memory (RAM). 

This is one example of a "Big Data" problem.

Let's say that you have a computer with one gigabyte (1 GB) of RAM. You 
have downloaded the CDC [BRFSS 2014](http://www.cdc.gov/brfss/annual_data/annual_2014.html) 
survey data file.

The ZIP file is only 69 MB. When unzipped the file is 203 MB. When imported
into a data frame, R allocates 976 MB to that data frame. For a computer with 
only 1 GB of available RAM, there is little left over after the import.

R consumed an amount of memory over 14 times the storage space consumed by the
original file as it was downloaded.

If you do not have enough available RAM, then you will have to try something 
else.

And this was _survey_ data. Imagine if you work with _genomics_ data where a 
data file for one sample is several gigabytes!

## Solutions to Big Data Problems

Here are the most common solutions to Big Data problems in R:

* **Sampling**: Use only a smaller, but representative portion of your data
* **Chunking**: Work on subsets of data then combine the results later
* **Hardware**: Use a server (cluster), install more memory, etc.
* **Packages**: Use packages offering more efficient data objects and operations
* **Storage**: Store data objects on hard disk (or databases) instead of memory
* **Language**: Use a more efficient language for some of the processing
* **Interpreter**: Use an alternative R interpreter which is optimized for Big Data

## Sampling and Chunking

While a statistician will naturally think of sampling from a large data set to
create a smaller, more manageable one, they will face a problem. If they use 
R, and R needs to read in all of the data before it can subset it, they face 
the RAM limitation before they are able to work around it. This is a "Catch 22".

Usually the first solution that people try is to **work with smaller chunks** and
combine the results. This is an intuitive solution and does not require knowledge
of other technologies or access to other systems. It is also the most tedious. A 
benefit is that sometimes the chunks can be processed in parallel (to some degree).

## Hardware

You could try **adding more RAM** to your workstation or laptop, but that will only
work for slightly larger data sets. For genomics or large simulations, you will
quickly exceed the maximum capacity of most workstations and laptops. This may 
fine for you if your data files are only a couple of gigabytes in size.

## Use a Server

The easiest solution may be to **use a server**, accessing it remotely. You will 
need to know how to access it, transfer data to and from it, adjust to it's 
environment (like it's operating system), etc. Most people adapt quickly as
learning how to access a remote server is far easier than learning how to code.

A server will often have much more RAM and CPUs that your own workstation and 
may also have larger and faster storage capabilities. To use the extra CPUs, 
you will need to parallelize your R.

See:

* [A gentle introduction to parallel computing in R](http://www.win-vector.com/blog/2016/01/parallel-computing-in-r/)
* [How-to go parallel in R – basics + tips](https://www.r-bloggers.com/how-to-go-parallel-in-r-basics-tips/)
* [The Benefits of Multithreaded Performance with Microsoft R Open ](https://mran.microsoft.com/documents/rro/multithread/)

## High-Performance R Packages

A few R projects are devoted to producing new replacements for standard R 
data objects (data frame) and operations (subsetting,reading files, etc.)

* **data.table**
* **dplyr**, **dtplyr**, and **tibble**
* **sqldf**

The packages offer new syntax as well. While some projects focus on intuitive
but verbose syntax, others encourage arcane but concise code.

The performance enhancements vary greatly depending on the operation, so 
benchmarking your particular use case is essential to choosing the top performer 
for you.

```
We optimise dplyr for expressiveness on medium data; feel free to use 
data.table for raw speed on bigger data

     -- @hadleywickham, chief scientist at RStudio
        http://stackoverflow.com/questions/21435339/
```

In practice, people seem to pick their favorite tools and stick with them.

## Storage

You can also use **special file formats** or **databases** to store your data in 
a more efficient manner, allowing you to access that data from R instead of 
loading it all into RAM. We will look more at databases in a later module.

Some special file formats, such as Feather, XDF, HDF5, and netCDF allow you to 
use the file in a way similar to an in-memory data frame. This provides some of 
the benefits of databases without the administrative overhead. The downside is 
you may have to use special functions or even a commercial version or R.

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
