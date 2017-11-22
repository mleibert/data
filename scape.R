
leased<-"https://about.usps.com/who-we-are/foia/leased-facilities/report.htm"
leased<-readLines(leased)

STcsv<-grep('href="(.*?)>CSV',leased,value=T) 


STcsv<-unlist(strsplit(STcsv, " "))
STcsv<-grep('"(.*?).csv',STcsv,value=T) 

 
STcsv<-gsub('href=\"', "", STcsv, fixed = TRUE)
STcsv<-gsub('\">CSV</a><br', "", STcsv, fixed = TRUE)
STcsv<-gsub('\">CSV</a></p>', "", STcsv, fixed = TRUE)


tablez<-"https://about.usps.com/who-we-are/foia/leased-facilities/"

setwd("G:\\data\\leased")

for ( i in 1:length(STcsv)){
dat<-read.csv(	paste0(tablez,STcsv[i])  	)
write.csv(dat,paste0(substring(toupper(STcsv[i]), 1, 2),"lease.csv") )}

setwd("G:\\data\\owned")

owned<-readLines(
"https://about.usps.com/who-we-are/foia/readroom/ownedfacilitiesreport.htm")

STcsv<-grep('href="(.*?)>CSV',owned,value=T) 

STcsv<-unlist(strsplit(STcsv, " "))
STcsv<-grep('facilities(.*?).csv',STcsv,value=T) 

 
STcsv<-gsub('href=\"/who-we-are/foia/owned-facilities/', "",
	 STcsv, fixed = TRUE)
STcsv<-gsub('\">CSV</a><br', "", STcsv, fixed = TRUE)
STcsv<-gsub('\">CSV</a></p>', "", STcsv, fixed = TRUE)
length(STcsv)

tablez<-"https://about.usps.com/who-we-are/foia/owned-facilities/"

for ( i in 1:length(STcsv)){
dat<-read.csv(	paste0(tablez,STcsv[i])  	)
write.csv(dat,paste0(substring(toupper(STcsv[i]), 1, 2),"owned.csv") )}









