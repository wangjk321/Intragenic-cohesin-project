cat contVSE2_multiCI.csv |sed '1d'| \
	awk '$6>30{print $0}'| awk '($5/$6)>1.5{print $0}' |\
       	intersectBed -u -a intra.bed -b stdin |\
	awk '($3-$2)>10000{print $1"\t"$2-15000"\t"$3+15000"\t"$4}'|\
	sort|uniq > newDIgene.bed




