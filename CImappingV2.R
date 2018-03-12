rm(list = ls())
library(readxl)
 library(ggthemes)
 setwd("G:\\2803\\data")

source("G:\\2803\\data\\DistrictBorders.R")
head(ADZ)

CI<-as.data.frame(read_excel("G:\\2803\\data\\CI17.xlsx", sheet="district"))
CI$color<-NA

for( i in 1:6){	 CI[which( CI$Rank >= seq(0,65,10)[i] &
			CI$Rank < seq(0,65,10)[i+1] ),ncol(CI)] <-i}
CI[which(CI$Rank >= 60),ncol(CI)]<-7


 


################################################################
################################################################
################################################################
################################################################


shapefile <- readOGR("G:\\2803\\data", "zip3")
sdf<-fortify(shapefile)



#############
#https://postcalc.usps.com/DomesticZoneChart
#https://en.wikipedia.org/wiki/List_of_ZIP_code_prefixes

head(sdf)
nrow(sdf)

#within the actual shapefile (zip3.shp) had the actual zip3 IDs
#in order
head(shapefile[[1]])

#create a new data frame with those zip3s and place and id from 0 to 2374
tdf<-data.frame(shapefile[[1]],0:(length(shapefile[[1]])-1))
colnames(tdf)<-c("zip","id")
head(tdf);nrow(tdf)

head(sdf)
nrow(sdf)
#unique(sdf$group)
### sdf$id == tdf$id


tdf<-merge(sdf,tdf,by="id")
nrow(tdf)
head(tdf)
head(ADZ)

 

### http://slideplayer.com/slide/7858742/
 

 
 tdf<-merge(tdf,ADZ,"zip")

 


head(tdf)

nrow(tdf)
 

#dip<-data.frame(unique(dis[,1]),	sample( seq(3,17,.01) , 
#	length(unique(dis[,1])), replace = T) )
#colnames(dip)<-c("district","dip")
#tdf<-merge(tdf,dip,"district")
 


tdf<- tdf[order(tdf$group),] 
head(tdf)
head(sdf)

 
sdf$zip<-tdf$zip
sdf$district<-tdf$district
sdf$bin<-NA


 for( i in 1:nrow(CI)) {
	sdf[which( CI$Districts[i] == sdf$district ),ncol(sdf)]<-
		CI[i,(ncol(CI))]	}


head(sdf)
head(CI)

## change colors from #1-10 to Dark forest green, remove 11-20 color


colorz<-c('#A91101', '#f46d43','#fdae61' ,'#e6f598',
	'#abdda4','#66c2a5','#4CBB17')


colorz<-c('#A91101', '#f46d43','#fdae61' ,'#e6f598',
	'#abdda4','#4CBB17','#228B22')

colorz<-rev(colorz)
length(colorz)

namez<-c("1-10","11-20","21-30","31-40","41-50","51-60","60-67")
legendz<-"Rank" 


CImap<-ggplot() + geom_polygon(data = sdf, aes(x=long, y = lat, group = group ,
	fill = as.factor(bin)) ) + theme_void()  

 
CImap  + geom_polygon(data = bdf, 
            aes(x=long, y=lat, group = group) ,  colour = "#000000", 
            fill = NA, size = .2)  + 
		geom_polygon(data = bdf, 
            aes(x=long, y=lat, group = group) ,  colour = "gray", 
            fill = NA, size = .2)  + 
		guides(fill =  guide_legend(title= legendz )) +
 		 theme(plot.title = element_text( hjust = 0.5 , vjust=-3,
			color="#67a9cf", face="bold", size=14)	) + 
		  coord_map()+ 
		 scale_fill_manual(values =colorz ,labels=  namez ) 

 CImap  + scale_fill_brewer(palette = "RdYlGn")


CImap  + geom_polygon(data = bdf, 
            aes(x=long, y=lat, group = group) ,  colour = "#000000", 
            fill = NA, size = .2)  + 
		geom_polygon(data = bdf, 
            aes(x=long, y=lat, group = group) ,  colour = "gray", 
            fill = NA, size = .2)  + 
		guides(fill =  guide_legend(title= legendz )) +
			labs(title=titlez   ) +
 		 theme(plot.title = element_text( hjust = 0.5 , vjust=-3,
			color="#67a9cf", face="bold", size=14)	) + 
		  coord_map()+ 
		scale_fill_brewer(palette = "RdYlGn",direction = -1)

 
