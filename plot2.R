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

# plot the "Global_active_power" variable over time and save to PNG
png(filename = 'plot2.png', width = 480, height = 480)
plot(data$Time, data$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)',
	xlab = '')
dev.off()