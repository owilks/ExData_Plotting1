library(data.table)
#Opening up the graphics device and setting the specified measurements in the assignment.
png(filename="Plot3.png",width=480,height=480)
#Reading in the data and creating a "datetime" variable from the respective columns
edata <-read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)
edata$Datetime <- as.POSIXct(paste(edata$Date, edata$Time), format="%d/%m/%Y %H:%M:%S")
#Additionally converted the "Date" field since it was much easier to subset using that,
#than to subset using the full Datetime field!
edata$Date <- as.Date(edata$Date,format="%d/%m/%Y",origin="01/01/1970")
esub <-subset(edata,Date>="2007-02-01"&Date<="2007-02-02")
rm(edata)
#With the datetime field there was no need to convert the "Time" column, but all of the
#other values needed to be converted from character to numeric. This is where the
#data.table package was useful for just having shorter more efficient code
esub <- transform(esub,Global_active_power=as.numeric(Global_active_power))
esub <- transform(esub,Global_reactuve_power=as.numeric(Global_reactive_power))
esub <- transform(esub,Voltage=as.numeric(Voltage))
esub <- transform(esub,Global_intensity=as.numeric(Global_intensity))
esub <- transform(esub,Sub_metering_1=as.numeric(Sub_metering_1))
esub <- transform(esub,Sub_metering_2=as.numeric(Sub_metering_2))
esub <- transform(esub,Sub_metering_3=as.numeric(Sub_metering_3))
#As many of the initial parameters as possible were included directly in the initial
#plot call for the graph!
plot(esub$Datetime,esub$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
#Then the points were added in one by one, finishing with the call for the legend
points(esub$Datetime,esub$Sub_metering_1,type="l")
points(esub$Datetime,esub$Sub_metering_2,type="l",col="red")
points(esub$Datetime,esub$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=c(1,1,1))
dev.off()
