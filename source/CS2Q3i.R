##############################################################################
# Question 3.i
#---------------
#Find the difference between the maximum and the minimum monthly average
#temperatures for each country and report/visualize top 20 countries with the
#maximum differences for the period since 1900.
##############################################################################

#Standardize dates prior to subsetting data
TempData$First2ofDate <- substr(TempData$Date, 1, 2)
TempData$First2ofDate <- as.integer(TempData$First2ofDate)
GT1899TempData <- subset(TempData, (First2ofDate < 17 | is.na(First2ofDate) == TRUE) & complete.cases(Monthly.AverageTemp)== TRUE)
GT1899TempData$Date <- as.Date(GT1899TempData$Date, "%m/%d/%Y")

#Find max and min monthly avg temp by country
MMCTempData <- GT1899TempData %>% group_by(Country) %>% summarise(MaxMonthlyAvg=max(Monthly.AverageTemp), MinMonthlyAvg=min(Monthly.AverageTemp))

#Calculate Difference in Max and Min Average Temp by Country
MMCTempData$Diff <- (MMCTempData$MaxMonthlyAvg - MMCTempData$MinMonthlyAvg)

#Sort by Diff Descending
MMCTempData <- MMCTempData[order(MMCTempData$Diff, decreasing = TRUE),]

#Subset the top 20
MMCTop20 <- MMCTempData[1:20,]

#Plot the top 20
ggplot(MMCTop20, aes(x=Diff, y=reorder(Country, Diff))) +geom_point() +labs(x="Temperature Difference", y="Country")
