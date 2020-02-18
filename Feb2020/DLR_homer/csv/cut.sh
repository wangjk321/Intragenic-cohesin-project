for bed in DIC DIC_highCTCF DIC_lowCTCF IC allCohesin F5.hg38.enhancers cohesin-TES cohesin-TSS cohesin-extra cohesin-intra
do
	for post in  DLR PC1 ICF
	do
		cut -f 1,2,5 $bed.$post.csv > $bed.$post.cut.txt
	done
done

for bed in DIC DIC_highCTCF DIC_lowCTCF IC allCohesin F5.hg38.enhancers cohesin-TES cohesin-TSS cohesin-extra cohesin-intra
do
        for post in  deltaDLR deltaICF diffPC1 diffPC1_window50k
        do
                cut -f 1-2 $bed.$post.csv >  $bed.$post.cut.txt
        done
done


for bed in DIC DIC_highCTCF DIC_lowCTCF IC allCohesin F5.hg38.enhancers cohesin-TES cohesin-TSS cohesin-extra cohesin-intra
do
        for post in IS
        do
                cut -f 1,2,5,8,11 $bed.$post.csv >  $bed.$post.cut.txt
        done
done




