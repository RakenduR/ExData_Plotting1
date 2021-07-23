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

png(filename = "Plot3.png", width = 480, height = 480, units = "px")
plot(data$datetime,data$Sub_metering_1,type = "n",xlab = "", ylab="Energy sub metering")
lines(data$datetime,data$Sub_metering_1)
lines(data$datetime,data$Sub_metering_2, col = "red")
lines(data$datetime,data$Sub_metering_3, col = "blue")
legend("topright",lwd = 1, col =c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()