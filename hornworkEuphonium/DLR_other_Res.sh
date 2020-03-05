#analyzeHiC combinedPlus/ -res 25000 -window 50000 -nomatrix -compactionStats Plus25kb -cpu 60
#analyzeHiC combinedMinus/ -res 25000 -window 50000 -nomatrix -compactionStats Minus25kb -cpu 60

#analyzeHiC combinedPlus/ -res 10000 -window 30000 -nomatrix -compactionStats Plus10kb -cpu 60
#analyzeHiC combinedMinus/ -res 10000 -window 30000 -nomatrix -compactionStats Minus10kb -cpu 60

#analyzeHiC combinedPlus/ -res 15000 -window 40000 -nomatrix -compactionStats Plus15kb -cpu 60
#analyzeHiC combinedMinus/ -res 15000 -window 40000 -nomatrix -compactionStats Minus15kb -cpu 60



#getHiCcorrDiff.pl diffPC1_window50000 combinedPlus/ combinedMinus/ -cpu 60 -res 25000 -window 50000


subtractBedGraphs.pl Minus15kb.DLR.bedGraph Plus15kb.DLR.bedGraph -center -name Plus15k-Minus15k > Plus15k-Minus15k.DLR.bedGraph

subtractBedGraphs.pl Minus25kb.DLR.bedGraph Plus25kb.DLR.bedGraph -center -name Plus25k-Minus25k > Plus25k-Minus25k.DLR.bedGraph

subtractBedGraphs.pl Minus10kb.DLR.bedGraph Plus10kb.DLR.bedGraph -center -name Plus10k-Minus10k > Plus10k-Minus10k.DLR.bedGraph



