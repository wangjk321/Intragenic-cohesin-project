
for ibed in `ls bed | sed 's/.bed//g'`
do 
	echo $ibed
	echo PC1compare
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/PC1minusTempo.PC1.bedGraph bedGraph/PC1plusTempo.PC1.bedGraph -size 1000000 -cpu 60 > csv/$ibed.PC1.csv
	
	echo DLRcompare
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/combinedMinus.DLR.bedGraph bedGraph/combinedPlus.DLR.bedGraph -size 1000000 -cpu 60 > csv/$ibed.DLR.csv
	
#	echo ICFcompare
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/combinedMinus.ICF.bedGraph bedGraph/combinedPlus.ICF.bedGraph -size 1000000 -cpu 60 > csv/$ibed.ICF.csv

	echo deltaDLR
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/PlusVsMinus.DLR.bedGraph  -size 1000000 -cpu 60 > csv/$ibed.deltaDLR.csv
	
	echo deltaICF
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/PlusVsMinus.ICF.bedGraph  -size 1000000 -cpu 60 > csv/$ibed.deltaICF.csv

	echo diffPC1
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/diffPC1tempo.corrDiff.bedGraph  -size 1000000 -cpu 60 > csv/$ibed.diffPC1.csv

	echo diffPC1_window50k
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph diffPC1tempo_window50000.corrDiff.bedGraph  -size 1000000 -cpu 60 > csv/$ibed.diffPC1_window50k.csv

	echo IScompare
	annotatePeaks.pl bed/$ibed.bed hg38 -hist 1000 -bedGraph bedGraph/InsulationScore.minus1.bedGraph bedGraph/InsulationScore.minus2.bedGraph bedGraph/InsulationScore.plus1.bedGraph bedGraph/InsulationScore.plus2.bedGraph -size 1000000 -cpu 60 > csv/$ibed.IS.csv

done








