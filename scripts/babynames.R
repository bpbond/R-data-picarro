# babynames script
# January 26, 2016

library(dplyr)
library(babynames)


# Information about the dataset
?babynames
print(summary(babynames))

# Let's use some pipelines and dplyr!

# Total number of SSA baby names, by year - about 0.1 seconds
babynames %>%
  group_by(year) %>%
  summarise(n = sum(n))

# Same operation, using base R (not dplyr) - about 3.0 seconds
babynames %>%
  aggregate(n ~ year, data = ., FUN = sum)

