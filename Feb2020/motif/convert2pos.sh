for id in *bed
do
	echo $id
	awk '{print $1"-"$2"-"$3"\t"$1"\t"$2"\t"$3"\t+"}' $id > motif/${id%.*}.pos
done
