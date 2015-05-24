## Unzip the zip file and Set Working directory  to the NEI Data 
## setwd("C:/R/exdata_data_NEI_data")

install.packages("plyr")
install.packages("ggplot")
library("plyr")
library("ggplot2")

## Reading the files using the readRDS function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## Converting year  to a Factor to plot against Emission totals
data<-transform(NEI,year=factor(year))
Baltimoredata <- data[data$fips=="24510",]

## Plyr functionto use the ddply function to summarize sum of Emissions
plottingdata <- ddply(Baltimoredata,.(year,type),summarize,sum=sum(Emissions))
png("plot3.png")
gplot <- ggplot(plottingdata,aes(year,sum))
gplot+geom_point()+facet_grid(.~type)+labs(title="PM2.5 Emissions in Baltimore",y="PM2.5 emission/year")
dev.off()
