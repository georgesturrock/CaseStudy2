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

#Create average land temp by year, subset for for dates greater than 1989
USTemp$Year <- as.numeric(format(USTemp$Date, "%Y"))
USTemp <- subset(USTemp, Year > 1989)

#Create (°F) column
USTemp$Monthly.AverageTemp.F <- (USTemp$Monthly.AverageTemp * (9/5) + 32)

#Calculate average yearly temperature and create new dataframe
USTempYear <- USTemp %>% group_by(Year) %>% summarise(MeanTempF=mean(Monthly.AverageTemp.F))

#Plot yearly temperature averages and Calculate linear regression for input into ggplot abline function
reg1 <- lm(USTempYear$MeanTempF ~ USTempYear$Year)
ggplot(USTempYear, aes(x=Year, y=MeanTempF, group=1)) +geom_point() +labs(y="Average Temperature (°F)") +geom_abline(intercept = reg1$coefficients[1], slope = reg1$coefficients[2], color = "red", linetype = "dashed", size = 1) +ggtitle("Average US Land Temperature by Year")

#Calculate Year Over Year average temparature difference
USTempYearYOY <- USTempYear %>% mutate(YoY = MeanTempF - lag(MeanTempF), PriorYear = lag(Year))
USTempYearYOY <- USTempYearYOY[order(USTempYearYOY$YoY, decreasing = TRUE),]

#Print maximum year over year change with the corresponding years
cat("The maximum Year over Year Temperature Difference is:",USTempYearYOY$YoY[1], "This difference occured in", USTempYearYOY$Year[1], "The prior year was", USTempYearYOY$PriorYear[1])
