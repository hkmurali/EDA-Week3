## Unzip the zip file and Set Working directory  to the NEI Data 
## setwd("C:/R/exdata_data_NEI_data")

install.packages("plyr")
library("plyr")
## Reading the files using the readRDS function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Converting year  to a Factor to plot against Emission totals
data<-transform(NEI,year=factor(year))
Baltimoredata <- data[data$fips=="24510",]

## Plyr package to use the ddply function to summarize sum of Emissions
plottingdata <- ddply(Baltimoredata,.(year),summarize,sum=sum(Emissions))
png("plot2.png")
plot(plottingdata$year,plottingdata$sum,type="n",xlab="year",ylab="total PM2.5 Emission in Baltimore")
lines(plottingdata$year,plottingdata$sum)
dev.off()
