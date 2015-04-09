
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

# Set up multi-plot display using png device
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

# Scatter plot of Global Average Power vs DateTime
plot(x = data$DateTime, y = data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power",
     main = "")

# Scatter plot of Voltage vs DateTime
plot(x = data$DateTime, y = data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage",
     main = "")

# Plot line plot with multiple lines for Sub_metering fields
plot(x = data$DateTime, y = data$Sub_metering_1, type = "l", 
     col = "black", xlab = "", ylab = "Energy sub metering",
     main = "")
lines(x = data$DateTime, y = data$Sub_metering_2, col = "red")
lines(x = data$DateTime, y = data$Sub_metering_3, col = "blue")
legend_text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(x = "topright", legend = legend_text, lty = c(1, 1, 1), 
       col = c("black", "red", "blue"), bty = "n")

# Scatter plot of Global_reactive_power vs DateTime
plot(x = data$DateTime, y = data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power",
     main = "")

# Close device
dev.off()

