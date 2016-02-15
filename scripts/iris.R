# Examine the `iris` dataset
# January 26, 2016

# Don't actually have to do this step, as `datasets` is attached automatically
library(datasets) 

print("Information about the `iris` dataset:")

# For all of the commands below, you only need to use `print` when running
# in a script. From the command line, you can just type `summary(iris)` e.g.
print(summary(iris))
print(names(iris))
?iris # get help about iris
readline("<RETURN>")

print("Number of rows and columms:")
print(nrow(iris))
print(ncol(iris))
print(str(iris))  # "structure"
readline("<RETURN>")

print("Head and tail of iris:")
print(head(iris))
print(head(iris, n = 20))
print(tail(iris))

# Data frames are indexed by [row, column]
print("Indexing into data frames:")
print(iris[3,])  # row 3
print(iris[3:5,]) # rows 3-5
print(head(iris[c(2, 3)]))  # columns 2 and 3
print(head(iris[-2]))  # not column 2
readline("<RETURN>")

# Subsetting the data
print("Looking at short sepals:")
short_sepals <- subset(iris, Sepal.Length < 4.5)
print(short_sepals)
print(which(iris$Sepal.Length < 4.5))
readline("<RETURN>")

print("Species:")
print(unique(iris$Species))
readline("<RETURN>")

print("Mean of Sepal.Length:")
print(mean(iris$Sepal.Length))

print("Duplicate values of Sepal.Length in rows:")
print(duplicated(iris$Sepal.Length))
readline("<RETURN>")

print("Pairs plot:")
print(pairs(iris[-5]))   # remove 5th column (species) before plotting 
readline("<RETURN>")

# Use the `ggplot2` package for generally easier, better graphing
# Less time fiddling with graphics = more time analyzing data
library(ggplot2)

print("Petal.Width versus Petal.Length:")
p1 <- qplot(Petal.Width, Petal.Length, data = iris, color = Species)
print(p1)
readline("<RETURN>")

p2 <- qplot(Petal.Width, Petal.Length, data = iris, color = Species, 
            size = Sepal.Length, alpha = I(0.5))
print(p2)
readline("<RETURN>")

print("Log y axis:")
print(p2 + coord_trans(y = "log10"))

print("All done.")
