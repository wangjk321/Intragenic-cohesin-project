#extract DIC promoter

cohesin=DIC_lowCTCF.bed

intersectBed -u -a $cohesin -b ../chromRegion/intra.bed |\
	intersectBed -u -a refFlat.protein.long -b stdin > DIC_lowCTCF.gene

intersectBed -f 1 -u -a Rad21_manorm.bed -b $cohesin |awk '$5<-0.2{print $0}'| cut -f 1-5 > DIC_lowCTCF.peak

intersectBed -wa -wb -a DIC_lowCTCF.gene -b DIC_lowCTCF.peak | cut -f 1-4,9 | awk '{if ($4=="+") print $1"\t"$2-2000"\t"$2+2000"\t"$0; else print $1"\t"$3-2000"\t"$3+2000"\t"$0}'| intersectBed -F 1 -wa -wb -a stdin -b Rad21_manorm.bed |cut -f4-8,13| awk '{print $0"\t"$1"-"$2"-"$3}' > tempo1.bed

R --no-save <<EOF
s <- read.csv("tempo1.bed",header=F, sep="\t")
ss <- s[,c(7,5,6)]
colnames(ss) <- c("chrom","DIC","promoter")

dic <- tapply(ss[,2],INDEX=ss[,1],FUN=mean)
promoter <- tapply(ss[,3],INDEX=ss[,1],FUN=mean)
print(cor(dic,promoter,method="spearman"))
m <- lm(promoter~dic,)
summary(m)


pdf("test.pdf")
plot(dic,promoter,xlim=c(-1.2,0),xlab="Rad21 intensity in DICs",ylab="Rad21 intensity in promoter of DIC host genes")
abline(m,col="red")
dev.off()   
EOF

intersectBed -u -a DIC_lowCTCF.gene -b DIC_lowCTCF.peak | cut -f 1-4,9 | awk '{if ($4=="+") print $1"\t"$2-1000"\t"$2+1000"\t"$0; else print $1"\t"$3-1000"\t"$3+1000"\t"$0}'|sort|uniq >promoter.bed

intersectBed -u -a Rad21_manorm.bed -b promoter.bed > promoter.cohesin


dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/parse2wigdir
dir3=/work/WangData/FromSaxophone/database
dir4=/work/WangData/FromSaxophone/omicsData/publicHistone/parse2wigdir
end="-n2-m1-hg38-raw-mpbl-GR"

drompa_draw PROFILE -offse -p promoter.cohesin -cw 1000 -gt $dir3/genome_table -ptype 4 -bed promoter.cohesin \
        -i $dir1/Rad21_0min$end,$dir1/Input_0min$end,Rad21_0min \
        -i $dir1/Rad21_45min$end,$dir1/Input_45min$end,Rad21_45min

drompa_draw PROFILE -offse -p promoter -cw 1000 -gt $dir3/genome_table -ptype 4 -bed promoter.bed\
        -i $dir1/Rad21_0min$end,$dir1/Input_0min$end,Rad21_0min \
        -i $dir1/Rad21_45min$end,$dir1/Input_45min$end,Rad21_45min



rm DIC_lowCTCF.gene DIC_lowCTCF.peak
