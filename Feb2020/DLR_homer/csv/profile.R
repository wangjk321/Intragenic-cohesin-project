bed <- c("DIC","DIC_highCTCF","DIC_lowCTCF","IC","allCohesin","F5.hg38.enhancers","cohesin-TES","cohesin-TSS","cohesin-extra","cohesin-intra")

for(post in c("DLR","PC1","ICF")){
	for(i in bed){
		csv <- paste(i,post,"cut","txt",sep=".")
		print(csv)
		s <-read.csv(csv,header=F,sep="\t",stringsAsFactors=F)
		ss <- s[-1,]
		name <- paste(i,post,"png",sep=".")
		x <- as.numeric(ss[,1])/1000
		y1 <- as.numeric(ss[,2])
		y2 <- as.numeric(ss[,3])
		png(name)
		plot(x,y1,type="l",col="black",xlab="Distance from peak summit (kb)",
		    ylab="Average value", ylim=c(min(y1,y2),max(y1,y2)),cex.lab=1.4)
		lines(x,y2,col="orange")
		legend("bottomright",c("E2-","E2+"),lty=c(1,1),col=c("black","orange"),lwd=1.5,cex=1.5)
		dev.off()	
	    }
}



for(post in c("deltaDLR","deltaICF","diffPC1","diffPC1_window50k")){
        for(i in bed){
                csv <- paste(i,post,"cut","txt",sep=".")
                print(csv)
		s <-read.csv(csv,header=F,sep="\t",stringsAsFactors=F)
                ss <- s[-1,]
                name <- paste(i,post,"png",sep=".")
                x <- as.numeric(ss[,1])/1000
                y1 <- as.numeric(ss[,2])
                png(name)
                plot(x,y1,type="l",col="black",xlab="Distance from peak summit (kb)",
                    ylab="Average value", ylim=c(min(y1),max(y1)),cex.lab=1.4)
                legend("bottomright",c("E2plusVSminus"),lty=c(1,1),col=c("black"),lwd=1.5,cex=1.5)
                dev.off()
            }
}

for(post in c("IS")){
        for(i in bed){
                csv <- paste(i,post,"cut","txt",sep=".")
                print(csv)
		                s <-read.csv(csv,header=F,sep="\t",stringsAsFactors=F)
                ss <- s[-1,]
                name <- paste(i,post,"png",sep=".")
                x <- as.numeric(ss[,1])/1000
                y1 <- as.numeric(ss[,2])
		y4 <- as.numeric(ss[,5])
                png(name)
                plot(x,y1,type="l",col="black",xlab="Distance from peak summit (kb)",
                    ylab="Average value", ylim=c(min(y1,y4),max(y1,y4)),cex.lab=1.4)
		lines(x,y4,col="red")
                legend("bottomright",c("E2-","E2+"),lty=c(1,1),col=c("black","red"),lwd=1.5,cex=1.5)
                dev.off()
            }
}


#    s <- read.csv("test.csv",header=F,sep="\t",stringAsFactors=F)

