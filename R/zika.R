#:-----------------------------------------------------------------------------:
# Make a choropleth of "Zika Case Counts in the US by State".
# (Similar to this map: http://www.cdc.gov/zika/intheus/maps-zika-us.html)
#
# "Scrapes" tabular data from "Case Counts in the US" CDC web page.
# (http://www.cdc.gov/zika/geo/united-states.html)
#
# Last updated by Brian High (https://github.com/brianhigh) on Sept. 12, 2016.
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
pkgs <- c("dplyr", "tools", "scales", "png", "XML", 
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

# Scrape table from CDC web page
zikaURL <- "http://www.cdc.gov/zika/geo/united-states.html"
zikaWeb <-readHTMLTable(zikaURL)
zika <- zikaWeb[[1]]

# Clean up state and territory names
zika <- zika %>% filter(States != "Territories")
zika <- zika[grepl('[A-Za-z ]+', zika[,1]),]
zika$States <- as.factor(as.character(zika$States))

# Rename columns (to match https://github.com/BuzzFeedNews/zika-data/ CSV files)
names(zika) <- c('state_or_territory', 'travel_associated_cases', 
                    'locally_acquired_cases')

# Define function to remove non-digit text from integer data
cleanDigits <- function (x){
    x <- gsub("^([0-9,]+).*$", "\\1", x)
    x <- gsub(",", "", x)
    x <- as.integer(x)
}

# Remove non-digit text from the two cases columns
zika[, 2:3] <- sapply(2:3, function(x) sapply(zika[, x], 
                                              function(y) cleanDigits(y)))

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

# Construct plot title from date of most recent update, as found in CDC web page
cdcPage <- readLines(zikaURL)
asof.date <- gsub("<.*?>", "", cdcPage[grepl('As of ', cdcPage)])
plot_title <- paste('Zika Case Counts in the US by State', 
                    'January 01, 2015 to Present', asof.date, sep='\n')

# Create the choropleth map with ggplot
usmap <- ggplot(df, aes(map_id=region)) + ggtitle(plot_title) +
    geom_map(aes(fill=cases), map=states_map) + coord_map("polyconic") + 
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
table <- tableGrob(not_mapped, theme = ttheme_default(base_size = 8))

# Create a graphical object (grob) for the citation text
source_text <- paste("Source: Case Counts in the US", "CDC", 
                     "http://www.cdc.gov/zika/geo/united-states.html",sep=", ")
text <- textGrob(source_text, x=0, hjust=-0.2, vjust=0.2, 
                             gp=gpar(fontface = "italic", fontsize = 8))

# Combine plot elements (map, table, source text) into a "grid"
g <- arrangeGrob(usmap, heights=c(8, 1), sub=table, bottom = text)

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
