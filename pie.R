df <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50)
  )
head(df)

library(ggplot2)
library(RColorBrewer)

bp<- ggplot(df, aes(x="", y=value, fill=group))+
geom_bar(width = 1, stat = "identity") 
 
pie <- bp + coord_polar("y", start=0) 
 


############################################################
############################################################
############################################################
library(extrafont)

library(ggplot2)
library(RColorBrewer)

 blank_theme <- theme_minimal()+
  theme(
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  panel.border = element_blank(),
  panel.grid=element_blank(),
  axis.ticks = element_blank(),
  plot.title=element_text(size=14, face="bold")
  )

  
dat<-data.frame( c(39331374279,2940504221 ,12867887434),
	c("USPS Marketing Mail letters","Periodicals",
		"USPS Marketing Mail flats") )
names(dat)<-c("Volumes","Product")
dat$percent<-100*round(dat$Volumes/sum(dat$Volumes),4)
str(dat)
dat$Product<-as.factor(dat$Product)

options(scipen=10000)


bp<- ggplot(dat, aes(x="", y=Volumes, fill=Product))+
	geom_bar(width = 1, stat = "identity")  +
 	geom_text(aes(label = dat$percent), 
	position = position_stack(vjust = 0.5 ),  
	family="Calibri",color="white")

pie <- bp + coord_polar("y", start=0) 

pie <-pie + scale_fill_brewer(palette ="Paired") + blank_theme +	
	theme(axis.text.x=element_blank())   + 
  theme(plot.title = element_text(hjust = 0.5) ) +
    theme(legend.position="bottom",legend.title=element_blank(),	) 

 
 
pie + theme(text=element_text(size=10,  family="Calibri")) 



############################################################
############################################################
############################################################

	labs(title = "FY17 Measured Volumes by Product")  

pie <- pie+  theme(plot.title = element_text(  size=12, face="plain"))


dat$Product= factor(dat$Product,levels(dat$Product)[c(3,1,2)])
require(scales)
dat$Volumes<-dat$Volumes/1000 
dat$Volumes/2
 
BP<- ggplot(dat, aes(x=Product, y=Volumes, fill=Product))+
	geom_bar(width = .9, stat = "identity")  + coord_flip() + 
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
	  theme(legend.position="bottom",legend.title=element_blank()) +
	ylim(0,40000000) +scale_fill_brewer(palette ="Paired") + 
	labs(title = "FY17 Measured Volumes by Product") +
  theme(plot.title = element_text(hjust = 0.5))
	

BP +   coord_polar("y", start=0) 


