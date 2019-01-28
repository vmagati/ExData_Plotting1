setwd("~/Documents/Data Science Files/Course 4 Project 1")
table <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
table$Date <- as.Date(table$Date, "%d/%m/%Y")
table <- subset(table, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
table <- table[complete.cases(table), ]
dateTime <- paste(table$Date, table$Time)
dateTime <- setNames(dateTime, "Date/Time")
table <- table[ , !(names(table) %in% c("Date","Time"))]
table <- cbind(dateTime, table)
table$dateTime <- as.POSIXct(dateTime)

par(mfrow = c(2, 2))
with(table, {
  plot(Global_active_power~dateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  plot(Voltage~dateTime, type = "l", xlab = "", ylab = "Voltage (volt)")
  plot(Sub_metering_1~dateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  lines(Sub_metering_2~dateTime, col ="red")
  lines(Sub_metering_3~dateTime, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type = "l", xlab = "", ylab = "Global Rective Power (kilowatts)")
  })

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()