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
  read_table(f) %>%
    select(DATE, TIME, ALARM_STATUS, MPVPosition, CH4_dry, CO2_dry) ->
    rawdata[[f]]
}
rawdata <- rbind_all(rawdata)

# Make sure that no instrument alarm was triggered
if(any(rawdata$ALARM_STATUS != 0)) {
  warning("There are non-zero alarm statuses in this dataset!")  
}

# Change the `DATE` and `TIME` character fields into a single date field
# Be careful: know date and time on instrument versus local time
print("Computing DATETIME...")
rawdata$DATETIME <- lubridate::ymd_hms(paste(rawdata$DATE, rawdata$TIME))

# Get rid of unneeded fields
rawdata$DATE <- rawdata$TIME <- NULL

# Assign sample numbers
# We've seen this code before!
print("Computing sample numbers...")
vnums <- rawdata$MPVPosition
rawdata$samplenum <- c(TRUE, vnums[-length(vnums)] != vnums[-1]) %>%
  cumsum
print(summary(rawdata$samplenum))

# Make a plot. What's the problem?
print("Ugly plot...")
uglyplot <- qplot(DATETIME, CO2_dry, data = rawdata, color = factor(MPVPosition))
uglyplot <- uglyplot + scale_color_discrete("Valve")
print(uglyplot)

print("Reading valve data..")
valvedata <- read_csv("picarrodata/valvedata.csv")

# TODO: a dplyr pipeline that
# (1) filters out fractional valve values
# (2) merges the data with `valvedata`
# (3) arranges the data by DATETIME
# (4) groups the data by samplenum
# (5) computes elapsed_seconds for each sample (using `mutate`)
# (8) filters out soil core "J"
# rawdata %>% ...  -> cleandata


# TODO: make a pretty plot: elapsed_seconds (x) by CO2_dry (y), colored by soilcore


stop("Not really an error. But we're all done.")


# Solution below...don't look until you try!











# Really, I mean it, don't.











# Solution - data pipeline
rawdata %>%
  filter(MPVPosition == floor(MPVPosition)) %>%
  left_join(valvedata, by = "MPVPosition") %>%
  arrange(DATETIME) %>%
  group_by(samplenum) %>%
  # this next line is tricky. See ?difftime
  mutate(elapsed_seconds = as.numeric(DATETIME - min(DATETIME))) %>%
  filter(elapsed_seconds >= 2.0) %>%   # first few seconds are "wonky" sometimes
  filter(soilcore != "J") ->
  cleandata

# Solution - pretty plot
prettyplot <- qplot(elapsed_seconds, CO2_dry, data = cleandata, 
                    color = soilcore, group = samplenum, geom = "line")
print(prettyplot)

