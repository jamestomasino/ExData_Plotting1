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
