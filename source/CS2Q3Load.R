# Load data into R
dataloc <- paste(getwd(),"/data/TEMP.csv", sep = "")
print(dataloc)
TempData <- read.csv(dataloc, stringsAsFactors = FALSE, header = TRUE)
dataloc <- paste(getwd(),"/data/CityTemp.csv", sep = "")
print(dataloc)
CityTemp <- read.csv(dataloc, stringsAsFactors = FALSE, header = TRUE)