## plot3.R
## source code for reading household power consumption & plot a graph of Energy sub metering values by Day of the week

## Read the household power consumption data 
pcdf <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## create a subset - Power consumption data on 01/02/2007 & 02/02/2007
subdf <- subset(pcdf, as.Date(pcdf$Date,"%d/%m/%Y") == as.Date("01/02/2007", "%d/%m/%Y") | as.Date(pcdf$Date,"%d/%m/%Y") == as.Date("02/02/2007", "%d/%m/%Y") )

## convert the Date & Time variables to a POSIX datetime variable
subdf$Date <- as.Date(subdf$Date,"%d/%m/%Y")
subdf$Time <- format(subdf$Time,format = "%H:%M:%S")
newdf <- cbind(subdf, datetime = strptime(paste(subdf$Date, subdf$Time),"%Y-%m-%d %H:%M:%S",tz = "PST8PDT"))

## Plot a graph of Energy Sub metering values by day of the week to a png file
png(filename = "plot3.png")

with(newdf, plot(datetime, as.numeric(paste(Sub_metering_1)), type = "l", ylim = c(0, 38),xlab ="", ylab = "Energy sub metering"))
lines(newdf$datetime, as.numeric(paste(newdf$Sub_metering_2)), col = "red")
lines(newdf$datetime, as.numeric(paste(newdf$Sub_metering_3)), col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 1, lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

## end of source code