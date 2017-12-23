if (!file.exists("data")) {
  dir.create("data")
}

htmlfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(htmlfile, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", na.strings = "?", sep=";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")) - 1, nrows = 2880)
names(data) <- unlist(read.table("./data/household_power_consumption.txt", sep = ";", nrows = 1))

library(lubridate)
library(dplyr)
data <- data %>%  
  mutate(datetime = paste(Date, Time, sep = " "))
data$datetime <- dmy_hms(data$datetime)
png(filename = "polt2.png")
with(data, {
  plot(datetime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n")
  lines(datetime, Global_active_power)
})
dev.off()
