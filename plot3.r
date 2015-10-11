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



png("plot3.png",width = 480,height = 480)
plot(y = newData$Sub_metering_1, x = newData$DateTime,type = "l",ylab = "Energy sub metering",xlab = "")
lines(newData$DateTime,newData$Sub_metering_2,col="red")
lines(newData$DateTime,newData$Sub_metering_3,col="blue")
legend("topright",col = c("black","red","blue"),lty = 1,lwd=2,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
