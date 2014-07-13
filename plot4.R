## read file from web.
## you must be connected to internet
if (!file.exists("household_power_consumption.txt")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile="household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}
## read data from file
data<-read.table("household_power_consumption.txt", sep=";", 
                 header=FALSE, stringsAsFactors = FALSE, na.strings= "?",
                 skip=(66638-1), ## when you want to read from row X you must skip (x-1) rows
                 nrow=(69517-66638+1))
## add real column names
colnames(data)<-c("Date", "Time", "Global_active_power", 
                  "Global_reactive_power", "Voltage", "Global_intensity", 
                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## change the data first two column types from factor to date and time
data$DateTime<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## draw the plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2, 2))
## top left
plot(x=data$DateTime, y=data$Global_active_power, type = "l", xlab="", 
     ylab="Global Active Power", col="black")

## top right
plot(x=data$DateTime, y=data$Voltage, type = "l", xlab="datetime", 
     ylab="Voltage", col="black")

## bottom left
with(data, plot(DateTime, Sub_metering_1 , type="l", col="gray50", 
                xlab="", ylab="Energy sub metering"))
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", pch="-", col=c("gray50", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## bottom right
plot(x=data$DateTime, y=data$Global_reactive_power, type = "l", xlab="datetime", 
     ylab="Global Reactive Power", col="black")

dev.off()
