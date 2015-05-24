
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
NEIdata<-transform(NEI,year=factor(year))
## checking for Combustion and Coal keywords in the SCC data set.
combustiondata <-as.data.frame(SCC[grep("combustion",SCC$SCC.Level.One,ignore.case=T) & grep("coal",SCC$SCC.Level.Three,ignore.case=T),1])
names(combustiondata)<-"SCC"
plottingdata<-merge(combustiondata,NEIdata,by="SCC")
#Plot Data
plotdata<-ddply(plottingdata,.(year),summarize,sum=sum(Emissions))
png("plot4.png")
gplot4<-ggplot(plotdata,aes(year,sum))
gplot4+geom_point(size=4)+labs(title="PM2.5 Emissions from coal combustion-related sources ",y="PM2.5 emission/year")
dev.off()