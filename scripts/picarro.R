# Basic script to process Picarro data
# January 26, 2016

library(dplyr)      # data manipulation
library(ggplot2)    # plotting
library(readr)      # fast file reading
library(lubridate)  # easy date handling


# Read and combine data from all Picarro files
filelist <- list.files("picarrodata/", full.names = TRUE)
rawdata <- list()
for(f in filelist) {
  print(f)
  rawdata[[f]] <- read_table(f)
}
rawdata <- rbind_all(rawdata)

# Change the `DATE` and `TIME` character fields into a single date field
# Gotcha #1: date and time on instrument versus local time versus 
rawdata$DATETIME <- ymd_hms(paste(rawdata$DATE, rawdata$TIME))

# Remove fractional valve numbers


# Assign sample numbers


# Summarise

