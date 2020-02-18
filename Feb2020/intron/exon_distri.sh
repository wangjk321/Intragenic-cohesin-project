R --no-save <<EOF

library("ChIPseeker")
library("TxDb.Hsapiens.UCSC.hg38.knownGene")
library("clusterProfiler")
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

#peak1 <- readPeakFile("DIC.bed")
#peakAnno1 <- annotatePeak(peak1,tssRegion=c(-200,200),TxDb=txdb,annoDb="org.Hs.eg.db")
#pdf("DIC.pdf")
#plotAnnoPie(peakAnno1,ndigit=1)
#dev.off()

#peak2 <- readPeakFile("DIC_highCTCF.bed")
#peakAnno2 <- annotatePeak(peak2,tssRegion=c(-200,200),TxDb=txdb,annoDb="org.Hs.eg.db")
#pdf("DIC_highCTCF.pdf")
#plotAnnoPie(peakAnno2,ndigit=1)
#dev.off()

#peak3 <- readPeakFile("DIC_lowCTCF.bed")
#peakAnno3 <- annotatePeak(peak3,tssRegion=c(-200,200),TxDb=txdb,annoDb="org.Hs.eg.db")
#pdf("DIC_lowCTCF.pdf")
#plotAnnoPie(peakAnno3,ndigit=1)
#dev.off()

peak4 <- readPeakFile("allCohesin.bed")
peakAnno4 <- annotatePeak(peak4,tssRegion=c(-2000,2000),TxDb=txdb,annoDb="org.Hs.eg.db")
pdf("allCohesin.pdf")
plotAnnoPie(peakAnno4,ndigit=1)
dev.off()

EOF

