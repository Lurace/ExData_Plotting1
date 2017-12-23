if (!file.exists("data")) {
  dir.create("data")
}

htmlfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(htmlfile, destfile = "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", na.strings = "?", sep=";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")) - 1, nrows = 2880)
names(data) <- unlist(read.table("./data/household_power_consumption.txt", sep = ";", nrows = 1))

data <- read.table("./data/household_power_consumption.txt", na.strings = "?", sep=";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")) - 1, nrows = 2880)
names(data) <- unlist(read.table("./data/household_power_consumption.txt", sep = ";", nrows = 1))
library(lubridate)
library(dplyr)
data <- data %>%  
  mutate(datetime = paste(Date, Time, sep = " "))
data$datetime <- dmy_hms(data$datetime)
png(filename = "polt4.png")
par(mfrow = c(2,2))
with(data, {
  plot(datetime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n")
  lines(datetime, Global_active_power)
  
  plot(datetime, Voltage, ylab = "Voltage", xlab = "datetime", type = "n")
  lines(datetime, Voltage)
    
  plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
  lines(datetime, Sub_metering_1)
  points(datetime, Sub_metering_2, col = "red", type = "n")
  lines(datetime, Sub_metering_2, col = "red")
  points(datetime, Sub_metering_3, col = "blue", type = "n")
  lines(datetime, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, bty= "n", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(datetime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "n")
  lines(datetime, Global_reactive_power)
})
dev.off()
