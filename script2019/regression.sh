# encoding: utf-8.0

#input1 is bed folder
#input2 is parse2dir folder

input1=narrowpeak

# i is the target protein to be classified
# j is the dependent varibles for regression
# z is the independent varibles for each regression
for i in `ls $input1 | grep "narrowPeak"| grep "45"`
do
	for j in $(ls $input1 | grep "narrowPeak"| grep "45"| grep -v `echo $i`)
	do
		for z in $(ls $input1 | grep "narrowPeak"| grep "45"| grep -v `echo $i`|grep -v `echo $j`)
		do
			 func $i $j $z
#			 echo ++++++++++++++++++++++++++++++
		done
#		echo ..............................
	done
	echo ---------------------------------
done

func(){
	ipeak=$1
	jpeak=$2
	zpeak=$3
	intersectBed -u -a $jpeak -b $zpeak | intersectBed -v -a $ipeak -b stdin \
	       	| awk '($3-$2)<2000{print $0}' > iposition.bed
	if bino
	then
		pass
	elif value
	then
		pass
	fi

	rm iposition.bed
}






