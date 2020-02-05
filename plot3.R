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

#Do the plotting and legend
with(Specificdates,{
  plot(Sub_metering_1~Datetime,ylab="Energy sub metering",xlab="",type="l")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  })
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
       
#Export to png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
