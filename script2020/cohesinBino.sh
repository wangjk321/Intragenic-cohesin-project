#!/bin/bash

function usage(){
	echo "cohesinBino.sh [-c cohesin-peaks] [-t transcriptionFactor]"
}

while getopts "c:t:" opt
do
	case $opt in
		c)
			cohesin=${OPTARG}
			;;
		t)
			tf=${OPTARG}
			;;
		*)
			usage
			exit 1
			;;
	esac
done

if test $# -ne 4; then
    usage
    exit 0
fi

#将参数位置清零
shift $((OPTIND-1))

echo ----start bash script----

inter=`echo ${tf##*/} | cut -d "." -f1`
intersectBed -u -a $cohesin -b $tf > `echo $inter`.inter
echo ----finish bash script----

echo ----start R----
Rscript cohesinBino.R $cohesin `echo $inter`.inter 

rm *inter

echo ----finish R----
