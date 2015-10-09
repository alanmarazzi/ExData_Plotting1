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

# For the first plot we want a red histogram of Global Active Power
png("plot1.png", units = "px", width = 480, height = 480) # First create the png file
hist(pwr$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (Kilowatts)") # This is all plot code
dev.off() # Always remember to close the device or the script won't write the png file

