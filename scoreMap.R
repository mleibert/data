read.csv("G:\\2803\\data\\mergeintoci17.csv")


rm(list = ls())
library(readxl)
library(dplyr)
library(ggplot2)
library("RColorBrewer")
library(extrafont)
 library("viridis")

driv<-"G:\\2803\\data\\mergetintoCI17.xlsx"
source("G:\\2803\\data\\CImappingV2.R")

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




################################################################

scores<-scores[ order(scores$GrandMean), ]
scores$GMrank<-NA

scores[1:10,4]<-1
scores[11:21,4]<-2
scores[22:34,4]<-3
scores[35:47,4]<-4
scores[48:59,4]<-5
scores[59:nrow(scores),4]<-6

head(scores)
names(scores)[1]<- "Districts"
scores$Districts<-paste0(scores$Districts," District" )



################################################################
################################################################
################################################################

head(sdf)
sdf$binn<-NA


 for( i in 1:nrow(CI)) {
	sdf[which( scores$Districts[i] == sdf$district ),ncol(sdf)]<-
		scores[i,(ncol(scores))]	}

sdf$GM<-NA
for( i in 1:nrow(CI)) {
	sdf[which( scores$Districts[i] == sdf$district ),ncol(sdf)]<-
		scores[ which( scores$Districts == scores$Districts[i]),]$
			GrandMean }



 display.brewer.all(type="div")


p<-ggplot() +   geom_polygon(data = sdf, aes(fill = GM,x = long, 
		y = lat, group = group) ) +
	geom_polygon(data = bdf, aes(x=long, y=lat, group = group) ,
		colour = "#000000", fill = NA, size = .2)  +    
	theme_void(  )+ theme(panel.grid.major = element_blank(),
		panel.grid.minor = element_blank()) +
	geom_polygon(data = bdf, aes(x=long, y=lat, group = group) ,
		colour = "gray", fill = NA, size = .2)  #+   coord_map() 
 

#p+  scale_fill_gradient2(low = "orange",    high = "red" ,
#	 midpoint = mean( scores[,2] ))



 p+ scale_fill_distiller(name="Mean", palette = "RdBu", direction= 1 )

p+ scale_fill_distiller(name="Percent", palette = "RdYlGn", direction= 1 )
 p+ scale_fill_distiller(name="Percent", palette = "PiYG", direction= 1 )
 p+ scale_fill_distiller(name="Percent", palette = "Spectral", direction= 1 )



scores



 
###### Response Rates

sdf$rr<-NA
for( i in 1:nrow(CI)) {
	sdf[which( scores$Districts[i] == sdf$district ),ncol(sdf)]<-
		scores[ which( scores$Districts == scores$Districts[i]),]$
			Response.Rate}


q<-ggplot() +   geom_polygon(data = sdf, aes(fill = rr,x = long, 
		y = lat, group = group) ) +
	geom_polygon(data = bdf, aes(x=long, y=lat, group = group) ,
		colour = "#000000", fill = NA, size = .2)  +   theme_void()+
	geom_polygon(data = bdf, aes(x=long, y=lat, group = group) ,
		colour = "gray",  fill = NA, size = .2)  #+   coord_map() 


 q+ scale_fill_distiller(name="Percent", palette = "PiYG", direction= 1 )
 q+ scale_fill_distiller(name="Percent", palette = "BrBG", direction= 1 )
 q+ scale_fill_distiller(name="Percent", palette = "PRGn", direction= 1 )




p +  scale_fill_viridis(  direction= -1)
 p+ scale_fill_distiller(name="Mean", palette = "RdBu", direction= 1 )
 q+ scale_fill_distiller(name="Percent", palette = "PRGn", direction= 1 )


############
library(tidyverse)


scores

h.v<-quantile(scores[,2],c(0.33,0.66,1))
p.v<-quantile(scores[,3] ,c(0.33,0.66,1))

h.v
( scores[which(scores[,2]  < 3.16),] )
( scores[which(3.1600   < scores[,2] & scores[,2]  < 3.3056),] )
( scores[which(scores[,2]  > 3.3056),] )



scores$A<-ifelse(scores[,2] <h.v[1],1,ifelse(scores[,2] <h.v[2],2,3))
scores$B<-ifelse(scores[,3] <p.v[1],1,ifelse(scores[,3] <p.v[2],2,3))



head(scores)

colourz<-paste0("#",c( "e8e8e8","e4acac","c85a5a","b0d6df","ad9ea5",
	"985356","64acbe","627f8c","574249" ) )

 scores$colourz<-NA

for( i in 1:nrow(scores) ) {

	if( scores$A[i] == 1 && scores$B[i] == 1  ) {scores$colourz[i]<-colourz[1] 
		} else if (
	scores$A[i] == 1 &  scores$B[i] == 2  ) {scores$colourz[i]<-colourz[2] 
		} else if (
	scores$A[i] == 1 &  scores$B[i] == 3  ) {scores$colourz[i]<-colourz[3] 
		} else if (
	scores$A[i] == 2 &  scores$B[i] == 1  ) {scores$colourz[i]<-colourz[4] 
		} else if (
	scores$A[i] == 2 &  scores$B[i] == 2  ) {scores$colourz[i]<-colourz[5] 
		} else if (
	scores$A[i] == 2 &  scores$B[i] == 3  ) {scores$colourz[i]<-colourz[6] 
		} else if (
	scores$A[i] == 3 &  scores$B[i] == 1  ) {scores$colourz[i]<-colourz[7] 
		} else if (
	scores$A[i] == 3 &  scores$B[i] == 2  ) {scores$colourz[i]<-colourz[8] 
		} else   {scores$colourz[i]<-colourz[9] 
		}  
}

scores$colourz<-as.numeric(scores$colourz)

sdf$colourz<-NA
for( i in 1:nrow(CI)) {
	sdf[which( scores$Districts[i] == sdf$district ),ncol(sdf)]<-
		scores[ which( scores$Districts == scores$Districts[i]),]$
			colourz}


ggplot(sdf) +   geom_polygon( aes(long,lat,group=group,
	fill=factor(colourz))) + scale_fill_manual(values = colourz) +

	geom_polygon(data = bdf, aes(x=long, y=lat, group = group) ,
		colour = "#000000", fill = NA, size = .2)  +    
	theme_void(  )+ theme(panel.grid.major = element_blank(),
		panel.grid.minor = element_blank()) +
	geom_polygon(data = bdf, aes(x=long, y=lat, group = group) ,
		colour = "gray", fill = NA, size = .2)  #+   coord_map() 
 

 
legendGoal=melt(matrix(1:9,nrow=3))
test<-ggplot(legendGoal, aes(Var1,Var2))+ geom_tile(aes(fill = as.factor(value)))
test<- test + scale_fill_manual(name="Var1 vs Var2",
	values=colourz,drop=FALSE)
test + labs(x = expression(1 %->% 2)  )


