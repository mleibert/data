library(readx)
cause<-as.data.frame(read_excel("G:\\2803\\CI17.xlsx", sheet="mvas"))

cause[,1]<-substring(cause[,1],1,3)

cause17<-as.data.frame(read_excel("G:\\2803\\CI17.xlsx", sheet="Sheet2"))
cause17[,1]<-substring(cause17[,1],1,3)

nrow(cause);nrow(cause17)

cause<-merge(cause,cause17,"23Cause")

cause[which( !(cause[,1] %in% as.character(500:699) )),]
 
 cause<-cause[  rev(order( cause[,4] )),]
colSums(cause[,-1])

cause500<-cause[which(cause[,1] %in% as.character(500:599) ),]
names(cause500)[2:4]<-as.character(15:17)
cause500$class<-LETTERS[1:nrow(cause500)]
str(cause500)
str(df)
right_label <- paste(cause500[-1 , 1], cause500[-1 , 3],sep=", ")

#cause500[4,-c(1,5)]<-cause500[4,-c(1,5)]+500
cause500<-cause500[c(1,2,3,4,6,5),]
linez<-c("solid","F1", "dotted","dashed","twodash")

#500 without BIG
 p<- ggplot(cause500[-1 ,-1]) + 
	geom_segment(aes(x=1, xend=2, y=`15`, yend=`16`, col=class), 
		size=.75, show.legend=F) + 
	geom_segment(aes(x=2, xend=3, y=`16`, yend=`17`, col=class), 
		size=.75, show.legend=F ,linetype=linez  ) +
	geom_vline(xintercept=1, linetype="dashed", size=.1) + 	
	geom_vline(xintercept=2, linetype="dashed", size=.1) +
	geom_vline(xintercept=3, linetype="dashed", size=.1) +
	#scale_color_manual(labels = c("Up", "Down"), 
	#values = c("green"="#00ba38", "red"="#f8766d")) +  # color of lines
	#labs(x="", y="Mean GdpPerCap") +  # Axis labels
	xlim(.5, 3.5) + ylim(0, 2000)  


p + geom_text(label=right_label, y=cause500[-1 ,-1]$`17`, 
	x=rep(3, NROW(cause500[-1 ,-1])), hjust=-0.1, size=3.5)


