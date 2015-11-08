electric <- read.table("household_power_consumption.txt",header=TRUE,sep=";")
head(electric)
elecD <- electric$Date
elecT <- electric$Time
elecDT <- electric[,1:2]
head(elecDT)
elecD <- as.Date(elecDT[,1],"%d/%m/%Y")
head(elecD)
electric[,1] <- elecD
head(electric)
elecfebone07 <- subset(electric,electric$Date=="2007-02-01")
elecfebtwo07 <- subset(electric,electric$Date=="2007-02-02")
elecfeb <- rbind(elecfebone07,elecfebtwo07)
elecfebDT <- paste(elecfeb$Date,elecfeb$Time)
head(elecfebDT)
p <- as.POSIXct(elecfebDT)
head(p)
head(elecfeb)
ques <- elecfeb$Global_active_power=="?"
elecfeb$Global_active_power[ques] <- NA
elecfebKW <- as.numeric(elecfeb$Global_active_power) / 1000
png(file = "plot4.png")
par(mfcol = c(2,2))
plot(p,elecfebKW,type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")
plot(p,elecfeb$Sub_metering_1,type = "n",xlab = "", ylab = "Energy sub metering")
lines(p,elecfeb$Sub_metering_1)
lines(p,elecfeb$Sub_metering_2,col="red")
lines(p,elecfeb$Sub_metering_3,col="blue")
legend("topright", pch = "-", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(p,elecfeb$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(p,elecfeb$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()