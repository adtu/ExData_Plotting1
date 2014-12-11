## Plot 4: Daily Global Active Power (kilowatts)

library(sqldf)
hpcfile <- file("./data/household_power_consumption.txt")
hpcsub <- sqldf('select * from hpcfile where Date = "1/2/2007" OR Date = "2/2/2007"', 
                dbname = tempfile(),
                file.format = list(header=T, sep=";", eol = '\r\n'))
hpcsub$datetime <- as.POSIXct(strptime(paste(as.character(hpcsub[,1]), as.character(hpcsub[,2]), sep=" "), 
                                       format="%d/%m/%Y %H:%M:%S"))
png(filename = "plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 4, 2), oma = c(0, 0, 2, 0))
with(hpcsub, {
    plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
    plot(datetime, Voltage, type = "l")
    plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
        lines(hpcsub$datetime, hpcsub$Sub_metering_2, col = "red")
        lines(hpcsub$datetime, hpcsub$Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(datetime, Global_reactive_power, type = "l")
})
dev.off()
