## Plot 1: Global Active Power Histogram

library(sqldf)
hpcfile <- file("./data/household_power_consumption.txt")
hpcsub <- sqldf('select * from hpcfile where Date = "1/2/2007" OR Date = "2/2/2007"', 
                dbname = tempfile(),
                file.format = list(header=T, sep=";", eol = '\r\n'))
hpcsub$DateTime <- as.POSIXct(strptime(paste(as.character(hpcsub[,1]), as.character(hpcsub[,2]), sep=" "), 
                                       format="%d/%m/%Y %H:%M:%S"))
hist(hpcsub$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()