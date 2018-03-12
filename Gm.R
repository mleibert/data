scores<-scores[ order(scores$GrandMean), ]
scores$GMrank<-NA
library("viridis")

scores[1:10,4]<-1
scores[11:21,4]<-2
scores[22:34,4]<-3
scores[35:47,4]<-4
scores[48:59,4]<-5
scores[59:nrow(scores),4]<-6

head(scores)
names(scores)[1]<- "Districts"
scores$Districts<-paste0(scores$Districts," District" )

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



 ggplot() + geom_polygon(data = sdf, aes(x=long, y = lat, group = group ,
	fill = as.factor(bin)) ) + theme_void() + 
	 scale_fill_manual(values =colorz ,labels=  namez )  

ggplot() +   geom_polygon(data = sdf, aes(fill = GM,x = long, 
	y = lat, group = group)) + 
	 scale_fill_viridis(option = "magma", direction = -1)
 











