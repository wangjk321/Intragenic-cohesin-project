#输入文件夹为count目录
args=commandArgs(T)
indir <-args[1]
outdir <- args[2]
outname <- args[3]
cat("Input count dir =", indir,"\n")
cat("Output count dir=", outdir,"\n")
cat("Output name=",outname,"\n")

count <- dir(indir)
mn<-grep("minus",count,value=T)
pn<-grep("plus",count,value=T)

setwd(indir)
#创建一个函数读取count并构建矩阵
cr <-function(x){mt <- NA
            for(rep in seq(length(x))){print(rep)
                va <- read.table(x[rep],sep = "\t",header=FALSE)
                id<-va[,1]
                va <- va[,-1]
                names(va) <- id
                mt <-cbind(va,mt)}

            mt <-mt[,-(length(x)+1)]

            if(x[1]==mn[1]){colnames(mt)<-paste("minus", 1:length(x), sep = "")}
            else{colnames(mt)<-paste("plus", 1:length(x), sep = "")}

            return(mt)
}

minus <- cr(mn)
plus <- cr(pn)

cmt<-cbind(minus,plus)

#使用deseq2计算差异基因
library(DESeq2)

condition <- factor(c(rep("minus",length(mn)),rep("plus",length(pn))),levels = c("minus","plus"))
colData <- data.frame(row.names = colnames(cmt),condition)
dds <- DESeqDataSetFromMatrix(cmt,colData, design = ~condition)
dds <- DESeq(dds)

res = results(dds, contrast=c("condition","plus","minus"))
diffgene<- subset(res,pvalue<0.05 & abs(log2FoldChange) >1)

#mtnor <- counts(dds,normalized=TRUE)
#diffmt <- mtnor[rownames(diffloop),]
#pheatmap(diffmt,cluster_cols=FALSE,show_rownames = FALSE,scale = "row")
#heatmap(as.matrix(mtnor),Colv = NA,labRow = NA,scale="row")

#library(org.Hs.eg.db)
#genelist <- rownames(diffgene)
#list <- apply(t(t(genelist)),1,function(x){strsplit(x,'[.]')[[1]][1]})
#list2 <- select(org.Hs.eg.db, keys = list, 
#                         columns = "SYMBOL", keytype = "ENSEMBL")
#grep("ENSG00000082175",genelist)
#grep("PGR",list2)


#结合p值和logFC
cmtt <- cbind(cmt,log2FC=res$log2FoldChange,pvalue=res$pvalue) 

#导入gtf文件并添加染色体坐标信息
library(org.Hs.eg.db)
gtf <- read.csv("~/MCF7_RNAseq/database/gtf.bed",sep = "\t",header=FALSE)
rownames(gtf) <- gtf$V6
reGtf <- gtf[rownames(cmtt),]
reGtf$V4 <- reGtf$V6
reGtf <- reGtf[,-6]
colnames(reGtf)<-c("chrNo","start","end","ENSEMBL","strand")
cmttt <- cbind(reGtf,cmtt)
rownames(cmttt) <- NULL

setwd(outdir)
outn <- paste(outname,".csv",sep="")
write.table(cmttt,outn,row.names = FALSE,quote = FALSE,sep = "\t")

cat("-------","complete","--------","\n")

deg <-length( rownames(diffgene))
cat("DEG number = ",deg)

