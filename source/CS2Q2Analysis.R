############################################################################################
# Question 2
# -----------
#a) Calculate the mean and the median of the trunk circumferences for different size of the
#trees. (Tree)
# Mean and Median for all data in Orange
############################################################################################
# Mean and Median Summarized by Tree
TreeCirc <- Orange %>% group_by(Tree) %>% summarise(circmedian=median(circumference), circmean=mean(circumference))

###############################################################################################
#b) Make a scatter plot of the trunk circumferences against the age of the tree. Use different
#plotting symbols for different size of trees.
# Scatter plot for circumference vs age
###############################################################################################
ggplot(Orange, aes(x=circumference, y=age, shape=Tree, color=Tree)) +geom_point() +ggtitle("Orange Tree Circumference vs Age")

ggplot(Orange, aes(x=circumference, y=age, shape=Tree, color=Tree)) +geom_point() +geom_line() +ggtitle("Orange Tree Circumference vs Age with Lines")

########################################################################################
#c) Display the trunk circumferences on a comparative boxplot against tree. Be sure you
#order the boxplots in the increasing order of maximum diameter.
########################################################################################
ggplot(Orange, aes(x=Tree, y=circumference, fill=Tree)) +geom_boxplot() +ggtitle("Tree Circumference")