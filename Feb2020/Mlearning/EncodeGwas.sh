co=allCohesin.bed

echo gwas snp for ER positive
cp preData/GwasMCF7/GWAS_ERpositive.bed bedData/
cohesinBino.sh -c $co -t bedData/GWAS_ERpositive.bed

echo gwas snp for all breast
cp preData/GwasMCF7/GWAS_allBreast.bed bedData/
cohesinBino.sh -c $co -t bedData/GWAS_allBreast.bed

echo CAGE for MCF7
#cp ~/DIC/Feb2020/EncodeMCF7/CAGE/MCF7_CAGE.bed preData/Encode/CAGE_MCF7.bed
cp preData/Encode/CAGE_MCF7.bed bedData/
cohesinBino.sh -c $co -t bedData/CAGE_MCF7.bed

echo CAGE for all
#cp ~/DIC/Feb2020/EncodeMCF7/CAGE/hg38_fair+new_CAGE_peaks_phase1and2.bed preData/Encode/CAGE_all.bed
cp preData/Encode/CAGE_all.bed bedData/
cohesinBino.sh -c $co -t bedData/CAGE_all.bed

echo DNase-seq
#cat ~/DIC/Feb2020/EncodeMCF7/DNase-seq/*bed |sortBed|uniq > preData/Encode/DNase.bed
cp preData/Encode/DNase.bed bedData/
cohesinBino.sh -c $co -t bedData/DNase.bed

echo FAIRE-seq
#cat ~/DIC/Feb2020/EncodeMCF7/FAIRE/*hg38.bed |sortBed|uniq > preData/Encode/FAIRE.bed
cp preData/Encode/FAIRE.bed bedData/
cohesinBino.sh -c $co -t bedData/FAIRE.bed

echo DNAmethyl
#cat ~/DIC/Feb2020/EncodeMCF7/DNAmethyl/*hg38.bed |sortBed|uniq > preData/Encode/DNAmethyl.bed
cp preData/Encode/DNAmethyl.bed bedData/

cut -f 1-3 allCohesin.bed |\
	intersectBed -a stdin -b bedData/DNAmethyl.bed -c |\
	awk '{print $1"-"$2"-"$3"\t"$4}'|\
	 sed '1iCohesinPos\tDNAmethyl'>./continuetxt/DNAmethyl.txt

echo 103 TFs
cp -r ~/DIC/Feb2020/EncodeMCF7/TFs preData/Encode/
for i in preData/Encode/TFs/*bed
do
	cohesinBino.sh -c $co -t $i
done


