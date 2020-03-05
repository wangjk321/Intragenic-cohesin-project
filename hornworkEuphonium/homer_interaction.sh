
#diff interaction
analyzeHiC combinedPlus -res 10000 -ped combinedMinus -interactions Interaction_res10k_PlusVsMinus.txt -cpu 60 -nomatrix

#find interaction
findHiCInteractionsByChr.pl combinedMinus -res 2000 -superRes 10000 -cpu 60 > InteractionsByChr_res2k_Minus.txt
findHiCInteractionsByChr.pl combinedPlus -res 2000 -superRes 10000 -cpu 60 > InteractionsByChr_res2k_Plus.txt

analyzeHiC combinedMinus -res 10000 -interactions Interaction_res10k_Minus.txt -cpu 60 -nomatrix
analyzeHiC combinedPlus -res 10000 -interactions Interaction_res10k_Plus.txt -cpu 60 -nomatrix

#loop and TAD
findTADsAndLoops.pl find combinedMinus -cpu 60 -res 3000 -window 15000 -genome hg38
findTADsAndLoops.pl find combinedPlus -cpu 60 -res 3000 -window 15000 -genome hg38

merge2Dbed.pl combinedMinus/combinedMinus.loop.2D.bed combinedPlus/combinedPlus.loop.2D.bed -loop > merged.loop.2D.bed

merge2Dbed.pl combinedMinus/combinedMinus.tad.2D.bed combinedPlus/combinedPlus.tad.2D.bed -tad > merged.tad.2D.bed

findTADsAndLoops.pl score -tad merged.tad.2D.bed -loop merged.loop.2D.bed -o mergeMinusPlus -d combinedMinus/ combinedPlus/ -cpu 60 -res 3000 -window 15000

getDiffExpression.pl mergeMinusPlus.loop.scores.txt combinedMinus combinedPlus > mergeMinusPlus.diff.loop.txt
getDiffExpression.pl mergeMinusPlus.tad.scores.txt combinedMinus combinedPlus  > mergeMinusPlus.diff.tad.txt



#diff TAD and loop
findTADsAndLoops.pl find minus1-filtered -cpu 60 -res 3000 -window 15000 -genome hg38
findTADsAndLoops.pl find minus2-filtered -cpu 60 -res 3000 -window 15000 -genome hg38
findTADsAndLoops.pl find plus1-filtered -cpu 60 -res 3000 -window 15000 -genome hg38
findTADsAndLoops.pl find plus2-filtered -cpu 60 -res 3000 -window 15000 -genome hg38
















