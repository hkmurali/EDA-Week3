install.packages("plyr")
install.packages("ggplot2")
library("plyr")
library("ggplot2")

## Reading the files using the readRDS function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
  
## Converting year  to a Factor to plot against Emission totals
data <-transform(NEI,type=factor(type),year=factor(year))
cities <- data[data$fips=="24510"|data$fips=="06037",]

## Filtering Vehicles data in SCC by checking in Level Two Column
vehicles <-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"

mergedata <- merge(vehicles,cities,by="SCC")
#Creating a column called City
mergedata$city[mergedata$fips=="24510"] <- "Baltimore"
mergedata$city[mergedata$fips=="06037"] <- "LA"

## Plotting the Data
plottingdata<-ddply(mergedata,.(year,city),summarize,sum=sum(Emissions))
png("plot6.png")
gplot<-ggplot(plottingdata,aes(year,sum))
gplot+geom_point(size=4,aes(color=city))+labs(title="PM2.5 Emission from MotorVehicles",y="PM2.5 emissions/year")
dev.off()