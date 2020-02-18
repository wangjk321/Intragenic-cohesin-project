for i in *.pos
do
	findMotifsGenome.pl $i hg38 ${i%.*}_Dir -p 60 -preparsedDir ~/software/homer
done
