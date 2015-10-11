wd <- "C:/Users/Dan/Documents/Coursera/Exploratory Data Analysis/Project 1"
setwd(wd)
getwd()

file <- list.files()

# Read the file separated by ;
read <- read.csv(file,sep = ";", header = T, stringsAsFactors = F)

# Convert the row Date 
read$Date <- as.Date(strptime(read$Date,format = "%d/%m/%Y", tz="UTC"))

# Get the data only for the specific time 
newData <- read[read$Date == "2007-02-01" | read$Date =="2007-02-02",]
# Convert to numeric
newData$Global_active_power <- as.numeric(newData$Global_active_power)

png("plot1.png",width = 480,height = 480)
hist(newData$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", 
     main = "Global Active Power")
dev.off()