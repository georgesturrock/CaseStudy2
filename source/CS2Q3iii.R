###################################################################################
# Question 3.iii
#----------------
#Download “CityTemp” data set at box.com. Find the difference between the
#maximum and the minimum temperatures for each major city and report/visualize top
#20 cities with maximum differences for the period since 1900. 
###################################################################################

#Standardize dates prior to subsetting data
CityTemp$First2ofDate <- substr(CityTemp$Date, 1, 2)
CityTemp$First2ofDate <- as.integer(CityTemp$First2ofDate)
CityTempGT1899 <- subset(CityTemp, (First2ofDate < 17 | is.na(First2ofDate) == TRUE) & complete.cases(Monthly.AverageTemp)== TRUE)
CityTempGT1899$Date <- as.Date(CityTempGT1899$Date, "%m/%d/%Y")

#Find max and min monthly avg temp by country
CityTempMaxMin <- CityTempGT1899 %>% group_by(Country, City) %>% summarise(MaxMonthlyAvg=max(Monthly.AverageTemp), MinMonthlyAvg=min(Monthly.AverageTemp))

#Calculate Difference in Max and Min Average Temp by Country
CityTempMaxMin$Diff <- (CityTempMaxMin$MaxMonthlyAvg - CityTempMaxMin$MinMonthlyAvg)

#Sort by Diff Descending
CityTempMaxMin <- CityTempMaxMin[order(CityTempMaxMin$Diff, decreasing = TRUE),]

#Subset the top 20 and concatenate City and Country
CityTempTop20 <- CityTempMaxMin[1:20,]
CityTempTop20$CityCountry <- paste(CityTempTop20$City, ", ", CityTempTop20$Country, sep = "")

#Plot the top 20
ggplot(CityTempTop20, aes(x=Diff, y=reorder(CityCountry, Diff))) +geom_point() +labs(x="Temperature Difference", y="City")
