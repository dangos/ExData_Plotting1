wd <- "C:/Users/Dan/Documents/Coursera/Exploratory Data Analysis/Project 1"
setwd(wd)
getwd()

file <- list.files(pattern = ".txt")

# Read the file separated by ;
read <- read.csv(file,sep = ";", header = T, stringsAsFactors = F, na.strings = "?")

# Convert the row Date 
read$Date <- as.Date(strptime(read$Date,format = "%d/%m/%Y", tz="UTC"))

# Get the data only for the specific time 
newData <- read[read$Date == "2007-02-01" | read$Date =="2007-02-02",]
# Convert to numeric
newData$Global_active_power <- as.numeric(newData$Global_active_power)

Sys.setlocale("LC_TIME", "English")

newData$DateTime <-as.POSIXct(paste(newData$Date,newData$Time))

png("plot4.png",width = 480,height = 480)
par(mfrow = c(2,2))

# Plot 1
plot(y = newData$Global_active_power, x = newData$DateTime,type = "l",ylab = "Global Active Power (kilowatss)",xlab = "")
# Plot 2
plot(y = newData$Voltage, x = newData$DateTime,type = "l",ylab = "Voltage",xlab = "datetime")
# Plot 3
plot(y = newData$Sub_metering_1, x = newData$DateTime,type = "l",ylab = "Energy sub metering",xlab = "")
lines(newData$DateTime,newData$Sub_metering_2,col="red")
lines(newData$DateTime,newData$Sub_metering_3,col="blue")
legend("topright",col = c("black","red","blue"),lty = 1,lwd=2,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),adj = c(.05,.05), cex = .5)

# Plot 4
plot(y = newData$Global_reactive_power, x = newData$DateTime,type = "l", ylab = "Global_reactive_power (kilowatss)",xlab = "datetime")

dev.off()
