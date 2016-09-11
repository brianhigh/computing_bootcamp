# ----------------------------------------------------------------------------
# Malaria prevalence per year by world region and subregion
# 
# Last updated by Brian High (https://github.com/brianhigh) on Sept. 11, 2016
# License: CC0 1.0 Universal https://creativecommons.org/publicdomain/zero/1.0/
# ----------------------------------------------------------------------------
# Clear workspace
rm(list=ls())
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Load Packages
# ----------------------------------------------------------------------------
# Load one or more packages into memory, installing as needed.
# https://github.com/brianhigh/imp ; License: Public Domain (CC0 1.0)
load.pkgs <- function(pkgs, repos = 'http://cran.r-project.org') {
    is.installed <- function(x) x %in% installed.packages()[,"Package"]
    inst.cran <- function(x) install.packages(x, quiet = TRUE, repos = repos)
    result <- sapply(pkgs, function(x) { 
        if (! is.installed(x)) inst.cran(x)
        library(x, character.only = TRUE)
    })
}

pkgs <- c("dplyr", "ggplot2", "WDI")
load.pkgs(pkgs)
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Getting Data
# ----------------------------------------------------------------------------
data.folder <- 'data'
dir.create(data.folder, showWarnings = FALSE)

iso2c.file <- file.path(data.folder, 'iso2c.csv')

# Only download the file if it does not already exist
if (! file.exists(iso2c.file)) {
    # Split URL into several variables so the line doesn't wrap :p
    site <- 'https://raw.githubusercontent.com'
    repo <- 'lukes/ISO-3166-Countries-with-Regional-Codes'
    file <- 'master/all/all.csv'
    method <- ifelse(.Platform$OS.type == 'windows', 'wininet', 'curl')
    download.file(paste(site, repo, file, sep='/'), iso2c.file, method)
}

codes <- read.csv(iso2c.file, header=TRUE, stringsAsFactors = FALSE) %>%
    select(country = name, iso2c = alpha.2, region, sub.region)

start.yr <- 2004
end.yr <- 2014

sub.title <- paste(start.yr, '-', end.yr, '(Source: World Bank)')

pop.file <- file.path(data.folder, 'pop_wdi.csv')

# Only create the file if it does not already exist
if (! file.exists(pop.file)) {
    Pop <- WDI(indicator='SP.POP.TOTL', start = start.yr, end = end.yr)
    write.csv(Pop, pop.file, row.names = FALSE)
}

Pop <- read.csv(pop.file, stringsAsFactors = FALSE)

malaria.file <- file.path(data.folder, 'malaria_wdi.csv')

# Only create the file if it does not already exist
if (! file.exists(malaria.file)) {
    Malaria <- WDI(indicator='SH.STA.MALR', start = start.yr, end = end.yr)
    write.csv(Malaria, malaria.file, row.names = FALSE)
}

Malaria <- read.csv(malaria.file, stringsAsFactors = FALSE)
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Data Munging
# ----------------------------------------------------------------------------

#--------------
# Join datasets
#--------------
Malaria <- Malaria %>% na.omit()
Malaria <- inner_join(Malaria, codes, by = c("country", "iso2c"))
Malaria <- inner_join(Malaria, Pop, by = c("country", "iso2c", "year"))

# --------------------
# Prevalence
# --------------------
MalariaPrev <- Malaria %>% na.omit() %>% group_by(year) %>%
    summarize(cases = sum(SH.STA.MALR), pop = sum(SP.POP.TOTL)) %>% 
    mutate(prevalance.per.100k = 100000 * cases/pop) %>%
    mutate(log.prevalance.per.100k = log(prevalance.per.100k)) %>% 
    arrange(year)

# --------------------
# Prevalence by Region
# --------------------
MalariaReg <- Malaria %>% na.omit() %>% group_by(region, year) %>%
    summarize(cases = sum(SH.STA.MALR), pop = sum(SP.POP.TOTL)) %>% 
    mutate(prevalance.per.100k = 100000 * cases/pop) %>%
    mutate(log.prevalance.per.100k = log(prevalance.per.100k)) %>% 
    arrange(region, year)

# -----------------------
# Prevalence by Subregion
# -----------------------
MalariaSubReg <- Malaria %>% na.omit() %>% 
    group_by(region, sub.region, year) %>%
    summarize(cases = sum(SH.STA.MALR), pop = sum(SP.POP.TOTL)) %>% 
    mutate(prevalance.per.100k = 100000 * cases/pop) %>%
    mutate(log.prevalance.per.100k = log(prevalance.per.100k)) %>% 
    arrange(region, sub.region, year)
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Analysis and Visualization
# ----------------------------------------------------------------------------

# ----------
# Prevalence
# ----------

m <- ggplot(MalariaPrev, aes(x = year, y = prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
m

summary(lm(log.prevalance.per.100k ~ year, MalariaPrev))

m <- ggplot(MalariaPrev, aes(x = year, y = log.prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
m

# --------------------
# Prevalence by Region
# --------------------

summary(lm(log.prevalance.per.100k ~ region, MalariaReg))

mr0 <- ggplot(MalariaReg, aes(x = year, y = log.prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm")+ theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
mr0

mr <- ggplot(data=MalariaReg, aes(x=year, y=log.prevalance.per.100k,
                                  group=region, color=region)) + 
    geom_point(size=I(0.5)) + geom_smooth(method="lm") + 
    ggtitle(paste('World Malaria Prevalence by Region', sub.title, sep='\n')) + 
    theme_grey(base_size = 10)
mr

# -----------------------
# Prevalence by Subregion
# -----------------------

summary(lm(log.prevalance.per.100k ~ sub.region, MalariaSubReg))

ms0 <- ggplot(MalariaSubReg, aes(x = year, y = log.prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
ms0

ms <- ggplot(data=MalariaSubReg, aes(x=year, y=log.prevalance.per.100k,
                                     group=sub.region, color=sub.region)) + 
    geom_point(size=I(0.5)) + facet_grid(region~., scale="free") +
    geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence by Subregion', sub.title, sep='\n'))
ms