sed '1d' ./manorm/Rad21_manorm.bed > Rad21.bed

cat ./peaks/CTCF_0min_peaks.narrowPeak ./peaks/CTCF_30min_peaks.narrowPeak | sort -k1,1 -k2,2n| mergeBed -i stdin |uniq > CTCF.bed

intersectBed -u -a Rad21.bed -b CTCF.bed > Rad21_withCTCF.bed
intersectBed -v -a Rad21.bed -b CTCF.bed > Rad21_nonCTCF.bed

