## Retrieve Data

remoteArchive <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localArchive <- "./data/household_power_consumption.zip"
localFile <- "./data/household_power_consumption.txt"

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists(localFile)) {
  download.file(
    url = remoteArchive,
    destfile = localArchive,
    method = "auto")
  unzip(localArchive, exdir = "./data")
}

## Read Data

#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

colNames <- c('Date',
              'Time',
              'Global_active_power',
              'Global_reactive_power',
              'Voltage',
              'Global_intensity',
              'Sub_metering_1',
              'Sub_metering_2',
              'Sub_metering_3')

#66638 - First Line of 2/1/2007
#69517 - Last Line of 2/2/2007
#2880 - Number of Rows

d <- read.csv2(localFile, 
               header=FALSE, 
               skip=66637, 
               nrows=2880,
               col.names=colNames,
               na.strings=c("?"))

dt <- paste(d$Date, d$Time)
d$Date = strptime(dt, "%d/%m/%Y %H:%M:%S")
d$Time <- NULL

## Plot 2

d$Global_active_power <- as.numeric(levels(d$Global_active_power))[d$Global_active_power]

plot(d$Date, d$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

dev.copy(png, file="plot2.png")
dev.off()
