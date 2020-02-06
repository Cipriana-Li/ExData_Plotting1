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

#Specify the the number of subplots and margin
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(2,2,2,2))

#Draw the plots
with(Specificdates, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="",cex.axis=0.7,cex.lab=0.7)
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime",cex.axis=0.7,cex.lab=0.7)
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="",cex.axis=0.7,cex.lab=0.7)
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",cex.axis=0.7,cex.lab=0.7,ylab="Global_rective_power", xlab="datetime")
})

#Save it to PNG file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
