## plot2.R
## source code for reading household power consumption & plot a graph of Active Power consumption by day of the week

## Read the household power consumption data 
pcdf <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## create a subset - Power consumption data on 01/02/2007 & 02/02/2007
subdf <- subset(pcdf, as.Date(pcdf$Date,"%d/%m/%Y") == as.Date("01/02/2007", "%d/%m/%Y") | as.Date(pcdf$Date,"%d/%m/%Y") == as.Date("02/02/2007", "%d/%m/%Y") )

## convert the Date & Time variables to a POSIX datetime variable
subdf$Date <- as.Date(subdf$Date,"%d/%m/%Y")
subdf$Time <- format(subdf$Time,format = "%H:%M:%S")
newdf <- cbind(subdf, datetime = strptime(paste(subdf$Date, subdf$Time),"%Y-%m-%d %H:%M:%S",tz = "PST8PDT"))

## Plot a graph of Active Power consumption by day of the week to a png file
png(filename = "plot2.png")

with(newdf,plot(datetime,as.numeric(paste(newdf$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", main = ""))

dev.off()

## end of source code