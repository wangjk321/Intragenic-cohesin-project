for i in *bedGraph
do
	cat $i |sed '1d'| sort -k1,1 -k2,2n > $i.sort
	bgzip $i.sort
	tabix -p bed $i.sort.gz
done

