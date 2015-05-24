install.packages("plyr")
install.packages("ggplot2")
library("plyr")
library("ggplot2")

## Reading the files using the readRDS function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Converting year  to a Factor to plot against Emission totals
data <-transform(NEI,type=factor(type),year=factor(year))
#Subsetting Baltimore
BaltimoreCity <- data[data$fips=="24510",]

## Filtering Vehicles data in SCC by checking in Level Two Column
vehicles <-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"

mergedata <- merge(vehicles,BaltimoreCity,by="SCC")

## Plotting the Data
plottingdata<-ddply(mergedata,.(year),summarize,sum=sum(Emissions))
png("plot5.png")
gplot<-ggplot(plottingdata,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from MotorVehicles in Baltimore",y="PM2.5 emissions/year")
dev.off()