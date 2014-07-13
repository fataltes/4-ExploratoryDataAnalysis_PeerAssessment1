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

## draw the plot
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", col="red", main="Global Active Power")
dev.off()
