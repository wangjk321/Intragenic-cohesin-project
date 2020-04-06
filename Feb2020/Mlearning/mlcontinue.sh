##cohesin peak width as continuous value
awk '{print $1"-"$2"-"$3"\t"$3-$2}' allCohesin.bed |\
       	sed '1i CohesinPos\tcohesinWidth' > continuetxt/cohesinWidth.txt

##cohesin peak intensity as continuous value (normalized A-value)
awk '{print $1"-"$2"-"$3"\t"$6}' allCohesin.bed |\
       	sed '1i CohesinPos\tcohesinAvalue' > continuetxt/cohesinAvalue.txt

###homerMore
#DLR of plus hic
cut -f 1-3 allCohesin.bed |\
       	mapBed -a stdin -b ./homerMore/combinedPlus.DLR.bedGraph -c 4 -o mean|\
       	awk '{print $1"-"$2"-"$3"\t"$4}' |\
       	sed '1icoheinPos\tDLRofPlus' > ./continuetxt/DLRofPlus.txt
#ICF of plus hic
cut -f 1-3 allCohesin.bed |\
        mapBed -a stdin -b ./homerMore/combinedPlus.ICF.bedGraph -c 4 -o mean|\
        awk '{print $1"-"$2"-"$3"\t"$4}' |\
        sed '1icoheinPos\tICFofPlus' > ./continuetxt/ICFofPlus.txt
#DI of plus hic
sort-bed  ./homerMore/combinedPlus.DI.bedGraph > DI.temp
cut -f 1-3 allCohesin.bed |\
        mapBed -a stdin -b DI.temp -c 4 -o mean|\
        awk '{print $1"-"$2"-"$3"\t"$4}' |\
        sed '1icoheinPos\tDIofPlus' > ./continuetxt/DIofPlus.txt
rm DI.temp
#homerInsulation
sort-bed ./homerMore/combinedPlus.Insulation.bedGraph > homerIS.temp
cut -f 1-3 allCohesin.bed |\
        mapBed -a stdin -b homerIS.temp -c 4 -o mean|\
        awk '{print $1"-"$2"-"$3"\t"$4}' |\
        sed '1icoheinPos\thomerInsulation' > ./continuetxt/homerInsulation.txt
rm homerIS.temp
####
echo interaction per peak 10k
cut -f 1-3 allCohesin.bed > cohe.temp

awk 'BEGIN{OFS="\t"}{print $3,$4,$5,$1}' homerMore/Interaction_res10k_PlusVsMinus.txt|\
	sed '1d'> inter.temp
awk 'BEGIN{OFS="\t"}{print $9,$10,$11,$1}' homerMore/Interaction_res10k_PlusVsMinus.txt|\
        sed '1d'>> inter.temp

sort-bed inter.temp |\
	intersectBed -a cohe.temp -b stdin -c |\
	awk '{print $1"-"$2"-"$3"\t"$4}'|\
	sed '1iCohesinPos\tInterNumber'> ./continuetxt/interNumber10k.txt
rm cohe.temp inter.temp
####
#echo interaction per peak 2k
#cut -f 1-3 allCohesin.bed > cohe.temp

#sed '1d'  homerMore/InteractionsByChr_res2k_Plus.txt|\
#	awk 'BEGIN{OFS="\t"}{print $3,$4,$5,$1}'|\
#	grep -v "-"|grep -v "+" > inter.temp
#sed '1d' homerMore/InteractionsByChr_res2k_Plus.txt|\
#	awk 'BEGIN{OFS="\t"}{print $9,$10,$11,$1}'|\
#        sed '1d' | grep -v "-"|grep -v "+" >> inter.temp

#sort-bed inter.temp |\
#        intersectBed -a cohe.temp -b stdin -c |\
#        awk '{print $1"-"$2"-"$3"\t"$4}'|\
#        sed '1iCohesinPos\tInterNumber'> ./continuetxt/interNumberIntra2k.txt
#rm cohe.temp inter.temp
###
echo Z-score 10k
cut -f 3-5,17 homerMore/Interaction_res10k_PlusVsMinus.txt|\
	sed '1d'> z10k.temp
cut -f 9-11,17 homerMore/Interaction_res10k_PlusVsMinus.txt|\
        sed '1d'>> z10k.temp
sort-bed z10k.temp> z10k.temp.sort
cut -f 1-3 allCohesin.bed |\
	 mapBed -a stdin -b z10k.temp.sort -c 4 -o mean|\
	 awk '{print $1"-"$2"-"$3"\t"$4}' |\
	 sed '1icoheinPos\tZscore10k' > ./continuetxt/Zscore10k.txt

rm z10k.temp  z10k.temp.sort
###
echo z-score 2k
#cut -f 3-5,17 homerMore/InteractionsByChr_res2k_Plus.txt|\
#        sed '1d'| grep -v "-"|grep -v "+" > z2k.temp
#cut -f 9-11,17 homerMore/InteractionsByChr_res2k_Plus.txt|\
#        sed '1d'| grep -v "-"|grep -v "+" >> z2k.temp
#sort-bed z2k.temp> z2k.temp.sort
#cut -f 1-3 allCohesin.bed |\
#         mapBed -a stdin -b z2k.temp.sort -c 4 -o mean|\
#         awk '{print $1"-"$2"-"$3"\t"$4}' |\
#         sed '1icoheinPos\tZscore2k' > ./continuetxt/ZscoreIntra2k.txt
#rm z2k.temp  z2k.temp.sort
###
echo diffZscore 10k
cut -f 3-5,27 homerMore/Interaction_res10k_PlusVsMinus.txt|\
        sed '1d'> diffz10k.temp
cut -f 9-11,27 homerMore/Interaction_res10k_PlusVsMinus.txt|\
        sed '1d'>> diffz10k.temp
sort-bed diffz10k.temp> diffz10k.temp.sort
cut -f 1-3 allCohesin.bed |\
         mapBed -a stdin -b diffz10k.temp.sort -c 4 -o mean|\
         awk '{print $1"-"$2"-"$3"\t"$4}' |\
         sed '1icoheinPos\tdiffZscore10k' > ./continuetxt/diffZscore10k.txt
rm diffz10k.temp  diffz10k.temp.sort

#deltaDLR
echo delraDLR
cut -f 1-3 allCohesin.bed |\
       	mapBed -a stdin -b ./preData/HiC/PlusVsMinus.DLR.bedGraph -c 4 -o mean|\
	awk '{print $1"-"$2"-"$3"\t"$4}' |\
	sed '1icoheinPos\tdeltaDLR' > ./continuetxt/deltaDLR.txt
#deltaICF
echo deltaICF
cut -f 1-3 allCohesin.bed |\
        mapBed -a stdin -b ./preData/HiC/PlusVsMinus.ICF.bedGraph -c 4 -o mean|\
        awk '{print $1"-"$2"-"$3"\t"$4}' |\
        sed '1icoheinPos\tdeltaICF' > ./continuetxt/deltaICF.txt
#Insulation score
echo IS
cut -f 1-3 allCohesin.bed |\
        mapBed -a stdin -b ./preData/HiC/InsulationScore.plus2.bedGraph -c 4 -o mean|\
        awk '{print $1"-"$2"-"$3"\t"$4}' |\
        sed '1icoheinPos\tInsulation' > ./continuetxt/InsulationScore.txt

#PC1 value
echo PC1
sed '1d' ./preData/HiC/PC1minusTempo.PC1.bedGraph > PC1.bedGraph
cut -f 1-3 allCohesin.bed |\
        mapBed -a stdin -b PC1.bedGraph -c 4 -o mean|\
        awk '{print $1"-"$2"-"$3"\t"$4}'|\
	awk '{if($2>0){print $1"\t"1}else{print $1"\t"0}}'|\
	sed '1icoheinPos\tPC1'> ./binotxt/PC1positive.txt

rm PC1.bedGraph

##CTCF peak intensity around cohesin summit 100bp (continuous ??)
cut -f 1-3 allCohesin.bed |\
       	awk '{print $1"\t"int(($2+$3)/2-50)"\t"int(($2+$3)/2+50)}' > allCohesin.summit

dir1=/work/CohesinProject/MCF7/ChIP-seq/hg38/parse2wigdir
dir2=~/dbSaxo
end="-n2-m1-hg38-raw-mpbl-GR"
drompa_draw MULTICI -p ctcf_intensity \
	-gt $dir2/genome_table \
	-bed allCohesin.summit \
	-i $dir1/CTCF_30min$end,,CTCF_30min \
	-i $dir1/CTCF_0min$end,,CTCF_0min

sed '1d' ctcf_intensity.csv|\
	awk 'BEGIN{OFS= "\t"}{print $1"-"$2"-"$3,($5+$6)/2}' \
	> CTCF_cont.txt

#use median value as CTCF signal on chrY
grep "chrY" allCohesin.bed |\
       	awk 'BEGIN{OFS="\t"}{print $1"-"$2"-"$3,18}'> CTCFchrY.tempo

cat CTCF_cont.txt CTCFchrY.tempo|\
       sed '1i CohesinPos\tCTCFsignal' > ./continuetxt/CTCF_signal.txt
rm allCohesin.summit ctcf_intensity.csv CTCF_cont.txt CTCFchrY.tempo

#peak increase or decrease
cut -f 1-3,5 allCohesin.bed |\
       	awk 'BEGIN{OFS="\t"}{if($4>0.5){print $1"-"$2"-"$3,1}else if($4<-0.5){print $1"-"$2"-"$3,-1}else{print $1"-"$2"-"$3,0}}'|\
	sed '1icohesinPos\tMvalue' > ./binotxt/Mvalue.txt

#Mvalue continuous
awk '{print $1"-"$2"-"$3"\t"$5}' allCohesin.bed |        sed '1i CohesinPos\tMvalue_continue' > continuetxt/Mvalue_continue.txt


##semi-bino for chromatin location
###要精不要多

cat preData/genome_table | awk '{print $1"\t"0"\t"$2}' > allchrom.bed
#filter refseq
cat ./preData/refFlat.bed |\
	awk '{print $1"\t"$2"\t"$3"\t"$6}'|sort|uniq | \
	grep -v "alt" |grep -v "chrUn"|grep -v "random"  > ref.filter

#more than 5kb length protein-coding gene
cat ./preData/refFlat.bed | grep "NM"|\
        awk '{print $1"\t"$2"\t"$3"\t"$6}'|sort|uniq | \
        grep -v "alt" |grep -v "chrUn"|grep -v "random"  > ref.filter.p


#TSS region flank=3kb
cat ref.filter.p|grep "+" | awk '{print $1"\t"$2-3000"\t"$2+3000}'|\
	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'|\
	sort|uniq > TSS.temp
cat ref.filter.p|grep "-" | awk '{print $1"\t"$3-3000"\t"$3+3000}'|\
	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'|\
	sort|uniq >> TSS.temp
mv TSS.temp TSS_flank5kb.bed

#TES region flank=3kb
cat ref.filter.p|grep "+" | awk '{print $1"\t"$3-3000"\t"$3+3000}'|\
	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'|\
	sort|uniq > TES.temp
cat ref.filter.p|grep "-" | awk '{print $1"\t"$2-3000"\t"$2+3000}'|\
	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'|\
	sort|uniq >> TES.temp
mv TES.temp TES_flank5kb.bed

# create intra region in long gene (>20kb)
cat ref.filter.p | awk '($3-$2)>20000{print $0}' | sort|uniq > ref.filter.long #select long gene

cat ref.filter.long | awk '{print $1"\t"$2+7000"\t"$3-7000"\t"$4}'> refFlat.intra

cat ./preData/refFlat.bed | awk '{print $1"\t"$2-5000"\t"$2+5000}' > TSSTES.bed
cat ./preData/refFlat.bed | awk '{print $1"\t"$3-5000"\t"$3+5000}' >> TSSTES.bed
awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}' TSSTES.bed |sort |uniq > aroundTSSTES.bed
rm TSSTES.bed

#subtractBed -a refFlat.intra -b aroundTSSTES.bed > intraGene.bed
bedtools intersect -v -a refFlat.intra -b aroundTSSTES.bed > intraGene.bed

#create extra region around gene flank 100kb
cat ref.filter |\
	awk '{print $1"\t"$2-5000"\t"$3+5000"\t"$6}'|\
	sort|uniq |\
	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'\
	>allgene_5kb.bed
cat ref.filter|\
        awk '{print $1"\t"$2-100000"\t"$3+100000"\t"$6}'|\
        sort|uniq |\
	awk 'BEGIN{OFS="\t"}{if($2<0){print $1,0,$3}else{print $1,$2,$3}}'\
	>allgene_100kb.bed
subtractBed -a allgene_100kb.bed -b allgene_5kb.bed > extraNearGene.bed

#create extra far from gene
subtractBed -a allchrom.bed -b allgene_100kb.bed > extraFarGene.bed

#cohesin location
intersectBed -u -f 1 -a allCohesin.bed -b TSS_flank5kb.bed > ./bedData/cohesin-TSS.bed
intersectBed -u -f 1 -a allCohesin.bed -b TES_flank5kb.bed > ./bedData/cohesin-TES.bed
intersectBed -u -f 1 -a allCohesin.bed -b intraGene.bed > ./bedData/cohesin-intra.bed
intersectBed -u -f 1 -a allCohesin.bed -b extraNearGene.bed > ./bedData/cohesin-extraNear.bed
intersectBed -u -f 1 -a allCohesin.bed -b extraFarGene.bed > ./bedData/cohesin-extraFar.bed

co=allCohesin.bed
cohesinBino.sh -c $co -t bedData/cohesin-TSS.bed
cohesinBino.sh -c $co -t bedData/cohesin-TES.bed
cohesinBino.sh -c $co -t bedData/cohesin-intra.bed
cohesinBino.sh -c $co -t bedData/cohesin-extraNear.bed
cohesinBino.sh -c $co -t bedData/cohesin-extraFar.bed

rm allchrom.bed ref.filter ref.filter.p ref.filter.long refFlat.intra aroundTSSTES.bed allgene_5kb.bed allgene_100kb.bed
rm TSS_flank5kb.bed TES_flank5kb.bed intraGene.bed extraNearGene.bed extraFarGene.bed
