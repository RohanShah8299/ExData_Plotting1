# Read data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Convert string to data-time format
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Start png device
png("plot3.png", width=480, height=480)

# Plot Graph fro Submeter 1
plot(data[, dateTime], data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")


# Add readings of submeter 2 and 3 to same graph
lines(data[, dateTime], data[, Sub_metering_2],col="red")
lines(data[, dateTime], data[, Sub_metering_3],col="blue")

# Define legend
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

# Close Device
dev.off()