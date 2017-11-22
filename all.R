STcsv
options(stringsAsFactors=FALSE)
library(plyr)


getwd()
setwd("G://data//owned")

STcsv<-list.files()

STcsv<-substr(STcsv,1,2)

owned<-list()

for(i in 1:length(STcsv)){ owned[[i]]<-read.csv(paste0(STcsv[i],"owned.csv"),
	header=T,stringsAsFactors=F);	owned[[i]]<-owned[[i]][-c(1:2),-1]
	names( owned[[i]] )<-as.character(owned[[i]][1,])
	names( owned[[i]] )<-gsub(" ","",colnames(owned[[i]]))
	owned[[i]]<-owned[[i]][-1,]	}

STocsv<-STcsv

head(owned[[27]]	)


getwd()
setwd("G://data//leased")
STcsv<-list.files()

STcsv<-substr(STcsv,1,2)
STcsv

leased<-list()


for(i in 1:length(STcsv)){ leased[[i]]<-read.csv(paste0(STcsv[i],
	"lease.csv"),	header=T,stringsAsFactors=F) ;	
	leased[[i]]<-leased[[i]][-c(1:2),-1]
	names( leased[[i]] )<-as.character(leased[[i]][1,])	
	names( leased[[i]] )<-gsub(" ","",colnames(leased[[i]]))
	leased[[i]]<-leased[[i]][-1,]}

 

head( leased[[i]] )


STcsv %in% STocsv
length(STcsv )
length(STocsv)

intersect(colnames(leased[[i]]),colnames(owned[[1]]))

head(leased[[1]])
 head(owned[[1]])


for( i in 1:length(leased)){
for( j in 26:ncol(leased[[i]]) ) {
	leased[[i]][,j]<- as.numeric((gsub("\\$|,| ","",leased[[i]][,j] )))
} }

length(owned) 
for( i in 1:length(owned) ){
		owned[[i]][,ncol(owned[[i]])][ 
		which(owned[[i]][,ncol(owned[[i]])]=="")]<-0
	for( j in 22:23 ) {
		owned[[i]][,j]<- as.numeric((gsub("\\$|,| ","",owned[[i]][,j] )))
	} }


for( i in 1:length(leased)){leased[[i]][leased[[i]]==""] <- NA}
for( i in 1:length(owned)){owned[[i]][owned[[i]]==""] <- NA}

for( i in 1:length(leased)){leased[[i]]$leased <- 1}
for( i in 1:length(owned)){owned[[i]]$leased  <- 0}

for( i in 1:length(owned)){
	owned[[i]]<-owned[[i]][-which(owned[[i]][,1] == "Total"),]
	owned[[i]]<-owned[[i]][-which(owned[[i]][,1] == "Count"),]}

leased[[29]]<-leased[[29]][,-which(names(leased[[29]])=="Metrics")]
leased[[39]]<-leased[[39]][, -which(names(leased[[39]])=="Metrics")]

Lall<-do.call("rbind",  leased)

Oall<-do.call("rbind", owned)

setwd("G:\\data")
write.csv( bind_rows(Lall,Oall),"Foo.csv") 


dat<- bind_rows(Lall,Oall)
"leased" %in% names(dat)
