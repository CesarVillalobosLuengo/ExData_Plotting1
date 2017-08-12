## STEP: Download zip data from URL
urlZipFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFileName <- "household_power_consumption.zip"
txtFileName <- "household_power_consumption.txt"

if(!file.exists(zipFileName)){
  download.file(urlZipFile,zipFileName, mode = "wb") 
}

if(!file.exists(txtFileName)){
  unzip(zipFileName, files = NULL, exdir=".")
}

## STEP: The data is read completely
 dataSet <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings= "?")
 dataSet$Date <- as.Date(dataSet$Date, format = "%d/%m/%Y")


## STEP: Is created a subset of the data where  dataSet$Date >='2007-02-01' and dataSet$Date <='2007-02-02'
 subDataSet <- dataSet[dataSet$Date >= as.Date("2007-02-01") & dataSet$Date <= as.Date("2007-02-02"),]
 
## STEP: Set the  datatypes in the subset
 subDataSet$Global_active_power <- as.numeric(subDataSet$Global_active_power)
 subDataSet$Global_reactive_power <- as.numeric(subDataSet$Global_reactive_power)	
 subDataSet$Voltage <- as.numeric(subDataSet$Voltage)	
 subDataSet$Global_intensity <- as.numeric(subDataSet$Global_intensity)	
 subDataSet$Sub_metering_1 <- as.numeric(subDataSet$Sub_metering_1)	
 subDataSet$Sub_metering_2 <- as.numeric(subDataSet$Sub_metering_2)	
 subDataSet$Sub_metering_3 <- as.numeric(subDataSet$Sub_metering_3)


## STEP: Create the first one Plot in the windows screen and then output in PNG File (width=480, height=480) 
 
 hist(subDataSet$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
 dev.copy(png, file="plot1.png", width=480, height=480, units = "px")
 dev.off() 