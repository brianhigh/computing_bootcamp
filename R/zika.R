#:-----------------------------------------------------------------------------:
# Make a choropleth of "Zika Case Counts in the US by State".
# (Similar to this map: http://www.cdc.gov/zika/intheus/maps-zika-us.html)
#
# Last updated by Brian High (https://github.com/brianhigh) on Sept. 11, 2016
# License: CC0 1.0 Universal https://creativecommons.org/publicdomain/zero/1.0/
#:-----------------------------------------------------------------------------:

#:-----------------------------------------------------------------------------:
# Clear workspace and load packages
#:-----------------------------------------------------------------------------:

# Clear the workspace, unless you are running in knitr context.
if (!isTRUE(getOption('knitr.in.progress'))) {
    closeAllConnections()
    rm(list = ls())
}

# Load one or more packages into memory, installing as needed.
load.pkgs <- function(pkgs, repos = "http://cran.r-project.org") {
    result <- sapply(pkgs, function(pkg) { 
        if (!suppressWarnings(require(pkg, character.only = TRUE))) {
            install.packages(pkg, quiet = TRUE, repos = repos)
            library(pkg, character.only = TRUE)}})
}

# Create a vector of package names for the packages we will need.
pkgs <- c("dplyr", "tools", "scales", "png", 
          "ggthemes", "ggplot2", "gridExtra", "grid")

# Load the packages, installing as needed.
load.pkgs(pkgs)

#:-----------------------------------------------------------------------------:
# Create the data folder
#:-----------------------------------------------------------------------------:

# Create the data folder if it does not already exist.
data.dir <- "data"
dir.create(file.path(data.dir),
           showWarnings = FALSE,
           recursive = TRUE)

#:-----------------------------------------------------------------------------:
# Get the data
#:-----------------------------------------------------------------------------:

# Use cached data files, if present, or download as needed.
# Note: If you want the script to get all the data directly from the sources
#       on the web, just delete the "data" folder before running this script.
# Original data source is: http://www.cdc.gov/zika/geo/united-states.html
#zika.file <- 'cdc-state-case-counts-latest.csv'
zika.file <- 'cdc-state-case-counts-2016-08-31.csv'
data.file <- paste(data.dir, zika.file, sep = '/')
if (!file.exists(data.file)) {
    # Download the data.
    data.host <- 'https://raw.githubusercontent.com'
    data.repo <- 'BuzzFeedNews/zika-data'
    data.path <- 'master/data/parsed/cdc'
    data.url <- paste(data.host, data.repo, data.path, zika.file, sep = '/')
    if (!file.exists(data.file)) {
        download.file(data.url, data.file, mode = 'wb')
    }
}

# Read data file
zika <- read.table(data.file, sep = ',', header = TRUE)

#:-----------------------------------------------------------------------------:
# Prepare the data for plotting
#:-----------------------------------------------------------------------------:

# Convert state names to lower case, add case types to get total cases
region <- gsub("[^a-z ]", "", tolower(zika$state_or_territory))
cases <- zika$travel_associated_cases + zika$locally_acquired_cases
df <- data.frame(region, cases, row.names=NULL)

# Get map data
states_map <- map_data("state")

# Extract state  names and find center point of each state
cnames <-aggregate(cbind(long, lat) ~ region, 
                   data = states_map, 
                   FUN = function(x) mean(range(x)))
cnames$angle <- 0

# Combine state data with zika data
df <- merge(x = df, y = cnames, by = "region", all.x = TRUE)

#:-----------------------------------------------------------------------------:
# Create the choropleth map
#:-----------------------------------------------------------------------------:

plot_title <- paste('Zika Case Counts in the US by State', '\n', 
                    'January 01, 2015 – August 31, 2016', sep='')

# Create the choropleth map with ggplot
us <- ggplot(df, aes(map_id=region)) + geom_map(aes(fill=cases), map=states_map) + 
    coord_map(projection = "polyconic") + ggtitle(plot_title) +
    expand_limits(x = states_map$long, y = states_map$lat) + theme_map() +
    theme(plot.title = element_text(hjust = 0.5),  
          legend.justification = "center", legend.position="bottom") +
    scale_fill_continuous(limits=c(0, 100), 
                          low = "lightcyan", high = "royalblue", oob=squish) +
    geom_text(data=df[complete.cases(df$long),], 
              aes(long, lat, label = cases, angle=angle), size=2.5)

#:-----------------------------------------------------------------------------:
# Add a table and footer to the plot
#:-----------------------------------------------------------------------------:

# Create a table of states (regions) not mapped
not_mapped <- df[! df$region %in% unique(states_map$region), ]
not_mapped %<>% select(region, cases) %>% 
    arrange(cases) %>% mutate(region=toTitleCase(as.character(region))) %>% 
    mutate(region=gsub("^Us ", "US ", region)) %>% t
row.names(not_mapped) <- NULL

# Create a graphical object (grob) for this table
table_not_mapped <- tableGrob(not_mapped, 
                              theme = ttheme_default(base_size = 8))

# Create a graphical object (grob) for the citation text
source_text <- paste("Source: Case Counts in the US", "CDC", 
                     "http://www.cdc.gov/zika/geo/united-states.html",
                     sep=", ")
source_text_grob <- textGrob(source_text, x=0, hjust=-0.2, vjust=0.2, 
                             gp=gpar(fontface = "italic", fontsize = 8))

# Combine plot elements (map, table, source text) into a "grid"
g <- arrangeGrob(us, heights=c(8, 1), sub=table_not_mapped, 
                 bottom = source_text_grob)

# View the plot
#grid::grid.draw(g)

#:-----------------------------------------------------------------------------:
# Save the plot to a file and view it
#:-----------------------------------------------------------------------------:

# Save the plot to a PNG file
plot.file <- "zikaplot.png"
ggsave(plot.file, g, width=5.5, height=5)

# Read the image file and display the plot
img <- readPNG(plot.file)
grid::grid.raster(img)
