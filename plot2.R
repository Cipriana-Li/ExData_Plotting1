#Download the file, put the file in the data folder and unzip the file
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Household.zip",method="curl")
unzip(zipfile="./data/Household.zip",exdir="./data")

#Read data from the files and create a variable to store it
Householddata<- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")

#Subset the rows only on the dates 2007-02-01 and 2007-02-02 from the file
Specificdates<-subset(Householddata,Date %in% c("1/2/2007","2/2/2007"))

#Change the format of the date
Specificdates$Date<-as.Date(Specificdates$Date,format="%d/%m/%Y")

#Combine date and time
datetime<-paste(as.Date(Specificdates$Date),Specificdates$Time)

#Create a column in the data to store date and time
Specificdates$Datetime<-as.POSIXct(datetime)

#Do the plotting
with(Specificdates,plot(Global_active_power~Datetime,ylab="Global Active Power (kilowatts)",xlab="",type="l"))

#Create png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
