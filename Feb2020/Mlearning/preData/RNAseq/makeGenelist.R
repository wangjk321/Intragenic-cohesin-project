gse8 <- read.csv("GSE89888_TPM.csv",sep=",")
gse8 <- gse8[,1:2]
gse8high <- as.character(gse8[gse8[,2]>1024,][,1])
library(org.Hs.eg.db)
geneL <- select(org.Hs.eg.db,keys=gse8high,columns=c("SYMBOL"),keytype="ENSEMBL")
gse8gene <- na.omit(geneL)[,2]


gse9 <- read.csv("GSE99680_RPKM.csv",sep=",")
gse9 <- gse9[,c(1,8)]
gse9 <- gse9[gse9[,2]>0.01,]
gse9gene <- as.character(gse9[gse9[,2]>20,][,1])

highgene <- unique(c(gse8gene,gse9gene))

write.table(highgene,"../highGeneRNAseq.txt",sep="\t",row.names = F,col.names = F,quote = F)



