wget https://www.encodeproject.org/files/ENCFF165CEG/@@download/ENCFF165CEG.bed.gz

wget https://www.encodeproject.org/files/ENCFF923KQX/@@download/ENCFF923KQX.bed.gz

wget https://www.encodeproject.org/files/ENCFF553ILL/@@download/ENCFF553ILL.bed.gz


gunzip *gz


cat ENC* |cut -f 1-3,6 > tempo.bed
sort-bed tempo.bed |uniq > MCF7_CAGE.bed

rm tempo.bed


wget https://fantom.gsc.riken.jp/5/datafiles/reprocessed/hg38_latest/extra/CAGE_peaks/hg38_fair+new_CAGE_peaks_phase1and2.bed.gz

gunzip *gz
