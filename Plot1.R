
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

### Plot histogram and save as PNG

png(filename = "Plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.off()