library(data.table)

# download data
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
	destfile = 'household_power_consumption.zip')
unzip('household_power_consumption.zip')

# load subset of data, between dates we are interested in
data <- fread('household_power_consumption.txt', sep = ';', header = FALSE, na.strings = '?',
	skip = "1/2/2007", nrows = 2880,
	col.names = c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage',
		'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
	data.table = FALSE)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$FullDate <- paste(data$Date, data$Time)
data$Time <- strptime(data$FullDate, "%Y-%m-%d %H:%M:%S")

# open PNG device
png(filename = 'plot4.png', width = 480, height = 480)

# setup default params and layout
par(mfrow = c(2,2))

with(data, {
	# top left plot - plot "Global_active_power" over time
	plot(Time, Global_active_power, type = 'l', ylab = 'Global Active Power', xlab = '')

	# top right plot - plot "Voltage" over time
	plot(Time, Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')

	# bottom left plot - plot all 3 "submetering" vars over time
	plot(Time, Sub_metering_1, type = 'l', col = 'black', ylab = 'Energy sub metering', xlab = '')
	lines(Time, Sub_metering_2, col = 'red')
	lines(Time, Sub_metering_3, col = 'blue')
	legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
		col = c('black', 'red', 'blue'), lwd = 1, bty = 'n')

	# bottom right plot - plot "Global_reactive_power" over time
	plot(Time, Global_reactive_power, type = 'l', xlab = 'datetime')
})

# close device 
dev.off()