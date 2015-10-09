# First let's set the working directory where we have the dataset
setwd("your/working/directory")

# Now we can read the dataset I renamed pwr.txt for simplicity. It is pretty large,
# so be careful.
pwr <- read.table("pwr.txt", sep = ";", header = T, na.strings = "?")

# I will use the "dplyr" package to subset data, it is faster, easier and more readable.
library(dplyr)

# We want just the data for February the 1st and 2nd
pwr <- filter(pwr, Date == "1/2/2007" | Date == "2/2/2007")

# Date and Time variables are loaded as factors in the dataframe, we want a unique variable
# of class "Time" (POSIXlt POSIXt)
pwr$Date <- strptime(paste(pwr$Date,pwr$Time), "%d/%m/%Y %H:%M:%S")

# For this plot we want 4 plots on the same view

# To replicate the result of the example I had to add before the plot this chunk of code:
# Sys.setlocale("LC_ALL", "en_US.utf8")
# This is needed to have the name of the days in English (since my system is in Italian).
# If you have the same issue simply delete the # before the code and run it (be aware that
# the .utf8 extension will work only on linux OS)

png("plot4.png", units = "px", width = 480, height = 480)

# To divide the plot in 4 parts we have to use par(mfrow = ), the mar = variable is optional
par(mfrow = c(2,2), mar = c(4,4,1.5,1.5))

# Afterwards we have to fill the plot one by one, the spaces are filled by row
plot(pwr$Date,pwr$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=""
) # 1st plot top-left

plot(pwr$Date, pwr$Voltage, 
     type = "l", 
     ylab = "Voltage", 
     xlab = ""
) # 2nd plot top-right


plot(pwr$Date, pwr$Sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Energy sub metering (kilowatts)") 
points(pwr$Date, pwr$Sub_metering_1, type = "l")
points(pwr$Date, pwr$Sub_metering_2, type = "l", col = "red")
points(pwr$Date, pwr$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 0.5,
       lty = c(1,1),
       col = c("black", "red", "blue")) #3rd plot bottom-left


plot(pwr$Date, pwr$Global_reactive_power, 
     type = "l", 
     ylab = "Global_reactive_power", 
     xlab = ""
) #4th plot bottom-right

dev.off()