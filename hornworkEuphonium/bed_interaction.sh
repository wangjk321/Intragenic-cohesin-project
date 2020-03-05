#cut -f 1-3 allCohesin.bed |\
#       	awk 'BEGIN{OFS="\t"}{print $1,($2+$3)/2-2500,($2+$3)/2+2500,$1"-"$2"-"$3}'> coheisn_summit_5kb.bed

#analyzeHiC ../combinedPlus -res 10000 -interactions Cohesin_Inter_res10k_Plus.txt -cpu 60 -nomatrix -p coheisn_summit_5kb.bed
#analyzeHiC ../combinedMinus -res 10000 -interactions Cohesin_Inter_res10k_Minus.txt -cpu 60 -nomatrix -p coheisn_summit_5kb.bed


analyzeHiC ../combinedPlus -res 10000 -ped ../combinedMinus -interactions Cohesin_Inter_res10k_PlusVsMinus.txt -cpu 60 -nomatrix -p coheisn_summit_5kb.bed












