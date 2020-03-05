#!/usr/bin/R

args=commandArgs(T)
gene <- args[1]

geneT <- read.csv(gene)
geneC <- as.character(geneT[,1])

library(org.Hs.eg.db)
glist <- select(org.Hs.eg.db,keys=geneC,columns=c("REFSEQ"),keytype="SYMBOL")

ref <- read.table("~/database/refFlat.mainChr.bed")
overlap <- ref[is.element(ref$V4,glist[,2]),]
bed <- unique(overlap[,1:3])

id <-  strsplit(get("gene"),"[.]")[[1]][1]
filename <- paste(id,".bed", sep="")

write.table(bed,filename,sep="\t",row.names = F,col.names = F,quote = F)

