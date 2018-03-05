library(sp)
library(maptools)
library(rgeos)
library(rgdal)
library(dplyr)
library(ggplot2)
require("ggthemes")
library(ggalt)
library(mapproj)

ADZ<-read.csv("G:/viz/realdist.csv")
shapefile <- readOGR("G:/zip3", "zip3")
ADZ$zip<-sprintf("%03d", ADZ[,ncol(ADZ)])

shapefile@data

shapefile@data$district<-NA
for(i in 1:nrow(shapefile@data) ) {
	shapefile@data[i,2]<- ADZ[ which(  ( 
		shapefile@data[i,1] ) ==
		ADZ$zip) ,1] }
 

gIsValid(shapefile)
shapefile<-gBuffer(shapefile, byid = TRUE, width = 0);gIsValid(shapefile)
shapefile<-gUnaryUnion(shapefile, shapefile@data$district)

bdf<-fortify(shapefile)
head(bdf)

 
  

