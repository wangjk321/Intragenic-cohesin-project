#Based on cohesinBino.R cohesinBino.sh

#cohesin sites and Mvalue
#cp ~/DIC/Feb2020/motif/allCohesin.bed .

co=allCohesin.bed

##homerMore
#homerloop
sed '1d' ./homerMore/merged.loop.2D.bed| cut -f 1-3 > homerLoop.tempo
sed '1d' ./homerMore/merged.loop.2D.bed| cut -f 4-6 >> homerLoop.tempo
mv homerLoop.tempo ./bedData/loopHomer.bed

cohesinBino.sh -c $co -t bedData/loopHomer.bed

#homerTAD border
sed '1d' ./homerMore/merged.tad.2D.bed |awk 'BEGIN{OFS="\t"}{print $1,$2-10000,$2+10000}' > border.temp
sed '1d' ./homerMore/merged.tad.2D.bed |awk 'BEGIN{OFS="\t"}{print $1,$3-10000,$3+10000}' >> border.temp
sort-bed border.temp > bedData/homerBorder.bed
cohesinBino.sh -c $co -t bedData/homerBorder.bed


#CpG island
cut -f 1-4 ./preData/CpG/cpgIslandUnmasked.hg38.bed > bedData/CpG.bed
cohesinBino.sh -c $co -t bedData/CpG.bed

#Fantom5 enhancer
cut -f 1-4 ~/DIC/Feb2020/enhancerComp/F5.hg38.enhancers.bed > bedData/Fantom.bed
cohesinBino.sh -c $co -t bedData/Fantom.bed

#HiC loop
cut -f 1-3 ./preData/HiC/HiC.loop > hic.tempo
cut -f 4-6 ./preData/HiC/HiC.loop >> hic.tempo
mv hic.tempo ./bedData/loopHiC.bed

cohesinBino.sh -c $co -t bedData/loopHiC.bed

#Pol2 ChIAloop
cat ./preData/HiC/MCF7* > chia.loop
cut -f 1-3 chia.loop > chia.temp
cut -f 4-6 chia.loop >> chia.temp
mv chia.temp ./bedData/ChIAloop.bed
rm chia.loop

cohesinBino.sh -c $co -t bedData/ChIAloop.bed

#public TFs ( E2+ctrl peaks)
cp /work/WangData/FromSaxophone/omicsData/publicTFs/usedData/macs/*narrowPeak .

for i in `ls *narrowPeak| cut -d "_" -f1|uniq`
do
	cat ${i}_E2_* ${i}_veh_* > bedData/$i.bed
	rm ${i}_*
	cohesinBino.sh -c $co -t bedData/$i.bed
done	

#public histone markers
cp /work/WangData/FromSaxophone/omicsData/publicHistone/macs/*narrowPeak .

for i in `ls *narrowPeak| cut -d "_" -f1|uniq`
do
        cat ${i}_E2_* ${i}_veh_* > bedData/$i.bed
        rm ${i}_*
        cohesinBino.sh -c $co -t bedData/$i.bed
done

#local TFs Bando (E2+ctrl peaks)
dirL=/work/WangData/FromSaxophone/omicsData/MCF7_bando/macs
postL=peaks.narrowPeak

cat $dirL/CBP_0min_$postL $dirL/CBP_45min_$postL > bedData/CBP.bed
cohesinBino.sh -c $co -t bedData/CBP.bed

cat $dirL/Mau2_0min_$postL $dirL/Mau2_30min_$postL $dirL/Mau2_45min_$postL >bedData/Mau2.bed
cohesinBino.sh -c $co -t bedData/Mau2.bed

cat $dirL/MCF7_ER_treat-n2-m1-hg38_peaks.narrowPeak $dirL/MCF7_ER_vehicle-n2-m1-hg38_peaks.narrowPeak >bedData/ER.bed
cohesinBino.sh -c $co -t bedData/ER.bed

cat $dirL/p300_0min_$postL $dirL/p300_45min_$postL > bedData/p300.bed
cohesinBino.sh -c $co -t bedData/p300.bed

cat $dirL/Pol2_0min_$postL $dirL/Pol2_30min_$postL $dirL/Pol2_45min_$postL >bedData/Pol2.bed
cohesinBino.sh -c $co -t bedData/Pol2.bed

cat $dirL/TAF1_0min_$postL $dirL/TAF1_30min_$postL > bedData/TAF1.bed
cohesinBino.sh -c $co -t bedData/TAF1.bed

cat $dirL/AFF4_0min_$postL $dirL/AFF4_30min_$postL > bedData/AFF4.bed
cohesinBino.sh -c $co -t bedData/AFF4.bed

#clinical genes from PMID30234119
Rscript ./preData/Gene2pos.R preData/clinical-gene.csv
#around 100kb
cat preData/clinical-gene.bed |\
	awk 'BEGIN{OFS="\t"}{print $1,$2-100000,$3+100000}'|\
       	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'\
       	> bedData/Gene_clinical.bed

cohesinBino.sh -c $co -t bedData/Gene_clinical.bed

#MCF7 special gene from harmonizome
# run ./preData/harmonizome/getGeneApi.py 
cat ./preData/harmonizome/*txt | sort|uniq > ./preData/HarmonMCF7Gene.txt
Rscript ./preData/Gene2pos.R preData/HarmonMCF7Gene.txt

cat preData/HarmonMCF7Gene.bed |\
	awk 'BEGIN{OFS= "\t"}{print $1,$2-100000,$3+100000}'|\
       	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'\
       	> bedData/Gene_HarmonMCF7.bed

cohesinBino.sh -c $co -t bedData/Gene_HarmonMCF7.bed

#high expressed gene from  RNA-seq(GSE99680+GSE89888)
#run ./preData/RNAseq/makeGenelist.R
Rscript ./preData/Gene2pos.R preData/highGeneRNAseq.txt

cat preData/highGeneRNAseq.bed |\
	awk 'BEGIN{OFS="\t"}{print $1,$2-100000,$3+100000}'|\
       	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'\
	> bedData/Gene_highRNAseq.bed

cohesinBino.sh -c $co -t bedData/Gene_highRNAseq.bed

#repeat genome
cohesinBino.sh -c $co -t bedData/repeat_hg38_pos.bed

#E2-response gene
awk 'BEGIN{OFS="\t"}{print $1,$2+5000,$3-5000}' ./preData/E2-response.gene.expand > ./preData/E2reponse.gene

cat ./preData/E2reponse.gene |\
	awk 'BEGIN{OFS= "\t"}{print $1,$2-100000,$3+100000}'|\
       	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'\
       	> bedData/GeneE2response.bed

cohesinBino.sh -c $co -t bedData/GeneE2response.bed


