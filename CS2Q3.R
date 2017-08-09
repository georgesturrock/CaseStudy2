# Load Libraries.  
library(ggplot2)
library(dplyr)
#library(boxr)

# Load data into R
dataloc <- paste(getwd(),"/data/TEMP.csv", sep = "")
print(dataloc)
TempData <- read.csv(dataloc, stringsAsFactors = FALSE, header = TRUE)
dataloc <- paste(getwd(),"/data/CityTemp.csv", sep = "")
print(dataloc)
CityTemp <- read.csv(dataloc, stringsAsFactors = FALSE, header = TRUE)

##############################
# Data Cleansing and Analysis
##############################

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

##################################################################################
# Question 3.ii
#----------------
#Select a subset of data called “UStemp” where US land temperatures from
#01/01/1990 in Temp data. Use UStemp dataset to answer the followings.
#a) Create a new column to display the monthly average land temperatures in
#Fahrenheit (°F).
#b) Calculate average land temperature by year and plot it. The original file has
#the average land temperature by month.
#c) Calculate the one year difference of average land temperature by year and
#provide the maximum difference (value) with corresponding two years.
##################################################################################

USTemp <- subset(GT1899TempData, Country == 'United States')

#Create (°F) column
USTemp$Monthly.AverageTemp.F <- (USTemp$Monthly.AverageTemp * (9/5) + 32)

#Create average land temp by year and plot the result
USTemp$Year <- as.numeric(format(USTemp$Date, "%Y"))
USTempYear <- USTemp %>% group_by(Year) %>% summarise(MeanTempF=mean(Monthly.AverageTemp.F))

#Calculate linear regression for input into ggplot abline function
reg1 <- lm(USTempYear$MeanTempF ~ USTempYear$Year)
ggplot(USTempYear, aes(x=Year, y=MeanTempF, group=1)) +geom_point() +labs(y="Average Temperature (°F)") +scale_x_continuous(breaks=seq(1900,2015,10)) +geom_abline(intercept = reg1$coefficients[1], slope = reg1$coefficients[2], color = "red", linetype = "dashed", size = 1)

#Calculate Year Over Year average temparature difference
USTempYearYOY <- USTempYear %>% mutate(YoY = MeanTempF - lag(MeanTempF), PriorYear = lag(Year))
USTempYearYOY <- USTempYearYOY[order(USTempYearYOY$YoY, decreasing = TRUE),]

#Print maximum year over year change with the corresponding years
cat("Year over Year Temperature Difference:",USTempYearYOY$YoY[1], "| Year:", USTempYearYOY$Year[1], "| Prior Year:", USTempYearYOY$PriorYear[1])

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
