#around 5kb SNPs
cut -f 12-13 GWAS-ERpositive-EFO_1000649.csv |\
	sed '1d'|tr '\t' "t"| grep -w -v "t" |\
       	tr 't' '\t'|sed '2d'|\
	awk '{print "chr"$1"\t"$2-5000"\t"$2+5000}'|\
	sortBed > GWAS_ERpositive.bed

cut -f 12-13 GWAS-allBreastCancer-EFO_0000305-withChildTraits.csv |\
       	sed '1d'|tr '\t' "t"| grep -w -v "t"|\
	tr 't' '\t'|grep -v ";"|\
	awk '{print "chr"$1"\t"$2-5000"\t"$2+5000}'|\
	sortBed > GWAS_allBreast.bed


