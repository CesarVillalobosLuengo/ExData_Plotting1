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

## STEP: Add a new column "DateTime" = [Date Time]
 subDataSet$DateTime <- as.POSIXct(paste(subDataSet$Date, subDataSet$Time))
 

## STEP: Create the four (last one) Plot in the windows screen and then output in PNG File (width=480, height=480)
 
	par(mfrow=c(2,2))       
 ## Upper left corner plot
    plot(subDataSet$DateTime,subDataSet$Global_active_power, xlab="", ylab="Global Active Power", type="l")
 ## Upper right corner plot	
    plot(subDataSet$DateTime,subDataSet$Voltage, xlab="datetime", ylab="Voltage", type="l")
 ## Lower left corner
    plot(subDataSet$DateTime,subDataSet$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
    lines(subDataSet$DateTime,subDataSet$Sub_metering_2,col="red", type="l")
    lines(subDataSet$DateTime,subDataSet$Sub_metering_3,col="blue", type="l")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), cex=.6)
 ## Lower right corner plot       
    plot(subDataSet$DateTime,subDataSet$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")        
 
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
        


