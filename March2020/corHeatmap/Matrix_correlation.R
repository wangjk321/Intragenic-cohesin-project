setwd("/home/wang/DIC/March2020/corHeatmap")
mt <- read.csv("/home/wang/DIC/March2020/bino161_normalizedContinuous14.matrix",sep="\t",stringsAsFactors = F,
               colClasses = c("character",rep("numeric",161),rep("numeric",14)))

#select at least one position
cohPos <- mt[,50:54]    #去除代表cohesin位置的五列
mt2 <- mt[apply(cohPos,1,sum)==1,]  #131666rows,176 coloums
#exclude position features
cohPos2 <- mt2[,50:54] #131666 rows ,5 columns
mt3 <- mt2[,-c(50,51,52,53,54)] #131666 rows ,171 columns
rownames(mt3) <- mt3[,1]

mtAll <- mt3[,-1]   #131666 rows ,170 columns

mtTES <- mtAll[cohPos2[,1]==1,]
  mtTES$GWAS_ERpositive[1]=0.01

mtTSS <- mtAll[cohPos2[,2]==1,]

mtExtraFar <- mtAll[cohPos2[,3]==1,]
  mtExtraFar$Gene_clinical[1]=0.01
  mtExtraFar$GeneE2response[1]=0.01

mtExtraNear <- mtAll[cohPos2[,4]==1,]

mtIntra <-  mtAll[cohPos2[,5]==1,]

mtIntraE2 <- mtIntra[mtIntra$GeneE2response==1,]
  mtIntraE2$GWAS_ERpositive[round(runif(1,1,dim(mtIntraE2)[1]))]=0.01
  mtIntraE2$GeneE2response[round(runif(1,1,dim(mtIntraE2)[1]))]=1.01

library(corrplot)
orderName <- colnames(corrplot(cor(mtAll),order="hclust"))

pdf("Allcohesin.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "full",tl.pos = "lt")
dev.off()


pdf("TSS.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "lower",tl.pos = "lt")
corrplot(cor(mtTSS[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "upper")
dev.off()

pdf("TES.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "lower",tl.pos = "lt")
corrplot(cor(mtTES[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "upper")
dev.off()

pdf("Intra.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "lower",tl.pos = "lt")
corrplot(cor(mtIntra[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "upper")
dev.off()

pdf("IntraE2.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "lower",tl.pos = "lt")
corrplot(cor(mtIntraE2[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "upper")
dev.off()

pdf("ExtraFar.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "lower",tl.pos = "lt")
corrplot(cor(mtExtraFar[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "upper")
dev.off()

pdf("ExtraNear.pdf",width = 15,height = 15)
corrplot(cor(mtAll),order="hclust",tl.cex = 0.5,type = "lower",tl.pos = "lt")
corrplot(cor(mtExtraNear[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "upper")
dev.off()

pdf("IntraE2VsExtraNear.pdf",width = 15,height = 15)
corrplot(cor(mtIntraE2[orderName]),order="original",tl.cex = 0.5,
         type = "upper",tl.pos = "lt")
corrplot(cor(mtExtraNear[orderName]),add=T,order="original",tl.pos = "n",
         tl.cex = 0.5,type = "lowe")
dev.off()

#library(pheatmap)
