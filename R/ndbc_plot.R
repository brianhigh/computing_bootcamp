# -----------------------------------------------------------------------------
# Plot NDBC Historical Data
#
# Formatted report based on this script: https://rpubs.com/brianhigh/108765
#
# Last updated by Brian High (https://github.com/brianhigh) on Sept. 11, 2016
# License: CC0 1.0 Universal https://creativecommons.org/publicdomain/zero/1.0/
# -----------------------------------------------------------------------------

# Clear the workspace
rm(list=ls())

# Configuration
stn.id   <- '46087'      # ID List: http://www.ndbc.noaa.gov/to_station.shtml
stn.name <- 'Neah Bay'   # https://www.google.com/search?q=ndbc+neah+bay
tz.str   <- "US/Pacific" # Convert NDBC date/times from UTC to this timezone
days     <- 5            # Number of days to plot


# Retrieve NDBC Data

# Download the text data file for the NOAA NDBC Station
cols <- c("YY", "MM", "DD", "hh", "mm", "WDIR", "WSPD", "GST", "WVHT", "DPD", 
          "APD", "MWD", "PRES", "ATMP", "WTMP", "DEWP", "VIS", "PTDY", "TIDE")
site <- "http://www.ndbc.noaa.gov/data/realtime2/"
ndbc <- read.fwf(
    file=url(paste(site, stn.id, ".txt", sep="")),
    widths=c(4, 3, 3, 3, 3, 4, 5, 5, 6, 6, 6, 4, 7, 6, 6, 6, 5, 5, 6), skip=2,
    col.names=cols, na.strings=c("MM"), stringsAsFactors=F, strip.white=T)


# Calculate Date Range and Subset Data
# Convert dates to POSIX date format

# Determine start and end dates and convert dates to strings for use in plot
end.date <- as.POSIXct(Sys.time(), tz=tz.str)
start.date <- end.date - as.difftime(days, units = "days")
end.date.str <- format(end.date, format="%B %d, %Y")
start.date.str <- format(start.date, format="%B %d, %Y")

# Convert date components of raw data to a date-time format for calculations
ndbc$DATE <- as.POSIXct(paste(ndbc$YY, ndbc$MM, ndbc$DD, ndbc$hh, ndbc$mm, 
                              sep="."), format = "%Y.%m.%d.%H.%M", tz="UTC")
attr(ndbc$DATE, "tzone") <- tz.str
ndbcww <- na.exclude(ndbc[ndbc$DATE > start.date, c("DATE", "WVHT", "GST")])


# Plot wind gusts and wave height by date

# Save the plot as a PNG image named after the station ID and current date/time
plot.date <- format(end.date, format="%Y-%m-%d_%H%M%S")
plot.file <- paste(stn.id, '_', plot.date, ".png", sep='')
png(plot.file, width=640, height=480, units="px")

# Plot the data using base R graphics
par(mar=c(5, 4, 4, 5) + .1)
plot(ndbcww$DATE, ndbcww$GST, 
     type="l", col="red", ylab="Wind Gusts (kt)", xlab="")
par(new=T)
plot(ndbcww$DATE, ndbcww$WVHT, 
     type="l", col="blue", xaxt="n", yaxt="n", xlab="", ylab="")
axis(4)
mtext("Wave Height (m)", side=4, line=3)
title(main=paste("Wind Gusts and Wave Height, Station", stn.id, "-", stn.name))
legend("topleft", legend=c("Wind Gusts", "Wave Height"), 
       col=c("red", "blue"), lty=1, cex=0.75)
mtext(paste(start.date.str, '-', end.date.str), side = 1, line = 3)
mtext("Source: NOAA NDBC", font=3, side = 1, line = 4)

# Close the graphics device
dev.off()
