#Question 2 (30 points)
#The built-in data set called Orange in R is about the growth of orange trees. The Orange data
#frame has 3 columns of records of the growth of orange trees.
#Variable description
#Tree: an ordered factor indicating the tree on which the measurement is made. The ordering is
#according to increasing maximum diameter.
#age: a numeric vector giving the age of the tree (days since 1968/12/31)
#circumference: a numeric vector of trunk circumferences (mm). This is probably “circumference
#at breast height”, a standard measurement in forestry.

#Load Libraries
library(dplyr)
library(ggplot2)

# Open the Orange data set
data("Orange")

#####
#a) Calculate the mean and the median of the trunk circumferences for different size of the
#trees. (Tree)
# Mean and Median for all data in Orange
cat("median = ", median(Orange$circumference), "mean = ", mean(Orange$circumference))

# Mean and Median Summarized by Tree
TreeCirc <- Orange %>% group_by(Tree) %>% summarise(circmedian=median(circumference), circmean=mean(circumference))
#TreeCirc[order(TreeCirc$Tree),]
print(TreeCirc)

#####
#b) Make a scatter plot of the trunk circumferences against the age of the tree. Use different
#plotting symbols for different size of trees.
# Scatter plot for circumference vs age
ggplot(Orange, aes(x=circumference, y=age, shape=Tree, color=Tree)) +geom_point()

# Scatter plot with lines connecting the data points to allow for easy vizual comparison of the relationship of circumference vs age of the different trees
ggplot(Orange, aes(x=circumference, y=age, shape=Tree, color=Tree)) +geom_point() +geom_line()

#####
#c) Display the trunk circumferences on a comparative boxplot against tree. Be sure you
#order the boxplots in the increasing order of maximum diameter.
ggplot(Orange, aes(x=age, y=circumference, fill=Tree)) +geom_boxplot()