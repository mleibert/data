rm(list = ls())
library(readxl)
library(dplyr)
library(ggplot2)
library("RColorBrewer")

driv<-"C:\\Users\\Administrator\\Documents\\data\\CI17.xlsx"

accident<-as.data.frame(read_excel(driv, sheet="accidents"))

######## EXAMPLE 
# https://statkclee.github.io/R-ecology-lesson/05-visualization-ggplot2.html
 

head(accident)
 
accidents<-list()

for(  i in 1:length(c(2,3,5:7)) ){ j<-c(3,5,7,2,6)[i]
	accidents[[i]]<-data.frame(rep(names(accident)[j],nrow(accident)),
		accident[,j])
	names(accidents[[i]])<-c("type","total")
	accidents[[i]]$year<-as.factor(2014:2017)
}

accidents<-do.call("rbind", accidents)


 
ggplot(data = accidents, aes(x = year, y = total, group = 
	type, colour = type)) +    geom_bar() +
    theme(legend.position="bottom")



accidents
dev.new(width=6.5, height=3)

ggplot(data=accidents[1:12,], aes(x=year, y=total, fill=year)) +
  geom_bar(stat="identity", position=position_dodge() ) +
	facet_wrap(~ type) + theme(legend.position="none") +
  scale_fill_brewer(palette="Paired") + theme(
  plot.title = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank())
#previous color Pastel1


ggplot(data=accidents[13:nrow(accidents),], aes(x=year, y=total, fill=year)) +
  geom_bar(stat="identity", position=position_dodge() ) +
	facet_wrap(~ type) + theme(legend.position="none") +
  scale_fill_brewer(palette="Paired") + theme(
  plot.title = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank())
#previous color Dark2


###


ggplot(data=accidents[1:12,], aes(x=year, y=total, fill=year)) +
	geom_bar(stat="identity", position=position_dodge() ) +
	facet_wrap(~ type) + theme(legend.position="none") +
	scale_fill_brewer(palette="Paired") +   #theme_minimal() +
	theme(  plot.title = element_blank(),axis.title.x = element_blank(),
		axis.title.y = element_blank()) + 
	theme(legend.position="none")   

ggplot(data=accidents[13:nrow(accidents),], aes(x=year, y=total, fill=year)) +
	geom_bar(stat="identity", position=position_dodge() ) +
	facet_wrap(~ type) + theme(legend.position="none") +
	scale_fill_brewer(palette="Paired") +   #theme_minimal() +
	theme(  plot.title = element_blank(),axis.title.x = element_blank(),
		axis.title.y = element_blank()) + 
	theme(legend.position="none") 

brewer.pal(12, "Paired")



acd<-accidents[5:12,];acd[,1]<-as.character(acd[,1])
acd[which(acd$type=="MVAs"),1]<-"Motor Vehicle Accidents"
acd[,1]<-as.factor(acd[,1])

ggplot(acd, aes(x= year,y=total, fill = type) ) + 
	geom_bar(stat = "identity" ) + 	theme_minimal()   +	
	theme(legend.position="bottom",legend.title = element_blank()) +
  	scale_fill_brewer(palette="Paired") + 
	theme(axis.title.x = element_blank(),axis.title.y = element_blank())

ggplot(acd) + 
	geom_bar(stat = "identity" ,aes(x= year,y=total, fill = type) ) + 	
	theme_minimal()   +	
	theme(legend.position="bottom",legend.title = element_blank()) +
	scale_fill_manual(values = c(brewer.pal(12, "Paired")[3],
	brewer.pal(12, "Paired")[1]))	+	
	theme(axis.title.x = element_blank(),axis.title.y = element_blank())

##########################################
##########################################

top2<-as.data.frame(read_excel("G:\\2803\\CI17.xlsx", sheet="top2"))
top2<-top2[c(4:6,1:3),]


#ggplot(data=top2, aes(x=sideswipe, y=count, fill=year)) +
#  geom_bar(stat="identity", position=position_dodge())+
#  geom_text(aes(label=count), vjust=1.6, color="white",
#            position = position_dodge(0.9), size=3.5)+
#  scale_fill_brewer(palette="Paired")+
#  theme_minimal()+ scale_x_discrete(labels= SoilSciGuylabs)


 

ggplot(data=top2, aes(x=year, y=count, fill=year)) +
	geom_bar(stat="identity", position=position_dodge() ) +
	facet_wrap(~ sideswipe) + theme(legend.position="none") +
	scale_fill_brewer(palette="Paired") + 
	geom_text(aes(label=count), vjust=1.6, color="white",
		position = position_dodge(0.9), size=3.5)+
	theme_minimal()+
	theme(axis.title.x=element_blank() ,axis.title.y=element_blank()  )+ 
	labs(title = "Collision / Sideswipe", subtitle=" ")+
	theme(plot.title = element_text(hjust = 0.5))+ 
	theme(legend.position="none")   


 
