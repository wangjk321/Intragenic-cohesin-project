R --no-save <<EOF

library("ChIPseeker")
library("TxDb.Hsapiens.UCSC.hg38.knownGene")
library("clusterProfiler")
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

peak1 <- readPeakFile("F5.hg38.enhancers.bed")
peakAnno1 <- annotatePeak(peak1,tssRegion=c(-1000,1000),TxDb=txdb,annoDb="org.Hs.eg.db")
pdf("F5.enhancer.pdf")
plotAnnoPie(peakAnno1,ndigit=1)
dev.off()

EOF
