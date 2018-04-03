# ----------------------------------------------------------------------------
# Malaria prevalence per year by world region and subregion
# 
# Last updated by Brian High (https://github.com/brianhigh) on Apr. 02, 2018
# License: CC0 1.0 Universal https://creativecommons.org/publicdomain/zero/1.0/
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Setup
# ----------------------------------------------------------------------------

# -------------------
# Clear the Workspace
# -------------------
rm(list=ls())

# -------------
# Load Packages
# -------------

# Load pacman into memory, installing as needed
my_repo <- 'http://cran.r-project.org'
if (!require("pacman")) {install.packages("pacman", repos = my_repo)}

# Load the other packages, installing as needed
pacman::p_load(dplyr, ggplot2, WDI, grid, gridExtra)

# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Getting Data
# ----------------------------------------------------------------------------

# Create data folder (if needed)
data.folder <- 'data'
dir.create(data.folder, showWarnings = FALSE)

# Only download the file if it does not already exist
iso2c.file <- file.path(data.folder, 'iso2c.csv')
if (! file.exists(iso2c.file)) {
    # Split URL into several variables so the line doesn't wrap :p
    site <- 'https://raw.githubusercontent.com'
    repo <- 'lukes/ISO-3166-Countries-with-Regional-Codes'
    file <- 'master/all/all.csv'
    method <- ifelse(.Platform$OS.type == 'windows', 'wininet', 'curl')
    download.file(paste(site, repo, file, sep='/'), iso2c.file, method)
}

# Read the country codes file
codes <- read.csv(iso2c.file, header=TRUE, stringsAsFactors = FALSE) %>%
    select(country = name, iso2c = alpha.2, region, sub.region)

# Configure start and end years and set the subtitle for the plot
start.yr <- 2004
end.yr <- 2014
sub.title <- paste(start.yr, '-', end.yr, '(Source: World Bank)')

# Only create the population file if it does not already exist
pop.file <- file.path(data.folder, 'pop_wdi.csv')
if (! file.exists(pop.file)) {
    Pop <- WDI(indicator='SP.POP.TOTL', start = start.yr, end = end.yr)
    write.csv(Pop, pop.file, row.names = FALSE)
}

# Read population file
Pop <- read.csv(pop.file, stringsAsFactors = FALSE)

# Only create the Malaria file if it does not already exist
malaria.file <- file.path(data.folder, 'malaria_wdi.csv')
if (! file.exists(malaria.file)) {
    Malaria <- WDI(indicator='SH.STA.MALR', start = start.yr, end = end.yr)
    write.csv(Malaria, malaria.file, row.names = FALSE)
}

# Read Malaria file
Malaria <- read.csv(malaria.file, stringsAsFactors = FALSE)

# Join datasets
Malaria <- Malaria %>% na.omit()
Malaria <- inner_join(Malaria, codes, by = c("country", "iso2c"))
Malaria <- inner_join(Malaria, Pop, by = c("country", "iso2c", "year"))
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Analysis and Visualization
# ----------------------------------------------------------------------------

# ----------
# Prevalence
# ----------

# Calculate prevalence
MalariaPrev <- Malaria %>% na.omit() %>% group_by(year) %>%
    summarize(cases = sum(SH.STA.MALR), pop = sum(SP.POP.TOTL)) %>% 
    mutate(prevalance.per.100k = 100000 * cases/pop) %>%
    mutate(log.prevalance.per.100k = log(prevalance.per.100k)) %>% 
    arrange(year)

# Plot global Malaria prevalance
m <- ggplot(MalariaPrev, aes(x = year, y = prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
m

# Check fit of linear model
summary(lm(log.prevalance.per.100k ~ year, MalariaPrev))

# Plot global Malaria log prevalance with a linear model smoother
m <- ggplot(MalariaPrev, aes(x = year, y = log.prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
m

# --------------------
# Prevalence by Region
# --------------------

# Calculate prevalence by Region
MalariaReg <- Malaria %>% na.omit() %>% group_by(region, year) %>%
    summarize(cases = sum(SH.STA.MALR), pop = sum(SP.POP.TOTL)) %>% 
    mutate(prevalance.per.100k = 100000 * cases/pop) %>%
    mutate(log.prevalance.per.100k = log(prevalance.per.100k)) %>% 
    arrange(region, year)

# Check fit of linear model
summary(lm(log.prevalance.per.100k ~ region, MalariaReg))

# Plot all subregions on a single plot with a linear model smoother
mr0 <- ggplot(MalariaReg, aes(x = year, y = log.prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm")+ theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
mr0

# Facet by region
mr <- ggplot(data=MalariaReg, aes(x=year, y=log.prevalance.per.100k,
                                  group=region, color=region)) + 
    geom_point(size=I(0.5)) + geom_smooth(method="lm") + 
    ggtitle(paste('World Malaria Prevalence by Region', sub.title, sep='\n')) + 
    theme_grey(base_size = 10)
mr

# -----------------------
# Prevalence by Subregion
# -----------------------

# Calculate prevalence by Subregion
MalariaSubReg <- Malaria %>% na.omit() %>% 
    group_by(region, sub.region, year) %>%
    summarize(cases = sum(SH.STA.MALR), pop = sum(SP.POP.TOTL)) %>% 
    mutate(prevalance.per.100k = 100000 * cases/pop) %>%
    mutate(log.prevalance.per.100k = log(prevalance.per.100k)) %>% 
    arrange(region, sub.region, year)

# Check fit of linear model
summary(lm(log.prevalance.per.100k ~ sub.region, MalariaSubReg))

# Plot all subregions on a single plot with a linear model smoother
ms0 <- ggplot(MalariaSubReg, aes(x = year, y = log.prevalance.per.100k)) + 
    geom_point() + geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence', sub.title, sep='\n'))
ms0

# Facet by subregion
ms <- ggplot(data=MalariaSubReg, aes(x=year, y=log.prevalance.per.100k,
                                     group=sub.region, color=sub.region)) + 
    geom_point(size=I(0.5)) + facet_grid(region~., scale="free") +
    geom_smooth(method="lm") + theme_grey(base_size = 10) +
    ggtitle(paste('World Malaria Prevalence by Subregion', sub.title, sep='\n'))
ms

# Move to a new plot frame to avoid overlap with previous plot
plot.new()

# Create separate plots for each region so that legends go with the facets
xs <- split(MalariaSubReg, f = MalariaSubReg$region)
p1 <- ggplot(xs$Africa, aes(x=year, y=log.prevalance.per.100k, 
                            group=sub.region, color=sub.region)) + 
      geom_point() + geom_smooth(method="lm") + 
      facet_wrap(~region, ncol=1) + 
      scale_x_continuous(breaks = c(2004, 2009, 2014))
p2 <- p1 %+% xs$Americas
p3 <- p1 %+% xs$Asia
p4 <- p1 %+% xs$Oceania

# Arrange plots on a grid with a single title row on top
pushViewport(viewport(layout = grid.layout(3, 2, heights = unit(c(1, 4, 4), 
                                                                "null"))))
title <- paste('World Malaria Prevalence by Subregion', sub.title)
grid.text(title, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
print(p1, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))
print(p3, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
print(p4, vp = viewport(layout.pos.row = 3, layout.pos.col = 2))
popViewport()