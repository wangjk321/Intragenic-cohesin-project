dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/macs
dir2=/work/ChIP-seq/MCF7/Schmidt/hg38/macs
endPeak=peaks.narrowPeak
endPeak2=n2-m1-hg38_peaks.narrowPeak

bed=allintra.bed

###标准20个###
for i in CBP_0min CBP_45min AFF4_0min AFF4_30min CTCF_0min CTCF_30min Mau2_0min Mau2_45min Pol2_0min Pol2_45min Pol2ser_0min Pol2ser_30min Rad21_0min Rad21_45min TAF1_0min TAF1_30min p300_0min p300_45min
do
	cut -f 1-3 $dir1/${i}_$endPeak > $i.bed
        bedtools intersect -u -a $bed  -b $i.bed > $i.interbed
	rm $i.bed
done

for i in ER_treat ER_vehicle
do
	cut -f 1-3 $dir2/MCF7_${i}-$endPeak2 > $i.bed
	bedtools intersect -u -a $bed  -b $i.bed > $i.interbed
	rm $i.bed
done


R --slave --no-save <<EOF
bed <- "allintra.bed"

tf <- c("CBP_0min","CBP_45min","AFF4_0min", "AFF4_30min", "CTCF_0min", "CTCF_30min", "Mau2_0min", "Mau2_45min","Pol2_0min","Pol2_45min","Pol2ser_0min","Pol2ser_30min","Rad21_0min","Rad21_45min","TAF1_0min","TAF1_30min","p300_0min","p300_45min","ER_vehicle","ER_treat")

cohesin <- read.table(bed,header=FALSE)
co <- paste(as.character(cohesin[,1]),as.character(cohesin[,2]),as.character(cohesin[,3]),sep="tt")

mt <- NULL

for(i in tf){
	bedname <- paste(i,"interbed",sep=".")
	inter <- read.table(bedname,header=FALSE)
	interp <- paste(as.character(inter[,1]),as.character(inter[,2]),as.character(inter[,3]),sep="tt")
	x <- match(co,interp)
        x[!is.na(x)] <- 1
        x[is.na(x)] <- 0
	mt <- cbind(mt,x) 
}

colnames(mt) <- tf
mts <- cbind(co,mt)
write.table(mts,"bino22.txt",sep="\t",row.names = F,col.names = T,quote = F)

EOF

rm *interbed


