## Plot 3: Daily Energy sub metering

library(sqldf)
hpcfile <- file("./data/household_power_consumption.txt")
hpcsub <- sqldf('select * from hpcfile where Date = "1/2/2007" OR Date = "2/2/2007"', 
                dbname = tempfile(), file.format = list(header=T, sep=";", eol = '\r\n'))
hpcsub$DateTime <- as.POSIXct(strptime(paste(as.character(hpcsub[,1]), as.character(hpcsub[,2]), sep=" "), 
                                       format="%d/%m/%Y %H:%M:%S"))
png(filename = "plot3.png")
with(hpcsub, plot(DateTime, Sub_metering_1, xlab = "", 
                   ylab = "Energy sub metering", type = "l"))
lines(hpcsub$DateTime, hpcsub$Sub_metering_2, col = "red")
lines(hpcsub$DateTime, hpcsub$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

