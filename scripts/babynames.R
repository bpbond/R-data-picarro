# babynames script - dplyr practice
# January 26, 2016

library(dplyr)
library(babynames)
library(ggplot2)
theme_set(theme_bw())  # black and white graphs

# Information about the dataset
?babynames
print(summary(babynames))
print(head(babynames))
# Let's use some pipelines and dplyr!

# Total number of SSA baby names, by year - about 0.1 seconds
babynames %>%
  group_by(year) %>%
  summarise(sum(n))

# Same operation, using base R (not dplyr) - about 3.0 seconds
babynames %>%
  aggregate(n ~ year, data = ., FUN = sum)

# Names starting with "Ste"
# From http://www.r-statistics.com/2014/08/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/)
babynames %>%
  filter(substr(name, 1, 3) == "Ste") %>%
  group_by(year, sex) %>%
  summarize(total = sum(n)) ->
  SteCounts

p <- qplot(year, total, color = sex, data = SteCounts, geom = "line")
p <- p + ggtitle('Names starting with "Ste"')
print(p)

# 5th most popular girl name in each year
print("Computing 5th most popular female names...")
babynames %>% 
  filter(sex == 'F') %>% 
  group_by(year) %>% 
  arrange(desc(prop)) %>%
  summarise(fifth = nth(name, 5))

# Compute the most popular names by year and sex
print("Computing most popular names by year and sex")
timing <- system.time({
  babynames %>% 
    group_by(year, sex) %>% 
    summarise(prop=max(prop), 
              name=name[which.max(prop)]) ->
    popnames
})
print(timing)
print(popnames)

print("Plotting...")
# To display the names when they first appear, make a 'displaynames' dataset
popnames %>% 
  group_by(sex, name) %>% 
  summarise(year = min(year), prop = prop[which.min(year)]) ->
  displaynames

p <- qplot(year, prop, data = popnames, color = name) + facet_grid(sex ~ .) 
p <- p + guides(color = FALSE)
p <- p + geom_text(data = displaynames, aes(label = name), size = 4, vjust = -1)
p <- p + coord_cartesian(ylim = c(0, 0.095))
print(p)
ggsave("images/popular_babynames.png")  # used by presentation

print("All done.")
