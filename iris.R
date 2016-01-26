# Examine the `iris` dataset
# January 26, 2016

# Don't actually have to do this step, as `datasets` is attached automatically
library(datasets) 

print("Information about the `iris` dataset:")

# For all of the commands below, you only need to use `print` when running
# in a script. From the command line, you can just type `summary(iris)` e.g.
print(summary(iris))
print(names(iris))

print("Number of rows and columms:")
print(nrow(iris))
print(ncol(iris))

print(str(iris))  # "structure"

print(head(iris))

print(head(iris, n = 20))

print(tail(iris))

# Data frames are index by [row, column]
print(iris[3,])  # row 3
print(head(iris[c(2, 3)]))  # columns 2 and 3
print(head(iris[-2]))  # not column 2

print(unique(iris$Species))

print(iris$Sepal.Length)

print("Mean of Sepal.Length:")
print(mean(iris$Sepal.Length))

print("Making plots...")
pairs(iris[-5])   # remove 5th column (species) before plotting 

# Use the `ggplot2` package for generally easier, better graphing
library(ggplot2)
p1 <- qplot(Petal.Width, Petal.Length, data = iris, color = Species)
print(p1)
p2 <- qplot(Petal.Width, Petal.Length, data = iris, color = Species, size = Sepal.Length)
print(p2)
print(p2 + coord_trans(y = "log10"))

print("All done.")
