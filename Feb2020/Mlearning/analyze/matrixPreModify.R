setwd("~/DIC/Feb2020/Mlearning/analyze")
mt <- read.csv("./mkMatrix/All161b15c.matrix",sep="\t",stringsAsFactors = F,
               colClasses = c("character",rep("numeric",161),rep("character",15)))
rownames(mt)<-mt[,1]
mt <- mt [,-1]
mt[mt=="."] <- NA
mt <- na.omit(mt)

#simply treat bino as numeric data to make a correlationMap
bino <- mt[,1:161]
#for(i in c(seq(1,33),seq(35,161))){
#  bino[,i] <- factor(bino[,i],levels=c(0,1))
#}
#bino[,34] <- factor(bino[,34],levels=c(-1,0,1))

continue <-as.matrix(mt[,162:176])
mode(continue)<- "numeric"
continue[,1] <- log2(continue[,1]+0.01)
continue[,4] <- log2(continue[,4]+0.01)
continue[,10] <- log2(continue[,10]+0.01)

mt <- data.frame(bino,continue)

#library(corrplot)
#pdf("test.pdf",width = 15,height = 15)
#corrplot(cor(mt),method = "circle",order="hclust",
#               tl.cex = 0.5,tl.pos = "lt")

#dev.off()


##output standard data
CohesinPos <- row.names(mt)
mtout <- data.frame(CohesinPos,mt)
write.table(mtout,file="bino161_normalizedContinuous15.matrix",
            quote=F,row.names = F,col.names = T,sep="\t")

##logistic regression
#fit <- glm(data=mtnew,cohesin.intra~.,family = binomial())
