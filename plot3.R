# Creating dataset
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./household_power_consumption.txt")){
     if(!file.exists("./household_power_consumption.zip")){
          download.file(fileurl,destfile = "./household_power_consumption.zip")}
     unzip("./household_power_consumption.zip")
}

df<-read.table("./household_power_consumption.txt",sep=";", header=TRUE)

## Formatting
library(lubridate)
df$Date_Time<-dmy_hms(paste(df$Date,df$Time))
df$Date<-dmy(df$Date)
df$Time<-hms(df$Time)
df[,3:8]<-lapply(df[,3:8],as.numeric)


# Subsetting
df_sub <- subset(df, subset=(Date %in% c(ymd("2007-02-01"),ymd("2007-02-02"))))

# Plotting
## Canvas
plot(Sub_metering_1~Date_Time,data=df_sub, type="n",
     ylab="Energy sub metering",
     xlab="")
## Lines
lines(Sub_metering_1~Date_Time,data=df_sub,col='Black')
lines(Sub_metering_2~Date_Time,data=df_sub,col='Red')
lines(Sub_metering_3~Date_Time,data=df_sub,col='Blue')
## Legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
