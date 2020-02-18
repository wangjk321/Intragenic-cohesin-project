pairToBed -a ChIAPET_rep2.mango -b DIC_highCTCF.bed > inter.bed

cut -f 1-3 inter.bed > loop
cut -f 4-6 inter.bed >>loop
cat loop |sort|uniq > inter.loop
rm loop

cut -f 9-11 inter.bed | sort |uniq > inter.peak

intersectBed -v -a inter.loop -b inter.peak |sort|uniq > lowCTCF.otherside

rm inter.loop inter.peak inter.bed


dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/parse2wigdir
dir3=/work/WangData/FromSaxophone/database
dir4=/work/WangData/FromSaxophone/omicsData/publicHistone/parse2wigdir
end="-n2-m1-hg38-raw-mpbl-GR"

#overlap with cohesin
intersectBed -u -a lowCTCF.otherside -b ../../loop_DIC/allCohesin.bed |wc -l

#overlap with enhancer
intersectBed -u -a lowCTCF.otherside -b F5.hg38.enhancers.bed |wc -l

#overlap with all promoter
cat refFlat.bed | awk '{if ($6=="+") print $1"\t"$2-500"\t"$2+500; else print $1"\t"$3-500"\t"$3+500}'|awk '$2>=0{print $0}'|sort|uniq|intersectBed -u -a lowCTCF.otherside -b stdin|wc -l

#overlap with own promoter
cut -f 1-3,6 refFlat.bed |sort|uniq|intersectBed -u -a stdin -b DIC_highCTCF.bed | awk '{if ($4=="+") print $1"\t"$2-1000"\t"$2+1000; else print $1"\t"$3-1000"\t"$3+1000}'|awk '$2>=0{print $0}'|sort |uniq|intersectBed -u -a lowCTCF.otherside -b stdin|wc -l


drompa_draw PROFILE -offse -p profile/Rad21 -cw 1500 -gt $dir3/genome_table -ptype 4 -bed lowCTCF.otherside \
        -i $dir1/Rad21_0min$end,$dir1/Input_0min$end,Rad21_0min \
        -i $dir1/Rad21_30min$end,$dir1/Input_30min$end,Rad21_30min \
        -i $dir1/Rad21_45min$end,$dir1/Input_45min$end,Rad21_45min

drompa_draw PROFILE -offse -p  profile/H3K27ac -cw 1500 -gt $dir3/genome_table -ptype 4 -bed lowCTCF.otherside \
        -i $dir4/H3K27ac_veh$end,,H3K27ac_veh\
        -i $dir4/H3K27ac_E2$end,,H3K27ac_E2

drompa_draw PROFILE -offse -p  profile/H3K4me1 -cw 1500 -gt $dir3/genome_table -ptype 4 -bed lowCTCF.otherside \
        -i $dir4/H3K4me1_veh$end,,H3K4me1_veh\
        -i $dir4/H3K4me1_E2$end,,H3K4me1_E2


drompa_draw PROFILE -offse -p  profile/H3K4me3 -cw 1500 -gt $dir3/genome_table -ptype 4 -bed lowCTCF.otherside \
        -i $dir4/H3K4me3_veh$end,,H3K4me3_veh\
        -i $dir4/H3K4me3_E2$end,,H3K4me3_E2


#the distribution of otherside
R --no-save <<EOF
library("ChIPseeker")
library("TxDb.Hsapiens.UCSC.hg38.knownGene")
library("clusterProfiler")
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

peak <- readPeakFile("lowCTCF.otherside")
peakAnno <- annotatePeak(peak,tssRegion=c(-500,500),TxDb=txdb,annoDb="org.Hs.eg.db")
pdf("distribution.pdf")
plotAnnoPie(peakAnno,ndigit=1)
dev.off()
EOF


#association with looped promoter (all)
cat refFlat.bed | awk '{if ($6=="+") print $1"\t"$2-1000"\t"$2+1000; else print $1"\t"$3-1000"\t"$3+1000}'|awk '$2>=0{print $0}'|sort|uniq|intersectBed -u -a lowCTCF.otherside -b stdin | intersectBed -u -a allCohesin.bed -b stdin > otherside_looped.allpromoter

cut -f 1-3,6 refFlat.bed |sort|uniq|intersectBed -u -a stdin -b DIC_lowCTCF.bed | awk '{if ($4=="+") print $1"\t"$2-1000"\t"$2+1000; else print $1"\t"$3-1000"\t"$3+1000}'|awk '$2>=0{print $0}'|sort |uniq|intersectBed -u -a lowCTCF.otherside -b stdin |intersectBed -u -a allCohesin.bed -b stdin > otherside_looped.ownpromoter

intersectBed -u -a allCohesin.bed -b lowCTCF.otherside > otherside_looped.cohesin

drompa_draw PROFILE -offse -p profile/otherside.allpromoter -cw 1000 -gt $dir3/genome_table -ptype 4 -bed otherside_looped.allpromoter \
        -i $dir1/Rad21_0min$end,$dir1/Input_0min$end,Rad21_0min \
        -i $dir1/Rad21_45min$end,$dir1/Input_45min$end,Rad21_45min

drompa_draw PROFILE -offse -p profile/otherside.ownpromoter -cw 1000 -gt $dir3/genome_table -ptype 4 -bed otherside_looped.ownpromoter \
        -i $dir1/Rad21_0min$end,$dir1/Input_0min$end,Rad21_0min \
        -i $dir1/Rad21_45min$end,$dir1/Input_45min$end,Rad21_45min

drompa_draw PROFILE -offse -p profile/otherside.cohesin -cw 1000 -gt $dir3/genome_table -ptype 4 -bed otherside_looped.cohesin \
        -i $dir1/Rad21_0min$end,$dir1/Input_0min$end,Rad21_0min \
        -i $dir1/Rad21_45min$end,$dir1/Input_45min$end,Rad21_45min

intersectBed -u -a ../CTCF.bed -b lowCTCF.otherside > otherside_looped.ctcf

drompa_draw PROFILE -offse -p profile/otherside.ctcf -cw 1000 -gt $dir3/genome_table -ptype 4 -bed otherside_looped.ctcf \
        -i $dir1/CTCF_0min$end,$dir1/Input_0min$end,CTCF_0min \
        -i $dir1/CTCF_30min$end,$dir1/Input_30min$end,CTCF_30min


R --no-save <<EOF
library("ChIPseeker")
library("TxDb.Hsapiens.UCSC.hg38.knownGene")
library("clusterProfiler")
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

peak <- readPeakFile("otherside_looped.cohesin")
peakAnno <- annotatePeak(peak,tssRegion=c(-500,500),TxDb=txdb,annoDb="org.Hs.eg.db")
pdf("distribution-cohesin.pdf")
plotAnnoPie(peakAnno,ndigit=1)
dev.off()
EOF


















#R --no-save <<EOF
#s <- read.csv("otherside_looped.allpromoter",header=F,sep="\t")
#ss <- s[,5]
#library("vioplot")

