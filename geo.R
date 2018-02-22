getwd()
ifelse( "data" %in% list.files(), setwd("G:\\data"),
	setwd("C:\\Users\\Administrator\\Documents\\data")  )


options(stringsAsFactors = FALSE)
geocodeAdddress <- function(address) {
  require(RJSONIO)
  url <- "http://maps.google.com/maps/api/geocode/json?address="
  url <- URLencode(paste(url, address, "&sensor=false", sep = ""))
  x <- fromJSON(url, simplify = FALSE)
  if (x$status == "OK") {
    out <- c(x$results[[1]]$geometry$location$lng,
             x$results[[1]]$geometry$location$lat)
  } else {
    out <- NA
  }
  Sys.sleep(0.2)  # API only allows 5 requests per second
  out}

dat<-read.csv("Foo.csv",header=T)
dat<-(data.frame(dat$leased,dat[,-32]))
names(dat)[1]<-"leased"


DAT<-read.csv("DAT.csv",header=T)
DAT[which(DAT$ST == "AS"),ncol(DAT)]


head(DAT)
 
dat[which(is.na(dat$PropertyAddress )),]
dat$PropertyAddress [is.na(dat$PropertyAddress )] <- ""

DAT<-dat
states<-unique(DAT$ST)
states


ST<-states[1]

dat<-DAT[which(DAT$ST == ST),]
rownames(dat)<-NULL

tail(dat)

 

lat<-long<-rep(NA,nrow(dat))
for( i in 1:nrow(dat)){
	coord<-geocodeAdddress( paste(dat$PropertyAddress[i], dat$City[i],
		dat$ST[i], substr(dat$ZIPCode[i], 1,5) , sep="," ) )
	lat[i]<-coord[2]
	long[i]<-coord[1] 
 Sys.sleep(0.1)
if ( is.na(lat[i]) == T ) 
	{	coord<-geocodeAdddress( paste(dat$PropertyAddress[i], dat$City[i],
		dat$ST[i], substr(dat$ZIPCode[i], 1,5) , sep="," ) )
	lat[i]<-coord[2]
	long[i]<-coord[1] 
	}	else {next}
	  }


#DAT$long<-rep(NA,nrow(DAT)) ;DAT$lat<-rep(NA,nrow(DAT)) 

which(is.na(lat))








 
for( i in which(is.na(lat)) ){
	coord<-geocodeAdddress( paste(dat$PropertyAddress[i], dat$City[i],
		dat$ST[i], substr(dat$ZIPCode[i], 1,5) , sep="," ) )
	lat[i]<-coord[2]
	long[i]<-coord[1] 
 Sys.sleep(0.2)
if ( is.na(lat[i]) == T ) 
	{	coord<-geocodeAdddress( paste(dat$PropertyAddress[i], dat$City[i],
		dat$ST[i], substr(dat$ZIPCode[i], 1,5) , sep="," ) )
	lat[i]<-coord[2]
	long[i]<-coord[1] 
	}	else {next}	  }


DAT$long[which(DAT$ST == dat$ST[1] )]<-long
DAT$lat[which(DAT$ST == dat$ST[1] )]<-lat

write.csv(DAT,"DAT.csv")
states<-states[!states %in% ST]
 
