# Read data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Convert string to data-time format
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Start png device
png("plot4.png", width=480, height=480)

#Divide screen for 4 plots with 2 on each row by changing parameter
par(mfrow=c(2,2))

# Graph 1
plot(x = data[, dateTime], y = data[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Graph 2
plot(x = data[, dateTime], y = data[, Voltage], type="l", xlab="", ylab="Voltage")


# Graph 3
plot(data[, dateTime], data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data[, dateTime], data[, Sub_metering_2],col="red")
lines(data[, dateTime], data[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))
# Graph 4
plot(x = data[, dateTime], y = data[, Global_reactive_power], type="l", xlab="", ylab="Global Reactive Power (kilowatts)")

# Close Device
dev.off()