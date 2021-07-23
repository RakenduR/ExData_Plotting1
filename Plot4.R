### Download and Extract file

setwd("/Users/RanjitS1/Documents/Rakendu/Coursera/Exploratory Data Analysis/Assignment 1/ExData_Plotting1")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp,"household_power_consumption.txt",exdir=".")
unlink(temp)

### Find starting row and no of rows of data with date as 1/2/2007 or 2/2/2007

ColNames <- names(read.table(file="household_power_consumption.txt",header = TRUE,nrows = 1,sep = ";"))
SkipCount <- as.integer(grep("1/2/2007", readLines("household_power_consumption.txt"), fixed = TRUE)[1]-1)
RowCount <- as.integer(length(grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"))))
data <- read.table(file = "household_power_consumption.txt", na.strings = "?", sep=";",header = FALSE,col.names = ColNames,skip = SkipCount,nrows = RowCount)

### Add datetime column by combining the Date and Time columns
data <- cbind(data,datetime = as.POSIXct(paste(data$Date,data$Time),format = "%d/%m/%Y %H:%M:%S"))

### Plot the line graphs
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

### Plot 1
plot(data$datetime,data$Global_active_power,type = "n",xlab = "", ylab="Global Active Power")
lines(data$datetime,data$Global_active_power)

### Plot 2
plot(data$datetime,data$Voltage,type = "n", xlab = "datetime", ylab = "Voltage")
lines(data$datetime,data$Voltage)

### Plot 3
plot(data$datetime,data$Sub_metering_1,type = "n",xlab = "", ylab="Energy sub metering")
lines(data$datetime,data$Sub_metering_1)
lines(data$datetime,data$Sub_metering_2, col = "red")
lines(data$datetime,data$Sub_metering_3, col = "blue")
legend("topright",lwd = 1, col =c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### Plot 4
plot(data$datetime,data$Global_reactive_power,type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(data$datetime,data$Global_reactive_power)

dev.off()