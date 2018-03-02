read.csv("G:\\2803\\data\\mergeintoci17.csv")


rm(list = ls())
library(readxl)
library(dplyr)
library(ggplot2)
library("RColorBrewer")
library(extrafont)
 
driv<-"G:\\2803\\data\\mergetintoCI17.xlsx"

scores<-as.data.frame(read_excel(driv, sheet="Sheet1" ))

scores<-scores[1:201,]


scores<-data.frame(
	scores[which(scores[,1] == "District"),2],
	scores[which(scores[,1] == "GrandMean"),2],
	scores[which(scores[,1] == "Response Rate"),2] ,
	stringsAsFactors=F)

names(scores)<-c("District","GrandMean","Response.Rate")
scores[,2 ]<-as.numeric(scores[,2 ])
scores[,3 ]<-as.numeric(scores[,3 ])

lm(scores$GrandMean~scores$Response.Rate)
summary(lm(scores$GrandMean~scores$Response.Rate))