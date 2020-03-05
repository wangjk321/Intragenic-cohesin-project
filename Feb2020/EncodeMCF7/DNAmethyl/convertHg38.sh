for i in *bed
do
	sed '1d' ${i%%.*}.hg19.bed |cut -f 1-6 > tempo.bed
	liftOver tempo.bed ~/dbSaxo/hg19ToHg38.over.chain ${i%%.*}.hg38.bed unlifted.txt
	rm tempo.bed
done
