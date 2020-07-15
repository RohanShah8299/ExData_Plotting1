# Read data
data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Converting charater to numeric
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Convert string to data-time format
data[, Date := as.Date(Date, format = "%d/%m/%Y")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(Date >= "2007-02-01") & (Date < "2007-02-03")]

# Start png device
png("plot1.png", width=480, height=480)

# Plot the histogram
hist(data[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Close device
dev.off()
