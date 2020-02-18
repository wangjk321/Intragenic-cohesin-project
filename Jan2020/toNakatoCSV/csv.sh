awk '{print $1"-"$2"-"$3}' Rad21.bed > Rad21_all.position
awk '{print $1"-"$2"-"$3}' CTCF.bed > CTCF_all.position
awk '{print $1"-"$2"-"$3}' Rad21_withCTCF.bed > Rad21_withCTCF.position
awk '{print $1"-"$2"-"$3}' Rad21_nonCTCF.bed > Rad21_nonCTCF.position
touch blank.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_0min_peaks.narrowPeak > Rad21_0min_ours.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_45min_peaks.narrowPeak > Rad21_45min_ours.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_treat1_Schmidt.narrowPeak > Rad21_treat1_Schmidt.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_treat2_Schmidt.narrowPeak > Rad21_treat2_Schmidt.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_vehicle1_Schmidt.narrowPeak > Rad21_vehicle1_Schmidt.position
awk '{print $1"-"$2"-"$3}' ./peaks/Rad21_vehicle2_Schmidt.narrowPeak > Rad21_vehicle2_Schmidt.position

paste Rad21_all.position CTCF_all.position Rad21_withCTCF.position Rad21_nonCTCF.position blank.position Rad21_0min_ours.position Rad21_45min_ours.position Rad21_treat1_Schmidt.position Rad21_treat2_Schmidt.position Rad21_vehicle1_Schmidt.position Rad21_vehicle2_Schmidt.position | sed '1i Rad21\tCTCF\tRad21_withCTCF\tRad21_nonCTCF\t\tRad21_0min_ours\tRad21_45min_ours\tRad21_treat1_Schmidt\tRad21_treat2_Schmidt\tRad21_vehicle1_Schmidt\tRad21_vehicle2_Schmidt' >Rad21_CTCF.csv
