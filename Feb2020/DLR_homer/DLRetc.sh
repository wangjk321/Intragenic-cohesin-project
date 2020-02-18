#STEP1 split bam file
for i in minus1 minus2 plus1 plus2
do
	echo $i
	samtools view -@ 60 -f 0x40 $i.bam > $i-read1.sam
	samtools view -@ 60 -f 0x80 $i.bam > $i-read2.sam
done

#STEP2 create tag folder

for i in minus1 minus2 plus1 plus2
do
	echo $i
	makeTagDirectory $i-unfiltered $i-read1.sam,$i-read2.sam -tbp 1 -format sam
	cp -r $i-unfiltered $i-filtered
	makeTagDirectory $i-filtered -update -genome hg38 -removePEbg -restrictionSite GATC -both -removeSelfLigation -removeSpikes 10000 5
done

#STEP3 merge experimental replicates

makeTagDirectory combinedMinus/ -d minus1-filtered/ minus2-filtered/ 
makeTagDirectory combinedPlus/ -d plus1-filtered/ plus2-filtered/

#STEP4 make DLR and ICF
analyzeHiC combinedPlus/ -res 5000 -window 15000 -nomatrix -compactionStats auto -cpu 60
analyzeHiC combinedMinus/ -res 5000 -window 15000 -nomatrix -compactionStats auto -cpu 60

#STEP5 subtract DLR and ICF
subtractBedGraphsDirectory.pl combinedPlus/ combinedMinus/ -center -prefix MinusVsPlus

subtractBedGraphsDirectory.pl combinedMinus/ combinedPlus/ -center -prefix PlusVsMinus

#STEP6 make PC1
runHiCpca.pl auto combinedPlus/ -res 25000 -window 50000 -genome hg38 -cpu 60
runHiCpca.pl auto combinedMinus/ -res 25000 -window 50000 -genome hg38 -cpu 60

#STEP7 diff PC1
getHiCcorrDiff.pl PlusMinusPC1 combinedPlus/ combinedMinus/ -cpu 60 -res 25000

#last step, downstream analysis
#annotatePeaks.pl tss mm9 -size 1000000 -hist 1000 -bedGraph exp1.PC1.bedGraph exp2.PC1.bedGraph > output.histogram.txt




