setwd("G:\\data")

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
  out
}

dat<-read.csv("Foo.csv",header=T)
dat<-(data.frame(dat$leased,dat[,-32]))
names(dat)[1]<-"leased"

head(dat)
 
dat[which(is.na(dat$PropertyAddress )),]
dat$PropertyAddress [is.na(dat$PropertyAddress )] <- ""

lat<-long<-rep(NA,nrow(dat))


head(dat)

 geocodeAdddress("500 PHILLIPS ST, AKIACHAK, AK , 99551") 


for( i in 1:nrow(dat)){
	coord<-geocodeAdddress( paste(dat$PropertyAddress[i], dat$City[i],
		dat$ST[i], substr(dat$ZIPCode[i], 1,5) , sep=", " ) )
	lat[i]<-coord[2]
	long[i]<-coord[1] 
	Sys.sleep(0.2) }

