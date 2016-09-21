#Reading the data and organizing the variables ----

setwd("Curso de R/Exploratory Analysis") #setting work directory
if(!dir.exists("./data")) dir.create("./data") #creating a unique directory to work with

##Unzipping the file
if(file.exists("./exdata-data-household_power_consumption.zip")){
        if(!file.exists("./data/household_power_consumption.txt")){
                unzip("./exdata-data-household_power_consumption.zip", exdir= "./data")
        } else cat("File already unzipped")
}else cat("Please, put the household power consumption zip file on your working directory")

##Reading the data.frame

h_power<- read.table("./data/household_power_consumption.txt", header = TRUE,
                     sep = ";", na.strings = "?", dec = ".", stringsAsFactors = FALSE)
h_power$Date.Time <- paste(h_power$Date, h_power$Time)
h_power$Date.Time <- strptime(h_power$Date.Time, "%d/%m/%Y %H:%M:%S")
h_power$Date <- as.Date(h_power$Date, "%d/%m/%Y")
h_power <- h_power[,c(1,2,10,3:9)]

##Subsetting the data

h_power_sub <- subset(h_power, Date == "2007-02-01" | Date == "2007-02-02")
unique(h_power_sub$Date) #checking if the two days are there
rm(h_power) #removing the unnecessary data

#Plot 1 ----

png("plot1.png")
par(mar = c(5, 4, 2, 2))
hist(h_power_sub$Global_active_power, main = "Global Active Power",
     col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()
