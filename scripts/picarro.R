# A script to process Picarro data
# January 26, 2016

# Everything below can be done in base R. But we use the 
# following packages for speed and elegance.
library(dplyr)      # data manipulation
library(ggplot2)    # plotting
library(readr)      # fast file reading
library(lubridate)  # easy date handling


# Read and combine data from all Picarro files
filelist <- list.files("picarrodata/", pattern = "*.gz", full.names = TRUE)
rawdata <- list()
for(f in filelist) {
  cat("Reading", f, "\n")
  rawdata[[f]] <- read_table(f) 
}
rawdata <- rbind_all(rawdata)

# Change the `DATE` and `TIME` character fields into a single date field
# Be careful: know date and time on instrument versus local time
print("Computing DATETIME...")
rawdata$DATETIME <- ymd_hms(paste(rawdata$DATE, rawdata$TIME))

# Assign sample numbers
# We've seen this code before!
print("Computing sample numbers...")
vnums <- rawdata$MPVPosition
rawdata$samplenum <- c(TRUE, vnums[-length(vnums)] != vnums[-1]) %>%
  cumsum
print(summary(rawdata$samplenum))

# Make a plot. What's the problem?
uglyplot <- qplot(DATETIME, CO2_dry, data=rawdata, color=factor(MPVPosition))
uglyplot <- uglyplot + scale_color_discrete("Valve")
print(uglyplot)

print("Reading valve data..")
valvedata <- read_csv("picarrodata/valvedata.csv")

# TODO: a dplyr pipeline that
# (1) filters out fractional valve values
# (2) removes all but a few fields (samplenum, DATETIME, MPVPosition, CH4_dry, CO2_dry)
# (3) merges the data with `valvedata`
# (4) groups the data by samplenum
# (5) arranges the data by DATETIME
# (6) computes elapsed_seconds for each sample (using `mutate`)
# (7) filters out soil core "J"
# rawdata %>% ...  -> cleandata

# TODO: make a pretty plot: elapsed_seconds (x) by CO2_dry (y), colored by soilcore

# Bonus TODO: a dplyr pipeline that computes mean CO2 and CH4 for each samplenum
# cleandata %>% ... -> summarydata

print("All done.")
