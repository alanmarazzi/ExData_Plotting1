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

# For this plot we want the time series of Global Active Power variable

# To replicate the result of the example I had to add before the plot this chunk of code:
# Sys.setlocale("LC_ALL", "en_US.utf8")
# This is needed to have the name of the days in English (since my system is in Italian).
# If you have the same issue simply delete the # before the code and run it (be aware that
# the .utf8 extension will work only on linux OS)

png("plot2.png", units = "px", width = 480, height = 480)
plot(pwr$Date,pwr$Global_active_power, type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
