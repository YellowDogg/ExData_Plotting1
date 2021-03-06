
# Read text data file
# Separator is ";", NA character is "?"
# Data and Time fields should be converted to data and time classes
# Create new DateTime field with combined date and time
# Only keep data with dates between 2007-02-01 and 2007-02-02

data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", dec = ".", na.strings = "?", 
                   fill = TRUE, comment.char = "")
data$DateTime <- paste(data$Date, data$Time)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")
select <- (data$Date >= as.Date("2007-02-01", format = "%Y-%m-%d")
           & data$Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))
data <- data[select, ]

# Plot histogram of Global_active_power using png device
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col="red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()

