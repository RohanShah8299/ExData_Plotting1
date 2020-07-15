# Read data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Converting charater to numeric
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Convert string to data-time format
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Start png device
png("plot2.png", width=480, height=480)

# Plot the graph
plot(x = data[, dateTime], y = data[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Close device
dev.off()