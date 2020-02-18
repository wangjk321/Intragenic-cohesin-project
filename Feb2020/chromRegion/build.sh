#make a bed for all chromosome
cat genome_table | awk '{print $1"\t"0"\t"$2}' > allchrom.bed

#filter refseq ( protein coding gene only)
cat refFlat.bed | grep "NM" | \
	awk '{print $1"\t"$2"\t"$3"\t"$6}'|sort|uniq | \
       grep -v "alt" |grep -v "chrUn"|grep -v "random"	> refFlat.protein

#1. create TSS.bed flank=5kb
cat refFlat.protein|grep "+" | awk '{print $1"\t"$2-5000"\t"$2+5000}'|awk '$2>0{print $0}' |sort|uniq > TSS.temp
cat refFlat.protein|grep "-" | awk '{print $1"\t"$3-5000"\t"$3+5000}'|awk '$2>0{print $0}'|sort|uniq >> TSS.temp
mv TSS.temp TSS_flank5kb.bed

#2. create TES.bed
cat refFlat.protein|grep "+" | awk '{print $1"\t"$3-5000"\t"$3+5000}' |awk '$2>0{print $0}'|sort|uniq > TES.temp
cat refFlat.protein|grep "-" | awk '{print $1"\t"$2-5000"\t"$2+5000}' |awk '$2>0{print $0}'|sort|uniq >> TES.temp
mv TES.temp TES_flank5kb.bed

#3. create intra region in long gene (>20kb)
cat refFlat.protein | awk '($3-$2)>20000{print $0}' | sort|uniq >refFlat.protein.long #select long gene

cat refFlat.protein.long | awk '{print $1"\t"$2+10000"\t"$3-10000"\t"$4}'> refFlat.intra

#exclude possibe TSS & TES
cat refFlat.bed | awk '{print $1"\t"$2-3000"\t"$2+3000}' > TSSTES.bed
cat refFlat.bed | awk '{print $1"\t"$3-3000"\t"$3+3000}' >> TSSTES.bed
awk '$2>0{print $0}' TSSTES.bed |sort |uniq > aroundTSSTES.bed
rm TSSTES.bed

bedtools intersect -v -a refFlat.intra -b aroundTSSTES.bed > intra.bed
rm refFlat.intra

#4. create extra region
cat refFlat.bed | awk '{print $1"\t"$2-5000"\t"$3+5000"\t"$6}'|sort|uniq |awk '$2>=0{print $0}'>allgene.bed
bedtools subtract -a allchrom.bed -b allgene.bed |sort|uniq > extra.bed

rm allgene.bed

#5. create other region
subtractBed -a allchrom.bed -b TSS_flank5kb.bed | \
       	subtractBed -a stdin -b TES_flank5kb.bed | \
	subtractBed -a stdin -b intra.bed | \
	subtractBed -a stdin -b extra.bed \
	> otherRegion.bed

intersectBed -u -f 1 -a Rad21_manorm.bed -b TSS_flank5kb.bed > cohesin-TSS.bed
intersectBed -u -f 1 -a Rad21_manorm.bed -b TES_flank5kb.bed > cohesin-TES.bed
intersectBed -u -f 1 -a Rad21_manorm.bed -b intra.bed > cohesin-intra.bed
intersectBed -u -f 1 -a Rad21_manorm.bed -b extra.bed > cohesin-extra.bed
intersectBed -u -f 1 -a Rad21_manorm.bed -b otherRegion.bed > cohesin-other.bed





